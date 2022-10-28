//
//  CurrenciesViewController.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 25/10/2022.
//

import UIKit

struct CoindeskResponseDTO: Decodable {
    let statusCode: Int
    let message: String
    let data: [String: Coin]
    
    struct Coin: Decodable {
        let iso, name, slug: String
        let rate: Double
    }
}

class CurrenciesViewController: UITableViewController {
    
    var currencies: [CoindeskResponseDTO.Coin] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://production.api.coindesk.com/v2/exchange-rates")!
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            do {
                let dto = try JSONDecoder().decode(CoindeskResponseDTO.self, from: data)
                self?.currencies = dto.data.map { $1 }
            } catch {
                print(error)
            }
        }.resume()
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
        cell.detailTextLabel?.text = "\(currency.rate)"
        return cell
    }
}
