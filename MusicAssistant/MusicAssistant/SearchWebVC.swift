//
//  SearchWebVC.swift
//  MusicAssistant
//
//  Created by Ciro on 7/3/17.
//  Copyright © 2017 Ciro. All rights reserved.
//

import UIKit

class SearchWebVC: UIViewController {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var tabSwicth: UISwitch!
    private var importedText = ""
    private var webAddress = ""
    private var webSource = ""
    private var getCurrentPage = ""
    private var getCurrentTitle = ""
    private var getCurrentArtist = ""
    @IBOutlet weak var importWithTabLabel: UILabel!
    private var cifraClubImprimirGetTab = "imprimir.html"
    private var deletableTab = String()
    @IBOutlet weak var removeTabs: UIButton!
    var importedSearch = String()
    var check = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.google.com")
        webView.loadRequest(URLRequest(url: url!))
        getWebAddress()
        self.automaticallyAdjustsScrollViewInsets = false
        removeTabs.isEnabled = false
        if importedSearch != "" && !check{
            searchCifraClub(searchItem: importedSearch)
        }
        
        if importedSearch != "" && check{
            searchOnUltimateGuitar(searchItem: importedSearch)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func goButton(_ sender: UIButton) {
        if searchBar.text != "" {
            var fixedSearchBarText = searchBar.text!.replacingOccurrences(of: " ", with: "+")
            
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ç", with: "c")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ã", with: "a")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "á", with: "a")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "â", with: "a")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "é", with: "e")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ê", with: "e")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "í", with: "i")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ó", with: "o")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ô", with: "o")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "õ", with: "o")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ú", with: "u")
                        
            let url = URL(string: "https://www.google.com/#q=\(fixedSearchBarText)+tabs")
            webView.loadRequest(URLRequest(url: url!))
        }
        getWebAddress()
        self.searchBar.resignFirstResponder()
    }
    
    @IBAction func searchOnCifraClubButton(_ sender: UIButton) {
        searchCifraClub(searchItem: searchBar.text!)
    }
    
    @IBAction func searchOnUltimateGuitarButton(_ sender: UIButton) {
        searchOnUltimateGuitar(searchItem: searchBar.text!)
    }
    
    @IBAction func importButton(_ sender: UIButton) {
        getPageSource()
        getWebAddress()
        
        if getCurrentPage == "tabs.ultimate-guitar" {
            getTabFromUltimateGuitar()
            getSongTitle()
            getArtist()
        }
        
        if getCurrentPage == "www.cifraclub" {
            getTabFromCifraClub()
            if tabSwicth.isOn {
                importedText = importedText.replacingOccurrences(of: "<span>", with: "")
                importedText = importedText.replacingOccurrences(of: "</span>", with: "")
                importedText = importedText.replacingOccurrences(of: "<span class=\"tablatura\">", with: "")
                importedText = importedText.replacingOccurrences(of: "<span class=\"cnt\">", with: "")
            } else {
                
                let tok =  importedText.components(separatedBy: "tablatura")
                let count = tok.count - 1
                
                
                for _ in 0..<count {
                    if let startTitle = importedText.range(of: "E|"),
                        let endTitle = importedText.range(of: "</span></span>\n", range: startTitle.upperBound..<importedText.endIndex) {
                        let substringTitle = importedText[startTitle.upperBound..<endTitle.lowerBound]
                        deletableTab = substringTitle
                        importedText = importedText.replacingCharacters(in: startTitle.lowerBound..<endTitle.upperBound, with: "")
                    } else {
                        print("invalid input - 7")
                    }
                }
            }
            getSongTitle()
            getArtist()
        }
        
        addInfoToAddSongPage()
        addNewSongCheck = true
        addNewChordCheck = false
        fromImportedSongCheck = true
    }
    
    func searchCifraClub(searchItem: String){
        if searchItem != ""{
            var fixedSearchBarText = searchItem.replacingOccurrences(of: " ", with: "+")
            
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ç", with: "c")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ã", with: "a")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "á", with: "a")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "â", with: "a")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "é", with: "e")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ê", with: "e")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "í", with: "i")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ó", with: "o")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ô", with: "o")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "õ", with: "o")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ú", with: "u")
            
            var url = URL(string: "")
            if importedSearch != "" && !check{
                url = URL(string: "https://www.cifraclub.com.br/\(fixedSearchBarText)")
            } else {
                url = URL(string: "https://www.cifraclub.com.br/?q=\(fixedSearchBarText)")
            }
            webView.loadRequest(URLRequest(url: url!))
        }
        getWebAddress()
        self.searchBar.resignFirstResponder()
    }
    
    func searchOnUltimateGuitar(searchItem: String){
        if searchItem != ""{
            var fixedSearchBarText = searchItem.replacingOccurrences(of: " ", with: "+")
            
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ç", with: "c")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ã", with: "a")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "á", with: "a")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "â", with: "a")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "é", with: "e")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ê", with: "e")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "í", with: "i")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ó", with: "o")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ô", with: "o")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "õ", with: "o")
            fixedSearchBarText = fixedSearchBarText.replacingOccurrences(of: "ú", with: "u")
            
            let url = URL(string: "https://www.ultimate-guitar.com/search.php?search_type=title&order=&value=\(fixedSearchBarText)")
            webView.loadRequest(URLRequest(url: url!))
        }
        getWebAddress()
        self.searchBar.resignFirstResponder()
    }
    
    //function to get page source
    func getPageSource(){
        let text = webView.request?.url?.absoluteString
        let myURLString = text
        guard let myURL = URL(string: myURLString!) else {
            print("Error: \(String(describing: myURLString)) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            importedText = "HTML : \(myHTMLString)"
            webSource = myHTMLString
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    //function to get web address by removing www and .com...
    func getWebAddress(){
        //get current website's url
        if let urlAddress = webView.request?.url?.absoluteString{
            webAddress = urlAddress
        }
        if let startWeb = webAddress.range(of: "https://"),
            let endWeb = webAddress.range(of: ".com", range: startWeb.upperBound..<webAddress.endIndex) {
            let substringWeb = webAddress[startWeb.upperBound..<endWeb.lowerBound]
            getCurrentPage = substringWeb
        } else {
            print("invalid input - 0")
        }
    }
    
    // function to get tabs if website is ultimate guitar
    func getTabFromUltimateGuitar(){
        if let start = webSource.range(of: "\"wiki_tab\":{\"content\":\""),
            let end = webSource.range(of: ",\"revision_id", range: start.upperBound..<webSource.endIndex) {
            let substring = webSource[start.upperBound..<end.lowerBound]
            importedText = substring
        } else {
            print("invalid input - 1")
        }
        
        //remove undiserable text from tab
        importedText = importedText.replacingOccurrences(of: "<span>", with: "")
        importedText = importedText.replacingOccurrences(of: "</span>", with: "")
        importedText = importedText.replacingOccurrences(of: "<pre class=\"js-tab-content js-copy-content\">", with: "")
        importedText = importedText.replacingOccurrences(of: "</pre>", with: "")
        importedText = importedText.replacingOccurrences(of: "</pre>", with: "")
    }
    
    func getTabFromCifraClub() {
        let url = URL(string: "\(webAddress)\(cifraClubImprimirGetTab)")
        webView.loadRequest(URLRequest(url: url!))
        
        let text = webView.request?.url?.absoluteString
        let myURLString = text
        guard let myURL = URL(string: myURLString!) else {
            print("Error: \(String(describing: myURLString)) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .utf8)
            importedText = "HTML : \(myHTMLString)"
            webSource = myHTMLString
        } catch let error {
            print("Error: \(error)")
        }
        
        if let start = webSource.range(of: "<pre>"),
            let end = webSource.range(of: "</pre>", range: start.upperBound..<webSource.endIndex) {
            let substring = webSource[start.upperBound..<end.lowerBound]
            importedText = substring
        } else {
            print("invalid input - 4")
        }
        
        //remove undesirables
        importedText = importedText.replacingOccurrences(of: "<b>", with: "")
        importedText = importedText.replacingOccurrences(of: "</b>", with: "")
        importedText = importedText.replacingOccurrences(of: "<u>", with: "")
        importedText = importedText.replacingOccurrences(of: "</u>", with: "")
    }
    
    //get song title
    func getSongTitle() {
        if getCurrentPage == "tabs.ultimate-guitar" {
            if let startTitle = webSource.range(of: "'name': '"),
                let endTitle = webSource.range(of: "'", range: startTitle.upperBound..<webSource.endIndex) {
                let substringTitle = webSource[startTitle.upperBound..<endTitle.lowerBound]
                getCurrentTitle = substringTitle.capitalized
            } else {
                print("invalid input - 2")
            }
        }
        
        if getCurrentPage == "www.cifraclub" {
            if let startTitle = webSource.range(of: "name: '"),
                let endTitle = webSource.range(of: "'", range: startTitle.upperBound..<webSource.endIndex) {
                let substringTitle = webSource[startTitle.upperBound..<endTitle.lowerBound]
                getCurrentTitle = substringTitle.replacingOccurrences(of: "\\x20", with: " ")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00E1", with: "á")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00C1", with: "Á")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00E3", with: "ã")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00E9", with: "é")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00C9", with: "É")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00D3", with: "Ó")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00F3", with: "ó")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00ED", with: "í")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00F4", with: "ô")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00CD", with: "Í")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00FA", with: "ú")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00EA", with: "ê")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\u00E7", with: "ç")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "\\x2D", with: "-")
            } else {
                print("invalid input - 2")
            }
        }
    }
    
    //get artist
    func getArtist() {
        if getCurrentPage == "tabs.ultimate-guitar" {
            if let startArtist = webSource.range(of: "var name_art = '"),
                let endArtist = webSource.range(of: "'", range: startArtist.upperBound..<webSource.endIndex) {
                let substringArtist = webSource[startArtist.upperBound..<endArtist.lowerBound]
                getCurrentArtist = substringArtist
            } else {
                print("invalid input - 3")
            }
        }
        if getCurrentPage == "www.cifraclub" {
            if let startArtist = webSource.range(of: "artist: '"),
                let endArtist = webSource.range(of: "'", range: startArtist.upperBound..<webSource.endIndex) {
                let substringArtist = webSource[startArtist.upperBound..<endArtist.lowerBound]
                getCurrentArtist = substringArtist.replacingOccurrences(of: "\\x20", with: " ")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\u00E1", with: "á")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\u00C1", with: "Á")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\u00E3", with: "ã")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\u00E9", with: "é")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\u00C9", with: "É")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\u00D3", with: "Ó")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\u00F3", with: "ó")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\u00ED", with: "í")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\u00F4", with: "ô")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\u00CD", with: "Í")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\u00FA", with: "ú")
                
                
            } else {
                print("invalid input - 3")
            }
        }
    }
    
    //function to add tabs, artist, and title to addSongVC page and go to addSongVC
    func addInfoToAddSongPage() {
        let addSongViewController = self.storyboard?.instantiateViewController(withIdentifier: "addSongVC") as! AddSongVC
        importedTab = importedText
        importedTitle = getCurrentTitle
        importedArtist = getCurrentArtist
        
        self.navigationController?.pushViewController(addSongViewController, animated: true)
        
    }
    

    
    
}
