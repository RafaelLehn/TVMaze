//
//  MockApiService.swift
//  TVMazeTests
//
//  Created by Ana Luiza on 3/23/23.
//

@testable import TVMaze

class MockApiService: NetworkRequestsProtocol {
    var isFetchShowCalled = false
    var isFetchSeasonCalled = false
    var isFetchEpisodesCalled = false
    var isFetchActorsCalled = false
    var isFetchActorShowalled = false
    
    func makeRequest(id: Int,_ completion: @escaping (Result<([ShowModel]?), Error>) -> Void){
        isFetchShowCalled = true
    }
    
    func makeRequestSeason(id: Int, _ completion: @escaping (Result<([SeasonModel]?), Error>) -> Void) {
        isFetchSeasonCalled = true
    }
    
    func makeRequestEpisodes(id: Int, _ completion: @escaping (Result<([EpisodeModel]?), Error>) -> Void) {
        isFetchEpisodesCalled = true
    }
    
    func makeRequestActors(_ completion: @escaping (Result<([ActorsModel]?), Error>) -> Void) {
        isFetchActorsCalled = true
    }
    
    func makeRequestActorShow(id: Int, _ completion: @escaping (Result<([ActorShowModel]?), Error>) -> Void) {
        isFetchActorShowalled = true
    }
}
