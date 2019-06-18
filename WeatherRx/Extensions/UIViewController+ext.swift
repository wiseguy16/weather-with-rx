//
//  UIViewController+ext.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/26/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addSwipeRightToPop() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipeRight(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                navigationController?.popViewController(animated: true)
            default:
                break
            }
        }
    }
    
}
