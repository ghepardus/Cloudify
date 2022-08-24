//
//  Coordinator.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
