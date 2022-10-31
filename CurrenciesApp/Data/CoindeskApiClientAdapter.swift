//
//  CoindeskApiClientAdapter.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 31/10/2022.
//

import Foundation

extension CoindeskApiClient: CurrenciesRepositoryProtocol {
    func fetchCurrencies(completionHandler: @escaping (Result<[Currency], Error>) -> Void) {
        getExchangeRates { result in
            switch result {
            case .success(let dto):
                let currencies = dto.data.map { Currency(name: $1.name, rate: $1.rate) }
                completionHandler(.success(currencies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
