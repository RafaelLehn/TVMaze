//
//  ActorShowModel.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/23/23.
//

import Foundation

struct ActorShowModel: Codable {
    let actorShowModelSelf, voice: Bool
    let embedded: Embedded?
    
    init(actorShowModelSelf: Bool, voice: Bool, embedded: Embedded) {
        self.actorShowModelSelf = actorShowModelSelf
        self.voice = voice
        self.embedded = embedded
    }

    enum CodingKeys: String, CodingKey {
        case actorShowModelSelf = "self"
        case voice
        case embedded = "_embedded"
    }
}

struct Embedded: Codable {
    let show: ShowModel?
    
    init(show: ShowModel) {
        self.show = show
    }

    enum CodingKeys: String, CodingKey {
        case show
    }
}
