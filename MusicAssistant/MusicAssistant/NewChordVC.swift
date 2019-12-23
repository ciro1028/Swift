//
//  NewChordVC.swift
//  MusicAssistant
//
//  Created by Ciro on 7/13/17.
//  Copyright © 2017 Ciro. All rights reserved.
//

import UIKit

var originalStringsPositions = [0,0,0,0,0,0]

var passedChordName = String()
var fretNumber = String()
var eStrStatus = String()
var aStrStatus = String()
var dStrStatus = String()
var gStrStatus = String()
var bStrStatus = String()
var eEStrStatus = String()
var chordShape = [0,0,0,0,0,0]
var checkForUpOrDown = Bool()
var originalChordName = String()
var originalChordFamily = String()
var originalShape = [Int]()
var newChordShape = [Int]()
var newVariation = Bool()
var checkNewChordFromLongPress = Bool()

class NewChordVC: UIViewController {
    var chordArray = [String]()
    var chordShapeArray = [[Int]]()
    
    @IBOutlet weak var eStringOne: UIImageView!
    @IBOutlet weak var eStringTwo: UIImageView!
    @IBOutlet weak var eStringThree: UIImageView!
    @IBOutlet weak var eStringFour: UIImageView!
    @IBOutlet weak var eStringFive: UIImageView!
    @IBOutlet weak var aStringOne: UIImageView!
    @IBOutlet weak var aStringTwo: UIImageView!
    @IBOutlet weak var aStringThree: UIImageView!
    @IBOutlet weak var aStringFour: UIImageView!
    @IBOutlet weak var aStringFive: UIImageView!
    @IBOutlet weak var dStringOne: UIImageView!
    @IBOutlet weak var dStringTwo: UIImageView!
    @IBOutlet weak var dStringThree: UIImageView!
    @IBOutlet weak var dStringFour: UIImageView!
    @IBOutlet weak var dStringFive: UIImageView!
    @IBOutlet weak var gStringOne: UIImageView!
    @IBOutlet weak var gStringTwo: UIImageView!
    @IBOutlet weak var gStringThree: UIImageView!
    @IBOutlet weak var gStringFour: UIImageView!
    @IBOutlet weak var gStringFive: UIImageView!
    @IBOutlet weak var bStringOne: UIImageView!
    @IBOutlet weak var bStringTwo: UIImageView!
    @IBOutlet weak var bStringThree: UIImageView!
    @IBOutlet weak var bStringFour: UIImageView!
    @IBOutlet weak var bStringFive: UIImageView!
    @IBOutlet weak var eSStringOne: UIImageView!
    @IBOutlet weak var eSStringTwo: UIImageView!
    @IBOutlet weak var eSStringThree: UIImageView!
    @IBOutlet weak var eSStringFour: UIImageView!
    @IBOutlet weak var eSStringFive: UIImageView!
    
    @IBOutlet weak var chordLabel: UILabel!
    
    @IBOutlet weak var stringStatusE: UILabel!
    @IBOutlet weak var stringStatusA: UILabel!
    @IBOutlet weak var stringStatusD: UILabel!
    @IBOutlet weak var stringStatusG: UILabel!
    @IBOutlet weak var stringStatusB: UILabel!
    @IBOutlet weak var stringStatusEe: UILabel!
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var frentboardCounter: UILabel!
    @IBOutlet weak var chordAdded: UILabel!
    
    var location = CGPoint(x: 0, y: 0)
    var chordShapeCreator = [0,0,0,0,0,0]
    var tempChordName = [String]()
    var tempChordShape = [[Int]]()
    var chordShapeHolder = [Int]()
    var index = Int()
    var songArray = [String]()
    
