//
//  ColorPalletVC.swift
//  MusicAssistant
//
//  Created by Ciro on 8/1/17.
//  Copyright © 2017 Ciro. All rights reserved.
//

import UIKit

class ColorPalletVC: UIViewController {
    
    @IBAction func blueButton(_ sender: UIButton) {
        chordColor = UIColor.blue
    }

    
    @IBAction func redButton(_ sender: UIButton) {
        chordColor = UIColor.red
        performSegue(withIdentifier: "fromColortoVC", sender: self)
    }

    @IBAction func greenButton(_ sender: UIButton) {
        chordColor = UIColor.green
        performSegue(withIdentifier: "fromColortoVC", sender: self)
    }

    @IBAction func orangeButton(_ sender: UIButton) {
        chordColor = UIColor.orange
        performSegue(withIdentifier: "fromColortoVC", sender: self)
    }

    @IBAction func purpleButton(_ sender: UIButton) {
        chordColor = UIColor.purple
        performSegue(withIdentifier: "fromColortoVC", sender: self)
    }    
}
