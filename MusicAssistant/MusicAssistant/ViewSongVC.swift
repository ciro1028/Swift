//
//  ViewSongVC.swift
//  MusicAssistant
//
//  Created by Ciro on 6/30/17.
//  Copyright © 2017 Ciro. All rights reserved.
//

import UIKit
import StoreKit
import MediaPlayer
import Alamofire
import SwiftyJSON
import MediaPlayer

var currentLyrics = ""
var transferableSongTitle = String()
var transferableArtist = String()
var transferableText = String()
var newChords = [String]()
var checkForNewChord = Bool()
var checkTransposeMinus = Bool()
var checkTransposePlus = Bool()
var transposeLyrics = String()
var fontSize: CGFloat = 16.0
var chordColor: UIColor = UIColor.blue
var activeField: UITextField?
var songID = String()
var songDuration = Int()
let myMediaPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
var timer : Timer?
var count = 0
var minCount = 0
var selectA = 0.0
var selectB = 0.0
var repeatStatus = false
var settingsFile = Array<Array<String>>()
var currentSongSettings = Array<String>()

class ViewSongVC: UIViewController, MPMediaPickerControllerDelegate{
    
    var matches2 = [String]()
    var tempMatches2 = [String]()
    var countOfTransposes = 0
    var checkSaveOrSettings = Bool()
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var lyricsArea: UITextView!
    @IBOutlet weak var optionalSearch: UISegmentedControl!
    @IBOutlet weak var transposeText: UIButton!
    @IBOutlet weak var checkUser: UIBarButtonItem!
    @IBOutlet weak var playBar: UIView!
    @IBOutlet weak var songProgressBar: UISlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var selectRepeatButton: UIButton!
    @IBOutlet weak var songNotFoundLabel: UILabel!
    
    @IBAction func optionalSearchButton(_ sender: UISegmentedControl) {
        let searchWebViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchWebVC") as! SearchWebVC
        if optionalSearch.selectedSegmentIndex == 0{
            let searchString = artistLabel.text!
            searchWebViewController.importedSearch = searchString.replacingOccurrences(of: " ", with: "-")
            searchWebViewController.check = false
        } else {
            searchWebViewController.importedSearch = artistLabel.text!
            searchWebViewController.check = true
        }
        self.navigationController?.pushViewController(searchWebViewController, animated: true)
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "addSongVC") as! AddSongVC
               addNewSongCheck = false
               importedTitle = songTitleLabel.text!
               importedArtist = artistLabel.text!
               importedTab = lyricsArea.text!
               self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    
    @IBAction func fontMinus(_ sender: UIButton) {
        if fontSize != 6.0{
            fontSize -= 1.0
        }
        getSettingsFile()
        appendSongSetting()
        writeOnSettings()
        findFile()
        identifyChords(lyricsToEdit: lyricsArea.text!)
    }
    
    @IBAction func fontPlus(_ sender: UIButton) {
        if fontSize != 30.0{
            fontSize += 1.0
        }
        getSettingsFile()
        appendSongSetting()
        writeOnSettings()
        findFile()
        identifyChords(lyricsToEdit: lyricsArea.text!)
    }
    
    func getFontSizeFromFile(){
        for i in 0..<settingsFile.count{
            if songTitleLabel.text! == settingsFile[i][0]{
                if artistLabel.text! == settingsFile[i][1]{
                    currentSongSettings = settingsFile[i]
                    fontSize = CGFloat(Double(currentSongSettings[2])!)
                }
            }
        }
    }
    
