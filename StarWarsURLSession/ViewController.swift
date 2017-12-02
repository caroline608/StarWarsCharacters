//
//  ViewController.swift
//  StarWarsURLSession
//
//  Created by Keshawn Swanston on 12/1/17.
//  Copyright © 2017 Caroline Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var starWarsChars: StarWars? {
        didSet{
            filteredCharacterArr = starWarsChars!.results.filter{$0.name.range(of: searchTerm!, options: .caseInsensitive) != nil}
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchTerm: String? {
        didSet {
            loadData()
        }
    }
    
    var filteredCharacterArr: [ResultsWrapper] = [] {
        didSet {
            dump(filteredCharacterArr)
            self.tableView.reloadData()

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        filteredCharacterArr=[ResultsWrapper]()
    }
    
    func loadData() {
        let urlStr = "https://swapi.co/api/people/?search="
        let setCharToOnlineChar: (StarWars) -> Void = {(onlineChar: StarWars) in
            self.starWarsChars = onlineChar
            print("hrewlhfls")
        }
        StarWarsAPI.manager.getCharacters(from: urlStr, completionHandler: setCharToOnlineChar, errorHandler: {print($0)})
    }
    
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacterArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let starWarsChar = filteredCharacterArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Character Cell", for: indexPath)
        cell.textLabel?.text = starWarsChar.name
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
    }
    
}
