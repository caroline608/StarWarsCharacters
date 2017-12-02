//
//  StarWars.swift
//  StarWarsURLSession
//
//  Created by Keshawn Swanston on 12/1/17.
//  Copyright © 2017 Caroline Cruz. All rights reserved.
//

import Foundation

struct StarWars: Codable {
    let next: String?
    let results: [ResultsWrapper]
}

struct ResultsWrapper: Codable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
}
