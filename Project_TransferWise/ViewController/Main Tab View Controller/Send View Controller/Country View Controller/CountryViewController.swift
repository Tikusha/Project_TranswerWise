//
//  CountryViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/16/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

protocol SetCountryCodeDelegate: class {
    func setCountryCode(image: UIImage, code: String, country: String)
}

class CountryViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var clearButton: UIButton!
    
    // MARK: - Properties
    var countriesList = [CountryModel]()
    var searchCountries = [CountryModel]()
    weak var delegate: SetCountryCodeDelegate?
    var searching = false
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.configuration()
    }
    
    // MARK: - Configurarion
    private func configuration() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = Constants.Color.navyBlue
        self.searchTextField.delegate = self
        self.countriesList = CountryModel.setCountries()
        self.searchView.cornerView(cornerRadius: 12, borderWidth: 0.2, borderColor: Constants.Color.navyMid)
        self.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for a currency/country...", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.clearButton.isHidden = true
    }
    
    private func registerCell() {
        self.tableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "CountryCell")
    }
    
    // MARK: - IBActions
    @IBAction private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func clear() {
        self.searchTextField.text = ""
        self.clearButton.isHidden = true
        self.searchTextField.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource
extension CountryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        self.searching ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return self.searchCountries.count
        } else {
            if section == 0 {
                return 3
            } else {
                return self.countriesList.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell
        if self.searching {
            cell?.imageCountry.image = self.searchCountries[indexPath.row].image
            cell?.codeLabel.text = self.searchCountries[indexPath.row].code
            cell?.countryLabel.text = self.searchCountries[indexPath.row].country
        } else {
            cell?.imageCountry.image = self.countriesList[indexPath.row].image
            cell?.codeLabel.text = self.countriesList[indexPath.row].code
            cell?.countryLabel.text = self.countriesList[indexPath.row].country
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let text = self.searchTextField.text else {
            return ""
        }
        if self.searching {
            return ("Results for \(text.uppercased())")
        } else {
            if section == 0 {
                return "Popular currencies"
            } else {
                return "All currencies"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "System", size: 14)
        header.contentView.backgroundColor = Constants.Color.navyBlue
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
}

// MARK: - UITableViewDelegate
extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.setCountryCode(image: self.countriesList[indexPath.row].image!, code: self.countriesList[indexPath.row].code ?? "", country: self.countriesList[indexPath.row].country)
        self.dismiss(animated: true, completion: nil)
    }
}

extension CountryViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let attribute = [NSAttributedString.Key.backgroundColor: Constants.Color.navyDark ] as [NSAttributedString.Key: Any]?
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        textField.attributedText = NSAttributedString(string: searchText, attributes: attribute)
        if searchText.count != 0 {
            self.clearButton.isHidden = false
            self.searchCountries = self.countriesList.filter {
                $0.country.lowercased().contains(searchText.lowercased())
            }
            self.searching = true
        } else {
            self.searching = false
            self.clearButton.isHidden = true
            self.searchTextField.resignFirstResponder()
        }
        self.tableView.reloadData()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextField.resignFirstResponder()
        return false
    }
}

