//
//  ImageCompatible.swift
//  Cloudify
//
//  Created by Mario Severino on 23/08/22.
//

import Foundation
import UIKit

protocol ImageCompatible {
    var originalImage: UIImage? { get set }
    var editedImage: UIImage? { get set }
    var imageURL: String? { get set }
}
