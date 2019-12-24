//
//  AddPlaylistVC.swift
//  MusicAssistant
//
//  Created by Ciro on 12/23/19.
//  Copyright © 2019 Ciro. All rights reserved.
//

import UIKit

var indexOfSongAdded = String()

class AddPlaylistVC: UIViewController {

    var playlists = [String]()
    
    @IBOutlet weak var playlistName: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func addPlaylistButton(_ sender: UIButton) {
        //removePlaylist(name: playlistName.text!)
        if playlistName.text == ""{
            nameLabel.text = "Please Choose a Name"
            nameLabel.textColor = UIColor.red
        } else {
            var checkIfExists = false
            for i in 0..<playlists.count {
                if playlistName.text! == playlists[i]{
                    nameLabel.text = "Name Already Exists"
                    nameLabel.textColor = UIColor.red
                    checkIfExists = true
                    break
                }
            }
            if !checkIfExists {
                createNewPlaylist(name: playlistName.text!)
                playlists.append(playlistName.text!)
                savePlaylist()
            }

        }
        performSegue(withIdentifier: "backToViewSong", sender: self)
    }
    
    func removePlaylist(name: String){
        let fileNameToDelete = "\(name).txt"
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
    
    func createNewPlaylist(name: String){
        let tabFile = "\(name)-plist"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")
        var newList = [String]()

        newList.append(indexOfSongAdded)
        let writeString = newList.description
        
        do{
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print(error)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        playlistName.text = ""
        dismiss(animated: true) {
            print("Dismiss add playlist")
        }
    }
    
    
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
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
}
