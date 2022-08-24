//
//  CountryTableViewCell.swift
//  Cloudify
//
//  Created by Mario Severino on 23/08/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet var countryLabel: UILabel!
    
    var item: CountryCompatible? {
        didSet {
            self.bindData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func bindData() {
        guard let country = item else {
            return
        }
        
        self.countryLabel.text = country.countryName
    }
}
