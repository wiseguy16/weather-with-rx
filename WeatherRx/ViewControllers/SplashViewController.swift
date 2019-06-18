//
//  SplashViewController.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/26/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var poweredLabel: UILabel!
    @IBOutlet weak var sponsorImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        poweredLabel.alpha = 1
        sponsorImageView.alpha = 0
        animateSponsorImage()
    }
    
    // MARK: -  Animations
    
    private func animateSponsorImage() {
        fadeUpSponsor { (_) in
            self.fadeOutLabel(completion: { (_) in
                self.fadeOutSponsor(completion: nil)
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.leavePage()
        }
    }
    
    private func fadeUpSponsor(completion: ((Bool) -> Void)?)  {
        UIView.animate(withDuration: 1.5, animations: {
            self.sponsorImageView.alpha = 0.99
        }, completion: completion)
    }
    
    private func fadeOutLabel(completion: ((Bool) -> Void)?)  {
        UIView.animate(withDuration: 0.5, animations: {
            self.sponsorImageView.alpha = 1.0
            self.poweredLabel.alpha = 0
        }, completion: completion)
    }
    
    private func fadeOutSponsor(completion: ((Bool) -> Void)?)  {
        UIView.animate(withDuration: 1.0, animations: {
            self.sponsorImageView.alpha = 0
        }, completion: completion)
    }
    
    // MARK: - Exit Splash ViewController
    
    private func leavePage() {
        DispatchQueue.main.async {
            AppDelegate.shared.rootViewController.switchToMainScreen()
        }
    }
    
}

extension SplashViewController: StoryboardInstantiable {
    
    static var storyboardName: String { return "SplashBoard" }
    static var storyboardIdentifier: String? { return "SplashViewController" }
    
}
