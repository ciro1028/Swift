//
//  PlaylistVC.swift
//  MusicAssistant
//
//  Created by Ciro on 12/21/19.
//  Copyright © 2019 Ciro. All rights reserved.
//

import UIKit

class PlaylistVC: UITableViewController {

    var playlists = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getPlaylists()
        
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playlists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlists", for: indexPath)
    
        cell.textLabel?.text = playlists[indexPath.row]
        
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 24)
        tableView.tableFooterView = UIView()
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            myIndexForRowForPlaylist = indexPath.row
    }
    
    //function to add delete button when row is swiped
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
            removeFile(name: playlists[indexPath.row])
            playlists.remove(at: indexPath.row)
            savePlaylist()
            getPlaylists()
            tableView.reloadData()
        }
    }
    
    func removeFile(name: String){
        let fileNameToDelete = "\(name)-list.txt"
               var filePath = ""
               
               // Find documents directory on device
                let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
               
               if dirs.count > 0 {
                   let dir = dirs[0] //documents directory
                   filePath = dir.appendingFormat("/" + fileNameToDelete)
                   print("Local path = \(filePath)")
        
               } else {
                   print("Could not find local directory to store file")
                   return
               }
               
               do {
                    let fileManager = FileManager.default
                   
                   // Check if file exists
                   if fileManager.fileExists(atPath: filePath) {
                       // Delete file
                       try fileManager.removeItem(atPath: filePath)
                   } else {
                       print("File does not exist")
                   }
        
               }
               catch let error as NSError {
                   print("An error took place: \(error)")
               }
    }
    
    func savePlaylist(){
        let tabFile = "Playlists"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")

        let writeString = playlists.description
        
        do{
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print(error)
        }
    }
    
}
