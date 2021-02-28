//
//  FifthPageOnboardingMainScreen.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FifthPageOnboardingMainScreen: UIViewController {
    
    private let closeButton = UIButton()
    private let backButton = UIButton()
    private let firstPageButton = UIButton()
    private let secondPageButton = UIButton()
    private let thirdPageButton = UIButton()
    private let fourthPageButton = UIButton()
    private let fifthPageButton = UIButton()
    private let nextButton = UIButton()
    private let topLabel = UILabel()
    private let image = UIImageView()
    private let arrowImage = UIImageView()
    private let doneButton = HDButton(title: "Понятно. Спасибо", fontSize: 16)
    
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
        setupTopLabel()
        setupArrowImage()
        setupDoneButton()
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
        let size = 16.f
        secondPageButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        secondPageButton.layer.cornerRadius = 8
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
        let size = 20.f
        fifthPageButton.layer.cornerRadius = 10
        fifthPageButton.backgroundColor = .hdButtonColor
        fifthPageButton.layer.borderWidth = 1
        fifthPageButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(fifthPageButton)
        
        fifthPageButton.translatesAutoresizingMaskIntoConstraints = false
        fifthPageButton.leadingAnchor.constraint(equalTo: fourthPageButton.trailingAnchor, constant: 12).isActive = true
        fifthPageButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        fifthPageButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        fifthPageButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupNextButton() {
        nextButton.setImage(UIImage(named: "NextBraceButton"), for: .normal)
        nextButton.isHidden = true
        view.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.leadingAnchor.constraint(equalTo: fifthPageButton.trailingAnchor, constant: 12).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 10.f).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 20.f).isActive = true
    }
    
    private func setupImage() {
        let width = 0.4 * Session.width
        let imageName = "MenLeftInCircle.pdf"
        guard let newImage = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = newImage.resizeImage(width, opaque: false)
        image.image = resizedImage
        view.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        image.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 110).isActive = true
        image.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        image.heightAnchor.constraint(equalToConstant: resizedImage.size.height).isActive = true
    }
    
    private func setupTopLabel() {
        let top = 10.f
        let height = 100.f
        topLabel.font = .systemFont(ofSize: 14, weight: .black)
        topLabel.numberOfLines = 0
        topLabel.textColor = .white
        topLabel.text = "В любой момент Вы сможете перейти к своему профилю, нажав на эту иконку. Когда Вы загрузите в профиль свою фотографию, она отобразится и здесь"
        topLabel.textAlignment = .right
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: image.bottomAnchor,
                                      constant: top).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                          constant: 20).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                           constant: -20).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupArrowImage() {
        let imageName = "FifthPageArrow.pdf"
        arrowImage.image = UIImage(named: imageName)
        view.addSubview(arrowImage)
        
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.leadingAnchor.constraint(equalTo: fifthPageButton.leadingAnchor).isActive = true
        arrowImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23).isActive = true
        arrowImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        arrowImage.bottomAnchor.constraint(equalTo: topLabel.topAnchor).isActive = true
    }
    
    private func setupDoneButton() {
        let bottom = 64.f
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        doneButton.titleLabel?.textAlignment = .center
        view.addSubview(doneButton)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                               constant: -bottom).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 148).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupHole() {
        let finalPath = UIBezierPath(rect: view.bounds)
        let radius = 25.f
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        let centerX = Session.width - 23
        let centerY = topPadding + 20
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: 0.0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
        finalPath.append(path)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalPath.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        view.layer.mask = maskLayer
        view.clipsToBounds = true
    }
    
    // MARK: - Buttons methods
    @objc private func closeButtonPressed() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func doneButtonPressed() {
        UserDefaults.standard.set(true, forKey: "onboardingMainScreenPassed")
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}

