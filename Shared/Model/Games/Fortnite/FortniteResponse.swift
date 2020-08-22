//
//  FortniteResponse.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import Foundation

struct FortniteResponse: Codable {
    var epicUserHandle: String
    var avatar: String
    var stats: FortniteGameStats
}
