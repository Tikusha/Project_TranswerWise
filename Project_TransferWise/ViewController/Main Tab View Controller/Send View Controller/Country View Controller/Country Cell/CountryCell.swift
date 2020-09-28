//
//  CountryCell.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/16/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageCountry: UIImageView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    // MARK: - View LifeCyrcle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
