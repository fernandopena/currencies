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

class CoindeskApiClientUIAdapter: CurrencyViewDataSourceProtocol {
    let apiClient = CoindeskApiClient()
    
    func fetchCurrenciesViewData(completionHandler: @escaping (Result<[CurrencyViewData], Error>) -> Void) {
        apiClient.fetchCurrencies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                let currencies = self.map(dto: dto)
                completionHandler(.success(currencies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func map(dto: CoindeskResponseDTO) -> [CurrencyViewData] {
        dto.data.map { CurrencyViewData(coin: $1) }
    }
}

extension CurrencyViewData {
    init(coin: CoindeskResponseDTO.Coin) {
        self = CurrencyViewData(name: coin.name, rate: "USD: \(coin.rate)")
    }
}
