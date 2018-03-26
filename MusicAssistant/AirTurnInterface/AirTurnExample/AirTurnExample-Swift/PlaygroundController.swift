//
//  PlaygroundController.swift
//  AirTurnExample-Swift
//
//  Created by Nick Brook on 18/11/2015.
//  Copyright © 2015 AirTurn. All rights reserved.
//

import UIKit

class PlaygroundController: UIViewController, UIToolbarDelegate {
    
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    var pc: NBPopoverController!
    
    override func awakeFromNib() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.pc = NBPopoverController(contentViewController: UIViewController())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        /*
        When a modal view is dismissed, if there is no external keyboard connected but a text view is first responder, after the modal view is dismissed the AirTurn framework will indicate an external keyboard has been connected. This is because for some reason, UIKit dismisses the keyboard before resigning first responder. To avoid this problem, resign first responder before the view disappears.
        */
        self.textView.resignFirstResponder()
        self.searchBar.resignFirstResponder()
        super.viewWillDisappear(animated)
    }
    
    @IBAction func showPopover(_ sender: UIButton) {
        self.pc.present(from: sender.frame, in: self.view, permittedArrowDirections: .up, animated: true)
    }
    
    @IBAction func tap(_ sender: AnyObject) {
        self.textView.resignFirstResponder()
        self.searchBar.resignFirstResponder()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

}
