//
//  CurrenciesRepositoryProtocol.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 31/10/2022.
//

import Foundation

protocol CurrenciesRepositoryProtocol {
    func fetchCurrencies(completionHandler: @escaping (Result<[Currency], Error>) -> Void)

}
