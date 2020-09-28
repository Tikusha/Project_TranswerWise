//
//  CurrentyRate.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/20/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import Foundation

struct CurrencyRate: Codable {
    let from: String
    let to: String
    let amount: Double
    let value: Double
}
