import UIKit

var currentSongTitle = songTitle[myIndex]
var currentArtist = artist[myIndex]
var currentLyrics = ""
var uniquePosts = [String]()

class MainViewController: UIViewController {
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var lyricsArea: UITextView!
    
    @IBAction func editButton(_ sender: UIButton) {
        let addSongController = self.storyboard?.instantiateViewController(withIdentifier: "AddSongController") as! AddSongViewController
        addSongController.importedTitle = songTitleLabel.text!
        addSongController.importedArtist = artistLabel.text!
        addSongController.importedTab = lyricsArea.text
        
        self.navigationController?.pushViewController(addSongController, animated: true)
    }
    
    private func readFile(name: String) -> String {
        let fileName = name
        let documentDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirectoryURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        var readString: String!
        
        do {
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Error: \(error)")
        }
        return readString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songTitleLabel.text = songTitle[myIndex]
        artistLabel.text = artist[myIndex]
        
        readFile(name: songTitle[myIndex])
        
        
        
//        //finding files directory and saving location in variables
//        let fileName = songTitleLabel.text!
//        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
//        var readString = ""
//        
//        //read content of file
//        do {
//            readString = try String(contentsOf: fileURL)
//            lyricsArea.text = readString
//            currentLyrics = readString
//            
//        } catch let error as NSError {
//            print("Error: \(error)")
//        }
        
        //select all the chords in the tab to add to the song file
        var arrayOfChords = [String]()
        var chordBegin = lyricsArea.text.startIndex
        //select all the chords in the tab to add to the song file
        for i in 0..<lyricsArea.text.characters.count{
            let start1 = lyricsArea.text.index(lyricsArea.text.startIndex, offsetBy: i)
            let end1 = lyricsArea.text.index(start1, offsetBy: 1)
            let range1 = start1..<end1
            let firstChar = lyricsArea.text.substring(with: range1)
            
            let start2 = lyricsArea.text.index(lyricsArea.text.startIndex, offsetBy: i)
            let end2 = lyricsArea.text.index(start2, offsetBy: 1)
            let range2 = start2..<end2
            let secondChar = lyricsArea.text.substring(with: range2)
            
            if firstChar == "<"{
                chordBegin = start1
            }
            if secondChar == ">"{
                let range3 = chordBegin..<end2
                arrayOfChords.append(lyricsArea.text.substring(with: range3))
            }
        }
        uniquePosts = Array(Set(arrayOfChords))
        lyricsArea.text = lyricsArea.text.appending("\n" + "\n" + String(describing: uniquePosts))
        print(uniquePosts)
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: lyricsArea.text as String, attributes: [NSFontAttributeName:UIFont(name: "CourierNewPSMT", size: 18.0)!])
        
        var currentCharacterIndex = 0
        var position1 = 0
        var position2 = 0
        var lenght = 0
        let count = lyricsArea.text.characters.count
        
        while currentCharacterIndex < lyricsArea.text.characters.count{
            for i in currentCharacterIndex..<lyricsArea.text.characters.count{
                let char = lyricsArea.text.index(lyricsArea.text.startIndex, offsetBy: i)
                
                if lyricsArea.text[char] == "<"{
                    position1 = i
                    
                    
                }
                if lyricsArea.text[char] == ">"{
                    position2 = i
                    currentCharacterIndex = i + 1
                    break
                }
            }
            
            lenght = position2 - position1 - 1
            myMutableString.setAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17),
                                           NSForegroundColorAttributeName : UIColor.blue],
                                          range: NSRange(location: position1 + 1, length: lenght))
            currentCharacterIndex = currentCharacterIndex + 1
        }
        
        
//        for j in 0..<count{
//            let char = myMutableString.string.index(myMutableString.string.startIndex, offsetBy: j)
//            if myMutableString.string[char] == "<" {
//                print(myMutableString.string[char])
//                let range = NSMakeRange(j, 1)
//                myMutableString.replaceCharacters(in: range, with: " ")
//            }
//            
//            if myMutableString.string[char] == ">" {
//                print(myMutableString.string[char])
//                let range = NSMakeRange(j, 1)
//                myMutableString.replaceCharacters(in: range, with: " ")
//            }
//        }
//        
//        lyricsArea.attributedText = myMutableString
        
    }
}
