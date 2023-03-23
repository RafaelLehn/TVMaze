//
//  DetailViewModel.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/20/23.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func getEpisodes()
    func presentEpisodes()
}

final class DetailViewModel {

    private let coordinator: MainCoordinator
    var show: ShowModel
    var seasons: [SeasonModel] = []
    var episodes: [[EpisodeModel]] = []
    private let network: NetworkRequestsProtocol
    
    weak var delegate: DetailViewModelDelegate?
    
    init(coordinator: MainCoordinator, show: ShowModel, network: NetworkRequestsProtocol) {
        self.coordinator = coordinator
        self.show = show
        self.network = network
    }
    
    public func getSeasons(id: Int) {
        network.makeRequestSeason(id: id) { result in
            switch result {
            case .success(let seasons):
                guard let seasons = seasons else {
                    print("No users were returned.")
                    return
                }
                self.seasons = seasons
                self.delegate?.getEpisodes()
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    public func getEpisodes(id: Int) {
            self.network.makeRequestEpisodes(id: id) { result in
                switch result {
                case .success(let episodes):
                    guard let episodes = episodes else {
                        print("No users were returned.")
                        return
                    }
                    self.episodes.append(episodes)
                    self.delegate?.presentEpisodes()
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                    
                }
            }
        }
    
    public func goToEpisodeDetail(episode: EpisodeModel) {
        coordinator.goToEpisodeDetail(episode: episode)
    }
}

