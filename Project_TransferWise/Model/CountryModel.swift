//
//  CountryModel.swift
//  Project_TransferWise
//
//  Created by Tiko on 9/6/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class CountryModel {
    var image: UIImage? = UIImage(named: "cad")
    let code: String?
    let country: String
    
    init(image: UIImage?, code: String, country: String) {
        self.image = image
        self.code = code
        self.country = country
    }
    
    static func setCountries() -> [CountryModel] {
        let countries = [
            CountryModel(image: UIImage(named: "gel")!, code: "GEL", country: "Georgian lari"),
            CountryModel(image: UIImage(named: "usa")!, code: "USD", country: "United States dollar"),
            CountryModel(image: UIImage(named: "gbp")!, code: "GBP", country: "British pound"),
            CountryModel(image: UIImage(named: "eur")!, code: "EUR", country: "Euro"),
            CountryModel(image: UIImage(named: "bgn")!, code: "BGN", country: "Burgalian lev"),
            CountryModel(image: UIImage(named: "brl")!, code: "BRL", country: "Brazilian real"),
            CountryModel(image: UIImage(named: "cad")!, code: "CAD", country: "Canadian dollar"),
            CountryModel(image: UIImage(named: "jpy")!, code: "JPY", country: "Japanese yen"),
            CountryModel(image: UIImage(named: "sek")!, code: "SEK", country: "Swedish krona"),
            CountryModel(image: UIImage(named: "try")!, code: "TRY", country: "Turkish lira"),
            CountryModel(image: UIImage(named: "sgd")!, code: "SGD", country: "Singapore dollar"),
            CountryModel(image: UIImage(named: "ron")!, code: "RON", country: "Romanian leu"),
            CountryModel(image: UIImage(named: "nzd")!, code: "NZD", country: "New Zealand dollar"),
            CountryModel(image: UIImage(named: "dkk")!, code: "DKK", country: "Danish krone"),
            CountryModel(image: UIImage(named: "inr")!, code: "INR", country: "Indian rupee"),
        ]
        return countries
    }
}
//
//struct Countries {
//    let countries = [
//        CountryModel(image: UIImage(named: "gbp")!, code: "GBP", country: "British pound"),
//        CountryModel(image: UIImage(named: "gel")!, code: "GEL", country: "Georgian lari"),
//        CountryModel(image: UIImage(named: "usa")!, code: "USD", country: "United States dollar"),
//        CountryModel(image: UIImage(named: "eur")!, code: "EUR", country: "Euro"),
//        CountryModel(image: UIImage(named: "bgn")!, code: "BGN", country: "Burgalian lev"),
//        CountryModel(image: UIImage(named: "brl")!, code: "BRL", country: "Brazilian real"),
//        CountryModel(image: UIImage(named: "cad")!, code: "CAD", country: "Canadian dollar"),
//        CountryModel(image: UIImage(named: "jpy")!, code: "JPY", country: "Japanese yen"),
//        CountryModel(image: UIImage(named: "sek")!, code: "SEK", country: "Swedish krona"),
//        CountryModel(image: UIImage(named: "try")!, code: "TRY", country: "Turkish lira"),
//        CountryModel(image: UIImage(named: "sgd")!, code: "SGD", country: "Singapore dollar"),
//        CountryModel(image: UIImage(named: "ron")!, code: "RON", country: "Romanian leu"),
//        CountryModel(image: UIImage(named: "nzd")!, code: "NZD", country: "New Zealand dollar"),
//        CountryModel(image: UIImage(named: "dkk")!, code: "DKK", country: "Danish krone"),
//        CountryModel(image: UIImage(named: "inr")!, code: "INR", country: "Indian rupee"),
//    ]
//}
