//
//  CODGameStats.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import Foundation

struct CODGameStats: Codable {
    var wins: Int
    var kills: Int
    var kdRatio: Float
    var downs: Int
    var title: String
}
