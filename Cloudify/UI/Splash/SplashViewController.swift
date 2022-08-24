//
//  SplashViewController.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import UIKit

class SplashViewController: MSViewController {
    
    @IBOutlet var logoImage: UIImageView!
    
    weak var coordinator: MainCoordinator?
    
    var viewModel: SplashViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.startAnimation()
    }
    
    private func startAnimation() {
        UIView.transition(
            with: self.logoImage,
            duration: 0.4,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                self?.logoImage.isHidden = false
            }) { [weak self] _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self?.coordinator?.startHome()
                }
            }
    }

}
