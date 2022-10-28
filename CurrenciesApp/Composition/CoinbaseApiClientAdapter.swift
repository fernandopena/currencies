//
//  CoinbaseApiClientAdapter.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 28/10/2022.
//

import Foundation

extension CoindeskApiClient: CurrencyViewDataSourceProtocol {
    func fetchCurrenciesViewData(completionHandler: @escaping (Result<[CurrencyViewData], Error>) -> Void) {
        fetchCurrencies { result in
            switch result {
            case .success(let dto):
                let currencies = dto.data.map { CurrencyViewData(name: $1.name, rate: "USD: \($1.rate)") }
                completionHandler(.success(currencies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
