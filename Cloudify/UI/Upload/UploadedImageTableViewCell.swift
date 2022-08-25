//
//  UploadedImageTableViewCell.swift
//  Cloudify
//
//  Created by Mario Severino on 25/08/22.
//

import UIKit

class UploadedImageTableViewCell: UITableViewCell {
    
    @IBOutlet var urlLabel: UILabel!
    @IBOutlet var uploadedImageView: UIImageView!
    
    var item: UploadedImage? {
        didSet {
            self.bindData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureUI()
    }
    
    private func configureUI() {
        self.uploadedImageView.layer.masksToBounds = true
        self.uploadedImageView.layer.cornerRadius = 5
        self.uploadedImageView.layer.borderWidth = 1
        self.uploadedImageView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.uploadedImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    private func bindData() {
        self.uploadedImageView.image = item?.image
        self.urlLabel.text = item?.imageUrl
    }
    
}
