//
//  Coordinator.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/18/23.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    func start()
    func goToHome()
    func goToShowDetail(show: ShowModel)
    func goToActorDetail(show: ActorsModel)
    func goToEpisodeDetail(episode: EpisodeModel)
}

