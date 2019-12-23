//
//  BugReportVCViewController.swift
//  MusicAssistant
//
//  Created by Ciro on 12/19/19.
//  Copyright © 2019 Ciro. All rights reserved.
//

import UIKit

class BugReportVCViewController: UIViewController {
    
    @IBOutlet weak var bugText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bugText.layer.borderWidth = 1
        self.bugText.layer.borderColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        findFile()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        writeOnFile()
    }
    
    
    func writeOnFile() {
        if bugText.text != nil {
            
            let tabFile = "BugReport"
            let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirURL.appendingPathComponent(tabFile).appendingPathExtension("txt")
            let writeString = bugText.text!
            do{
                try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func findFile() {
        let fileName = "BugReport"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        do {
            let readString = try String(contentsOf: fileURL)
            
            bugText.text = readString

        } catch let error as NSError {
            print("Error: \(error)")
        }
    }

}
