//
//  PhotoImage.swift
//  Cloudify
//
//  Created by Mario Severino on 23/08/22.
//

import UIKit

class PhotoImage: ImageCompatible {
    var originalImage: UIImage?
    var editedImage: UIImage?
    var imageURL: URL?
    var imageName: String?
    
    init(imageInfo: [UIImagePickerController.InfoKey : Any]) {
        self.originalImage = imageInfo[.originalImage] as? UIImage
        self.editedImage = imageInfo[.editedImage] as? UIImage
        self.imageURL = imageInfo[.imageURL] as? URL
        self.imageName = self.imageURL?.lastPathComponent
    }
}
