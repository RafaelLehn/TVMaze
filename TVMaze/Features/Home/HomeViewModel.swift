//
//  HomeViewModel.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/19/23.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func presentShows()
}

final class HomeViewModel {

    private let coordinator: MainCoordinator
    var shows: [ShowModel] = []
    var favorites : [Show] = []
    private let network: NetworkRequestsProtocol
    
    var coreData = DataBaseHelper()

    weak var delegate: HomeViewModelDelegate?
    
    init(coordinator: MainCoordinator, network: NetworkRequestsProtocol) {
        self.coordinator = coordinator
        self.network = network
    }

    public func getShows(id: Int) {
        network.makeRequest(id: id) { result in
            switch result {
            case .success(let shows):
                guard let shows = shows else {
                    print("No users were returned.")
                    return
                }
                self.shows = shows
                self.delegate?.presentShows()
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    public func goToDetail(show: ShowModel) {
        coordinator.goToShowDetail(show: show)
    }
    
    func buttonHeartTappedAt(movieIndex: Int){
       let toFavorite = shows[movieIndex]
        if checkFavorite(movieName: toFavorite.name){
            let favMovie = favorites.filter { item in item.name.contains(toFavorite.name) }
            deleteFavorite(movie: favMovie[0])
            fetchCoreData()
    
        } else {
            saveFavorite(movie: toFavorite)
            fetchCoreData()
        }
    }
    

    func checkFavorite(movieName: String) -> Bool{return favorites.contains(where: {$0.name == movieName})}
    
    func deleteFavorite(movie: Show) { coreData.delete(movie: movie) }
    
    func saveFavorite(movie: ShowModel){
        
        let favoriteMovie: ShowToCoreData = ShowToCoreData(
            
            name: movie.name, imageURL: movie.image.original, summary: movie.summary, id: movie.id
        )
        
        coreData.save(movie: favoriteMovie)
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
