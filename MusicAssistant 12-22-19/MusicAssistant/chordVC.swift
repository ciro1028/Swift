//
//  chordVC.swift
//  MusicAssistant
//
//  Created by Ciro on 7/12/17.
//  Copyright © 2017 Ciro. All rights reserved.
//

import UIKit

var chordPlaceHolder = String()

class chordVC: UIViewController {
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var chordLabel: UILabel!
    @IBOutlet weak var fretNumberLabel: UILabel!
    
    @IBOutlet weak var eStringE: UILabel!
    @IBOutlet weak var bString: UILabel!
    @IBOutlet weak var gString: UILabel!
    @IBOutlet weak var dString: UILabel!
    @IBOutlet weak var aString: UILabel!
    @IBOutlet weak var eString: UILabel!
    
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
    
    @IBOutlet weak var variationsLabel: UILabel!
    @IBOutlet weak var variationsPrevi: UIButton!
    @IBOutlet weak var variationsNext: UIButton!
    @IBOutlet weak var addVariationButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var stringOne = Int()
    var stringTwo = Int()
    var stringThree = Int()
    var stringFour = Int()
    var stringFive = Int()
    var stringSix = Int()
    
    var variations = [[Int]]()
    var currentVariationNumber = 0
    var baseChord = String()
    var numberForFindingShape = Int()
    var count = Int()
    var check = false
    var chordFound = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true
        
        secondView.layer.cornerRadius = 15
        secondView.clipsToBounds = true

        label.text = chordPlaceHolder
        loadChordIntoDiagram()
        
