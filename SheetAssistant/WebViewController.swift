import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var importedText = ""
    var webAddres = ""
    var webSource = ""
    var getCurrentPage = ""
    var getCurrentTitle = ""
    var getCurrentArtist = ""
    
    @IBAction func searchButton(_ sender: UIButton) {
        let url = URL(string: "https://www." + searchBar.text!)
        webView.loadRequest(URLRequest(url: url!))
    }
    @IBAction func importButton(_ sender: UIButton) {
        //get the current website's address
        if let urlAddress = webView.request?.url?.absoluteString{
            webAddres = urlAddress
        }
        
        //get the page source
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
        
        //get web address by removing www and .com...
        if let startWeb = webAddres.range(of: "https://"),
            let endWeb  = webAddres.range(of: ".com", range: startWeb.upperBound..<webAddres.endIndex) {
            let substringWeb = webAddres[startWeb.upperBound..<endWeb.lowerBound]
            getCurrentPage = substringWeb
        } else {
            print("invalid input")
        }
        
        //get tabs if the website is ultimate guitar
        if getCurrentPage == "tabs.ultimate-guitar"{
            if let start = webSource.range(of: "</pre>"),
                let end  = webSource.range(of: "<section", range: start.upperBound..<webSource.endIndex) {
                let substring = webSource[start.upperBound..<end.lowerBound]
                importedText = substring
            } else {
            print("invalid input")
            }
            
            importedText = importedText.replacingOccurrences(of: "<span>", with: "")
            importedText = importedText.replacingOccurrences(of: "</span>", with: "")
            importedText = importedText.replacingOccurrences(of: "<pre class=\"js-tab-content\">", with: "")
            importedText = importedText.replacingOccurrences(of: "</pre>", with: "")
            
            if let startTitle = webSource.range(of: "banner_song_name: '"),
                let endTitle  = webSource.range(of: "'", range: startTitle.upperBound..<webSource.endIndex) {
                let substringTitle = webSource[startTitle.upperBound..<endTitle.lowerBound]
                getCurrentTitle = substringTitle
            } else {
                print("invalid input")
            }
            
            if let startArtist = webSource.range(of: "banner_artist_name: '"),
                let endArtist  = webSource.range(of: "'", range: startArtist.upperBound..<webSource.endIndex) {
                let substringArtist = webSource[startArtist.upperBound..<endArtist.lowerBound]
                getCurrentArtist = substringArtist
            } else {
                print("invalid input")
            }

        
            let addSongViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddSongController") as! AddSongViewController
            addSongViewController.importedTab = importedText
            addSongViewController.importedTitle = getCurrentTitle
            addSongViewController.importedArtist = getCurrentArtist
            self.navigationController?.pushViewController(addSongViewController, animated: true)
        }
        
        //get tabs if the website is cifraclub
        if getCurrentPage == "www.cifraclub"{
            
            let url = URL(string: webAddres + "imprimir.html")
            webView.loadRequest(URLRequest(url: url!))
            
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

            
            if let start = webSource.range(of: "<pre>"),
                let end  = webSource.range(of: "</pre>", range: start.upperBound..<webSource.endIndex) {
                let substring = webSource[start.upperBound..<end.lowerBound]
                print(substring)
                importedText = substring
            } else {
                print("invalid input")
            }
            
            importedText = importedText.replacingOccurrences(of: "<b>", with: "")
            importedText = importedText.replacingOccurrences(of: "</b>", with: "")
            importedText = importedText.replacingOccurrences(of: "<u>", with: "")
            importedText = importedText.replacingOccurrences(of: "</u>", with: "")
            importedText = importedText.replacingOccurrences(of: "<span class=\"cnt\">", with: "")
            importedText = importedText.replacingOccurrences(of: "<span>", with: "")
            importedText = importedText.replacingOccurrences(of: "</span>", with: "")
            importedText = importedText.replacingOccurrences(of: "Ã¡", with: "á")
            importedText = importedText.replacingOccurrences(of: "Ã©", with: "é")
            importedText = importedText.replacingOccurrences(of: "Ã£", with: "ã")
            importedText = importedText.replacingOccurrences(of: "Ã", with: "í")
            
            if let startTitle = webSource.range(of: "name: '"),
                let endTitle  = webSource.range(of: "'", range: startTitle.upperBound..<webSource.endIndex) {
                let substringTitle = webSource[startTitle.upperBound..<endTitle.lowerBound]
                getCurrentTitle = substringTitle
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "Ã¡", with: "á")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "Ã©", with: "é")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "Ã£", with: "ã")
                getCurrentTitle = getCurrentTitle.replacingOccurrences(of: "Ã", with: "í")
            } else {
                print("invalid input")
            }
            
            if let startArtist = webSource.range(of: "artist: '"),
                let endArtist  = webSource.range(of: "'", range: startArtist.upperBound..<webSource.endIndex) {
                let substringArtist = webSource[startArtist.upperBound..<endArtist.lowerBound]
                getCurrentArtist = substringArtist
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "\\x20", with: " ")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "Ã¡", with: "á")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "Ã©", with: "é")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "Ã£", with: "ã")
                getCurrentArtist = getCurrentArtist.replacingOccurrences(of: "Ã", with: "í")
            } else {
                print("invalid input")
            }
            
            let addSongViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddSongController") as! AddSongViewController
            addSongViewController.importedTab = importedText
            addSongViewController.importedTitle = getCurrentTitle
            addSongViewController.importedArtist = getCurrentArtist
            self.navigationController?.pushViewController(addSongViewController, animated: true)
        }
        
        let url = URL(string: "https://www.google.com")
        webView.loadRequest(URLRequest(url: url!))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.cifraclub.com.br")
        webView.loadRequest(URLRequest(url: url!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
