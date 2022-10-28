//
//  CoindeskApiClient.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 28/10/2022.
//

import Foundation

class CoindeskApiClient {
    func fetchCurrencies(completionHandler: @escaping (Result<CoindeskResponseDTO, Error>) -> Void) {
        let url = URL(string: "https://production.api.coindesk.com/v2/exchange-rates")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(.failure(error ?? ApiClientError.emptyData))
                return
            }
            do {
                let dto = try JSONDecoder().decode(CoindeskResponseDTO.self, from: data)
                completionHandler(.success(dto))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}

enum ApiClientError: Error {
    case emptyData
}
