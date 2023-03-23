//
//  HomeViewController.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/18/23.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: ShowCollectionViewCell.identifier)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.searchTextField.placeholder = "search a show"
        view.searchTextField.textColor = .white
        view.barTintColor = .black
        return view
    }()
    
    private let viewModel: HomeViewModel
    private var searchedShows: [ShowModel] = []
    private var searching = false
    private var page = 0
    private var isPageRefreshing:Bool = false
    
    
    init(viewModel: HomeViewModel) {
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
        searchBar.delegate = self
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if viewModel.shows.isEmpty {
            viewModel.getShows(id: page)
        }
        viewModel.fetchCoreData()
        collectionView.reloadData()
    }
    
    func setupUI() {
        logoImage.image = UIImage(named: "tv-maze-logo")
        logoImage.contentMode = .scaleToFill
        
        self.view.addSubview(mainStackView)
        self.view.addSubview(collectionView)
        mainStackView.addArrangedSubview(logoImage)
        mainStackView.addArrangedSubview(searchBar)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            
            logoImage.heightAnchor.constraint(equalToConstant: 120),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            
            collectionView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    func verifyFavorite(index: Int) -> String {
        
        if viewModel.checkFavorite(movieName: viewModel.shows[index].name){
            return "star.fill"
        } else {
            return "star"
        }
        
    }
    
    func verifyFavoriteInSearching(index: Int) -> String {
        
        if viewModel.checkFavorite(movieName: searchedShows[index].name){
            return "star.fill"
        } else {
            return "star"
        }
        
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.shows.count != 0 {
            if searching {
                return searchedShows.count
            } else {
                return viewModel.shows.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionViewCell.identifier, for: indexPath) as? ShowCollectionViewCell
        
        cell?.contentView.layer.cornerRadius = 25.0
        cell?.contentView.clipsToBounds = true
        cell?.contentView.layer.borderWidth = 1
        cell?.contentView.layer.borderColor = #colorLiteral(red: 0.4297937751, green: 0.7693057656, blue: 0.7303231955, alpha: 1).cgColor
        if searching {
            cell?.setCell(show: searchedShows[indexPath.item], image: verifyFavoriteInSearching(index: indexPath.row))
        } else {
            cell?.setCell(show: viewModel.shows[indexPath.item], image: verifyFavorite(index: indexPath.row))
        }
        
        cell?.item = indexPath.row
        cell?.cellDelegate = self
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width - 120, height: self.collectionView.frame.height-32)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.3) {
            cell?.contentView.alpha = 0.5
            UIView.animate(withDuration: 0.3) { // for animation effect
                cell?.contentView.alpha = 1.0
            } completion: { _ in
                if self.searching {
                    self.viewModel.goToDetail(show: self.searchedShows[indexPath.item])
                } else {
                    self.viewModel.goToDetail(show: self.viewModel.shows[indexPath.item])
                }
            }
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.contentOffset.x >= (self.collectionView.contentSize.width - self.collectionView.bounds.size.width)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                print(page)
                page = page + 1
                viewModel.getShows(id: page)
            }
        }
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    func presentShows() {
        DispatchQueue.main.async {
            self.isPageRefreshing = false
            self.collectionView.reloadData()
        }
    }
}

extension HomeViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String)
    {
        if !searchText.isEmpty {
            searching = true
            searchedShows.removeAll()
            for show in viewModel.shows {
                if show.name.lowercased().contains(searchText.lowercased()) {
                    searchedShows.append(show)
                }
            }
        } else {
            searching = false
            searchedShows.removeAll()
            searchedShows = viewModel.shows
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedShows.removeAll()
        collectionView.reloadData()
        
    }
}

extension HomeViewController: ShowCollectionViewCellDelegate {
    func isStarButtonTouched(indexPath: Int) {
        viewModel.buttonHeartTappedAt(movieIndex: indexPath)
        collectionView.reloadData()
    }
    
    
}
