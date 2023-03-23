//
//  EpisodeViewModel.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/21/23.
//
import Foundation

protocol EpisodeViewModelDelegate: AnyObject {
}

final class EpisodeViewModel {

    private let coordinator: MainCoordinator
    var episode: EpisodeModel
    
    weak var delegate: EpisodeViewModelDelegate?
    
    init(coordinator: MainCoordinator, episode: EpisodeModel) {
        self.coordinator = coordinator
        self.episode = episode
    }

}


