//
//  DetailWeatherPresenter.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/24/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation
import RxSwift

class DetailWeatherPresenter: Presenter {
    
    var dataArgument: Any?
    var dataFilter: Any?
    
    public var dataSource: Observable<[WeatherHourItem]> {
        return privateDataSource.asObservable()
    }
    
    private let privateDataSource: Variable<[WeatherHourItem]> = Variable([])
    private let bag = DisposeBag()
    private let networkManager = NetworkManager()
    
    override func loadMainData() {
        if let argument = dataArgument as? String {
            fetchWeather(city: argument)
        }
    }
    
    override func refreshUI() {
        delegate.reloadScreen()
    }
    
    private func fetchWeather(city: String) {
        let response = Observable.from([city])
            .map { [weak self] city in
                let url = self?.networkManager.buildUrl(for: city, weatherMode: .hourly)
                return URLRequest(url: url!)
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                URLSession.shared.rx.response(request: request)
            }
            .share(replay: 1, scope: .whileConnected)
        
        response
            .filter { response, _ -> Bool in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [WeatherHourItem] in
                let decoder = JSONDecoder()
                guard let threeHourForcastsItem = try? decoder.decode(Weather3HrItem.self, from: data) else {
                    return []
                }
                return threeHourForcastsItem.list
            }
            
            .subscribe(onNext: { [weak self] newEvents in
                self?.processEvents(newEvents)
            })
            .disposed(by: bag)
    }
    
    private func processEvents(_ newEvents: [WeatherHourItem]) {
        let updatedEvents = newEvents + privateDataSource.value
        guard let timeForDay = dataFilter as? Int else { return }
        let startOfDay = Converter.getStartOfDayInt(from: timeForDay)
        
        var dayOfEvents = updatedEvents.filter { $0.dt > startOfDay }
        
        if dayOfEvents.count > 10 {
            dayOfEvents = Array<WeatherHourItem>(dayOfEvents.prefix(upTo: 9))
        }
        
        privateDataSource.value = dayOfEvents
        
        DispatchQueue.main.async {
            self.refreshUI()
        }
    }
    
}
