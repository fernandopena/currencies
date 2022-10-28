//
//  CurrencyViewDataSource.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 28/10/2022.
//

import Foundation

protocol CurrencyViewDataSourceProtocol {
    func fetchCurrenciesViewData(completionHandler: @escaping (Result<[CurrencyViewData], Error>) -> Void)
}
