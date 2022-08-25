//
//  CountrySelectionViewController.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import UIKit
import RxRelay
import RxCocoa

class CountrySelectionViewController: MSViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var loader: UIActivityIndicatorView!
    
    var viewModel: CountrySelectionViewModel!
    
    weak var result: BehaviorRelay<CountryCompatible?>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.bindData()
        self.viewModel.fetch()
        
    }
    
    private func configureUI() {
        self.searchBar.placeholder = "country.list.searchbar.placeholder".localized
        
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.tableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
    }
    
    private func bindData() {
        
        self.searchBar.rx.text.orEmpty
            .subscribe(onNext: { [weak self] text in
                self?.viewModel.search(searchString: text)
            }).disposed(by: self.disposeBag)
                
        self.viewModel.items.bind(to: self.tableView.rx.items(cellIdentifier: "cellId", cellType: CountryTableViewCell.self)) { [weak self] (row,item,cell) in
            
            cell.item = item
            cell.selectionStyle = .none
            
            self?.loader.stopAnimating()
            
        }.disposed(by: self.disposeBag)
                
        self.tableView.rx.modelSelected(Country.self).subscribe(onNext: { [weak self] country in
            self?.result?.accept(country)
            self?.dismiss(animated: true)
        }).disposed(by: self.disposeBag)
    }


}

extension CountrySelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}
