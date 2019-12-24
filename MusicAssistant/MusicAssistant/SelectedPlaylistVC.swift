//
//  SelectedPlaylistVC.swift
//  MusicAssistant
//
//  Created by Ciro on 12/23/19.
//  Copyright © 2019 Ciro. All rights reserved.
//

import UIKit

var myIndexForRowForPlaylist = Int()


class SelectedPlaylistVC: UITableViewController {

    var playlists = [String]()
    var currentPlaylist = [String]()
    var songTitlesByArtist = [[String]]()
    var songList = [[String]]()
    var artisList = [String]()
    var indexOfSongs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getPlaylists()
        getCurrentPlaylist()
        navigationItem.title = playlists[myIndexForRowForPlaylist]
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentPlaylist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currentCellInfo = currentPlaylist[indexPath.row].components(separatedBy: ", ")
        let indexOne = Int(currentCellInfo[0])
        let indexTwo = Int(currentCellInfo[1])

        cell.textLabel?.text = songTitle[indexOne!][indexTwo!]
        cell.detailTextLabel?.text = artist[indexOne!]
        
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 24)
        tableView.tableFooterView = UIView()
        return cell
    }
    
    //function to add delete button when row is swiped
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
            print("Current Playlist1: \(currentPlaylist)")
            currentPlaylist.remove(at: indexPath.row)
            print("Current Playlist2: \(currentPlaylist)")
            saveCurrentPlaylist(name: playlists[myIndexForRowForPlaylist])
            print("Current Playlist3: \(currentPlaylist)")
            getCurrentPlaylist()
            tableView.reloadData()
            print("Current Playlist4: \(currentPlaylist)")
        }
    }
    
    func saveCurrentPlaylist(name: String){
        var tempList = [[String]]()
        for i in 0..<currentPlaylist.count{
            tempList.append([currentPlaylist[i]])
        }
        let tabFile = "\(name)-plist"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")
        
        let writeString = tempList.description
        
        do{
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getPlaylists(){
        let tabFile = "Playlists"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")
        do {
            let readString = try String(contentsOf: fileURL)
            var tempString = readString.replacingOccurrences(of: "\"", with: "")
            tempString = tempString.replacingOccurrences(of: "[", with: "")
            tempString = tempString.replacingOccurrences(of: "]", with: "")
            playlists = tempString.components(separatedBy: ", ")
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }

    func getCurrentPlaylist(){
        
        let tabFile = "\(playlists[myIndexForRowForPlaylist])-plist"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")
        do {
            let readString = try String(contentsOf: fileURL)
            
            var tempString = readString.replacingOccurrences(of: "\"", with: "")
            print("Current Playlist5: \(tempString)")
            tempString = tempString.replacingOccurrences(of: "[[", with: "")
            print("Current Playlist6: \(tempString)")
            tempString = tempString.replacingOccurrences(of: "]]", with: "")
            print("Current Playlist7: \(tempString)")
            currentPlaylist = tempString.components(separatedBy: "], [")
            print("Current Playlist8: \(currentPlaylist)")

        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedIndex = currentPlaylist[indexPath.row].components(separatedBy: ", ")
        
        myIndexForSection = Int(selectedIndex[0])!
        myIndexForRow = Int(selectedIndex[1])!
        
        //performSegue(withIdentifier: "fromPlaylistToSongView", sender: self)
    }
}
