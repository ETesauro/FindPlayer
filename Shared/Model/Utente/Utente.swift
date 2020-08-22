//
//  Utente.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import Foundation

struct Utente: Codable {
    var email: String
    var nickname: String
}

struct UtentiRisposta: Codable {
    var users: [Utente]
}
