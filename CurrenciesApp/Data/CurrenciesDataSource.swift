//
//  CurrenciesDataSource.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 28/10/2022.
//

import Foundation

protocol CurrenciesDataSourceProtocol {
    typealias Handler = (Result<CoindeskResponseDTO, Error>) -> Void
    
    func fetchCurrencies(completionHandler: @escaping Handler)
}

extension CoindeskApiClient: CurrenciesDataSourceProtocol {}
