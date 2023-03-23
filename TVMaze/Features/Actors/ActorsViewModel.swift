//
//  ActorsViewModel.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/22/23.
//

import Foundation

protocol ActorsViewModelDelegate: AnyObject {
    func presentShows()
}

final class ActorsViewModel {

    private let coordinator: MainCoordinator
    public var shows: [ActorsModel] = []
    private let network: NetworkRequestsProtocol


    weak var delegate: ActorsViewModelDelegate?
    
    init(coordinator: MainCoordinator, network: NetworkRequestsProtocol) {
        self.coordinator = coordinator
        self.network = network
    }

    public func getActors() {
        network.makeRequestActors() { result in
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
    
    public func goToDetail(show: ActorsModel) {
        coordinator.goToActorDetail(show: show)
    }

}

