//
//  MainWeatherPresenter.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/24/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation
import RxSwift

class MainWeatherPresenter: Presenter {
    
    var dataArgument: Any?
    
    // MARK: Outputs
    public var dataSource: Observable<[WeatherDailyItem]> {
        return privateDataSource.asObservable()
    }
    
    public var currentWeatherdataSource: Observable<[WeatherCurrentItem]> {
        return privateCurrentWeatherDataSource.asObservable()
    }
    
    private let privateDataSource: Variable<[WeatherDailyItem]> = Variable([])
    private let privateCurrentWeatherDataSource: Variable<[WeatherCurrentItem]> = Variable([])
    private let bag = DisposeBag()
    private let networkManager = NetworkManager()
    
    override func loadMainData() {
        if let argument = dataArgument as? String {
            fetchCurrentWeather(for: argument)
            fetch5DayForcast(for: argument)
        }
    }
    
    override func refreshUI() {
        delegate.reloadScreen()
    }
    
    override func handleActivity() {
        delegate.respondToActivity()
    }
    
    private func fetch5DayForcast(for city: String) {
        let response = Observable.from([city])
            .map { [weak self] city in
                let url = self?.networkManager.buildUrl(for: city, weatherMode: .daily)
                return URLRequest(url: url!)
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                URLSession.shared.rx.response(request: request)
            }
        
        response
            .filter { response, _ -> Bool in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [WeatherDailyItem] in
                let decoder = JSONDecoder()
                guard let fiveDayForcstsItem = try? decoder.decode(Weather5DayItem.self, from: data) else {
                    return []
                }
                return fiveDayForcstsItem.list
            }
            
            .subscribe(onNext: { [weak self] newEvents in
                self?.processEvents(newEvents)
            })
            .disposed(by: bag)
    }
    
    private func fetchCurrentWeather(for city: String) {
        let response = Observable.from([city])
            .map { [weak self] city in
                let url = self?.networkManager.buildUrl(for: city, weatherMode: .current)
                return URLRequest(url: url!)
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                URLSession.shared.rx.response(request: request)
        }
        
        response
            .filter { response, _ -> Bool in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [WeatherCurrentItem] in
                let decoder = JSONDecoder()
                guard let currentForcastItem = try? decoder.decode(WeatherCurrentItem.self, from: data) else {
                    return []
                }
                return [currentForcastItem]
            }
            
            .subscribe(onNext: { [weak self] newEvents in
                self?.processCurrentEvents(newEvents)
            })
            .disposed(by: bag)
    }
    
    private func processEvents(_ newEvents: [WeatherDailyItem]) {
        var updatedEvents = newEvents + privateDataSource.value
        updatedEvents = Array<WeatherDailyItem>(updatedEvents.prefix(upTo: 5))
        
        privateDataSource.value = updatedEvents
        
        DispatchQueue.main.async {
            self.refreshUI()
        }
    }
    
    private func processCurrentEvents(_ newEvents: [WeatherCurrentItem]) {
        var updatedEvents = newEvents + privateCurrentWeatherDataSource.value
        updatedEvents = Array<WeatherCurrentItem>(updatedEvents.prefix(upTo: 1))
        
        privateCurrentWeatherDataSource.value = updatedEvents
        
        DispatchQueue.main.async {
            self.handleActivity()
        }
    }
    
}
