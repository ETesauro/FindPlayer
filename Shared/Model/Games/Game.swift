//
//  Game.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import Foundation

struct Game: Codable {
    var name: String
    var id: Int
    var image: String
}

struct GameRisposta: Codable {
    var giochi: [Game]
}
