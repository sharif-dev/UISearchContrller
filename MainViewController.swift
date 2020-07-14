/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class MainViewController: UITableViewController {
  var countries = Country.countries()
  var searchController: UISearchController!
  var resultsTableViewController: ResultsTableViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    resultsTableViewController = storyboard!.instantiateViewController(withIdentifier: "resultsViewController") as? ResultsTableViewController
    
    searchController = UISearchController(searchResultsController: resultsTableViewController)
    navigationItem.searchController = searchController
    
    
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Find a country"
    searchController.searchBar.scopeButtonTitles = Year.allCases.map { $0.description }
    searchController.searchBar.delegate = self
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return Continent.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return Continent.allCases[section].description
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let continentForSection = Continent.allCases[section]
    return countries[continentForSection]?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath) as! CountryCell
    let continentForRow = Continent.allCases[indexPath.section]
    cell.country = countries[continentForRow]?[indexPath.row]
    return cell
  }
}

// MARK: -

extension MainViewController {
  func searchFor(_ searchText: String?) {
    guard searchController.isActive else { return }
    guard let searchText = searchText else {
      resultsTableViewController.countries = nil
      return
    }
    let selectedYear = selectedScopeYear()
    let allCountries = countries.values.joined()
    let filteredCountries = allCountries.filter { (country: Country) -> Bool in
      let isMatchingYear = selectedYear == Year.all.description ? true : (country.year.description == selectedYear)
      if searchText != "" {
        return
          isMatchingYear &&
          country.name.lowercased().contains(searchText.lowercased())
      }
      return false
    }
    resultsTableViewController.countries = filteredCountries
  }
  
  func selectedScopeYear() -> String {
    guard let scopeButtonTitles = searchController.searchBar.scopeButtonTitles else {
      return Year.all.description
    }
    return scopeButtonTitles[searchController.searchBar.selectedScopeButtonIndex]
  }
}

// MARK: -

extension MainViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    guard let searchText = searchController.searchBar.text else { return }
    searchFor(searchText)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchFor(searchText)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    resultsTableViewController.countries = nil
  }
}
