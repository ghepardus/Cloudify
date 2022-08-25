//
//  MainCoordinator.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import UIKit
import Swinject
import RxRelay

class MainCoordinator: Coordinator {
    var childCoordinator = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashController = Container.sharedContainer.resolve(SplashViewController.self)!
        splashController.coordinator = self
        self.navigationController.setViewControllers([splashController], animated: true)
    }
    
    func back() {
        self.navigationController.popViewController(animated: true)
    }
    
    func startHome() {
        //Set as first controller the HomeViewController
        let viewController = Container.sharedContainer.resolve(HomeViewController.self)!
        viewController.coordinator = self
        self.navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showCountryList(selection: BehaviorRelay<CountryCompatible?>?) {
        guard let viewController = Container.sharedContainer.resolve(CountrySelectionViewController.self) else {
            return
        }
        viewController.result = selection
        self.navigationController.present(viewController, animated: true, completion: nil)
    }
    
    func upload(images: [ImageCompatible]) {
        guard let viewController = Container.sharedContainer.resolve(UploadViewController.self) else {
            return
        }
        viewController.images = images
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
