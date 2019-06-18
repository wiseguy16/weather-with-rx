//
//  DailyWeatherViewController.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/24/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DailyWeatherViewController: UIViewController, PressenterProtocol {
        
    var presenter = MainWeatherPresenter()
    
    private let bag = DisposeBag()
    private let cellIdentifier = "DailyCellRx"
    private let nibIdentifier = "DailyCellRx"
    
    // Splash related...
    let splashImage = #imageLiteral(resourceName: "Splash")
    var splashImageView: UIImageView?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var dailyCollectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRXBindings()
        presenter.delegate = self
        presenter.dataArgument = cityForApp
        presenter.loadMainData()
    }
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        setSplashOverlay()
        cityLabel.text = cityForApp
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        dailyCollectionView.refreshControl = refreshControl
        dailyCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func setupRXBindings() {
        setupTempLabelBinding()
        setupConditionsLabelBinding()
        setupCollectionView()
        setupCollectionViewBinding()
        bindCollectionViewSelected()
    }
    
    @objc func refresh() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.presenter.loadMainData()
        }
    }
    
    // MARK: -  Presenter Delegate methods
    
    func reloadScreen() {
        DispatchQueue.main.async {
            //self.dailyCollectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func respondToActivity() {
        DispatchQueue.main.async {
            self.removeSplashOverlay()
        }
    }
    
}

extension DailyWeatherViewController {
    
    // MARK: -  Setting up labels
    
    private func setupTempLabelBinding() {
        presenter.currentWeatherdataSource
            .asObservable()
            .map { current -> (String?) in
                let temperatureDouble = current.first?.main.temp
                let temperature = Converter.tempKelvinToFahrenheit(temperature: temperatureDouble ?? 350.0)
                return Optional(" \(temperature)°")
            }
            .bind(to:self.currentTempLabel.rx.text)
            .disposed(by:self.bag)
    }
    
    private func setupConditionsLabelBinding() {
        presenter.currentWeatherdataSource
            .asObservable()
            .map { current -> (String?) in
                let conditions = current.first?.weather.first?.main ?? ""
                return Optional(conditions)
            }
            .bind(to:self.conditionsLabel.rx.text)
            .disposed(by:self.bag)
    }
    
}

extension DailyWeatherViewController {
    
    // MARK: -  Setting up CollectionView
    
    private func setupCollectionView() {
        dailyCollectionView.rx.setDelegate(self)
            .disposed(by: bag)
        dailyCollectionView.dataSource = nil
        dailyCollectionView.register(UINib(nibName: nibIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewBinding() {
        presenter.dataSource
            .bind(to: dailyCollectionView.rx.items(cellIdentifier: cellIdentifier, cellType: DailyCellRx.self)) {  row, element, cell in
                cell.configureCell(with: element)
            }
            .disposed(by: bag)
    }
    
    private func bindCollectionViewSelected() {
        dailyCollectionView.rx.modelSelected(WeatherDailyItem.self)
            .subscribe(onNext :{ [weak self] element in
                
                guard let strongSelf = self else { return }
                
                let detailVC = HourlyViewController.makeFromStoryboard()
                detailVC.dayForcastItem = element
                detailVC.timeForDayFilter = element.dt
                
                strongSelf.navigationController?.pushViewController(detailVC, animated: true)
                
            }).disposed(by: bag)
    }
    
}

extension DailyWeatherViewController {
    
    // MARK: -  Splash related methods
    
    private func setSplashOverlay() {
        let imageFrame = UIScreen.main.bounds
        splashImageView = UIImageView(frame: imageFrame)
        splashImageView?.image = splashImage
        splashImageView?.contentMode = .scaleAspectFill
        view.addSubview(splashImageView ?? UIImageView())
    }
    
    private func removeSplashOverlay() {
        UIView.animate(withDuration: 0.2, animations: {
            self.splashImageView?.alpha = 0
        }) { [weak self] (_) in
            self?.splashImageView?.removeFromSuperview()
        }
    }
    
}

extension DailyWeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        return CGSize(width: width, height: 90)
    }
    
}

extension DailyWeatherViewController: StoryboardInstantiable {
    
    static var storyboardName: String { return "Main" }
    static var storyboardIdentifier: String? { return "DailyWeatherViewController" }
    
}
