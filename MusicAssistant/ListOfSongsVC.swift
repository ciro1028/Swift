//
//  ListOfSongsVC.swift
//  MusicAssistant
//
//  Created by Ciro on 6/30/17.
//  Copyright © 2017 Ciro. All rights reserved.
//

import UIKit

enum selectedScope:Int{
    case title = 0
    case artist = 1
}

var artist = [String]()
var songTitle = [[String]]()
var keys = [Int: String]()
var comingFromNewChord = Bool()
var checkFirstLoad = Bool()

var chords = [String: [String]]()

class ListOfSongsVC: UITableViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredSongs = [[String]]()
    var fixedFilteredSongs = [[String]]()
    var filteredArtist = [String]()
    var indexOfArtists = [Int]()
    var indexOfSongs = [Int]()
    var artistByAlphabet = [Int]()
    let letters = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "W", "X", "Y", "Z"]
    var indexOfLetters = [Int]()
    var indexPathSelected = IndexPath()
    var numOfSongs = Int()
    let transition = SlideInTransition()
    var newAddedArtist = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //restore()
        setupChordNames()
        saveFileOnSystem()
        orderAlphabetically()
        removeBackButtonFromHomeScreen()
        tableView.reloadData()
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.sectionIndexColor = UIColor.orange
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        searchBarSetup()
        indexSections()
        
        let img = UIImage(named: "mahogany-background")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        
    }
    
    func restore(){
        var tabFile = "Artist Titles"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        var fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")
        do {
            var readString = try String(contentsOf: fileURL)
            let defaultsArtist = UserDefaults.standard
            defaultsArtist.set(readString, forKey: "Artist")
            readString = readString.replacingOccurrences(of: "\"", with: "")
            readString = readString.replacingOccurrences(of: "\\", with: "")
            readString = readString.replacingOccurrences(of: "[", with: "")
            readString = readString.replacingOccurrences(of: "]", with: "")
            var artistArray = [String]()
            artistArray = readString.components(separatedBy: ", ")
            artist = artistArray
            print("Artist: \(readString)")

        } catch let error as NSError {
            print("Error: \(error)")
        }
        tabFile = "Song Titles"
        fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")
        do {
            var readString = try String(contentsOf: fileURL)

            readString = readString.replacingOccurrences(of: "[[", with: "")
            readString = readString.replacingOccurrences(of: "]]", with: "")
            readString = readString.replacingOccurrences(of: "\"", with: "")
            readString = readString.replacingOccurrences(of: "\\", with: "")
            var songArray = [String]()
            songArray = readString.components(separatedBy: "], [")
            let defaultsArtist = UserDefaults.standard
            defaultsArtist.set(artist, forKey: "Artist")
            var songArrayofArrays = [[String]]()
            for i in 0..<songArray.count{
                let tempArray = songArray[i].components(separatedBy: ", ")
                songArrayofArrays.append(tempArray)
            }
            songTitle = songArrayofArrays
            let defaults = UserDefaults.standard
            defaults.set(songTitle, forKey: "SongList")
            
        } catch let error as NSError {
            print("Error: \(error)")
        }

    }
    
    @IBAction func plusSong(_ sender: UIBarButtonItem) {
        addNewSongCheck = true
    }
    
    @available(iOS 13.0, *)
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(identifier: "MenuViewController") else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var count = Int()
        for i in 0..<songTitle.count{
            count += songTitle[i].count
        }
        if count > 1 {
        searchController.searchBar.placeholder = "Search in the \(count) songs available."
        } else if count == 1{
            searchController.searchBar.placeholder = "There's only one song available, what the hell are you going to search for?"
        } else {
            searchController.searchBar.placeholder = "No songs available to search."
        }
    }
    
    //Get Artist index to make tableview scroll to right place after adding song
    func getIndexOfArtist() -> Int{
        var artistIndex = Int()
        for i in 0..<artist.count{
            if newAddedArtist == artist[i]{
                artistIndex = i
            }
        }
        return artistIndex
    }
    
    func searchBarSetup(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.showsScopeBar = false
        searchController.searchBar.scopeButtonTitles = ["Song Title", "Artist"]
        searchController.searchBar.selectedScopeButtonIndex = 0
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        filteredSongs = songTitle
        filteredArtist = artist
        
        if searchController.searchBar.text! != ""{
            filterTableView(ind: searchController.searchBar.selectedScopeButtonIndex, text: searchText)
        } else {
            filteredSongs = [[String]]()
            self.tableView.reloadData()
        }
    }
    
    func filterTableView(ind:Int,text:String) {
        switch ind {
        case selectedScope.title.rawValue:
            for i in 0..<songTitle.count{
                filteredSongs[i] = songTitle[i].filter( { $0.lowercased().contains(searchController.searchBar.text!.lowercased()) })
            }
            filteredArtist = [String]()
            for i in 0..<filteredSongs.count{
                if !filteredSongs[i].isEmpty{
                    filteredArtist.append(artist[i])
                }
            }
            
            fixedFilteredSongs = [[String]]()
            for i in 0..<filteredSongs.count{
                if !filteredSongs[i].isEmpty{
                    fixedFilteredSongs.append(filteredSongs[i])
                }
            }
            
            indexOfArtists = [Int]()
            for i in 0..<filteredArtist.count{
                for j in 0..<artist.count{
                    if filteredArtist[i] == artist[j]{
                        indexOfArtists.append(j)
                    }
                }
            }
            
            self.tableView.reloadData()
        case selectedScope.artist.rawValue:
            
            self.tableView.reloadData()
        default:
            print("no value")
        }
    }
    
    //function to set up sections titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if filteredSongs.isEmpty{
            return artist[section]
        }else{
            return filteredArtist[section]
        }
    }

    
    //function to count number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        if filteredSongs.isEmpty{
            return artist.count
        }else{
            return filteredArtist.count
        }
    }
    
    //function to count number of rows in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredSongs.isEmpty{
            return songTitle[section].count
        } else {
            return fixedFilteredSongs[section].count
        }
    }
    
    //function to go to songViewVC when row is pressed
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPathSelected = indexPath
        if filteredSongs.isEmpty{
            myIndexForSection = indexPath.section
            myIndexForRow = indexPath.row
            print("Index Path: \(indexPath)")
        } else {
            myIndexForSection = indexOfArtists[indexPath.section]
            indexOfSongs = [Int]()
            for i in 0..<fixedFilteredSongs[indexPath.section].count{
                for j in 0..<songTitle[myIndexForSection].count{
                    if fixedFilteredSongs[indexPath.section][i] == songTitle[myIndexForSection][j]{
                        indexOfSongs.append(j)
                    }
                }
            }
            
            myIndexForRow = indexOfSongs[indexPath.row]
        }
        performSegue(withIdentifier: "songViewSegue", sender: self)
    }
    
    //function to setup tableview initial value
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if filteredSongs.isEmpty{
            cell.textLabel?.text = songTitle[indexPath.section][indexPath.row]
            cell.detailTextLabel?.text = artist[indexPath.section]
        } else {
            cell.textLabel?.text = fixedFilteredSongs[indexPath.section][indexPath.row]
            cell.detailTextLabel?.text = filteredArtist[indexPath.section]
        }
        
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 24)
        tableView.tableFooterView = UIView()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height:CGFloat = 30
        return height
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height:CGFloat = 60
        return height
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black.withAlphaComponent(0.7)
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = UIColor.white
        }
    }
    
    //function to index sections alphabetically
    func indexSections(){
        var firstLetterOfEachArtist = [String]()
        var checkNum = false
        
        for i in 0..<artist.count{
            let start = artist[i].index(artist[i].startIndex, offsetBy: 0)
            let end = artist[i].index(start, offsetBy: 1)
            let range = start..<end
            let firstLetter = String(artist[i][range])
            firstLetterOfEachArtist.append(firstLetter)
        }
        
        for i in 0..<firstLetterOfEachArtist.count{
            let tempNum = Int(firstLetterOfEachArtist[i])
            if tempNum != nil{
                checkNum = true
            }
        }
        
        var numPlaceHolder = Int()
        
        for i in 1..<letters.count{
            for j in 0..<firstLetterOfEachArtist.count{
                if letters[i] == firstLetterOfEachArtist[j]{
                    numPlaceHolder = j
                    break
                }
            }
            
            if checkNum {
                indexOfLetters.append(0)
                checkNum = false
            }
            
            indexOfLetters.append(numPlaceHolder)
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letters
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return indexOfLetters[index]
    }
    
    func setupChordNames(){
        originalChords["A"] = chordA
        originalChords["A#"] = chordASharp
        originalChords["Ab"] = chordAFlat
        originalChords["B"] = chordB
        originalChords["Bb"] = chordBflat
        originalChords["C"] = chordC
        originalChords["C#"] = chordCSharp
        originalChords["D"] = chordD
        originalChords["D#"] = chordDSharp
        originalChords["Db"] = chordDFlat
        originalChords["E"] = chordE
        originalChords["Eb"] = chordEFlat
        originalChords["F"] = chordF
        originalChords["F#"] = chordFSharp
        originalChords["G"] = chordG
        originalChords["G#"] = chordGSharp
        originalChords["Gb"] = chordGFlat
    }
    
    func setupOriginalChordsList() {
        
        let chordNames = ["A", "A#", "Ab", "B", "Bb", "C", "C#", "D", "D#", "Db", "E", "Eb", "F", "F#", "G", "Gb", "G#"]
        var arrayOfCompleteShapesInStringNotSeparated = [String]()
        
        for chord in chordNames{
            var arrayOfShapesInInt = [[Int]]()
            let fileURLProject = Bundle.main.path(forResource: chord, ofType: "txt")
            // Read from the file
            var tempString = ""
            do {
                tempString = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("Error: " + error.localizedDescription)
            }
            
            arrayOfCompleteShapesInStringNotSeparated = tempString.components(separatedBy: "$$")
            
            
            for i in 0..<arrayOfCompleteShapesInStringNotSeparated.count - 1{
                let arrayOfCompleteShapesInStringSeparated = arrayOfCompleteShapesInStringNotSeparated[i].components(separatedBy: ", ")
                var currentShapeInInt = [Int]()
                for current in arrayOfCompleteShapesInStringSeparated{
                    currentShapeInInt.append(Int(current)!)
                }
                arrayOfShapesInInt.append(currentShapeInInt)
            }
            chordShapes[chord] = arrayOfShapesInInt
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.red
    }
    
    func removeBackButtonFromHomeScreen() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    //function to setup array on file
    func saveFileOnSystem() {
        //check to see if it is the first lauch
        let lauchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        //if launched before use SongList already created on device, if not create new SongList
        if lauchedBefore {
            let defaults = UserDefaults.standard
            songTitle = defaults.array(forKey: "SongList") as! [Array<String>]
            let defaultArtist = UserDefaults.standard
            artist = defaultArtist.stringArray(forKey: "Artist") ?? [String]()
            chords = retrieveDictionary(withKey: "Chords")!
            chordShapes = retrieveDictionary2(withKey: "ChordShapes")!
        }
            
        else {
            let defaults = UserDefaults.standard
            defaults.set(songTitle, forKey: "SongList")
            let defaultsArtist = UserDefaults.standard
            defaultsArtist.set(artist, forKey: "Artist")
            
            setupOriginalChordsList()
            
            save(dictionary: originalChords, forKey: "Chords")
            chords = retrieveDictionary(withKey: "Chords")!
            save2(dictionary: chordShapes, forKey: "ChordShapes")
            chordShapes = retrieveDictionary2(withKey: "ChordShapes")!
            
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    //save dictionary to UserDefaults
    func save(dictionary: [String: [String]], forKey key: String) {
        let archiver = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        UserDefaults.standard.set(archiver, forKey: key)
    }
    //save dictionary to UserDefaults
    func save2(dictionary: [String: [[Int]]], forKey key: String) {
        let archiver = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        UserDefaults.standard.set(archiver, forKey: key)
    }
    
    //retrieve dictionary from user defaults
    func retrieveDictionary(withKey key: String) -> [String: [String]]? {
        
        // Check if data exists
        guard let data = UserDefaults.standard.object(forKey: key) else {
            return nil
        }
        
        // Check if retrieved data has correct type
        guard let retrievedData = data as? Data else {
            return nil
        }
        
        // Unarchive data
        let unarchivedObject = NSKeyedUnarchiver.unarchiveObject(with: retrievedData)
        return unarchivedObject as? [String: [String]]
    }
    
    //retrieve dictionary from user defaults
    func retrieveDictionary2(withKey key: String) -> [String: [[Int]]]? {
        
        // Check if data exists
        guard let data = UserDefaults.standard.object(forKey: key) else {
            return nil
        }
        
        // Check if retrieved data has correct type
        guard let retrievedData = data as? Data else {
            return nil
        }
        
        // Unarchive data
        let unarchivedObject = NSKeyedUnarchiver.unarchiveObject(with: retrievedData)
        return unarchivedObject as? [String: [[Int]]]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        orderAlphabetically()
        tableView.reloadData()
        if checkFirstLoad{
            indexPathSelected = IndexPath(row: myIndexForRow, section: myIndexForSection)
            tableView.scrollToRow(at: indexPathSelected, at: .top, animated: false)
        }
        if !newAddedArtist.isEmpty {
            let indePath = IndexPath(row: 0, section: getIndexOfArtist())
            tableView.scrollToRow(at: indePath, at: .top, animated: false)
            newAddedArtist = String()
        }
    }

    
    //function to add delete button when row is swiped
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            songTitle[indexPath.section].remove(at: indexPath.row)
            if songTitle[indexPath.section].count < 1 {
                artist.remove(at: indexPath.section)
                songTitle.remove(at: indexPath.section)
            }
            orderAlphabetically()
            tableView.reloadData()
            
            //update entry from defaults
            let defaults = UserDefaults.standard
            defaults.set(songTitle, forKey: "SongList")
            let defaultsArtist = UserDefaults.standard
            defaultsArtist.set(artist, forKey: "Artist")
            let viewSongVC = AddSongVC()
            let songTitles = songTitle.description
            viewSongVC.saveSongsArtistsList(fileName: "Song Titles", fileContent: songTitles)
            let artistTitles = artist.description
            viewSongVC.saveSongsArtistsList(fileName: "Artist Titles", fileContent: artistTitles)
            let keysTitles = keys.description
            viewSongVC.saveSongsArtistsList(fileName: "Keys Titles", fileContent: keysTitles)
            
        }
    }
    
    //function to order alphabetically
    func orderAlphabetically(){
        var tempRelation = [String: [String]]()
        
        for i in 0..<artist.count {
            tempRelation[artist[i]] = songTitle[i]
        }
        artist.sort{$0 < $1}
        
        for i in 0..<artist.count {
            for currentArtist in tempRelation.keys {
                if artist[i] == currentArtist {
                    songTitle[i] = tempRelation[currentArtist]!
                }
            }
        }
        
        for i in 0..<songTitle.count{
            songTitle[i].sort{$0 < $1}
        }
    }
    

}

//For the Animation
extension ListOfSongsVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
