//
//  EpisodeModel.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/20/23.
//

import Foundation

struct EpisodeModel: Codable {
    let id: Int?
    let name: String?
    let image: ImageModel?
    let season: Int?
    let summary: String?
    let number: Int?
    
    init(id: Int, name: String, image: ImageModel, season: Int, summary: String, number: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.season = season
        self.summary = summary
        self.number = number
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case season = "season"
        case summary = "summary"
        case number = "number"
    }
}

struct ImageModel: Codable {
    let medium: String
    let original: String
    
    init(medium: String, original: String) {
        self.medium = medium
        self.original = original
    }

    enum CodingKeys: String, CodingKey {
        case medium = "medium"
        case original = "original"
    }
}
