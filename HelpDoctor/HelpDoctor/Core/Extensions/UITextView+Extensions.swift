//
//  UITextView+Extensions.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

extension UITextView {

    /// Add an attachment recognizer to a UITTextView
    func add(_ attachmentRecognizer: AttachmentTapGestureRecognizer) {
        for other in gestureRecognizers ?? [] {
            other.require(toFail: attachmentRecognizer)
        }
        addGestureRecognizer(attachmentRecognizer)
    }

}
