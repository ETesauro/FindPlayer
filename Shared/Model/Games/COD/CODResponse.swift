//
//  CODResponse.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import Foundation

struct CODResponse: Codable {
    // Battle Royale
    var br: CODGameStats
    
    // Malloppo
    var br_dmz: CODGameStats
    
    //Totale
    var br_all: CODGameStats
}
