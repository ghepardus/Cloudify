//
//  BaseCountryRepository.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

protocol BaseCountryRepository {
    func countryList(completitionHandler: @escaping (Result<[CountryCompatible], Error>) -> Void)
}
