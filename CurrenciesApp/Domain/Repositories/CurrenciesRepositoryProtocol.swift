//
//  CurrenciesRepositoryProtocol.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 31/10/2022.
//

import Foundation

protocol CurrenciesRepositoryProtocol {
    typealias Handler = (Result<[Currency], Error>) -> Void
    
    func fetchCurrencies(completionHandler: @escaping Handler)
}
