//
//  ActorsModel.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/22/23.
//

import Foundation


struct ActorsModel: Codable {
    let id: Int?
    let name: String
    let image: ImageModel?
    
    init(id: Int, name: String, image: ImageModel, season: Int, summary: String, number: Int) {
        self.id = id
        self.name = name
        self.image = image
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
    }
}
