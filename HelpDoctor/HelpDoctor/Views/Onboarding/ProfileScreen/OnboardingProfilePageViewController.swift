//
//  OnboardingProfileScreenPageViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.03.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class OnboardingProfilePageViewController: EZSwipeController {
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CloseButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.alpha = 1
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        pageControl.currentPageIndicatorTintColor = .hdButtonColor
        pageControl.transform = CGAffineTransform(scaleX: 2, y: 2)
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    override func setupView() {
        datasource = self
        addSubviews()
        setupConstraints()
        setupTargets()
        setupHole()
    }
    
    private func addSubviews() {
        [pageControl, closeButton]
            .forEach {
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setupConstraints() {
        let closeButtonConstraints = [
            closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let pageControlConstraints = [
            pageControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: Session.width - 80),
            pageControl.heightAnchor.constraint(equalToConstant: 16)
        ]
        
        [closeButtonConstraints,
         pageControlConstraints]
            .forEach(NSLayoutConstraint.activate(_:))
    }
    
    private func setupTargets() {
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
    }
    
    @objc private func closeButtonPressed() {
        UserDefaults.standard.set(true, forKey: "onboardingProfileScreenPassed")
        dismiss(animated: true)
    }
    
    private func createOneHole(x: CGFloat, y: CGFloat) -> CAShapeLayer {
        let radius = 25.f
        let finalPath = UIBezierPath(rect: view.bounds)
        let path = UIBezierPath(arcCenter: CGPoint(x: x, y: y),
                                radius: radius,
                                startAngle: 0.0,
                                endAngle: 2.0 * CGFloat.pi,
                                clockwise: false)
        
        finalPath.append(path)
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalPath.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        return maskLayer
    }
    
    private func createTwoHoles(centerX1: CGFloat,
                                centerY1: CGFloat,
                                centerX2: CGFloat,
                                centerY2: CGFloat,
                                radius2: CGFloat) -> CAShapeLayer {
        let finalPath = UIBezierPath(rect: view.bounds)
        let path1 = UIBezierPath(arcCenter: CGPoint(x: centerX1, y: centerY1),
                                 radius: 25.f,
                                 startAngle: 0.0,
                                 endAngle: 2.0 * CGFloat.pi,
                                 clockwise: false)
        finalPath.append(path1)
        
        
        let path2 = UIBezierPath(arcCenter: CGPoint(x: centerX2, y: centerY2),
                                 radius: radius2,
                                 startAngle: 0.0,
                                 endAngle: 2.0 * CGFloat.pi,
                                 clockwise: false)
        finalPath.append(path2)
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalPath.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        return maskLayer
    }
    
    private func createOvalHole(x: CGFloat, y: CGFloat) -> CAShapeLayer {
        let finalPath = UIBezierPath(rect: view.bounds)
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: x - 60,
                                                   y: y - 5,
                                                   width: 120,
                                                   height: 60))
        finalPath.append(ovalPath)
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalPath.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        return maskLayer
    }
    
    private func createRectHole(x: CGFloat, y: CGFloat) -> CAShapeLayer {
        let finalPath = UIBezierPath(rect: view.bounds)
        let rectPath = UIBezierPath(roundedRect: CGRect(x: x,
                                                        y: y,
                                                        width: Session.width - 20,
                                                        height: 40),
                                    byRoundingCorners: .allCorners,
                                    cornerRadii: CGSize(width: 5, height: 5))
        finalPath.append(rectPath)
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalPath.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        return maskLayer
    }
    
    private func setupHole() {
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        view.clipsToBounds = true
        
        switch pageControl.currentPage {
        case 0:
            view.layer.mask = createOvalHole(x: Session.width / 2, y: Session.height / 2 - 50 + topPadding)
        case 1:
            view.layer.mask = createRectHole(x: 10, y: Session.height / 2 + topPadding)
        case 2:
            view.layer.mask = createOneHole(x: Session.width - 15, y: (Session.height / 2) - 25 + topPadding)
        case 3:
            let TV = Session.height / 2 - 90 // Высота TopView
            let bottom = Session.height * 3 / 8 - 23.5
            let width = Session.width - ((Session.width / 2) - (TV / 3)) - 10 - TV / 12
            
            view.layer.mask = createTwoHoles(centerX1: Session.width - 15,
                                             centerY1: (Session.height / 2) - 25 + topPadding,
                                             centerX2: width,
                                             centerY2: bottom + topPadding,
                                             radius2: Session.height / 24 + 2.5)
        default:
            break
        }
        view.layoutSubviews()
    }
    
}

extension OnboardingProfilePageViewController: EZSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController] {
        let firstVC = OnboardingProfileScreenViewController(with: .pageZero)
        let secondVC = OnboardingProfileScreenViewController(with: .pageOne)
        let thirdVC = OnboardingProfileScreenViewController(with: .pageTwo)
        let fourthVC = OnboardingProfileScreenViewController(with: .pageThree)
        return [firstVC, secondVC, thirdVC, fourthVC]
    }
    
    func changedToPageIndex(_ index: Int) {
        pageControl.currentPage = index
        setupHole()
    }
}