        if variations.count > 1{
            variationsNext.isHidden = false
            variationsPrevi.isHidden = false
        } else {
            variationsNext.isHidden = true
            variationsPrevi.isHidden = true
        }
    }
    
    @IBAction func addVariationButton(_ sender: UIButton) {
        newVariation = true
        addNewChordCheck = true
        checkComeFromEditChord = false
        originalChordName = chordPlaceHolder
        performSegue(withIdentifier: "toNewChord", sender: self)
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        self.view.removeFromSuperview()
    }
    
    @IBAction func prevButton(_ sender: UIButton) {
        eStringE.text = "o"
        aString.text = "o"
        dString.text = "o"
        gString.text = "o"
        bString.text = "o"
        eString.text = "o"
        resetStrings()
        loadPrevVariation()
    }
    
    @IBAction func nextNutton(_ sender: UIButton) {
        eStringE.text = "o"
        aString.text = "o"
        dString.text = "o"
        gString.text = "o"
        bString.text = "o"
        eString.text = "o"
        resetStrings()
        loadNextVariation()
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        passInfoToNewChord()
        checkComeFromEditChord = true
    }
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBAction func searchText(_ sender: UITextField) {
        chordPlaceHolder = searchText.text!
        editButton.isHidden = true
        addVariationButton.isHidden = true
        resetStrings()
        hideDots()
        findChord()
        if variations.count > 1{
            variationsNext.isHidden = false
            variationsPrevi.isHidden = false
        } else {
            variationsNext.isHidden = true
            variationsPrevi.isHidden = true
        }
        if chordFound{
            editButton.isHidden = false
            addVariationButton.isHidden = false
            editButton.setTitle("Edit", for: .normal)
            chordFound = false
        }else{
            editButton.setTitle("New", for: .normal)
            addVariationButton.isHidden = true
        }
    }
    
    func findChord(){
        variations = [[Int]]()
        currentVariationNumber = 0
        if chordPlaceHolder != ""{
            loadChordIntoDiagram()
            if variations.count > 1{
                variationsNext.isHidden = false
                variationsPrevi.isHidden = false
            }
            
            if check{
                label.text = searchText.text!
                editButton.isHidden = false
                addVariationButton.isHidden = false
            } else {
                label.text = "Chord Does Not Exist"
                
                resetStrings()
                hideDots()
            }
        }
        if searchText.text! == ""{
            label.text = ""
        }
    }
    
    func passInfoToNewChord(){
        originalStringsPositions[0] = stringOne
        originalStringsPositions[1] = stringTwo
        originalStringsPositions[2] = stringThree
        originalStringsPositions[3] = stringFour
        originalStringsPositions[4] = stringFive
        originalStringsPositions[5] = stringSix
        if eString.text! == "x"{
            originalStringsPositions[0] = 100
        }
        if aString.text! == "x"{
            originalStringsPositions[1] = 100
        }
        if dString.text! == "x"{
            originalStringsPositions[2] = 100
        }
        if gString.text! == "x"{
            originalStringsPositions[3] = 100
        }
        if bString.text! == "x"{
            originalStringsPositions[4] = 100
        }
        if eStringE.text! == "x"{
            originalStringsPositions[5] = 100
        }
        
        passedChordName = label.text!
        
        if fretNumberLabel.text! == ""{
            fretNumber = "1"
        } else{
            fretNumber = fretNumberLabel.text!
        }
        originalShape = variations[currentVariationNumber]
    }
    
    func resetStrings(){
        stringOne = Int()
        stringTwo = Int()
        stringThree = Int()
        stringFour = Int()
        stringFive = Int()
        stringSix = Int()
    }
    
    func loadChordIntoDiagram(){
        let start = chordPlaceHolder.index(chordPlaceHolder.startIndex, offsetBy: 0)
        let end = chordPlaceHolder.index(start, offsetBy: 1)
        let range = start..<end
        let firstChar = chordPlaceHolder.substring(with: range)
        var additionalString = String()
        fretNumberLabel.text = ""
        var additionToTheString = 0
        var biggestNumber = Int()
        
        if chordPlaceHolder.characters.count > 1{
            let start2 = chordPlaceHolder.index(chordPlaceHolder.startIndex, offsetBy: 1)
            let end2 = chordPlaceHolder.index(start2, offsetBy: 1)
            let range2 = start2..<end2
            let firstChar2 = chordPlaceHolder.substring(with: range2)
            
            if firstChar2 == "b"{
                additionalString = "b"
            } else if firstChar2 == "#" {
                additionalString = "#"
            }
        }
        
        baseChord = "\(firstChar)\(additionalString)"
        
        for (key, _) in chords{
            if key == baseChord{
                check = true
                break
            } else {
                check = false
            }
        }
        
        
        if check{
            for i in 0..<chords[baseChord]!.count{
                if chords[baseChord]![i] == chordPlaceHolder{
                    label.text = chordPlaceHolder
                    variations.append(chordShapes[baseChord]![i])
                    chordFound = true
                }
            }
            
            if variations.isEmpty == false {
            for num in variations[currentVariationNumber]{
                if num > biggestNumber && num < 25{
                    biggestNumber = num
                }
            }
            
            for j in 0..<variations[currentVariationNumber].count{
                
                if biggestNumber > 5{
                    additionToTheString = biggestNumber - 5
                    fretNumberLabel.text = String(describing: additionToTheString + 1)
                    if Int(fretNumberLabel.text!)! >= 12{
                        fretNumberLabel.text = String(describing: Int(fretNumberLabel.text!)! - 12)
                    }
                    if fretNumberLabel.text! == "0"{
                        fretNumberLabel.text = ""
                    }
                }
                
                if j == 0{
                    switch variations[currentVariationNumber][j] - additionToTheString{
                    case _ where variations[currentVariationNumber][j] - additionToTheString <=  0:
                        eString.text = "o"
                    case 1:
                        eStringOne.isHidden = false
                        stringOne = 1
                    case 2:
                        eStringTwo.isHidden = false
                        stringOne = 2
                    case 3:
                        eStringThree.isHidden = false
                        stringOne = 3
                    case 4:
                        eStringFour.isHidden = false
                        stringOne = 4
                    case 5:
                        eStringFive.isHidden = false
                        stringOne = 5
                    default: eString.text = "x"
                    }
                }
                
                if j == 1{
                    switch variations[currentVariationNumber][j] - additionToTheString{
                    case _ where variations[currentVariationNumber][j] - additionToTheString <=  0:
                        aString.text = "o"
                    case 1:
                        aStringOne.isHidden = false
                        stringTwo = 1
                    case 2:
                        aStringTwo.isHidden = false
                        stringTwo = 2
                    case 3:
                        aStringThree.isHidden = false
                        stringTwo = 3
                    case 4:
                        aStringFour.isHidden = false
                        stringTwo = 4
                    case 5:
                        aStringFive.isHidden = false
                        stringTwo = 5
                    default: aString.text = "x"
                    }
                }
                
                if j == 2{
                    switch variations[currentVariationNumber][j] - additionToTheString{
                    case _ where variations[currentVariationNumber][j] - additionToTheString <=  0:
                        dString.text = "o"
                    case 1:
                        dStringOne.isHidden = false
                        stringThree = 1
                    case 2:
                        dStringTwo.isHidden = false
                        stringThree = 2
                    case 3:
                        dStringThree.isHidden = false
                        stringThree = 3
                    case 4:
                        dStringFour.isHidden = false
                        stringThree = 4
                    case 5:
                        dStringFive.isHidden = false
                        stringThree = 5
                    default: dString.text = "x"
                    }
                }
                if j == 3{
                    switch variations[currentVariationNumber][j] - additionToTheString{
                    case _ where variations[currentVariationNumber][j] - additionToTheString <=  0:
                        gString.text = "o"
                    case 1:
                        gStringOne.isHidden = false
                        stringFour = 1
                    case 2:
                        gStringTwo.isHidden = false
                        stringFour = 2
                    case 3:
                        gStringThree.isHidden = false
                        stringFour = 3
                    case 4:
                        gStringFour.isHidden = false
                        stringFour = 4
                    case 5:
                        gStringFive.isHidden = false
                        stringFour = 5
                    default: gString.text = "x"
                    }
                }
                if j == 4{
                    switch variations[currentVariationNumber][j] - additionToTheString{
                    case _ where variations[currentVariationNumber][j] - additionToTheString <=  0:
                        bString.text = "o"
                    case 1:
                        bStringOne.isHidden = false
                        stringFive = 1
                    case 2:
                        bStringTwo.isHidden = false
                        stringFive = 2
                    case 3:
                        bStringThree.isHidden = false
                        stringFive = 3
                    case 4:
                        bStringFour.isHidden = false
                        stringFive = 4
                    case 5:
                        bStringFive.isHidden = false
                        stringFive = 5
                    default: bString.text = "x"
                    }
                }
                if j == 5{
                    switch variations[currentVariationNumber][j] - additionToTheString{
                    case _ where variations[currentVariationNumber][j] - additionToTheString <=  0:
                        eStringE.text = "o"
                    case 1:
                        eSStringOne.isHidden = false
                        stringSix = 1
                    case 2:
                        eSStringTwo.isHidden = false
                        stringSix = 2
                    case 3:
                        eSStringThree.isHidden = false
                        stringSix = 3
                    case 4:
                        eSStringFour.isHidden = false
                        stringSix = 4
                    case 5:
                        eSStringFive.isHidden = false
                        stringSix = 5
                    default: eStringE.text = "x"
                    }
                }
            }
            }
        }
    }
    
    func loadNextVariation(){
        hideDots()
        if currentVariationNumber == variations.count {
            currentVariationNumber = 0
        } else {
            currentVariationNumber = currentVariationNumber + 1
        }
        loadChordIntoDiagram()
    }
    
    func loadPrevVariation(){
        hideDots()
        if currentVariationNumber == 0 {
            currentVariationNumber = variations.count - 1
        } else {
            currentVariationNumber = currentVariationNumber - 1
        }
        loadChordIntoDiagram()
    }
    
    func hideDots() {
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
        
        mainImageView.isHidden = false
    }
}
