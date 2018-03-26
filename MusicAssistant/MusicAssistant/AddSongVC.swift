//
//  AddSongVC.swift
//  MusicAssistant
//
//  Created by Ciro on 6/30/17.
//  Copyright © 2017 Ciro. All rights reserved.
//

import UIKit

var fromImportedSongCheck = false
var addNewSongCheck = true
var checkComeFromEditChord = Bool()
var myIndexForRow = 0
var myIndexForSection = 0
var importedTab = String()
var importedTitle = String()
var importedArtist = String()
var addNewChordCheck = false

class AddSongVC: UIViewController {
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var artistInput: UITextField!
    @IBOutlet weak var lyricsInput: UITextView!
    @IBOutlet weak var addSongButton: UIButton!
    @IBOutlet weak var importFromWebButton: UIButton!
    
    var songIntoArray = [String]()
    var lyrics = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(AddSongVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddSongVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //setting text view border temporarily
        lyricsInput.layer.borderWidth = 1
        self.lyricsInput.layer.borderColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        
        if checkComeFromEditChord{
            songIntoArray = importedTab.components(separatedBy: "\n")
            lyricsInput.text = importedTab
            titleInput.text = importedTitle
            artistInput.text = importedArtist
            identifyChords(songIntoArray: songIntoArray)
            completeSaveLyrics()
            addNewSongCheck = false
            checkComeFromEditChord = false
        }
                
        if importedTab != ""{
            lyricsInput.text = importedTab
            titleInput.text = importedTitle
            artistInput.text = importedArtist
        }
        
        if addNewChordCheck{
            songIntoArray = importedTab.components(separatedBy: "\n")
            identifyChords(songIntoArray: songIntoArray)
            completeSaveLyrics()
            comingFromNewChord = true
            addNewSongCheck = true
            addNewChordCheck = false
        }
        if !addNewSongCheck {
            addSongButton.setTitle("Save", for: .normal)
            importFromWebButton.isHidden = true
        }else{
            if !fromImportedSongCheck{
                lyricsInput.text = ""
                titleInput.text = ""
                artistInput.text = ""
            }
            fromImportedSongCheck = false
        }
    }
    
    @IBAction func addSongButton(_ sender: UIButton) {
        songIntoArray = lyricsInput.text!.components(separatedBy: "\n")
        identifyChords(songIntoArray: songIntoArray)
        completeSaveLyrics()
        comingFromNewChord = true
        addNewSongCheck = true
    }
    
