//
//  PagesProfileScreenOnboarding.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.03.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

enum PagesProfileScreenOnboarding: CaseIterable {
    case pageZero
    case pageOne
    case pageTwo
    case pageThree
    
    var contentView: UIView {
        switch self {
        case .pageZero:
            return FirstPageOnboardingProfileScreenView()
        case .pageOne:
            return SecondPageOnboardingProfileScreenView()
        case .pageTwo:
            return ThirdPageOnboardingProfileScreenView()
        case .pageThree:
            return FourthPageOnboardingProfileScreenView()
        }
    }
    
    var index: Int {
        switch self {
        case .pageZero:
            return 0
        case .pageOne:
            return 1
        case .pageTwo:
            return 2
        case .pageThree:
            return 3
        }
    }
}
