//
//  Container+Extention.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import Foundation
import Swinject

extension Container {
    
    static let sharedContainer: Container = {
        let container = Container()
        
        // Managers
//        container.register(BaseNSUserDefaultsManager.self) { _ in
//            if ZZVariables.mockUserDefaults {
//                return MockNSUserDefaultsManager()
//            } else {
//                return NSUserDefaultsManager()
//            }
//        }
        
        // Repositories
        if (Bundle.main.object(forInfoDictionaryKey: "Mock Environment") as? Bool) ?? true {
            container.register(BaseCountryRepository.self) { _ in MockCountryRepository() }
            container.register(BaseUploadRepository.self) { _ in MockUploadRepository() }
        } else {
            container.register(BaseCountryRepository.self) { _ in CountryRepository() }
            container.register(BaseUploadRepository.self) { _ in UploadRepository() }
        }
        
        
        // View Models
        container.register(SplashViewModel.self) { r in
            SplashViewModel()
        }
        
        container.register(HomeViewModel.self) { r in
            HomeViewModel()
        }
        
        container.register(CountrySelectionViewModel.self) { r in
            CountrySelectionViewModel(
                countryRepository: r.resolve(BaseCountryRepository.self)!
            )
        }
        
        container.register(UploadViewModel.self) { r in
            UploadViewModel(
                uploadRepository: r.resolve(BaseUploadRepository.self)!
            )
        }
        
        
        // View Controllers
        container.register(SplashViewController.self) { r in
            let controller = SplashViewController()
            controller.viewModel = r.resolve(SplashViewModel.self)
            return controller
        }
        
        container.register(HomeViewController.self) { r in
            let controller = HomeViewController()
            controller.viewModel = r.resolve(HomeViewModel.self)
            return controller
        }
        
        container.register(CountrySelectionViewController.self) { r in
            let controller = CountrySelectionViewController()
            controller.viewModel = r.resolve(CountrySelectionViewModel.self)
            return controller
        }
        
        container.register(UploadViewController.self) { r in
            let controller = UploadViewController()
            controller.viewModel = r.resolve(UploadViewModel.self)
            return controller
        }
        
        
        return container
    }()
}
