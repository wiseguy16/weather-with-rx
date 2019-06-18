//
//  Presenter.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/24/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation

protocol PressenterProtocol: class {
    func reloadScreen()
    func respondToActivity()
    
}

class Presenter : NSObject {
    
    weak var delegate: PressenterProtocol!
    
    func loadMainData()  { }
    
    func refreshUI() { }
    
    func handleActivity() { }
    
}

