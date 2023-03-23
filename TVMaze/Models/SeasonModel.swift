//
//  SeasonModel.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/20/23.
//

import Foundation

struct SeasonModel: Codable {
    let id: Int
    let number: Int
    
    init(id: Int, number: Int) {
        self.id = id
        self.number = number
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case number = "number"
    }
}







