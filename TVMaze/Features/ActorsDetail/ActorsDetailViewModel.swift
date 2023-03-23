//
//  ActorsDetailViewModel.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/22/23.
//

import Foundation
protocol ActorsDetailViewModelDelegate: AnyObject {
    func presentShows()
}

final class ActorsDetailViewModel {

    private let coordinator: MainCoordinator
    public var actor: ActorsModel
    private let network: NetworkRequestsProtocol
    public var showActor: [ActorShowModel] = []


    weak var delegate: ActorsDetailViewModelDelegate?
    
    init(coordinator: MainCoordinator, actor: ActorsModel, network: NetworkRequestsProtocol) {
        self.coordinator = coordinator
        self.actor = actor
        self.network = network
    }
    
    public func getActors(id: Int) {
        network.makeRequestActorShow(id: id) { result in
            switch result {
            case .success(let showActor):
                guard let showActor = showActor else {
                    print("No users were returned.")
                    return
                }
                self.showActor = showActor
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

