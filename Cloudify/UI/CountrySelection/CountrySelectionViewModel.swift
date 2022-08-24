//
//  CountrySelectionViewModel.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import RxSwift
import RxCocoa

class CountrySelectionViewModel: MSViewModel {
    
    let countryRepository: BaseCountryRepository
    
    let items = PublishSubject<[CountryCompatible]>()
    var originalItems: [CountryCompatible] = []
    
    init(countryRepository: BaseCountryRepository){
        self.countryRepository = countryRepository
    }
    
    func fetch() {
        self.countryRepository.countryList { [weak self] result in
            if let self = self {
                switch result {
                case .success(let resultObject):
                    self.originalItems = resultObject
                    self.items.onNext(self.originalItems)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func search(searchString: String) {
        
        if searchString.isEmpty {
            self.items.onNext(originalItems)
        } else {
            let filteredItems = originalItems.filter { country in
                country.countryName.lowercased().contains(searchString.lowercased())
            }
            self.items.onNext(filteredItems)
        }
    }

}
