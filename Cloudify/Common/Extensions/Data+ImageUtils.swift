//
//  Data+ImageUtils.swift
//  Cloudify
//
//  Created by Mario Severino on 24/08/22.
//

import Foundation
import UIKit

extension UIImage {
    func reduceImageData(maxSize: Int, tries: Int = 10) -> Data? {
        var maxQuality: CGFloat = 1.0
        var minQuality: CGFloat = 0.1
        var bestImage: Data?
        
        for _ in 1...tries {
            let currentQuality = (maxQuality + minQuality) / 2
            guard let data = self.jpegData(compressionQuality: currentQuality) else { return nil }
            let currentSize = data.count
            if currentSize > maxSize {
                maxQuality = currentQuality
            } else {
                minQuality = currentQuality
                bestImage = data
                return bestImage
            }
        }
        
        return bestImage
    }
}
