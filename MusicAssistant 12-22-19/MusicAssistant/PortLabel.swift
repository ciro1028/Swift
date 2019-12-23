//
//  PortLabel.swift
//  AirTurnExample-Swift
//
//  Created by Nick Brook on 18/11/2015.
//  Copyright © 2015 AirTurn. All rights reserved.
//

import UIKit

class PortLabel: UILabel {

    fileprivate var timer: Timer? {
        didSet {
            oldValue?.invalidate()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.setup()
    }
    
    fileprivate func setup() {
        if self.highlightedTextColor == nil {
            self.highlightedTextColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
        }
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }
    
    func highlight() {
        if self.timer == nil {
            self.isHighlighted = true
            self.layer.shadowColor = self.highlightedTextColor?.cgColor
            self.layer.shadowOpacity = 1
        }
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(PortLabel.deselectLabel), userInfo: nil, repeats: false)
    }
    
    @objc func deselectLabel() {
        self.isHighlighted = false
        self.layer.shadowOpacity = 0
        self.timer = nil
    }
}
