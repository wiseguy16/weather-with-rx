//
//  MainNavViewController.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/26/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import UIKit

class MainNavViewController: UINavigationController {

}

extension MainNavViewController: StoryboardInstantiable {
    
    static var storyboardName: String { return "Main" }
    static var storyboardIdentifier: String? { return "MainNavViewController" }
    
}
