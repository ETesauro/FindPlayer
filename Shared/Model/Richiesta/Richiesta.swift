//
//  Richiesta.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import Foundation

struct Richiesta: Codable {
    var id: Int
    var console: String
}

struct RichiesteRisposta: Codable {
    var richieste: [Richiesta]
}



// MARK: - GET RICHIESTE BY GAME ID
struct RichiesteByGameIDElement: Codable {
    let id: Int
    let console: String
    let gioco: Game
    let utente: Utente
}

typealias RichiesteByGameID = [RichiesteByGameIDElement]
// MARK: - :GET RICHIESTE BY GAME ID
