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
            filteredCharacterArr = starWarsChars!.results
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchTerm: String? {
        didSet {
            loadDataSearch()
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
        filteredCharacterArr = [ResultsWrapper]()
        loadData()
    }
    
    func loadDataSearch() {
        let urlStr = "https://swapi.co/api/people/?search=\(searchTerm!)"
        let setCharToOnlineChar: (StarWars) -> Void = {(onlineChar: StarWars) in
            self.starWarsChars = onlineChar
            print("hrewlhfls")
        }
        StarWarsAPI.manager.getCharacters(from: urlStr, completionHandler: setCharToOnlineChar, errorHandler: {print($0)})
    }
    
    func loadData() {
        //var charList = [StarWars]()
        for num in 1...9 {
        let urlStr = "https://swapi.co/api/people/?page=\(num)"
        let setCharToOnlineChar: (StarWars) -> Void = {(onlineChar: StarWars) in
            //self.starWarsChars = onlineChar
            //charList.append(onlineChar)
            self.filteredCharacterArr.append(contentsOf: onlineChar.results)
            
            self.tableView.reloadData()
            //print(charList)
           
        }
         StarWarsAPI.manager.getCharacters(from: urlStr, completionHandler: setCharToOnlineChar, errorHandler: {print($0)})
            
        }
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
