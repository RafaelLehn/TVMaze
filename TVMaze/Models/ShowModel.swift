//
//  ShowModel.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/18/23.
//

struct ShowModel: Codable {
    let id: Int
    let url: String
    let name, type, language: String
    let genres: [String]?
    let status: String?
    let runtime, averageRuntime: Int?
    let premiered: String?
    let officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let network: Network?
    let externals: Externals?
    let image: Image
    let summary: String
    let updated: Int?
    let links: Links?
    
    init(id: Int, url: String, name: String, type: String, language: String, genres: [String], status: String, runtime: Int, averageRuntime: Int, premiered: String, officialSite: String, schedule: Schedule, rating: Rating, weight: Int, network: Network, externals: Externals, image: Image, summary: String, updated: Int, links: Links) {
        self.id = id
        self.url = url
        self.name = name
        self.type = type
        self.language = language
        self.genres = genres
        self.status = status
        self.runtime = runtime
        self.averageRuntime = averageRuntime
        self.premiered = premiered
        self.officialSite = officialSite
        self.schedule = schedule
        self.rating = rating
        self.weight = weight
        self.network = network
        self.externals = externals
        self.image = image
        self.summary = summary
        self.updated = updated
        self.links = links
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case name = "name"
        case type = "type"
        case language = "language"
        case genres = "genres"
        case status = "status"
        case runtime = "runtime"
        case averageRuntime = "averageRuntime"
        case premiered = "premiered"
        case officialSite = "officialSite"
        case schedule = "schedule"
        case weight = "weight"
        case rating = "rating"
        case network = "network"
        case externals = "externals"
        case image = "image"
        case summary = "summary"
        case updated = "updated"
        case links = "links"
    }
}

// MARK: - Externals
struct Externals: Codable {
    let tvrage, thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, previousepisode: Previousepisode
    
}

// MARK: - Previousepisode
struct Previousepisode: Codable {
    let href: String
}

// MARK: - Network
struct Network: Codable {
    let id: Int
    let name: String
    let country: Country
}

// MARK: - Country
struct Country: Codable {
    let name, code, timezone: String
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

// MARK: - Schedule
struct Schedule: Codable {
    let time: String
    let days: [String]
}

struct ShowToCoreData : Codable {
    var name: String
    var imageURL : String
    var summary : String
    var id : Int
}
