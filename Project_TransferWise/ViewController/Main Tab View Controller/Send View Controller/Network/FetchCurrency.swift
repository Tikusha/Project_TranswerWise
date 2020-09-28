//
//  FetchCurrency.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/20/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import Foundation
import Alamofire

class FetchCurrency {
    
    var amount: String? = "1000"
    var currencyFrom: String? = "GEL"
    var currencyTo: String? = "EUR"
    
    public func fetch(_ completion: @escaping (CurrencyRate?) -> Void) {
        let parameters = ["amount": amount, "from": currencyFrom, "to": currencyTo]
        let headers: HTTPHeaders = [
            .authorization("0mAIbRdM6nlmkllYSUCGF5R1PRhAQ3Iy"),
            .accept("application/json")
        ]
        
        AF.request("https://test-api.tbcbank.ge/v1/exchange-rates/commercial/convert", method: .get, parameters: parameters, headers: headers).responseDecodable { (response: DataResponse<CurrencyRate, AFError>) in
            
            switch response.result {
            case .success(let currencyRate):
                completion(currencyRate)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
}
