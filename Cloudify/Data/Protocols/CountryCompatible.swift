//
//  CountryCompatible.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import Foundation

protocol CountryCompatible {
    var countryName: String { get set }
    var countryISO: Int { get set }
    var countryCode: String { get set }
}
