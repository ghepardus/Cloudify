//
//  CountryRepository.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import UIKit
import Alamofire

class CountryRepository: BaseCountryRepository {
    
    func countryList(completitionHandler: @escaping (Result<[CountryCompatible], Error>) -> Void) {
        
        let headers: HTTPHeaders = [
            "x-api-key": "AIzaSyCccmdkjGe_9Yt-INL2rCJTNgoS4CXsRDc"
        ]
        
        AF.request("https://api.photoforse.online/geographics/countries/", headers: headers).responseDecodable(of: [Country].self) { response in
            switch response.result {
                    case .success(let value):
                        completitionHandler(.success(value))
                    case let .failure(error):
                        completitionHandler(.failure(error))
            }
        }
    }

}
