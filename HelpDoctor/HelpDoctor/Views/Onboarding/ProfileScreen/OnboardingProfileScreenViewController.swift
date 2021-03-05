//
//  OnboardingProfileScreenViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.03.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class OnboardingProfileScreenViewController: UIViewController {
    private lazy var contentView = page.contentView
    
    var page: PagesProfileScreenOnboarding
    
    init(with page: PagesProfileScreenOnboarding) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
    }    
}
