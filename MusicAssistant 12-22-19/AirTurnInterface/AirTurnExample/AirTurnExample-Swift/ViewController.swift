//
//  ViewController.swift
//  AirTurnExample-Swift
//
//  Created by Nick Brook on 18/11/2015.
//  Copyright © 2015 AirTurn. All rights reserved.
//

import UIKit
import AirTurnInterface
import MediaPlayer

#if (arch(i386) || arch(x86_64)) && os(iOS)
let AirTurnPlayPauseiPod = false
#else
let AirTurnPlayPauseiPod = true
#endif

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, AirTurnUIDelegate {
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet var portLabels: [PortLabel]!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var connectedLED: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To be notified of button events, add an object as an observer of the button event to NSNotificationCenter.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.AirTurnEvent(_:)), name: NSNotification.Name.AirTurnPedalPress, object: nil)
        
        self.connectedLED.isHighlighted = AirTurnManager.shared().isConnected
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.connectionStateChanged(_:)), name: NSNotification.Name.AirTurnConnectionStateChanged, object: nil)
        
        // add the tap gesture to exit the text field
        let gr = UITapGestureRecognizer(target: self, action: #selector(ViewController.viewTapped(_:)))
        gr.numberOfTapsRequired = 1
        gr.numberOfTouchesRequired = 1
        gr.cancelsTouchesInView = false
        gr.delaysTouchesBegan = false
        self.view.addGestureRecognizer(gr)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - AirTurn

    @IBAction func killApp(_ sender: UIButton) {
        kill(getpid(), SIGKILL)
    }
    
    func AirTurnEvent(_ notification: Notification) {
        if let dict = (notification as NSNotification).userInfo as? [String:AnyObject], let portNum = dict[AirTurnPortNumberKey] as? NSNumber, let pedal = AirTurnPort(rawValue: portNum.intValue) {
            if pedal == .portInvalid {
                return
            }
            let curLab = self.portLabels[pedal.rawValue - 1]
            curLab.highlight()
            
            if AirTurnPlayPauseiPod && AirTurnCentral.backgroundOperationEnabled() {
                let ipod = MPMusicPlayerController.systemMusicPlayer()
                if ipod.nowPlayingItem == nil {
                    let query = MPMediaQuery.songs()
                    ipod.setQueue(with: query)
                    if let items = query.items {
                        let item = items[Int(arc4random_uniform(UInt32(items.count)))]
                        ipod.nowPlayingItem = item
                    }
                }
                switch pedal {
                    case .port1: ipod.play()
                    case .port3: ipod.pause()
                    default: break
                }
            }
        }
    }
    
    func connectionStateChanged(_ notification: Notification) {
        if let dict = (notification as NSNotification).userInfo as? [String:AnyObject], let num = dict[AirTurnPortNumberKey] as? NSNumber, let state = AirTurnConnectionState(rawValue: num.intValue) {
            self.connectedLED.isHighlighted = state == .connected
        }
    }
    
    func airTurnUIRequestsDisplay(_ connectionController: AirTurnUIConnectionController) -> Bool {
        self.performSegue(withIdentifier: "AirTurnUI", sender: self.settingsButton)
        return true
    }
    
    // MARK: - Other bits
    
    func viewTapped(_ gr: UITapGestureRecognizer) {
        if !self.textField.frame.contains(gr.location(in: self.view)) {
            self.textField.resignFirstResponder()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController {
            nav.popoverPresentationController?.delegate = self
        }
        super.prepare(for: segue, sender: sender)
    }
    
    func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .fullScreen
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        if let nc = controller.presentedViewController as? UINavigationController {
            let bbi = UIBarButtonItem(title: NSLocalizedString("Done", comment: "AirTurn UI dismiss button in nav controller"), style: .done, target: self, action: #selector(ViewController.dismissSelf))
            nc.topViewController?.navigationItem.leftBarButtonItem = bbi
        }
        return controller.presentedViewController
    }
    
    @IBAction func exit(_ segue: UIStoryboardSegue) {
        
    }
}

