//
//  Network.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/18/23.
//

import Foundation

protocol NetworkRequestsProtocol: AnyObject {
    func makeRequest(id: Int,_ completion: @escaping (Result<([ShowModel]?), Error>) -> Void)
    func makeRequestSeason(id: Int, _ completion: @escaping (Result<([SeasonModel]?), Error>) -> Void)
    func makeRequestEpisodes(id: Int, _ completion: @escaping (Result<([EpisodeModel]?), Error>) -> Void)
    func makeRequestActors(_ completion: @escaping (Result<([ActorsModel]?), Error>) -> Void)
    func makeRequestActorShow(id: Int, _ completion: @escaping (Result<([ActorShowModel]?), Error>) -> Void)
}

class NetworkRequests: NetworkRequestsProtocol {
    
    func makeRequest(id: Int,_ completion: @escaping (Result<([ShowModel]?), Error>) -> Void) {
        
        lazy var decoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: URL(string: "https://api.tvmaze.com/shows?page=\(id)")!) { data, response, error in
            
            guard let data = data, error == nil else{
                completion(.success(nil))
                return
            }
            
            do {
                let returned: [ShowModel]? = (try JSONConverter.decode(data))
                completion(.success(returned))
            } catch {
                print("\(error.localizedDescription)")
            }
            
        }
        .resume()
    }
    
    func makeRequestSeason(id: Int, _ completion: @escaping (Result<([SeasonModel]?), Error>) -> Void) {
        
        lazy var decoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: URL(string: "https://api.tvmaze.com/shows/\(id)/seasons")!) { data, response, error in
            
            guard let data = data, error == nil else{
                completion(.success(nil))
                return
            }
            
            do {
                let returned: [SeasonModel]? = (try JSONConverter.decode(data))
                completion(.success(returned))
            } catch {
                print("\(error.localizedDescription)")
            }
            
        }
        .resume()
    }
    
    func makeRequestEpisodes(id: Int, _ completion: @escaping (Result<([EpisodeModel]?), Error>) -> Void) {
        
        lazy var decoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: URL(string: "https://api.tvmaze.com/seasons/\(id)/episodes")!) { data, response, error in
            
            guard let data = data, error == nil else{
                completion(.success(nil))
                return
            }
            
            do {
                let returned: [EpisodeModel]? = (try JSONConverter.decode(data))
                completion(.success(returned))
            } catch {
                print("\(error.localizedDescription)")
            }
            
        }
        .resume()
    }
    
    func makeRequestActors(_ completion: @escaping (Result<([ActorsModel]?), Error>) -> Void) {
        
        lazy var decoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: URL(string: "https://api.tvmaze.com/people")!) { data, response, error in
            
            guard let data = data, error == nil else{
                completion(.success(nil))
                return
            }
            
            do {
                let returned: [ActorsModel]? = (try JSONConverter.decode(data))
                completion(.success(returned))
            } catch {
                print("\(error.localizedDescription)")
            }
            
        }
        .resume()
    }
    
    
    
    func makeRequestActorShow(id: Int, _ completion: @escaping (Result<([ActorShowModel]?), Error>) -> Void) {
        
        lazy var decoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: URL(string: "https://api.tvmaze.com/people/\(id)/castcredits?embed=show")!) { data, response, error in
            
            guard let data = data, error == nil else{
                completion(.success(nil))
                return
            }
            
            do {
                let returned: [ActorShowModel]? = (try JSONConverter.decode(data))
                completion(.success(returned))
            } catch {
                print("\(error.localizedDescription)")
            }
            
        }
        .resume()
    }
}


public struct JSONConverter {
    public static func decode<T: Decodable>(_ data: Data) throws -> [T]? {
        do {
            let decoded = try JSONDecoder().decode([T].self, from: data)
            return decoded
        } catch {
            throw error
        }
    }
}
