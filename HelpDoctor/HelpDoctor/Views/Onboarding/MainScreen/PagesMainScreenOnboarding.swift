//
//  PagesMainScreenOnboarding.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

enum PagesMainScreenOnboarding: CaseIterable {
    case pageZero
    case pageOne
    case pageTwo
    case pageThree
    case pageFour
    
    var contentView: UIView {
        switch self {
        case .pageZero:
            return FirstPageOnboardingMainScreenView()
        case .pageOne:
            return SecondPageOnboardingMainScreenView()
        case .pageTwo:
            return ThirdPageOnboardingMainScreenView()
        case .pageThree:
            return FourthPageOnboardingMainScreenView()
        case .pageFour:
            return FifthPageOnboardingMainScreenView()
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
        case .pageFour:
            return 4
        }
    }
}
