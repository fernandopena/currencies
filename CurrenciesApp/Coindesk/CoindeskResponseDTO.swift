//
//  CoindeskResponseDTO.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 28/10/2022.
//

import Foundation

struct CoindeskResponseDTO: Decodable {
    let statusCode: Int
    let message: String
    let data: [String: Coin]
    
    struct Coin: Decodable {
        let iso, name, slug: String
        let rate: Double
    }
}
