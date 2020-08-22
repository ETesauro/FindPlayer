//
//  RichiestaAccettata.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import Foundation

struct RichiestaAccettata: Codable {
    var id: Int
    
    //La richiesta per ora è int perchè si riferisce all'id della richiesta creata in precedenza
    //TO-DO: Capire come fare per ottenre l'oggetto richiesta senza mandare in loop il server
    var richiesta: Int
}

struct RichiesteAccettateRisposta: Codable {
    var richiesteAccettate: [RichiestaAccettata]
}
