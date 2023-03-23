//
//  FavoritsViewModel.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/22/23.
//

import Foundation

protocol FavoritsViewModelDelegate: AnyObject {
    func showRemovedFavorits()
}

final class FavoritsViewModel {

    private let coordinator: MainCoordinator
    var favorites : [Show] = []

    var coreData = DataBaseHelper()

    weak var delegate: FavoritsViewModelDelegate?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToDetail(show: ShowModel) {
        coordinator.goToShowDetail(show: show)
    }
    
    func deleteFavorite(movie: Show) {
        coreData.delete(movie: movie)
        self.delegate?.showRemovedFavorits()
        
    }
    
    func fetchCoreData(){
        coreData.requestFavorites { (favoritesMoviesCoreData:Result<[Show], Error>) in
            switch favoritesMoviesCoreData {
            case.success(let favoritesMoviesCoreData):
                self.favorites = favoritesMoviesCoreData
            case.failure(let error):
                print(error)
            }
        }
    }

}