    // Get the file and turn it into an array
    func getSettingsFile(){
        settingsFile.removeAll()
        let tabFile = "Settings"
        var emptyFile = false
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")
        do {
            var readString = try String(contentsOf: fileURL)
            if readString == "" {
                emptyFile = true
                fontSize = 16.0
            }
            readString = readString.replacingOccurrences(of: "\"", with: "")
            readString = readString.replacingOccurrences(of: "\\", with: "")
            if !emptyFile {
                var tempArrayOfSettings = readString.components(separatedBy: "], [")
                tempArrayOfSettings[0] = tempArrayOfSettings[0].replacingOccurrences(of: "[[", with: "")
                tempArrayOfSettings[tempArrayOfSettings.count - 1] = tempArrayOfSettings[tempArrayOfSettings.count - 1].replacingOccurrences(of: "]]", with: "")
                for i in 0..<tempArrayOfSettings.count{
                    settingsFile.append(tempArrayOfSettings[i].components(separatedBy: ", "))
                }
            }
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    //add or edit current song into the array
    func appendSongSetting(){

        currentSongSettings = [songTitleLabel.text!, artistLabel.text!, String(Double(fontSize))]
        var testIfExists = false
        var currentSongPossition = Int()
        for i in 0..<settingsFile.count{
            if songTitleLabel.text! == settingsFile[i][0]{
                if artistLabel.text! == settingsFile[i][1]{
                    testIfExists = true
                    currentSongPossition = i
                }
            }
        }
        if testIfExists {
            settingsFile[currentSongPossition] = currentSongSettings
        } else {
            settingsFile.append(currentSongSettings)
        }
    }
    
    //save updated file
    func writeOnSettings() {

        let tabFile = "Settings"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")
        
        let writeString = settingsFile.description
        
        do{
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func transposeMinusButton(_ sender: UIButton) {
        checkTransposeMinus = true
        identifyChords(lyricsToEdit: transposeLyrics)
        countOfTransposes = countOfTransposes + 1
        checkTransposeMinus = false
        //transposeText.setTitle("Original", for: .normal)
        checkSaveOrSettings = true
        checkTransposeMinus = false
    }
    
    @IBAction func transposePlus(_ sender: UIButton) {
        checkTransposePlus = true
        identifyChords(lyricsToEdit: transposeLyrics)
        countOfTransposes = countOfTransposes + 1
        checkTransposePlus = false
        checkSaveOrSettings = true
        checkTransposePlus = false
    }
    
    @IBAction func originalTone(_ sender: UIButton) {
        findFile()
        identifyChords(lyricsToEdit: lyricsArea.text!)
        transposeText.setTitle("Transpose", for: .normal)
    }
    
    @IBAction func settingsButton(_ sender: UIButton) {
        if checkSaveOrSettings{
            transposeText.setTitle("Transpose", for: .normal)
            checkSaveOrSettings = false
        } else {
            
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override var keyCommands: [UIKeyCommand]?{
        return[
            UIKeyCommand(input: UIKeyCommand.inputLeftArrow, modifierFlags: [], action: #selector(self.LeftArrowPress(sender:))),
            UIKeyCommand(input: UIKeyCommand.inputRightArrow, modifierFlags: [], action: #selector(self.RightArrowPress(sender:)))
        ]
    }
    
    @objc func LeftArrowPress(sender: UIKeyCommand){
        if (lyricsArea.contentOffset.y - 300) >= 0{
            
            lyricsArea.setContentOffset(CGPoint(x:0,y:lyricsArea.contentOffset.y - 200), animated: true);
        }
        else{
            lyricsArea.setContentOffset(.zero, animated: true)
        }
    }
    
    @objc func RightArrowPress(sender: UIKeyCommand){
        if (lyricsArea.contentSize.height>(lyricsArea.frame.size.height + lyricsArea.contentOffset.y)){
            
            lyricsArea.setContentOffset(CGPoint(x:0,y:lyricsArea.contentOffset.y + 200), animated: true);
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if checkForNewChord{
            songTitleLabel.text = transferableSongTitle
            artistLabel.text = transferableArtist
            lyricsArea.text = transferableText
            checkForNewChord = false
        } else {
            songTitleLabel.text = songTitle[myIndexForSection][myIndexForRow]
            artistLabel.text = artist[myIndexForSection]
        }
        fontSize = 16.0
        getSettingsFile()
        getFontSizeFromFile()
        findFile()
        
        identifyChords(lyricsToEdit: lyricsArea.text!)
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(ViewSongVC.tapRecognizerMethod(recognizer:)))
        tapped.numberOfTapsRequired = 1
        lyricsArea.addGestureRecognizer(tapped)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewSongVC.longPressTapRecognizerMethod(recognizer:)))
        lyricsArea.addGestureRecognizer(longPress)
        
        getSongIdFromApple(songName: songTitle[myIndexForSection][myIndexForRow])
        passingIndex = "[\(myIndexForSection), \(myIndexForRow)]"
        //requestStatus()
        
    }
    
    func requestPermission(){
        SKCloudServiceController.requestAuthorization { (SKCloudServiceAuthorizationStatus) in
            myMediaPlayer.setQueue(with: [songID])
        }
    }
    
//    func requestStatus() -> String{
//        let status = SKCloudServiceController.authorizationStatus()
//        var type = ""
//        
//        switch status{
//        case .authorized:
//            type = "Authorized"
//        case .denied:
//            type = "Denied"
//        case .notDetermined:
//            type = "Not Determined"
//        case .restricted:
//            type = "Restricted"
//        }
//        print("STATUS OF AUTHORIZATION: \(type)")
//        return type
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        myMediaPlayer.stop()
        resetTimeLabel()
        timer?.invalidate()
        repeatStatus = false
        self.songProgressBar.isHidden = false
        self.songNotFoundLabel.isHidden = true
        
    }
    
//    // method to get the song id based on the current tab
    func getSongIdFromApple(songName: String){

        let formattedTitle = songTitleLabel.text!.replacingOccurrences(of: " ", with: "+")
        let formattedArtist = artistLabel.text!.replacingOccurrences(of: " ", with: "+")

        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IllISzQzSlNVQzQifQ.eyJpc3MiOiJNQjVSMkpEVDRLIiwiaWF0IjoxNTc2MjY4NjExLCJleHAiOjE1ODkyMjUwMTF9.syyQuUUvZv4fbbEasecayAqA7HTh7EjFv9bqtutDsQYiFD97UKquWJpdDuIAAtg5dV5uTHozLxvkIhQkWtC8Rw",
            "Accept": "application/json"
        ]

        var url = "https://api.music.apple.com/v1/catalog/us/search?term=\(formattedTitle)+\(formattedArtist)&types=songs"
        
        url = url.replacingOccurrences(of: "’", with: "")
        url = url.replacingOccurrences(of: "ç", with: "c")
        url = url.replacingOccurrences(of: "ã", with: "a")
        url = url.replacingOccurrences(of: "á", with: "a")
        url = url.replacingOccurrences(of: "â", with: "a")
        url = url.replacingOccurrences(of: "à", with: "a")
        url = url.replacingOccurrences(of: "é", with: "e")
        url = url.replacingOccurrences(of: "ê", with: "e")
        url = url.replacingOccurrences(of: "í", with: "i")
        url = url.replacingOccurrences(of: "ó", with: "o")
        url = url.replacingOccurrences(of: "ô", with: "o")
        url = url.replacingOccurrences(of: "õ", with: "o")
        url = url.replacingOccurrences(of: "Ú", with: "U")
        url = url.replacingOccurrences(of: "Ç", with: "C")
        url = url.replacingOccurrences(of: "Ã", with: "A")
        url = url.replacingOccurrences(of: "Á", with: "A")
        url = url.replacingOccurrences(of: "Â", with: "A")
        url = url.replacingOccurrences(of: "É", with: "E")
        url = url.replacingOccurrences(of: "Ê", with: "E")
        url = url.replacingOccurrences(of: "Í", with: "I")
        url = url.replacingOccurrences(of: "Ó", with: "O")
        url = url.replacingOccurrences(of: "Ô", with: "O")
        url = url.replacingOccurrences(of: "Õ", with: "O")
        url = url.replacingOccurrences(of: "Ú", with: "U")
        url = url.replacingOccurrences(of: "À", with: "A")

        print("THIS IS THE URL::::::: \(url)")

        Alamofire.request(url, headers: headers).responseJSON { response in
            if response.result.isSuccess {

                let songJSON : JSON = JSON(response.result.value!)

                let numOfOccurrences = songJSON["results"]["songs"]["data"].count
                var indexOfRightSong = 0

                for i in 0..<numOfOccurrences {

                    if songJSON["results"]["songs"]["data"][i]["attributes"]["artistName"].string == artist[myIndexForSection] {
                        indexOfRightSong = i
                    }
                }
                if songJSON["results"]["songs"]["data"].count != 0 {
                    songID = songJSON["results"]["songs"]["data"][indexOfRightSong]["id"].string!
                    songDuration = songJSON["results"]["songs"]["data"][indexOfRightSong]["attributes"]["durationInMillis"].int!
                } else {
                    songID = ""
                    self.songProgressBar.isHidden = true
                    self.songNotFoundLabel.isHidden = false
                }
            }
            else {
                print("COULDN'T FIND THE SONG")
            }

        }

    }
    
    @IBAction func playSongButton(_ sender: UIBarButtonItem) {
        requestPermission()
        playBar.isHidden = false
        songProgressBar.minimumValue = 0.0
        songProgressBar.maximumValue = Float(songDuration / 1000)
        songProgressBar.value = 0
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        myMediaPlayer.play()
        pauseButton.isHidden = false
        playButton.isHidden = true
        setTimer()
    }
    
    func setTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            self.songProgressBar.value = Float(myMediaPlayer.currentPlaybackTime)
        
            self.setSecondsLabel()
            self.setMinuteLabel()
            
            count += 1
            
            if repeatStatus {
                if myMediaPlayer.currentPlaybackTime >= selectB {
                    myMediaPlayer.currentPlaybackTime = selectA
                }
            }
            
        }
    }
    
    //method to set Minute Label
    func setMinuteLabel(){
        
        minCount = Int(myMediaPlayer.currentPlaybackTime / 60)
        
        if minCount < 10 {
            minuteLabel.text = "0\(String(minCount))"
        } else {
            minuteLabel.text = String(minCount)
        }
    }
    
    func setSecondsLabel(){
        
        if Int(myMediaPlayer.currentPlaybackTime) < 60 {
            count = Int(myMediaPlayer.currentPlaybackTime)
        } else {
            count = Int(myMediaPlayer.currentPlaybackTime) % 60
        }
        
        if count < 10 {
            self.secondLabel.text = "0\(String(count))"
        } else {
            self.secondLabel.text = String(count)
        }
    }
    
    @IBAction func timeProgressBar(_ sender: Any) {
        setAfterSliderChanged()
    }
    
    
    func setAfterSliderChanged(){
        myMediaPlayer.currentPlaybackTime = TimeInterval(songProgressBar.value)
        setSecondsLabel()
        setMinuteLabel()
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        myMediaPlayer.pause()
        pauseButton.isHidden = true
        playButton.isHidden = false
        timer?.invalidate()
    }
    
    func resetTimeLabel(){
        secondLabel.text = "00"
        minuteLabel.text = "00"
        count = 0
        minCount = 0
    }
    
    @IBAction func closeButton(_ sender: Any) {
        playBar.isHidden = true
        myMediaPlayer.stop()
        resetTimeLabel()
        timer?.invalidate()
        pauseButton.isHidden = true
        playButton.isHidden = false
        repeatStatus = false
        selectA = 0.0
        selectB = 0.0
        selectRepeatButton.setTitle("Select A", for: .normal)
    }
    
    @IBAction func selectRepeatButton(_ sender: Any) {
        
        selectRepeat()
        
    }
    
    func selectRepeat(){
        
        if selectRepeatButton.titleLabel?.text == "Select A" {
            selectA = myMediaPlayer.currentPlaybackTime
            selectRepeatButton.setTitle("Select B", for: .normal)
        } else if selectRepeatButton.titleLabel!.text == "Select B"{
            selectB = myMediaPlayer.currentPlaybackTime
            selectRepeatButton.setTitle("Off", for: .normal)
            repeatStatus = true
        } else {
            selectA = 0.0
            selectB = 0.0
            selectRepeatButton.setTitle("Select A", for: .normal)
            repeatStatus = false
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //lyricsArea.setContentOffset(.zero, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        optionalSearch.selectedSegmentIndex = UISegmentedControl.noSegment
    }
    
    @objc func popToRoot(sender:UIBarButtonItem){
        let toListOfSongs = self.storyboard?.instantiateViewController(withIdentifier: "ListOfSongsVC") as! ListOfSongsVC
        self.navigationController?.pushViewController(toListOfSongs, animated: true)
        checkFirstLoad = true
    }
    
    @objc func longPressTapRecognizerMethod(recognizer: UILongPressGestureRecognizer){
        if recognizer.state == .ended{
            let myTextView = recognizer.view as! UITextView //sender is TextView
            let layoutManager = myTextView.layoutManager //Set layout manager
            // location of tap in myTextView coordinates
            var location = recognizer.location(in: myTextView)
            location.x -= myTextView.textContainerInset.left;
            location.y -= myTextView.textContainerInset.top;
            
            // character index at tap location
            var characterIndex = layoutManager.characterIndex(for: location, in: myTextView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
            
            // if index is valid then do something.
            if characterIndex < myTextView.textStorage.length {
                
                // print the character at the index
                var indexOfChordStart = characterIndex
                var indexOfChordEnd = characterIndex
                var placeHolder = characterIndex
                let myRange = NSRange(location: characterIndex, length: 1)
                let substring = (myTextView.attributedText.string as NSString).substring(with: myRange)
                
                if substring != " "{
                    for _ in 0..<15{
                        var myRange1 = NSRange(location: characterIndex, length: 1)
                        var substring1 = (myTextView.attributedText.string as NSString).substring(with: myRange1)
                        if substring1 == " " || substring1 == "\n" || substring1 == "\r"{
                            indexOfChordStart = characterIndex + 1
                            myRange1 = NSRange(location: indexOfChordStart, length: 1)
                            substring1 = (myTextView.attributedText.string as NSString).substring(with: myRange1)
                            break
                        }
                        characterIndex = characterIndex - 1
                    }
                    
                    for _ in 0..<15{
                        var myRange2 = NSRange(location: placeHolder, length: 1)
                        var substring2 = (myTextView.attributedText.string as NSString).substring(with: myRange2)
                        if substring2 == " " || substring2 == "\n" || substring2 == "\r"{
                            indexOfChordEnd = placeHolder - 1
                            myRange2 = NSRange(location: indexOfChordEnd, length: 1)
                            substring2 = (myTextView.attributedText.string as NSString).substring(with: myRange2)
                            break
                        }
                        placeHolder = placeHolder + 1
                    }
                    let length = indexOfChordEnd - indexOfChordStart + 1
                    let chordRange = NSRange(location: indexOfChordStart, length: length)
                    let chordString = (myTextView.attributedText.string as NSString).substring(with: chordRange)
                    
                    let pattern = "[ce-fhk-ln-rtw-zH-Z]"
                    if chordString.range(of: pattern, options: .regularExpression) == nil{
                        //check to see if it is already marked as a chord
                        var check = false
                        for chord in newChords{
                            if chordString == chord{
                                check = true
                                break
                            }
                        }
                        if !check{
                            let newChordQuestionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newChordQuestionVC") as! NewChordQuestionVC
                            passedChordName = chordString
                            self.addChild(newChordQuestionViewController)
                            newChordQuestionViewController.view.frame = self.view.frame
                            self.view.addSubview(newChordQuestionViewController.view)
                            newChordQuestionViewController.didMove(toParent: self)
                            importedTitle = songTitleLabel.text!
                            importedTab = lyricsArea.text!
                            importedArtist = artistLabel.text!
                            checkNewChordFromLongPress = true
                        }
                    }
                }
            }
        }
    }
    
    @objc func tapRecognizerMethod(recognizer: UITapGestureRecognizer){
        let myTextView = recognizer.view as! UITextView //sender is TextView
        let layoutManager = myTextView.layoutManager //Set layout manager
        
        // location of tap in myTextView coordinates
        
        var location = recognizer.location(in: myTextView)
        location.x -= myTextView.textContainerInset.left;
        location.y -= myTextView.textContainerInset.top;
        
        // character index at tap location
        var characterIndex = layoutManager.characterIndex(for: location, in: myTextView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        
        // if index is valid then do something.
        if characterIndex < myTextView.textStorage.length {
            
            // print the character at the index
            var indexOfChordStart = characterIndex
            var indexOfChordEnd = characterIndex
            var placeHolder = characterIndex
            let myRange = NSRange(location: characterIndex, length: 1)
            let substring = (myTextView.attributedText.string as NSString).substring(with: myRange)
            
            if substring != " " || substring != ""{
                for _ in 0..<15{
                    if substring == "\n"{
                        break
                    }
                    var myRange1 = NSRange(location: characterIndex, length: 1)
                    var substring1 = (myTextView.attributedText.string as NSString).substring(with: myRange1)
                    if substring1 == " " || substring1 == "\r" || substring1 == "\n"{
                        indexOfChordStart = characterIndex + 1
                        myRange1 = NSRange(location: indexOfChordStart, length: 1)
                        substring1 = (myTextView.attributedText.string as NSString).substring(with: myRange1)
                        break
                    }
                    characterIndex = characterIndex - 1
                    if characterIndex < 0{
                        indexOfChordStart = 0
                        break
                    }
                }
                
                for _ in 0..<15{
                    var myRange2 = NSRange(location: placeHolder, length: 1)
                    var substring2 = (myTextView.attributedText.string as NSString).substring(with: myRange2)
                    if substring2 == " " || substring2 == "\r" || substring2 == "\n"{
                        indexOfChordEnd = placeHolder - 1
                        myRange2 = NSRange(location: indexOfChordEnd, length: 1)
                        substring2 = (myTextView.attributedText.string as NSString).substring(with: myRange2)
                        break
                    }
                    placeHolder = placeHolder + 1
                    
                    if placeHolder > myTextView.textStorage.length{
                        indexOfChordEnd = myTextView.textStorage.length
                        break
                    }
                    
                }
                let length = indexOfChordEnd - indexOfChordStart + 1
                let chordRange = NSRange(location: indexOfChordStart, length: length)
                let chordString = (myTextView.attributedText.string as NSString).substring(with: chordRange)
                
                for chord in newChords{
                    if chordString == chord{
                        openChordWindow(chord: chordString)
                        break
                    }
                }
            }
        }
        importedTab = lyricsArea.text!
        importedTitle = songTitleLabel.text!
        importedArtist = artistLabel.text!
    }
    
    func openChordWindow(chord: String){
        
        let chordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chordVC") as! chordVC
        chordPlaceHolder = chord
        self.addChild(chordViewController)
        chordViewController.view.frame = self.view.frame
        self.view.addSubview(chordViewController.view)
        chordViewController.didMove(toParent: self)
        
    }
    
    func findFile() {
        let fileName = songTitleLabel.text!
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        do {
            let readString = try String(contentsOf: fileURL)
            

            lyricsArea.text = readString
            currentLyrics = readString
            transposeLyrics = readString
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    func identifyChords(lyricsToEdit: String){
        var count = 0
        let pattern = "\\<(.*?)\\>"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSMakeRange(0, lyricsToEdit.count)
        let matches = (regex?.matches(in: lyricsToEdit, options: [], range: range))!
        let attributedString = NSMutableAttributedString(string: lyricsToEdit, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont(name: "CourierNewPSMT", size: fontSize)!]))
        
        func matchesForRegexInText(regex: String, text: String) -> [String] {
            
            do {
                let regex = try NSRegularExpression(pattern: regex, options: [])
                let nsString = text as NSString
                let results = regex.matches(in: text, options: [], range: NSMakeRange(0, nsString.length))
                return results.map { nsString.substring(with: $0.range)}
            } catch let error as NSError {
                print("invalid regex: \(error.localizedDescription)")
                return []
            }
        }
        
        matches2 = matchesForRegexInText(regex: "\\<(.*?)\\>", text: lyricsToEdit)
        
        if checkTransposeMinus{
            if countOfTransposes == 0{
                transposeMinus(matches: matches2)
            }else {
                transposeMinus(matches: tempMatches2)
            }
        }
        
        if checkTransposePlus{
            if countOfTransposes == 0{
                transposePlus(matches: matches2)
            }else {
                transposePlus(matches: tempMatches2)
            }
        }
        
        newChords = [String]()
        
        for i in 0..<matches2.count{
            var tempString = matches2[i].replacingOccurrences(of: "<", with: "")
            tempString = tempString.replacingOccurrences(of: ">", with: "")
            newChords.append(tempString)
        }
        
        count = matches2.count - 1
        
        for match in matches.reversed(){
            attributedString.setAttributes(convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font) : UIFont.boldSystemFont(ofSize: fontSize), convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor) : chordColor]), range: match.range(at: 0))
            
            attributedString.replaceCharacters(in: match.range(at: 0), with: newChords[count])
            
            count = count - 1
        }
        lyricsArea.attributedText = attributedString
    }
    
    func transposeMinus(matches: [String]){
        var transposedArray = matches
        for i in 0..<transposedArray.count{
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "A#", with: "Z^Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Ab", with: "Z*Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "A", with: "Ab")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Bb", with: "A")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "B", with: "Bb")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "C#", with: "Z%Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "C", with: "B")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Db", with: "C")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "D#", with: "Z#Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "D", with: "Db")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Eb", with: "D")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "E", with: "Eb")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "F#", with: "Z(Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "F", with: "E")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Gb", with: "F")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "G#", with: "Z)Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "G", with: "Gb")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z*Z", with: "G")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z%Z", with: "C")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z#Z", with: "D")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z(Z", with: "F")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z)Z", with: "G")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z^Z", with: "A")
        }
        matches2 = transposedArray
        tempMatches2 = transposedArray
    }
    
    func transposePlus(matches: [String]){
        var transposedArray = matches
        for i in 0..<transposedArray.count{
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "A#", with: "Z^Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Ab", with: "Z*Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "A", with: "A#")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Bb", with: "Z^Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "B", with: "Z#Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "C#", with: "Z(Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "C", with: "C#")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Db", with: "Z(Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "D#", with: "Z-Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Eb", with: "Z-Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "D", with: "D#")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "E", with: "Z%Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "F#", with: "Z_Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "F", with: "F#")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Gb", with: "Z_Z")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "G#", with: "A")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "G", with: "G#")
            
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z^Z", with: "B")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z*Z", with: "A")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z#Z", with: "C")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z(Z", with: "D")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z-Z", with: "E")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z_Z", with: "G")
            transposedArray[i] = transposedArray[i].replacingOccurrences(of: "Z%Z", with: "F")
        }
        matches2 = transposedArray
        tempMatches2 = transposedArray
    }
    
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.lyricsArea.isScrollEnabled = true
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyboardSize!.height, right: 0.0)
        
        self.lyricsArea.contentInset = contentInsets
        self.lyricsArea.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if activeField != nil {
            if (!aRect.contains((activeField?.frame.origin)!)){
                self.lyricsArea.scrollRectToVisible((activeField?.frame)!, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: -keyboardSize!.height, right: 0.0)
        self.lyricsArea.contentInset = contentInsets
        self.lyricsArea.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.lyricsArea.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}


