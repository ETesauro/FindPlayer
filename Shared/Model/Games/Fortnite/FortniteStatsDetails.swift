//
//  FortniteStatsDetails.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import Foundation

struct FortniteStatsDetails: Codable {
    // Vittorie
    var top1: FortniteCategoryDetails
    
    // Numero di match
    var matches: FortniteCategoryDetails
    
    // Vittorie/Sconfitte
    var winRatio: FortniteCategoryDetails
    
    // Kills
    var kills: FortniteCategoryDetails
    
    // Kill/Morti
    var kd: FortniteCategoryDetails
}
