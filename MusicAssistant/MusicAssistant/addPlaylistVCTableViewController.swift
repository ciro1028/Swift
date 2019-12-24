//
//  addPlaylistVCTableViewController.swift
//  MusicAssistant
//
//  Created by Ciro on 12/23/19.
//  Copyright © 2019 Ciro. All rights reserved.
//

import UIKit

var passingIndex = String()

class addPlaylistVCTableViewController: UITableViewController {

    var playlists = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlaylists()
        indexOfSongAdded = passingIndex
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPlaylists()
        tableView.reloadData()
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
            print("Playlists: \(playlists)")
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playlists.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "Create New"
        } else {
            cell.textLabel?.text = playlists[indexPath.row - 1]
        }
        
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 24)
        tableView.tableFooterView = UIView()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            performSegue(withIdentifier: "toCreatePlaylist", sender: self)
        } else {
            var playlist = getCurrentPlaylist(name: playlists[indexPath.row - 1])
            playlist.append(passingIndex)
            savePlaylist(name: playlists[indexPath.row - 1], playlist: playlist)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func savePlaylist(name: String, playlist: [String]){
        let tabFile = "\(name)-plist"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")

        let writeString = playlist.description
        
        do{
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print(error)
        }
    }

    func getCurrentPlaylist(name: String) -> [String]{
        var playlist = [String]()
        let tabFile = "\(name)-plist"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")
        
        do {
            let readString = try String(contentsOf: fileURL)
            var tempString = readString.replacingOccurrences(of: "[\"[", with: "[")
            tempString = tempString.replacingOccurrences(of: "]\"]", with: "]")
            playlist = tempString.components(separatedBy: "\", \"")
        } catch let error as NSError {
            print("Error: \(error)")
        }
        
        return playlist
        
    }

}
