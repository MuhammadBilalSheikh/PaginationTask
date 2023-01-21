//
//  SearchVC.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import UIKit
import Foundation
import Combine


class SearchVC: BaseViewController<SearchViewModel> {

    @IBOutlet weak var SearchTableView: UITableView! {
        didSet {
            SearchTableView.delegate = self
            SearchTableView.dataSource = self
            SearchTableView.addSpinner()
        }
    }
    
    var observers: [AnyCancellable] = []
    var searchText: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel(binding: self)
        self.viewModel?.searchText = searchText
        setupViewModelObserver()
        setupCells()
        // Do any additional setup after loading the view.
    }
        
    private func setupCells() {
        
        self.SearchTableView.register(UINib.init(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }

 
    
    ///this function will handle the response from combine and reflect the result on the UI
    func setupViewModelObserver() {
        if(viewModel != nil) {
            viewModel!.isLoading = true
           if self.viewModel?.refresh == true {
                viewModel!.page = 1
            }
//            if(viewModel!.isLoading && viewModel!.page == 1) {
//            }
            
            self.viewModel!.fetchData()?.receive(on: DispatchQueue.main).sink( receiveCompletion: {[weak self] completion in
                self?.viewModel?.isLoading = false
                self?.SearchTableView.tableFooterView?.isHidden = true
                
                switch completion {
                case .finished:
                    print("Finished calling)")
                case .failure(let error):
                    print("Error calling \(error)")
                    // create the alert
                    let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self?.present(alert, animated: true, completion: nil)                }
            }, receiveValue: {[weak self] response in
                print("Response Successfully parsed with \(String(describing: response))")
                let model = self?.viewModel
                if(response != nil) {
                    
                    model?.handleResponse(response: response!)
                    
                }
                let page = model?.page ?? 0
                if(page > 1) {
                    let newIndexPaths = self?.viewModel?.calculateIndexPathsToReload(from: (self?.viewModel!.currentCount)!)
                    self?.onFetchCompleted(with: newIndexPaths)
                }else {
                    self?.onFetchCompleted(with: .none)
                }

            }).store(in: &observers)
        }
        
    }
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        // if we don't have anydata then reload all table and show the first result
        guard let newIndexPathsToReload = newIndexPathsToReload else {
                self.SearchTableView.reloadData()
                self.viewModel?.refresh = false
            return
        }
        // we avoid reloading all the table view
        self.SearchTableView.insertRows(at: newIndexPathsToReload, with: .automatic)
        SearchTableView.reloadRows(at: newIndexPathsToReload, with: .automatic)
        SearchTableView.reloadData()
    }
}

extension SearchVC: SearchDelegate {
    func reloadTableView() {
        self.setupViewModelObserver()
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentCount = viewModel?.currentCount ?? 0
        if(indexPath.row == currentCount - 1) {
            if(viewModel!.shouldFetchNextPage) {
                viewModel!.page += 1
                setupViewModelObserver()
                self.SearchTableView.tableFooterView?.isHidden = false
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   self.viewModel?.apiResponse?.itemsList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for : indexPath as IndexPath) as! SearchTableViewCell
        cell.selectionStyle = .none
        let data = self.viewModel?.apiResponse?.itemsList[indexPath.row]
        cell.loadData(avatar_URL: data?.avatarURL ?? "", Login_Text: data?.login ?? "", type_Text: data?.type ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}
