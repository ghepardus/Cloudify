//
//  String+Localization.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import Foundation

extension String {
  var localized: String {
        NSLocalizedString(self, comment: " ")
    }
}
