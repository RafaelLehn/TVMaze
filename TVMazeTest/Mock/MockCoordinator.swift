//
//  MockCoordinator.swift
//  TVMazeTests
//
//  Created by Ana Luiza on 3/23/23.
//

import Foundation
@testable import TVMaze

class MockCoordinator: Coordinator {
    
    var startIsCalled = false
    var goToHomeIsCalled = false
    var goToShowDetailIsCalled = false
    var goToActorDetailIsCalled = false
    var goToEpisodeDetailIsCalled = false
    
    var navigationController: UINavigationController { get set }
    
    func start() {
        startIsCalled = true
    }
    
    func goToHome() {
        goToHomeIsCalled = true
    }
    
    func goToShowDetail(show: ShowModel) {
        goToShowDetailIsCalled = true
    }
    
    func goToActorDetail(show: ActorsModel) {
        goToActorDetailIsCalled = true
    }
    
    func goToEpisodeDetail(episode: EpisodeModel) {
        goToEpisodeDetailIsCalled = true
    }
    
}
