//
//  HourlyViewController.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/25/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HourlyViewController: UIViewController, PressenterProtocol {

    var presenter = DetailWeatherPresenter()
    var dayForcastItem: WeatherDailyItem?
    var timeForDayFilter: Any?
    
    private let bag = DisposeBag()
    private let cellIdentifier = "HourlyCellRx"
    private let nibIdentifier = "HourlyCellRx"
        
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var bigIconImageView: UIImageView!
    @IBOutlet weak var forcastLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
        setupCollectionViewBinding()
        
        presenter.delegate = self
        presenter.dataArgument = cityForApp
        presenter.dataFilter = timeForDayFilter
        presenter.loadMainData()
    }
    
    private func setupUI() {
        setDayUIElements()
        addSwipeRightToPop()
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: -  Presenter Delegate methods
    
    func reloadScreen() {
        DispatchQueue.main.async {
           // self.hourlyCollectionView.reloadData()
        }
    }
    
    func respondToActivity() {
        // No operations needed...
    }
    
    private func setDayUIElements() {
        guard let element = dayForcastItem else { return }
        
        // Day of Week
        dayLabel.text = Converter.makeDayString(from: element.dt)
        
        // Image
        let imageIconId = element.weather.first?.icon ?? ""
        let iconImage = UIImage(named: "\(imageIconId)")
        bigIconImageView.image = iconImage
        
        // Forcast Conditions
        forcastLabel.text = element.weather.first?.description.capitalized ?? ""
        
        // Temperatures
        highTempLabel.text = " \(element.temp.maxFht)°"
        lowTempLabel.text = " \(element.temp.minFht)°"
        
        // Humidity
        humidityLabel.text = "\(element.humidity)%"
        
        // Atmospheric Pressure
        let pressure = Converter.pressureHpaToInches(pressure: element.pressure)
        let pressureString = String(format: "%.1f", pressure)
        pressureLabel.text = "\(pressureString) in"
        
        // Cloudiness
        cloudsLabel.text = "\(element.clouds ?? 0)%"
        
        // Precipitation Amount
        let precipAmount = Converter.rainMmToInches(precip: element.rain ?? 0.0)
        let precipString = String(format: "%.1f", precipAmount)
        precipLabel.text = "\(precipString) in"
    }

}

extension HourlyViewController {
    
    // MARK: -  View setup and bindings
    
    private func setupCollectionView() {
        hourlyCollectionView.rx.setDelegate(self)
            .disposed(by: bag)
        hourlyCollectionView.dataSource = nil
        hourlyCollectionView.register(UINib(nibName: nibIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        hourlyCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func setupCollectionViewBinding() {
        presenter.dataSource
            .bind(to: hourlyCollectionView.rx.items(cellIdentifier: cellIdentifier, cellType: HourlyCellRx.self)) {  row, element, cell in
                cell.configureCell(with: element)
            }
            .disposed(by: bag)
    }
    
}

extension HourlyViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 215)
    }
    
}

extension HourlyViewController: StoryboardInstantiable {
    
    static var storyboardName: String { return "HourlyBoard" }
    static var storyboardIdentifier: String? { return "HourlyViewController" }
    
}
