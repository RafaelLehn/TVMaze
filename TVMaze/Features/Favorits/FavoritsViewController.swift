//
//  FavoritsViewController.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/22/23.
//

import Foundation
import UIKit

final class FavoritsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .none
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private let viewModel: FavoritsViewModel
    private var coreData = DataBaseHelper()


    init(viewModel: FavoritsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel.delegate = self
        setupUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchCoreData()
        tableView.reloadData()
    }
    
    func setupUI() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
        ])
    }
    
}


extension FavoritsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.favorites.isEmpty {
            return 1
        }
        return viewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.favorites.isEmpty {
            let errorCell = UITableViewCell()
            errorCell.backgroundColor = .black
            errorCell.textLabel?.text = "don't have shows"
            errorCell.textLabel?.textColor = .white
            return errorCell
        }
        let cell: FavoriteTableViewCell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
        
        cell.update(with: viewModel.favorites[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.favorites.isEmpty {
            return 80
        }
        
        return 260
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if !viewModel.favorites.isEmpty {
            if editingStyle == .delete {
                viewModel.deleteFavorite(movie: viewModel.favorites[indexPath.row])
            }
            
        }
    }
    
    
}


extension FavoritsViewController: FavoritsViewModelDelegate {
    func showRemovedFavorits() {
        tableView.reloadData()
    }
    
}
