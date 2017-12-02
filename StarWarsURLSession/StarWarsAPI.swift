//
//  StarWarsAPI.swift
//  StarWarsURLSession
//
//  Created by Keshawn Swanston on 12/1/17.
//  Copyright © 2017 Caroline Cruz. All rights reserved.
//

import Foundation

class StarWarsAPI{
    private init() {}
    static let manager = StarWarsAPI()
    func getCharacters(from urlStr: String,
                 completionHandler: @escaping (StarWars) -> Void,
                 errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let character = try JSONDecoder().decode(StarWars.self, from: data)
                completionHandler(character)
            }
            catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
