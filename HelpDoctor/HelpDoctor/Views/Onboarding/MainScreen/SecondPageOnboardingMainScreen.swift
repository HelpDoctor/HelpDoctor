//
//  SecondPageOnboardingMainScreen.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 27.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SecondPageOnboardingMainScreen: UIViewController {
    
    private let closeButton = UIButton()
    private let backButton = UIButton()
    private let firstPageButton = UIButton()
    private let secondPageButton = UIButton()
    private let thirdPageButton = UIButton()
    private let fourthPageButton = UIButton()
    private let fifthPageButton = UIButton()
    private let nextButton = UIButton()
    private let label = UILabel()
    private let image = UIImageView()
    private let arrowImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        setupCloseButton()
        setupThirdPageButton()
        setupSecondPageButton()
        setupFirstPageButton()
        setupBackButton()
        setupFourthPageButton()
        setupFifthPageButton()
        setupNextButton()
        setupImage()
        setupLabel()
        setupArrowImage()
        setupHole()
    }
    
    // MARK: - Setup views
    private func setupCloseButton() {
        let size = 20.f
        closeButton.setImage(UIImage(named: "CloseButton"), for: .normal)
        closeButton.imageView?.contentMode = .scaleAspectFill
        closeButton.contentHorizontalAlignment = .center
        closeButton.contentVerticalAlignment = .center
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        view.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                         constant: 10).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupThirdPageButton() {
        let size = 16.f
        thirdPageButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        thirdPageButton.layer.cornerRadius = 8
        view.addSubview(thirdPageButton)
        
        thirdPageButton.translatesAutoresizingMaskIntoConstraints = false
        thirdPageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        thirdPageButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        thirdPageButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        thirdPageButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupSecondPageButton() {
        let size = 20.f
        secondPageButton.layer.cornerRadius = 10
        secondPageButton.backgroundColor = .hdButtonColor
        secondPageButton.layer.borderWidth = 1
        secondPageButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(secondPageButton)
        
        secondPageButton.translatesAutoresizingMaskIntoConstraints = false
        secondPageButton.trailingAnchor.constraint(equalTo: thirdPageButton.leadingAnchor, constant: -12).isActive = true
        secondPageButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        secondPageButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        secondPageButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupFirstPageButton() {
        let size = 16.f
        firstPageButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        firstPageButton.layer.cornerRadius = 8
        view.addSubview(firstPageButton)
        
        firstPageButton.translatesAutoresizingMaskIntoConstraints = false
        firstPageButton.trailingAnchor.constraint(equalTo: secondPageButton.leadingAnchor, constant: -12).isActive = true
        firstPageButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        firstPageButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        firstPageButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupBackButton() {
        backButton.setImage(UIImage(named: "BackBraceButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.trailingAnchor.constraint(equalTo: firstPageButton.leadingAnchor, constant: -12).isActive = true
        backButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 10.f).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20.f).isActive = true
    }
    
    private func setupFourthPageButton() {
        let size = 16.f
        fourthPageButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        fourthPageButton.layer.cornerRadius = 8
        view.addSubview(fourthPageButton)
        
        fourthPageButton.translatesAutoresizingMaskIntoConstraints = false
        fourthPageButton.leadingAnchor.constraint(equalTo: thirdPageButton.trailingAnchor, constant: 12).isActive = true
        fourthPageButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        fourthPageButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        fourthPageButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupFifthPageButton() {
        let size = 16.f
        fifthPageButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        fifthPageButton.layer.cornerRadius = 8
        view.addSubview(fifthPageButton)
        
        fifthPageButton.translatesAutoresizingMaskIntoConstraints = false
        fifthPageButton.leadingAnchor.constraint(equalTo: fourthPageButton.trailingAnchor, constant: 12).isActive = true
        fifthPageButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        fifthPageButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        fifthPageButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupNextButton() {
        nextButton.setImage(UIImage(named: "NextBraceButton"), for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        view.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.leadingAnchor.constraint(equalTo: fifthPageButton.trailingAnchor, constant: 12).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 10.f).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 20.f).isActive = true
    }
    
    private func setupImage() {
        let width = 0.4 * Session.width
        let imageName = "WomenRightInCircle.pdf"
        guard let newImage = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = newImage.resizeImage(width, opaque: false)
        image.image = resizedImage
        view.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        image.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 80).isActive = true
        image.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        image.heightAnchor.constraint(equalToConstant: resizedImage.size.height).isActive = true
    }
    
    private func setupLabel() {
        let top = 10.f
        let leading = 20.f
        let height = 40.f
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "Нажав на эту кнопку, Вы попадете на экран расписания"
        label.textAlignment = .right
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: image.bottomAnchor,
                                   constant: top).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                        constant: -leading).isActive = true
        label.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupArrowImage() {
        let imageName = "SecondPageArrow.pdf"
        arrowImage.image = UIImage(named: imageName)
        view.addSubview(arrowImage)
        
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Session.width / 5).isActive = true
        arrowImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        arrowImage.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        arrowImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                           constant: -30).isActive = true
    }
    
    private func setupHole() {
        let window = UIApplication.shared.windows[0]
        let bottomPadding = window.safeAreaInsets.bottom
        let radius = 25.f
        let path = CGMutablePath()
        let centerX = Session.width / 10
        let centerY = Session.height - bottomPadding - radius
        path.addArc(center: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: 0.0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
        path.addRect(CGRect(origin: .zero, size: view.frame.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        view.layer.mask = maskLayer
        view.clipsToBounds = true
    }
    
    // MARK: - Buttons methods
    @objc private func closeButtonPressed() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextButtonPressed() {
        let onboardingVC = ThirdPageOnboardingMainScreen()
        navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
}