    //give up first responder at touch screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func identifyChords(songIntoArray: [String]){
        var chordFound = false
        var songArrayLine = [String()]
        var songConvertedArray = [String]()
        var finalLyrics = String()
        var currentLine = String()
        var checkForChords = Bool()
        for countOfeachLineOfTheSong in 0..<songIntoArray.count{
            songArrayLine = songIntoArray[countOfeachLineOfTheSong].components(separatedBy: " ")
            for i in 0..<songArrayLine.count{
                songArrayLine[i] = songArrayLine[i].replacingOccurrences(of: "\r", with: "")
            }
            for countOfEachWordOfTheLine in 0..<songArrayLine.count {
                
                //eliminate empty cells
                if songArrayLine[countOfEachWordOfTheLine] != "" {
                    
                    if countOfEachWordOfTheLine == 0 && songArrayLine.count > 1{
                        let word = songArrayLine[countOfEachWordOfTheLine + 1]
                        let pattern = "[ce-fh-ik-ln-rtw-zH-Z]"
                        if word.range(of: pattern, options: .regularExpression) != nil{
                            checkForChords = true
                        }
                    }
                    
                    
                    if countOfEachWordOfTheLine != songArrayLine.count - 1 {
                        let word = songArrayLine[countOfEachWordOfTheLine + 1]
                        let pattern = "[ce-fh-ik-ln-rtw-zH-Z]"
                        if word.range(of: pattern, options: .regularExpression) != nil{
                            checkForChords = true
                        }
                    }
                    
                    if !checkForChords {
                    //check first character of each cell and try to find it in the dictionary
                    for (key, value) in chords{
                        let startOfWord = songArrayLine[countOfEachWordOfTheLine].index(songArrayLine[countOfEachWordOfTheLine].startIndex, offsetBy: 0)
                        let endOfWord = songArrayLine[countOfEachWordOfTheLine].index(startOfWord, offsetBy: 1)
                        let rangeOfWord = startOfWord..<endOfWord
                        let firstCharOfWord = songArrayLine[countOfEachWordOfTheLine].substring(with: rangeOfWord)
                        if firstCharOfWord == key{
                            
                            for i in 0..<value.count{
                                if songArrayLine[countOfEachWordOfTheLine] == value[i]{
                                    songArrayLine[countOfEachWordOfTheLine] = songArrayLine[countOfEachWordOfTheLine].replacingOccurrences(of: songArrayLine[countOfEachWordOfTheLine], with: "<\(songArrayLine[countOfEachWordOfTheLine])>")
                                    chordFound = true
                                
                                } else {
                                    chordFound = false
                                }
                            }
                            
                        }
                    }
                    
                    if !chordFound{
                        if songArrayLine[countOfEachWordOfTheLine].characters.count >= 2 {
                            //check first two character for flat or sharp
                            for (key, value) in chords{
                                let startOfWord = songArrayLine[countOfEachWordOfTheLine].index(songArrayLine[countOfEachWordOfTheLine].startIndex, offsetBy: 0)
                                let endOfWord = songArrayLine[countOfEachWordOfTheLine].index(startOfWord, offsetBy: 2)
                                let rangeOfWord = startOfWord..<endOfWord
                                let firstCharOfWord = songArrayLine[countOfEachWordOfTheLine].substring(with: rangeOfWord)
                                
                                if firstCharOfWord == key{
                                    for i in 0..<value.count{
                                        if songArrayLine[countOfEachWordOfTheLine] == value[i]{
                                            songArrayLine[countOfEachWordOfTheLine] = songArrayLine[countOfEachWordOfTheLine].replacingOccurrences(of: songArrayLine[countOfEachWordOfTheLine], with: "<\(songArrayLine[countOfEachWordOfTheLine])>")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    }
                    
                }
                checkForChords = false
            }
            
            currentLine = songArrayLine.joined(separator: " ")
            songConvertedArray.append("\(currentLine)\n")
        }
        for temp in songConvertedArray{
            finalLyrics = finalLyrics.appending(temp)
        }
        lyricsInput.text = finalLyrics
    }
    
    func completeSaveLyrics(){

        if addNewSongCheck {
            if titleInput.text != "" {
                saveSongAndArtist()
                writeOnFile()
                let listVC = self.storyboard?.instantiateViewController(withIdentifier: "ListOfSongsVC") as! ListOfSongsVC
                self.navigationController?.pushViewController(listVC, animated: true)

                addNewSongCheck = false
            }
        } else {
            //first delete entry
            songTitle[myIndexForSection].remove(at: myIndexForRow)
            if songTitle[myIndexForSection].count < 1 {
                artist.remove(at: myIndexForSection)
                songTitle.remove(at: myIndexForSection)
            }
            
            //update entry from defaults
            let defaults = UserDefaults.standard
            defaults.set(songTitle, forKey: "SongList")
            let defaultsArtist = UserDefaults.standard
            defaultsArtist.set(artist, forKey: "Artist")
            saveSongAndArtist()
            writeOnFile()
            
            let viewSongVC = self.storyboard?.instantiateViewController(withIdentifier: "viewSongVC") as! ViewSongVC
            self.navigationController?.pushViewController(viewSongVC, animated: false)
            checkForNewChord = true
            transferableArtist = artistInput.text!
            transferableSongTitle = titleInput.text!
            transferableText = lyricsInput.text!
            addNewSongCheck = true
        }
    }
    
    //when button clicked save title and artist into array
    func saveSongAndArtist(){
        var count = false
        var getPositionOfArtist = 0
        
        for i in 0..<artist.count{
            if artistInput.text == artist[i] {
                getPositionOfArtist = i
                count = true
                break
            }
        }
        
        if count {
            songTitle[getPositionOfArtist].append(titleInput.text!)
            
        } else {
            artist.append(artistInput.text!)
            songTitle.append([titleInput.text!])
        }
        
        if keys.isEmpty{
            keys = [1: titleInput.text!]
        } else {
            let keyCount = keys.count
            keys[keyCount + 1] = titleInput.text!
        }
        
        let defaults = UserDefaults.standard
        defaults.set(songTitle, forKey: "SongList")
        let defaultsArtist = UserDefaults.standard
        defaultsArtist.set(artist, forKey: "Artist")
        let defaultsKeys = NSKeyedArchiver.archivedData(withRootObject: keys)
        UserDefaults.standard.set(defaultsKeys, forKey: "Keys")
    }
    
    //write on file or create file
    func writeOnFile() {
        if titleInput.text != nil {
            
            let tabFile = titleInput.text!
            let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")
            let writeString = lyricsInput.text!
            do{
                try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}

