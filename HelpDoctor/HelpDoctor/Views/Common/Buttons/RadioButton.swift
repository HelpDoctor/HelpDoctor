//
//  RadioButton.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 06.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
    // Images
    let checkedImage = UIImage(named: "WhiteSelectedEllipse.pdf")
    let uncheckedImage = UIImage(named: "WhiteEllipse.pdf")
    
    var alternateButton: [RadioButton]?

    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }

    func unselectAlternateButtons() {
        guard let alternateButton = alternateButton else {
            toggleButton()
            return
        }
        self.isSelected = true
        
        for aButton: RadioButton in alternateButton {
            aButton.isSelected = false
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }

    func toggleButton() {
        self.isSelected = !isSelected
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }

}
