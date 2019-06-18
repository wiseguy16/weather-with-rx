//
//  StoryBoardInstantiable+ext.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/24/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardInstantiable {
    
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle? { get }
    static var storyboardIdentifier: String? { get }
    
}

extension StoryboardInstantiable {
    
    static var storyboardBundle: Bundle? { return nil }
    static var storyboardIdentifier: String? { return nil }
    
    static func makeFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        guard let storyboardIdentifier = storyboardIdentifier else {
            fatalError("Could not instantiate storyboard with name: \(storyboardName)")
        }
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("Could not instantiate initial storyboard with name: \(storyboardName)")
        }
        
        return vc
    }
    
}
