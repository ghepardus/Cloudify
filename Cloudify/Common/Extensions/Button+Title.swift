//
//  Button+Title.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import Foundation
import UIKit

extension UIButton {
    func setCustomTitle(title: String) {
        self.setTitle(title, for: .application)
        self.setTitle(title, for: .highlighted)
        self.setTitle(title, for: .reserved)
        self.setTitle(title, for: .selected)
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .focused)
        self.setTitle(title, for: .disabled)
    }
}
