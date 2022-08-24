//
//  PhotoCollectionViewCell.swift
//  Cloudify
//
//  Created by Mario Severino on 23/08/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var photo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

}
