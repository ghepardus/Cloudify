//
//  MockCountryRepository.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import Foundation

class MockCountryRepository: BaseCountryRepository {
    
    func countryList(completitionHandler: @escaping (Result<[CountryCompatible], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completitionHandler(.success([
                Country(countryName: "Mozambico", countryISO: 1, countryCode: "MZ"),
                Country(countryName: "Germania", countryISO: 2, countryCode: "DE"),
                Country(countryName: "Italia", countryISO: 3, countryCode: "IT")
            ]))
        }
    }
    

}
