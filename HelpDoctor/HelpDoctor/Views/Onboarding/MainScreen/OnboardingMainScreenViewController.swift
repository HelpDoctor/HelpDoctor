//
//  OnboardingMainScreenViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class OnboardingMainScreenViewController: UIViewController {
    private lazy var contentView = page.contentView
    
    var page: PagesMainScreenOnboarding
    
    init(with page: PagesMainScreenOnboarding) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        
        guard let fifthView = contentView as? FifthPageOnboardingMainScreenView else { return }
        fifthView.doneButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
    }
    
    override func loadView() {
        view = contentView
    }
    
    @objc private func closeButtonPressed() {
        UserDefaults.standard.set(true, forKey: "onboardingMainScreenPassed")
        dismiss(animated: true)
    }
    
}
