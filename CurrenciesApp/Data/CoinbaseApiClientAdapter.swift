//
//  CoinbaseApiClientAdapter.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 28/10/2022.
//

import Foundation

class CoindeskApiClientAdapter: CurrenciesRepositoryProtocol {
    let apiClient = CoindeskApiClient()
    
    func fetchCurrencies(completionHandler: @escaping (Result<[Currency], Error>) -> Void) {
        apiClient.getExchangeRates { [weak self] result in
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
    
    func map(dto: CoindeskResponseDTO) -> [Currency] {
        dto.data.map { Currency(coin: $1) }
    }
}

extension Currency {
    init(coin: CoindeskResponseDTO.Coin) {
        self = Currency(name: coin.name,
                        rate: coin.rate)
    }
}
