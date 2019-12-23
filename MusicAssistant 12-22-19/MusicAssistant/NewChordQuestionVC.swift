//
//  NewChordQuestionVC.swift
//  MusicAssistant
//
//  Created by Ciro on 7/13/17.
//  Copyright © 2017 Ciro. All rights reserved.
//

import UIKit

class NewChordQuestionVC: UIViewController {
    
    @IBAction func yesButton(_ sender: UIButton) {
        let newChordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newChordVC") as! NewChordVC
        self.addChild(newChordViewController)
        newChordViewController.view.frame = self.view.frame
        self.view.addSubview(newChordViewController.view)
        newChordViewController.didMove(toParent: self)
        addNewChordCheck = true
    }
    @IBAction func noButton(_ sender: UIButton) {
        close()
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
    }

    func close(){
        self.view.removeFromSuperview()
    }
    
}
    