    @IBOutlet weak var newChordTextField: UITextField!
    @IBOutlet weak var newChordButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let viewSongViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewSongVC") as! ViewSongVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if checkComeFromEditChord{
            copyInfoFromOriginalChord()
            chordLabel.text = passedChordName
            newChordTextField.isEnabled = false
            newChordTextField.alpha = 1.0
        }
        
        if checkNewChordFromLongPress{
            chordLabel.text = passedChordName
        }
        
        if newVariation{
            chordLabel.text = originalChordName
        }
        
        self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        roundView.layer.cornerRadius = 16.0
        roundView.clipsToBounds = true
        songArray = importedTab.components(separatedBy: "\n")
        newChordTextField.alpha = 1.0
    }
    
    @IBAction func newChordButton(_ sender: UIButton) {
        newChordTextField.isHidden = false
        newChordButton.isHidden = true
        newChordTextField.isEnabled = true
        newChordTextField.alpha = 1.0
        checkComeFromEditChord = false
        newChordTextField.becomeFirstResponder()
        addNewChordCheck = true
        checkNewChordFromLongPress = false
        resetDots()
    }
    
    @IBAction func upButon(_ sender: UIButton) {
        let counter = Int(frentboardCounter.text!)
        if counter != 20{
            for i in 0..<chordShape.count{
                chordShape[i] = chordShape[i] + 1
            }
        }
        if counter != 20{
            frentboardCounter.text = String(describing: counter! + 1)
        }
        checkForUpOrDown = true
    }
    
    @IBAction func downButton(_ sender: UIButton) {
        let counter = Int(frentboardCounter.text!)
        if counter != 1{
            for i in 0..<chordShape.count{
                chordShape[i] = chordShape[i] - 1
            }
        }
        if counter != 1{
            frentboardCounter.text = String(describing: counter! - 1)
        }
        checkForUpOrDown = true
    }
    
    @IBAction func cancel(_ sender: Any) {
        newVariation = false
        checkComeFromEditChord = false
        addNewChordCheck = false
        checkNewChordFromLongPress = false
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "addSongVC") as! AddSongVC
        self.navigationController?.pushViewController(editVC, animated: false)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if newChordTextField.text != "" || chordLabel.text != ""{
            save()
            
            if newVariation{
                let editVC = self.storyboard?.instantiateViewController(withIdentifier: "viewSongVC") as! ViewSongVC
                self.navigationController?.pushViewController(editVC, animated: false)
            }else{
                let editVC = self.storyboard?.instantiateViewController(withIdentifier: "addSongVC") as! AddSongVC
                self.navigationController?.pushViewController(editVC, animated: false)
            }
            
            addNewSongCheck = false
            checkNewChordFromLongPress = false
            newVariation = false
            passedChordName = ""
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
            newIndex = index
            let deleteVC = self.storyboard?.instantiateViewController(withIdentifier: "deleteVC") as! DeleteChordQuestionVC
            self.addChild(deleteVC)
            deleteVC.view.frame = self.view.frame
            self.view.addSubview(deleteVC.view)
            deleteVC.didMove(toParent: self)
    }
    
    func save(){
        if checkComeFromEditChord{
                //delete entry
                chords[originalChordFamily]!.remove(at: index)
                chordShapes[originalChordFamily]!.remove(at: index)
                
                //save edited chord
                chords[originalChordFamily]!.append(passedChordName)
                chordShapes[originalChordFamily]!.append(chordShape)
        } else {
            
            if addNewChordCheck{
                if !checkNewChordFromLongPress{
                    passedChordName = newChordTextField.text!
                }
                
                if newVariation{
                    passedChordName = chordLabel.text!
                }
                
                let start = passedChordName.index(passedChordName.startIndex, offsetBy: 0)
                let end = passedChordName.index(start, offsetBy: 1)
                let range = start..<end
                //let firstChar = passedChordName.substring(with: range)
                let firstChar = String(passedChordName[range])
                var additionalString = String()
                
                originalChordName = passedChordName
                originalChordFamily = "\(firstChar)\(additionalString)"
                
                if passedChordName.count > 1{
                    let start2 = passedChordName.index(passedChordName.startIndex, offsetBy: 1)
                    let end2 = passedChordName.index(start2, offsetBy: 1)
                    let range2 = start2..<end2
                    //let firstChar2 = passedChordName.substring(with: range2)
                    let firstChar2 = String(passedChordName[range2])
                    if firstChar2 == "b"{
                        additionalString = "b"
                    } else if firstChar2 == "#" {
                        additionalString = "#"
                    }
                }
                chords[originalChordFamily]!.append(passedChordName)
                chordShapes[originalChordFamily]!.append(chordShape)
                newChordTextField.isEnabled = false
                newChordTextField.alpha = 1.0
            }
        }
        resetDots()
        save(dictionary: chords, forKey: "Chords")
        save2(dictionary: chordShapes, forKey: "ChordShapes")
    }
    
    func save(dictionary: [String: [String]], forKey key: String) {
        let archiver = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        UserDefaults.standard.set(archiver, forKey: key)
    }
    
    func save2(dictionary: [String: [[Int]]], forKey key: String) {
        let archiver = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        UserDefaults.standard.set(archiver, forKey: key)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let locationTouched: UITouch = touches.first!
        location = locationTouched.location(in: eStringOne)
        testForLocation()
    }
    
    func setLocationOfDots(shape: [Int]){
        
        stringStatusE.text = "o"
        stringStatusA.text = "o"
        stringStatusD.text = "o"
        stringStatusG.text = "o"
        stringStatusB.text = "o"
        stringStatusEe.text = "o"
        
        switch shape[0] {
        case 0:
            stringStatusE.text = "o"
        case 1:
            eStringOne.isHidden = false
        case 2:
            eStringTwo.isHidden = false
        case 3:
            eStringThree.isHidden = false
        case 4:
            eStringFour.isHidden = false
        case 5:
            eStringFive.isHidden = false
        default:
            stringStatusE.text = "x"
        }
        
        switch shape[1] {
        case 0:
            stringStatusA.text = "o"
        case 1:
            aStringOne.isHidden = false
        case 2:
            aStringTwo.isHidden = false
        case 3:
            aStringThree.isHidden = false
        case 4:
            aStringFour.isHidden = false
        case 5:
            aStringFive.isHidden = false
        default:
            stringStatusA.text = "x"
            
        }
        
        switch shape[2] {
        case 0:
            stringStatusD.text = "o"
        case 1:
            dStringOne.isHidden = false
        case 2:
            dStringTwo.isHidden = false
        case 3:
            dStringThree.isHidden = false
        case 4:
            dStringFour.isHidden = false
        case 5:
            dStringFive.isHidden = false
        default:
            stringStatusD.text = "x"
        }
        
        switch shape[3] {
        case 0:
            stringStatusG.text = "o"
        case 1:
            gStringOne.isHidden = false
        case 2:
            gStringTwo.isHidden = false
        case 3:
            gStringThree.isHidden = false
        case 4:
            gStringFour.isHidden = false
        case 5:
            gStringFive.isHidden = false
        default:
            stringStatusG.text = "x"
        }
        
        switch shape[4] {
        case 0:
            stringStatusB.text = "o"
        case 1:
            bStringOne.isHidden = false
        case 2:
            bStringTwo.isHidden = false
        case 3:
            bStringThree.isHidden = false
        case 4:
            bStringFour.isHidden = false
        case 5:
            bStringFive.isHidden = false
        default:
            stringStatusB.text = "x"
        }
        
        switch shape[5] {
        case 0:
            stringStatusEe.text = "o"
        case 1:
            eSStringOne.isHidden = false
        case 2:
            eSStringTwo.isHidden = false
        case 3:
            eSStringThree.isHidden = false
        case 4:
            eSStringFour.isHidden = false
        case 5:
            eSStringFive.isHidden = false
        default:
            stringStatusEe.text = "x"
        }
    }
    
    func copyInfoFromOriginalChord(){
        var chordName = ""
        
        frentboardCounter.text = fretNumber
        stringStatusE.text = eStrStatus
        stringStatusA.text = aStrStatus
        stringStatusD.text = dStrStatus
        stringStatusG.text = gStrStatus
        stringStatusB.text = bStrStatus
        stringStatusEe.text = eEStrStatus
        
        setLocationOfDots(shape: originalStringsPositions)
        
        chordName = passedChordName
        
        let start = chordName.index(chordName.startIndex, offsetBy: 0)
        let end = chordName.index(start, offsetBy: 1)
        let range = start..<end
        //let firstChar = chordName.substring(with: range)
        let firstChar = String(chordName[range])
        var additionalString = String()
        
        if chordName.count > 1{
            let start2 = chordName.index(chordName.startIndex, offsetBy: 1)
            let end2 = chordName.index(start2, offsetBy: 1)
            let range2 = start2..<end2
            //let firstChar2 = chordName.substring(with: range2)
            let firstChar2 = String(chordName[range2])
            
            if firstChar2 == "b"{
                additionalString = "b"
            } else if firstChar2 == "#" {
                additionalString = "#"
            }
        }
        
        originalChordName = chordName
        originalChordFamily = "\(firstChar)\(additionalString)"
        
        //get the location of the chord and the shape
        let count = chords[originalChordFamily]!.count
        for i in 0..<count{
            if chords[originalChordFamily]![i] == chordName{
                var tempArray = [Int]()
                for current in chordShapes[originalChordFamily]![i]{
                    tempArray.append(current)
                }
                if tempArray == originalShape{
                    index = i
                    newIndex = i
                    break
                }
            }
        }
        
        if checkComeFromEditChord{
            chordShape = originalShape
        }
    }
    
    func testForLocation(){
        switch location.x{
        case -6...16:
            switch location.y {
            case 4...24:
                if eStringOne.isHidden == true{
                    eStringOne.isHidden = false
                    if stringStatusE.text == "x"{
                        stringStatusE.text = "o"
                        chordShapeCreator[0] = 1
                        chordShape[0] = Int(frentboardCounter.text!)!
                        
                    } else{
                        chordShapeCreator[0] = 1
                        chordShape[0] = Int(frentboardCounter.text!)!
                        eStringTwo.isHidden = true
                        eStringThree.isHidden = true
                        eStringFour.isHidden = true
                        eStringFive.isHidden = true
                    }
                } else {
                    eStringOne.isHidden = true
                    chordShapeCreator[0] = 0
                    chordShape[0] = 0
                }
            case 40...60:
                if eStringTwo.isHidden == true{
                    eStringTwo.isHidden = false
                    if stringStatusE.text == "x"{
                        stringStatusE.text = "o"
                        chordShapeCreator[0] = 2
                        chordShape[0] = Int(frentboardCounter.text!)! + 1
                    } else{
                        chordShapeCreator[0] = 2
                        chordShape[0] = Int(frentboardCounter.text!)! + 1
                        eStringOne.isHidden = true
                        eStringThree.isHidden = true
                        eStringFour.isHidden = true
                        eStringFive.isHidden = true
                    }
                } else {
                    eStringTwo.isHidden = true
                    chordShapeCreator[0] = 0
                    chordShape[0] = 0
                }
            case 76...96:
                if eStringThree.isHidden == true{
                    eStringThree.isHidden = false
                    if stringStatusE.text == "x"{
                        stringStatusE.text = "o"
                        chordShapeCreator[0] = 3
                        chordShape[0] = Int(frentboardCounter.text!)! + 2
                    } else{
                        chordShapeCreator[0] = 3
                        chordShape[0] = Int(frentboardCounter.text!)! + 2
                        eStringTwo.isHidden = true
                        eStringOne.isHidden = true
                        eStringFour.isHidden = true
                        eStringFive.isHidden = true
                    }
                } else {
                    eStringThree.isHidden = true
                    chordShapeCreator[0] = 0
                    chordShape[0] = 0
                }
            case 112...132:
                if eStringFour.isHidden == true{
                    eStringFour.isHidden = false
                    if stringStatusE.text == "x"{
                        stringStatusE.text = "o"
                        chordShapeCreator[0] = 4
                        chordShape[0] = Int(frentboardCounter.text!)! + 3
                    } else{
                        chordShapeCreator[0] = 4
                        chordShape[0] = Int(frentboardCounter.text!)! + 3
                        eStringTwo.isHidden = true
                        eStringThree.isHidden = true
                        eStringOne.isHidden = true
                        eStringFive.isHidden = true
                    }
                } else {
                    eStringFour.isHidden = true
                    chordShapeCreator[0] = 0
                    chordShape[0] = 0
                }
            case 156...176:
                if eStringFive.isHidden == true{
                    eStringFive.isHidden = false
                    if stringStatusE.text == "x"{
                        stringStatusE.text = "o"
                        chordShapeCreator[0] = 5
                        chordShape[0] = Int(frentboardCounter.text!)! + 4
                    } else{
                        chordShapeCreator[0] = 5
                        chordShape[0] = Int(frentboardCounter.text!)! + 4
                        eStringTwo.isHidden = true
                        eStringThree.isHidden = true
                        eStringFour.isHidden = true
                        eStringOne.isHidden = true
                    }
                } else {
                    eStringFive.isHidden = true
                    chordShapeCreator[0] = 0
                    chordShape[0] = 0
                }
            case 180...200:
                if stringStatusE.text == "o"{
                    stringStatusE.text = "x"
                    eStringOne.isHidden = true
                    eStringTwo.isHidden = true
                    eStringThree.isHidden = true
                    eStringFour.isHidden = true
                    eStringFive.isHidden = true
                    chordShape[0] = 100
                } else{
                    stringStatusE.text = "o"
                    chordShape[0] = Int(frentboardCounter.text!)! - 1
                }
            default: break
            }
        case 20...40:
            switch location.y {
            case 4...24:
                if aStringOne.isHidden == true{
                    aStringOne.isHidden = false
                    if stringStatusA.text == "x"{
                        stringStatusA.text = "o"
                        chordShapeCreator[1] = 1
                        chordShape[1] = Int(frentboardCounter.text!)!
                    } else{
                        chordShapeCreator[1] = 1
                        chordShape[1] = Int(frentboardCounter.text!)!
                        aStringTwo.isHidden = true
                        aStringThree.isHidden = true
                        aStringFour.isHidden = true
                        aStringFive.isHidden = true
                    }
                } else {
                    aStringOne.isHidden = true
                    chordShapeCreator[1] = 0
                    chordShape[1] = 0
                }
            case 40...60:
                if aStringTwo.isHidden == true{
                    aStringTwo.isHidden = false
                    if stringStatusA.text == "x"{
                        stringStatusA.text = "o"
                        chordShapeCreator[1] = 2
                        chordShape[1] = Int(frentboardCounter.text!)! + 1
                    } else{
                        chordShapeCreator[1] = 2
                        chordShape[1] = Int(frentboardCounter.text!)! + 1
                        aStringOne.isHidden = true
                        aStringThree.isHidden = true
                        aStringFour.isHidden = true
                        aStringFive.isHidden = true
                    }
                } else {
                    aStringTwo.isHidden = true
                    chordShapeCreator[1] = 0
                    chordShape[1] = 0
                }
            case 76...96:
                if aStringThree.isHidden == true{
                    aStringThree.isHidden = false
                    if stringStatusA.text == "x"{
                        stringStatusA.text = "o"
                        chordShapeCreator[1] = 3
                        chordShape[1] = Int(frentboardCounter.text!)! + 2
                    } else{
                        chordShapeCreator[1] = 3
                        chordShape[1] = Int(frentboardCounter.text!)! + 2
                        aStringTwo.isHidden = true
                        aStringOne.isHidden = true
                        aStringFour.isHidden = true
                        aStringFive.isHidden = true
                    }
                } else {
                    aStringThree.isHidden = true
                    chordShapeCreator[1] = 0
                    chordShape[1] = 0
                }
            case 112...132:
                if aStringFour.isHidden == true{
                    aStringFour.isHidden = false
                    if stringStatusA.text == "x"{
                        stringStatusA.text = "o"
                        chordShapeCreator[1] = 4
                        chordShape[1] = Int(frentboardCounter.text!)! + 3
                    } else{
                        chordShapeCreator[1] = 4
                        chordShape[1] = Int(frentboardCounter.text!)! + 3
                        aStringTwo.isHidden = true
                        aStringThree.isHidden = true
                        aStringOne.isHidden = true
                        aStringFive.isHidden = true
                    }
                } else {
                    aStringFour.isHidden = true
                    chordShapeCreator[1] = 0
                    chordShape[1] = 0
                }
            case 156...176:
                if aStringFive.isHidden == true{
                    aStringFive.isHidden = false
                    if stringStatusA.text == "x"{
                        stringStatusA.text = "o"
                        chordShapeCreator[1] = 5
                        chordShape[1] = Int(frentboardCounter.text!)! + 4
                    } else{
                        chordShapeCreator[1] = 5
                        chordShape[1] = Int(frentboardCounter.text!)! + 4
                        aStringTwo.isHidden = true
                        aStringThree.isHidden = true
                        aStringFour.isHidden = true
                        aStringOne.isHidden = true
                    }
                } else {
                    aStringFive.isHidden = true
                    chordShapeCreator[1] = 0
                    chordShape[1] = 0
                }
            case 180...200:
                if stringStatusA.text == "o"{
                    stringStatusA.text = "x"
                    aStringOne.isHidden = true
                    aStringTwo.isHidden = true
                    aStringThree.isHidden = true
                    aStringFour.isHidden = true
                    aStringFive.isHidden = true
                    chordShape[1] = 100
                } else{
                    stringStatusA.text = "o"
                    chordShape[1] = Int(frentboardCounter.text!)! - 1
                }
            default: break
            }
        case 45...65:
            switch location.y {
            case 4...24:
                if dStringOne.isHidden == true{
                    dStringOne.isHidden = false
                    if stringStatusD.text == "x"{
                        stringStatusD.text = "o"
                        chordShapeCreator[2] = 1
                        chordShape[2] = Int(frentboardCounter.text!)!
                    } else{
                        chordShapeCreator[2] = 1
                        chordShape[2] = Int(frentboardCounter.text!)!
                        dStringTwo.isHidden = true
                        dStringThree.isHidden = true
                        dStringFour.isHidden = true
                        dStringFive.isHidden = true
                    }
                } else {
                    dStringOne.isHidden = true
                    chordShapeCreator[2] = 0
                    chordShape[2] = 0
                }
            case 40...60:
                if dStringTwo.isHidden == true{
                    dStringTwo.isHidden = false
                    if stringStatusD.text == "x"{
                        stringStatusD.text = "o"
                        chordShapeCreator[2] = 2
                        chordShape[2] = Int(frentboardCounter.text!)! + 1
                    } else{
                        chordShapeCreator[2] = 2
                        chordShape[2] = Int(frentboardCounter.text!)! + 1
                        dStringOne.isHidden = true
                        dStringThree.isHidden = true
                        dStringFour.isHidden = true
                        dStringFive.isHidden = true
                    }
                } else {
                    dStringTwo.isHidden = true
                    chordShapeCreator[2] = 0
                    chordShape[2] = 0
                }
            case 76...96:
                if dStringThree.isHidden == true{
                    dStringThree.isHidden = false
                    if stringStatusD.text == "x"{
                        stringStatusD.text = "o"
                        chordShapeCreator[2] = 3
                        chordShape[2] = Int(frentboardCounter.text!)! + 2
                    } else{
                        chordShapeCreator[2] = 3
                        chordShape[2] = Int(frentboardCounter.text!)! + 2
                        dStringTwo.isHidden = true
                        dStringOne.isHidden = true
                        dStringFour.isHidden = true
                        dStringFive.isHidden = true
                    }
                } else {
                    dStringThree.isHidden = true
                    chordShapeCreator[2] = 0
                    chordShape[2] = 0
                }
            case 112...132:
                if dStringFour.isHidden == true{
                    dStringFour.isHidden = false
                    if stringStatusD.text == "x"{
                        stringStatusD.text = "o"
                        chordShapeCreator[2] = 4
                        chordShape[2] = Int(frentboardCounter.text!)! + 3
                    } else{
                        chordShapeCreator[2] = 4
                        chordShape[2] = Int(frentboardCounter.text!)! + 3
                        dStringTwo.isHidden = true
                        dStringThree.isHidden = true
                        dStringOne.isHidden = true
                        dStringFive.isHidden = true
                    }
                } else {
                    dStringFour.isHidden = true
                    chordShapeCreator[2] = 0
                    chordShape[2] = 0
                }
            case 156...176:
                if dStringFive.isHidden == true{
                    dStringFive.isHidden = false
                    if stringStatusD.text == "x"{
                        stringStatusD.text = "o"
                        chordShapeCreator[2] = 5
                        chordShape[2] = Int(frentboardCounter.text!)! + 4
                    } else{
                        chordShapeCreator[2] = 5
                        chordShape[2] = Int(frentboardCounter.text!)! + 4
                        dStringTwo.isHidden = true
                        dStringThree.isHidden = true
                        dStringFour.isHidden = true
                        dStringOne.isHidden = true
                    }
                } else {
                    dStringFive.isHidden = true
                    chordShapeCreator[2] = 0
                    chordShape[2] = 0
                }
            case 180...200:
                if stringStatusD.text == "o"{
                    stringStatusD.text = "x"
                    dStringOne.isHidden = true
                    dStringTwo.isHidden = true
                    dStringThree.isHidden = true
                    dStringFour.isHidden = true
                    dStringFive.isHidden = true
                    chordShape[2] = 100
                } else{
                    stringStatusD.text = "o"
                    chordShape[2] = Int(frentboardCounter.text!)! - 1
                }
            default: break
            }
        case 70...90:
            switch location.y {
            case 4...24:
                if gStringOne.isHidden == true{
                    gStringOne.isHidden = false
                    if stringStatusG.text == "x"{
                        stringStatusG.text = "o"
                        chordShapeCreator[3] = 1
                        chordShape[3] = Int(frentboardCounter.text!)!
                    } else{
                        chordShapeCreator[3] = 1
                        chordShape[3] = Int(frentboardCounter.text!)!
                        gStringTwo.isHidden = true
                        gStringThree.isHidden = true
                        gStringFour.isHidden = true
                        gStringFive.isHidden = true
                    }
                } else {
                    gStringOne.isHidden = true
                    chordShapeCreator[3] = 0
                    chordShape[3] = 0
                }
            case 40...60:
                if gStringTwo.isHidden == true{
                    gStringTwo.isHidden = false
                    if stringStatusG.text == "x"{
                        stringStatusG.text = "o"
                        chordShapeCreator[3] = 2
                        chordShape[3] = Int(frentboardCounter.text!)! + 1
                    } else{
                        chordShapeCreator[3] = 2
                        chordShape[3] = Int(frentboardCounter.text!)! + 1
                        gStringOne.isHidden = true
                        gStringThree.isHidden = true
                        gStringFour.isHidden = true
                        gStringFive.isHidden = true
                    }
                } else {
                    gStringTwo.isHidden = true
                    chordShapeCreator[3] = 0
                    chordShape[3] = 0
                }
            case 76...96:
                if gStringThree.isHidden == true{
                    gStringThree.isHidden = false
                    if stringStatusG.text == "x"{
                        stringStatusG.text = "o"
                        chordShapeCreator[3] = 3
                        chordShape[3] = Int(frentboardCounter.text!)! + 2
                    } else{
                        chordShapeCreator[3] = 3
                        chordShape[3] = Int(frentboardCounter.text!)! + 2
                        gStringTwo.isHidden = true
                        gStringOne.isHidden = true
                        gStringFour.isHidden = true
                        gStringFive.isHidden = true
                    }
                } else {
                    gStringThree.isHidden = true
                    chordShapeCreator[3] = 0
                    chordShape[3] = 0
                }
            case 112...132:
                if gStringFour.isHidden == true{
                    gStringFour.isHidden = false
                    if stringStatusG.text == "x"{
                        stringStatusG.text = "o"
                        chordShapeCreator[3] = 4
                        chordShape[3] = Int(frentboardCounter.text!)! + 3
                    } else{
                        chordShapeCreator[3] = 4
                        chordShape[3] = Int(frentboardCounter.text!)! + 3
                        gStringTwo.isHidden = true
                        gStringThree.isHidden = true
                        gStringOne.isHidden = true
                        gStringFive.isHidden = true
                    }
                } else {
                    gStringFour.isHidden = true
                    chordShapeCreator[3] = 0
                    chordShape[3] = 0
                }
            case 156...176:
                if gStringFive.isHidden == true{
                    gStringFive.isHidden = false
                    if stringStatusG.text == "x"{
                        stringStatusG.text = "o"
                        chordShapeCreator[3] = 5
                        chordShape[3] = Int(frentboardCounter.text!)! + 4
                    } else{
                        chordShapeCreator[3] = 5
                        chordShape[3] = Int(frentboardCounter.text!)! + 4
                        gStringTwo.isHidden = true
                        gStringThree.isHidden = true
                        gStringFour.isHidden = true
                        gStringOne.isHidden = true
                    }
                } else {
                    gStringFive.isHidden = true
                    chordShapeCreator[3] = 0
                    chordShape[3] = 0
                }
            case 180...200:
                if stringStatusG.text == "o"{
                    stringStatusG.text = "x"
                    gStringOne.isHidden = true
                    gStringTwo.isHidden = true
                    gStringThree.isHidden = true
                    gStringFour.isHidden = true
                    gStringFive.isHidden = true
                    chordShape[3] = 100
                } else{
                    stringStatusG.text = "o"
                    chordShape[3] = Int(frentboardCounter.text!)! - 1
                }
            default: break
            }
        case 95...115:
            switch location.y {
            case 4...24:
                if bStringOne.isHidden == true{
                    bStringOne.isHidden = false
                    if stringStatusB.text == "x"{
                        stringStatusB.text = "o"
                        chordShapeCreator[4] = 1
                        chordShape[4] = Int(frentboardCounter.text!)!
                    } else{
                        chordShapeCreator[4] = 1
                        chordShape[4] = Int(frentboardCounter.text!)!
                        bStringTwo.isHidden = true
                        bStringThree.isHidden = true
                        bStringFour.isHidden = true
                        bStringFive.isHidden = true
                    }
                } else {
                    bStringOne.isHidden = true
                    chordShapeCreator[4] = 0
                    chordShape[4] = 0
                }
            case 40...60:
                if bStringTwo.isHidden == true{
                    bStringTwo.isHidden = false
                    if stringStatusB.text == "x"{
                        stringStatusB.text = "o"
                        chordShapeCreator[4] = 2
                        chordShape[4] = Int(frentboardCounter.text!)! + 1
                    } else{
                        chordShapeCreator[4] = 2
                        chordShape[4] = Int(frentboardCounter.text!)! + 1
                        bStringOne.isHidden = true
                        bStringThree.isHidden = true
                        bStringFour.isHidden = true
                        bStringFive.isHidden = true
                    }
                } else {
                    bStringTwo.isHidden = true
                    chordShapeCreator[4] = 0
                    chordShape[4] = 0
                }
            case 76...96:
                if bStringThree.isHidden == true{
                    bStringThree.isHidden = false
                    if stringStatusB.text == "x"{
                        stringStatusB.text = "o"
                        chordShapeCreator[4] = 3
                        chordShape[4] = Int(frentboardCounter.text!)! + 2
                    } else{
                        chordShapeCreator[4] = 3
                        chordShape[4] = Int(frentboardCounter.text!)! + 2
                        bStringTwo.isHidden = true
                        bStringOne.isHidden = true
                        bStringFour.isHidden = true
                        bStringFive.isHidden = true
                    }
                } else {
                    bStringThree.isHidden = true
                    chordShapeCreator[4] = 0
                    chordShape[4] = 0
                }
            case 112...132:
                if bStringFour.isHidden == true{
                    bStringFour.isHidden = false
                    if stringStatusB.text == "x"{
                        stringStatusB.text = "o"
                        chordShapeCreator[4] = 4
                        chordShape[4] = Int(frentboardCounter.text!)! + 3
                    } else{
                        chordShapeCreator[4] = 4
                        chordShape[4] = Int(frentboardCounter.text!)! + 3
                        bStringTwo.isHidden = true
                        bStringThree.isHidden = true
                        bStringOne.isHidden = true
                        bStringFive.isHidden = true
                    }
                } else {
                    bStringFour.isHidden = true
                    chordShapeCreator[4] = 0
                    chordShape[4] = 0
                }
            case 156...176:
                if bStringFive.isHidden == true{
                    bStringFive.isHidden = false
                    if stringStatusB.text == "x"{
                        stringStatusB.text = "o"
                        chordShapeCreator[4] = 5
                        chordShape[4] = Int(frentboardCounter.text!)! + 4
                    } else{
                        chordShapeCreator[4] = 5
                        chordShape[4] = Int(frentboardCounter.text!)! + 4
                        bStringTwo.isHidden = true
                        bStringThree.isHidden = true
                        bStringFour.isHidden = true
                        bStringOne.isHidden = true
                    }
                } else {
                    bStringFive.isHidden = true
                    chordShapeCreator[4] = 0
                    chordShape[4] = 0
                }
            case 180...200:
                if stringStatusB.text == "o"{
                    stringStatusB.text = "x"
                    bStringOne.isHidden = true
                    bStringTwo.isHidden = true
                    bStringThree.isHidden = true
                    bStringFour.isHidden = true
                    bStringFive.isHidden = true
                    chordShape[4] = 100
                } else{
                    stringStatusB.text = "o"
                    chordShape[4] = Int(frentboardCounter.text!)! - 1
                }
            default: break
            }
            
        case 120...140:
            switch location.y {
            case 4...24:
                if eSStringOne.isHidden == true{
                    eSStringOne.isHidden = false
                    if stringStatusEe.text == "x"{
                        stringStatusEe.text = "o"
                        chordShapeCreator[5] = 1
                        chordShape[5] = Int(frentboardCounter.text!)!
                    } else{
                        chordShapeCreator[5] = 1
                        chordShape[5] = Int(frentboardCounter.text!)!
                        eSStringTwo.isHidden = true
                        eSStringThree.isHidden = true
                        eSStringFour.isHidden = true
                        eSStringFive.isHidden = true
                    }
                } else {
                    eSStringOne.isHidden = true
                    chordShapeCreator[5] = 0
                    chordShape[5] = 0
                }
            case 40...60:
                if eSStringTwo.isHidden == true{
                    eSStringTwo.isHidden = false
                    if stringStatusEe.text == "x"{
                        stringStatusEe.text = "o"
                        chordShapeCreator[5] = 2
                        chordShape[5] = Int(frentboardCounter.text!)! + 1
                    } else{
                        chordShapeCreator[5] = 2
                        chordShape[5] = Int(frentboardCounter.text!)! + 1
                        eSStringOne.isHidden = true
                        eSStringThree.isHidden = true
                        eSStringFour.isHidden = true
                        eSStringFive.isHidden = true
                    }
                } else {
                    eSStringTwo.isHidden = true
                    chordShapeCreator[5] = 0
                    chordShape[5] = 0
                }
            case 76...96:
                if eSStringThree.isHidden == true{
                    eSStringThree.isHidden = false
                    if stringStatusEe.text == "x"{
                        stringStatusEe.text = "o"
                        chordShapeCreator[5] = 3
                        chordShape[5] = Int(frentboardCounter.text!)! + 2
                    } else{
                        chordShapeCreator[5] = 3
                        chordShape[5] = Int(frentboardCounter.text!)! + 2
                        eSStringTwo.isHidden = true
                        eSStringOne.isHidden = true
                        eSStringFour.isHidden = true
                        eSStringFive.isHidden = true
                    }
                } else {
                    eSStringThree.isHidden = true
                    chordShapeCreator[5] = 0
                    chordShape[5] = 0
                }
            case 112...132:
                if eSStringFour.isHidden == true{
                    eSStringFour.isHidden = false
                    if stringStatusEe.text == "x"{
                        stringStatusEe.text = "o"
                        chordShapeCreator[5] = 4
                        chordShape[5] = Int(frentboardCounter.text!)! + 3
                    } else{
                        chordShapeCreator[5] = 4
                        chordShape[5] = Int(frentboardCounter.text!)! + 3
                        eSStringTwo.isHidden = true
                        eSStringThree.isHidden = true
                        eSStringOne.isHidden = true
                        eSStringFive.isHidden = true
                    }
                } else {
                    eSStringFour.isHidden = true
                    chordShapeCreator[5] = 0
                    chordShape[5] = 0
                }
            case 156...176:
                if eSStringFive.isHidden == true{
                    eSStringFive.isHidden = false
                    if stringStatusEe.text == "x"{
                        stringStatusEe.text = "o"
                        chordShapeCreator[5] = 5
                        chordShape[5] = Int(frentboardCounter.text!)! + 4
                    } else{
                        chordShapeCreator[5] = 5
                        chordShape[5] = Int(frentboardCounter.text!)! + 4
                        eSStringTwo.isHidden = true
                        eSStringThree.isHidden = true
                        eSStringFour.isHidden = true
                        eSStringOne.isHidden = true
                    }
                } else {
                    eSStringFive.isHidden = true
                    chordShapeCreator[5] = 0
                    chordShape[5] = 0
                }
            case 180...200:
                if stringStatusEe.text == "o"{
                    stringStatusEe.text = "x"
                    eSStringOne.isHidden = true
                    eSStringTwo.isHidden = true
                    eSStringThree.isHidden = true
                    eSStringFour.isHidden = true
                    eSStringFive.isHidden = true
                    chordShape[5] = 100
                } else{
                    stringStatusEe.text = "o"
                    chordShape[5] = Int(frentboardCounter.text!)! - 1
                }
            default: break
            }
        default: break
        }
    }
    
    func resetDots(){
        eStringOne.isHidden = true
        eStringTwo.isHidden = true
        eStringThree.isHidden = true
        eStringFour.isHidden = true
        eStringFive.isHidden = true
        aStringOne.isHidden = true
        aStringTwo.isHidden = true
        aStringThree.isHidden = true
        aStringFour.isHidden = true
        aStringFive.isHidden = true
        dStringOne.isHidden = true
        dStringTwo.isHidden = true
        dStringThree.isHidden = true
        dStringFour.isHidden = true
        dStringFive.isHidden = true
        gStringOne.isHidden = true
        gStringTwo.isHidden = true
        gStringThree.isHidden = true
        gStringFour.isHidden = true
        gStringFive.isHidden = true
        bStringOne.isHidden = true
        bStringTwo.isHidden = true
        bStringThree.isHidden = true
        bStringFour.isHidden = true
        bStringFive.isHidden = true
        eSStringOne.isHidden = true
        eSStringTwo.isHidden = true
        eSStringThree.isHidden = true
        eSStringFour.isHidden = true
        eSStringFive.isHidden = true
        
        stringStatusE.text = "o"
        stringStatusA.text = "o"
        stringStatusD.text = "o"
        stringStatusG.text = "o"
        stringStatusB.text = "o"
        stringStatusEe.text = "o"
        
        frentboardCounter.text = "1"
        
        chordShape = [0, 0, 0, 0, 0, 0]
        newChordTextField.text = ""
        newChordTextField.becomeFirstResponder()
    }
}

