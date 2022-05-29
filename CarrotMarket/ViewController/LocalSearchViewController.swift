//
//  LocalSearchViewController.swift
//  CarrotMarket
//
//  Created by JongHo Park on 2022/05/26.
//

import UIKit
import Combine

class LocalSearchViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchText: UILabel!
  private var dataSource: UITableViewDiffableDataSource<String, Town>!
  private var searchBar: UISearchBar!
  private var cancelBag: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationTitle()
    initializeDataSource()
    updateDataSource(towns: Town.mockTowns)
    tableView.delegate = self
    searchTextObserver()
  }

  private func setNavigationTitle() {
    let width: CGFloat = UIScreen.main.bounds.width
    searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 76, height: 0))
    searchBar.placeholder = "동명(읍, 면)으로 검색 (ex. 서초동)"
    searchBar.setImage(UIImage(systemName: "xmark"), for: .clear, state: .normal)
    searchBar.tintColor = .black.withAlphaComponent(0.8)
    searchBar.searchTextField.backgroundColor = .clear
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
  }

  private func initializeDataSource() {
    dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, town in
      let cell = tableView.dequeueReusableCell(withIdentifier: "TownCell", for: indexPath)
      print(town.city)
      var content = cell.defaultContentConfiguration()
      content.text = town.description
      cell.contentConfiguration = content
      return cell
    })
  }
  
  private func updateDataSource(towns: [Town], animate: Bool = false) {
    var snapshot: NSDiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<String, Town>()
    snapshot.appendSections([""])
    snapshot.appendItems(towns)
    DispatchQueue.global().async { [weak self] in
      guard let self = self else {
        return
      }
      self.dataSource.apply(snapshot, animatingDifferences: animate)
    }
  }
  
  @IBAction func dismiss(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
}
// MARK: TableView Delegate 설정
extension LocalSearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
// MARK: TextField Publisher 연결
extension LocalSearchViewController {
  private func searchTextObserver() {
    searchBar.searchTextField.textPublisher
      .sink { [weak self] text in
        guard let self = self else {
          return
        }
        self.updateDataSource(towns: self.filterTown(text))
        self.searchText.text = self.setSearchResult(text)
      }.store(in: &cancelBag)
  }
  
  private func filterTown(_ text: String) -> [Town] {
    guard !text.isEmpty else {
      return Town.mockTowns
    }
    return Town.mockTowns.filter { town in
      town.description.contains(text)
    }
  }
  
  private func setSearchResult(_ text: String) -> String {
    if text.isEmpty {
      return "근처 동네"
    } else {
      return "'\(text)' 검색 결과"
    }
  }
}
