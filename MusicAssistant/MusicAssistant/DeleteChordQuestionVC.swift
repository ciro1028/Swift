//
//  DeleteChordQuestionVC.swift
//  MusicAssistant
//
//  Created by Ciro on 7/23/17.
//  Copyright © 2017 Ciro. All rights reserved.
//

import UIKit

var newIndex = Int()


class DeleteChordQuestionVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        mainView.layer.cornerRadius = mainView.frame.size.height/2
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        chords[originalChordFamily]!.remove(at: newIndex)
        chordShapes[originalChordFamily]!.remove(at: newIndex)
        
        save(dictionary: chords, forKey: "Chords")
        save2(dictionary: chordShapes, forKey: "ChordShapes")
        
        addNewChordCheck = true
        addNewSongCheck = false
        checkComeFromEditChord = false
                
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "addSongVC") as! AddSongVC
        self.navigationController?.pushViewController(editVC, animated: false)
        
    }
    
    func save(dictionary: [String: [String]], forKey key: String) {
        let archiver = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        UserDefaults.standard.set(archiver, forKey: key)
    }
    
    func save2(dictionary: [String: [[Int]]], forKey key: String) {
        let archiver = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        UserDefaults.standard.set(archiver, forKey: key)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
}
