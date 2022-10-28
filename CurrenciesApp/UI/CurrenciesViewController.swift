//
//  CurrenciesViewController.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 25/10/2022.
//

import UIKit

class CurrenciesViewController: UITableViewController {
    internal init(dataSource: CurrencyViewDataSourceProtocol) {
        self.dataSource = dataSource
        self.currencies = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dataSource: CurrencyViewDataSourceProtocol
    
    var currencies: [CurrencyViewData] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.fetchCurrenciesViewData { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currencies = currencies
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            }
            return cell
        }()
        let currency = currencies[indexPath.row]
        cell.textLabel?.text = currency.name
        cell.detailTextLabel?.text = currency.rate
        return cell
    }
}
