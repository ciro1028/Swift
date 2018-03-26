//
//  ViewSongVC.swift
//  MusicAssistant
//
//  Created by Ciro on 6/30/17.
//  Copyright © 2017 Ciro. All rights reserved.
//

import UIKit

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

class ViewSongVC: UIViewController{
    
    var matches2 = [String]()
    var tempMatches2 = [String]()
    var countOfTransposes = 0
    var checkSaveOrSettings = Bool()
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var lyricsArea: UITextView!
    @IBOutlet weak var optionalSearch: UISegmentedControl!
    @IBOutlet weak var transposeText: UIButton!
    @IBOutlet weak var colorsButton: UIButton!
    
    @IBAction func optionalSearchButton(_ sender: UISegmentedControl) {
        let searchWebViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchWebVC") as! SearchWebVC
        if optionalSearch.selectedSegmentIndex == 0{
            let searchString = artistLabel.text!
            searchWebViewController.importedSearch = searchString.replacingOccurrences(of: " ", with: "-")
            searchWebViewController.check = false
            self.navigationController?.pushViewController(searchWebViewController, animated: true)
        } else {
            searchWebViewController.importedSearch = artistLabel.text!
            searchWebViewController.check = true
            self.navigationController?.pushViewController(searchWebViewController, animated: true)
        }
    }
    
    @IBAction func editButton(_ sender: UIButton) {
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
        findFile()
        identifyChords(lyricsToEdit: lyricsArea.text!)
    }
    
    @IBAction func fontPlus(_ sender: UIButton) {
        if fontSize != 30.0{
            fontSize += 1.0
        }
        findFile()
        identifyChords(lyricsToEdit: lyricsArea.text!)
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
    
    @IBAction func colorsButton(_ sender: Any) {

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
            UIKeyCommand(input: UIKeyInputLeftArrow, modifierFlags: [], action: #selector(self.LeftArrowPress(sender:))),
            UIKeyCommand(input: UIKeyInputRightArrow, modifierFlags: [], action: #selector(self.RightArrowPress(sender:)))
        ]
    }
    
    func LeftArrowPress(sender: UIKeyCommand){
        if (lyricsArea.contentOffset.y - 300) >= 0{
            
            lyricsArea.setContentOffset(CGPoint(x:0,y:lyricsArea.contentOffset.y - 300), animated: true);
        }
        else{
            lyricsArea.setContentOffset(.zero, animated: true)
        }
    }
    
    func RightArrowPress(sender: UIKeyCommand){
        if (lyricsArea.contentSize.height>(lyricsArea.frame.size.height + lyricsArea.contentOffset.y)){
            
            lyricsArea.setContentOffset(CGPoint(x:0,y:lyricsArea.contentOffset.y + 300), animated: true);
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
        
        
        findFile()
        identifyChords(lyricsToEdit: lyricsArea.text!)
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(ViewSongVC.tapRecognizerMethod(recognizer:)))
        tapped.numberOfTapsRequired = 1
        lyricsArea.addGestureRecognizer(tapped)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewSongVC.longPressTapRecognizerMethod(recognizer:)))
        lyricsArea.addGestureRecognizer(longPress)
        
        //Create back button of type custom because it was going back to newChordQuestion
        self.navigationController?.setNavigationBarHidden(false, animated:false)
        let myBackButton:UIButton = UIButton.init(type: .custom)
        myBackButton.addTarget(self, action: #selector(ViewSongVC.popToRoot(sender:)), for: .touchUpInside)
        myBackButton.setTitle("Home", for: .normal)
        myBackButton.setTitleColor(.blue, for: .normal)
        myBackButton.sizeToFit()
        
        //Add back button to navigationBar as left Button
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        
        colorsButton.layer.cornerRadius = 5
        colorsButton.layer.borderWidth = 1
        colorsButton.layer.borderColor = UIColor.black.cgColor
        
        
        
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lyricsArea.setContentOffset(.zero, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        optionalSearch.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    func popToRoot(sender:UIBarButtonItem){
        let toListOfSongs = self.storyboard?.instantiateViewController(withIdentifier: "ListOfSongsVC") as! ListOfSongsVC
        self.navigationController?.pushViewController(toListOfSongs, animated: true)
        checkFirstLoad = true
    }
    
    func longPressTapRecognizerMethod(recognizer: UILongPressGestureRecognizer){
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
                            self.addChildViewController(newChordQuestionViewController)
                            newChordQuestionViewController.view.frame = self.view.frame
                            self.view.addSubview(newChordQuestionViewController.view)
                            newChordQuestionViewController.didMove(toParentViewController: self)
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
    
    func tapRecognizerMethod(recognizer: UITapGestureRecognizer){
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
        self.addChildViewController(chordViewController)
        chordViewController.view.frame = self.view.frame
        self.view.addSubview(chordViewController.view)
        chordViewController.didMove(toParentViewController: self)
        
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
        let range = NSMakeRange(0, lyricsToEdit.characters.count)
        let matches = (regex?.matches(in: lyricsToEdit, options: [], range: range))!
        let attributedString = NSMutableAttributedString(string: lyricsToEdit, attributes: [NSFontAttributeName: UIFont(name: "CourierNewPSMT", size: fontSize)!])
        
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
            attributedString.setAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: fontSize), NSForegroundColorAttributeName : chordColor], range: match.rangeAt(0))
            
            attributedString.replaceCharacters(in: match.rangeAt(0), with: newChords[count])
            
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.lyricsArea.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
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
    
    func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
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

