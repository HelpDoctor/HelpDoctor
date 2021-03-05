//
//  OnboardingMainScreenPageViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class OnboardingMainScreenPageViewController: EZSwipeController {
    
    override func setupView() {
        datasource = self
        addSubviews()
        setupConstraints()
        setupTargets()
    }
    
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
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        pageControl.currentPageIndicatorTintColor = .hdButtonColor
        pageControl.transform = CGAffineTransform(scaleX: 2, y: 2)
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
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
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
    }
    
    @objc private func closeButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc private func pageControlValueChanged() {
        print(pageControl.currentPage)
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
                                centerY2: CGFloat) -> CAShapeLayer {
        let radius = 25.f
        let finalPath = UIBezierPath(rect: view.bounds)
        let path1 = UIBezierPath(arcCenter: CGPoint(x: centerX1, y: centerY1),
                                 radius: radius,
                                 startAngle: 0.0,
                                 endAngle: 2.0 * CGFloat.pi,
                                 clockwise: false)
        finalPath.append(path1)
        
        
        let path2 = UIBezierPath(arcCenter: CGPoint(x: centerX2, y: centerY2),
                                 radius: radius,
                                 startAngle: 0.0,
                                 endAngle: 2.0 * CGFloat.pi,
                                 clockwise: false)
        finalPath.append(path2)
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalPath.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        return maskLayer
    }
    
    private func setupHole() {
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        let bottomPadding = window.safeAreaInsets.bottom
        let radius = 25.f
        view.clipsToBounds = true
        
        switch pageControl.currentPage {
        case 0:
            view.layer.mask = nil
        case 1:
            view.layer.mask = createOneHole(x: Session.width / 10, y: Session.height - bottomPadding - radius)
        case 2:
            let centerX1 = (Session.width / 10) + (Session.width / 5)
            let centerY = Session.height - bottomPadding - radius
            let centerX2 = (Session.width / 10) + 2 * (Session.width / 5)
            view.layer.mask = createTwoHoles(centerX1: centerX1,
                                             centerY1: centerY,
                                             centerX2: centerX2,
                                             centerY2: centerY)
        case 3:
            let centerX1 = (Session.width / 10) + 3 * (Session.width / 5)
            let centerY = Session.height - bottomPadding - radius
            let centerX2 = (Session.width / 10) + 4 * (Session.width / 5)
            view.layer.mask = createTwoHoles(centerX1: centerX1,
                                             centerY1: centerY,
                                             centerX2: centerX2,
                                             centerY2: centerY)
        case 4:
            view.layer.mask = createOneHole(x: Session.width - 23, y: topPadding + 20)
        default:
            break
        }
        view.layoutSubviews()
    }
}

extension OnboardingMainScreenPageViewController: EZSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController] {
        let firstVC = OnboardingMainScreenViewController(with: .pageZero)
        let secondVC = OnboardingMainScreenViewController(with: .pageOne)
        let thirdVC = OnboardingMainScreenViewController(with: .pageTwo)
        let fourthVC = OnboardingMainScreenViewController(with: .pageThree)
        let fifthVC = OnboardingMainScreenViewController(with: .pageFour)
        return [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
    }
    
    func changedToPageIndex(_ index: Int) {
        pageControl.currentPage = index
        setupHole()
    }
}
