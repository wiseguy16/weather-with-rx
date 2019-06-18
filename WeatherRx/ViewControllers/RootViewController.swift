//
//  RootViewController.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/26/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    var current: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(self.current)
        self.current.view.frame = view.bounds
        view.addSubview(self.current.view)
        self.current.didMove(toParentViewController: self)
    }
    
    func switchToMainScreen() {
        let mainNavViewController = MainNavViewController.makeFromStoryboard()
        animateFadeTransition(to: mainNavViewController)
    }
    
    func gotoSplash() {
        let splash = SplashViewController.makeFromStoryboard()
        animateFadeTransition(to: splash)
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParentViewController: nil)
        addChildViewController(new)
        transition(from: current, to: new, duration: 0, options: [.curveEaseIn], animations: {
            
        }) { completed in
            self.current.removeFromParentViewController()
            new.didMove(toParentViewController: self)
            self.current = new
            completion?()
        }
    }

}

extension RootViewController: StoryboardInstantiable {
    
    static var storyboardName: String { return "RootBoard" }
    static var storyboardIdentifier: String? { return "RootViewController" }
    
}
