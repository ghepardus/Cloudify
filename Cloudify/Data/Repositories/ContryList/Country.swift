//
//  Country.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import UIKit

struct Country: CountryCompatible, Decodable {
    var countryName: String
    var countryISO: Int
    var countryCode: String
    
    enum CodingKeys: String, CodingKey {
        case countryName = "name"
        case countryISO = "iso"
        case countryCode = "isoAlpha2"
    }
}
