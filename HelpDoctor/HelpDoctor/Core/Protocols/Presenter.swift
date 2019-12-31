//
//  Presenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol Presenter {
    var view: UIViewController { get set }
    
    init(view: UIViewController)
}
