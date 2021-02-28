//
//  FourthPageOnboardingMainScreen.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FourthPageOnboardingMainScreen: UIViewController {
    
    private let closeButton = UIButton()
    private let backButton = UIButton()
    private let firstPageButton = UIButton()
    private let secondPageButton = UIButton()
    private let thirdPageButton = UIButton()
    private let fourthPageButton = UIButton()
    private let fifthPageButton = UIButton()
    private let nextButton = UIButton()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    private let image = UIImageView()
    private let leftArrowImage = UIImageView()
    private let rightArrowImage = UIImageView()
    
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
        setupBottomLabel()
        setupLeftArrowImage()
        setupRightArrowImage()
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
        let size = 20.f
        fourthPageButton.layer.cornerRadius = 10
        fourthPageButton.backgroundColor = .hdButtonColor
        fourthPageButton.layer.borderWidth = 1
        fourthPageButton.layer.borderColor = UIColor.white.cgColor
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
        let imageName = "WomenLeftInCircle.pdf"
        guard let newImage = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = newImage.resizeImage(width, opaque: false)
        image.image = resizedImage
        view.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        image.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 50).isActive = true
        image.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        image.heightAnchor.constraint(equalToConstant: resizedImage.size.height).isActive = true
    }
    
    private func setupTopLabel() {
        let top = 10.f
        let height = 60.f
        topLabel.font = .systemFont(ofSize: 14, weight: .black)
        topLabel.numberOfLines = 0
        topLabel.textColor = .white
        topLabel.text = "Нажав на неё, Вы сможете найти своих знакомых из профессионального сообщества и быть с ними на связи"
        topLabel.textAlignment = .left
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
    
    private func setupBottomLabel() {
        let top = 80.f
        let height = 70.f
        bottomLabel.font = .systemFont(ofSize: 14, weight: .black)
        bottomLabel.numberOfLines = 0
        bottomLabel.textColor = .white
        bottomLabel.text = "Эта кнопка Настроек. На этом экране Вы сможете настроить сервис HelpDoctor на комфортный режим использования"
        bottomLabel.textAlignment = .right
        view.addSubview(bottomLabel)
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                         constant: top).isActive = true
        bottomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                              constant: -20).isActive = true
        bottomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                             constant: 50).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupLeftArrowImage() {
        let imageName = "FourthPageLeftArrow.pdf"
        leftArrowImage.image = UIImage(named: imageName)
        view.addSubview(leftArrowImage)
        
        leftArrowImage.translatesAutoresizingMaskIntoConstraints = false
        leftArrowImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        leftArrowImage.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: (Session.width / 5) * 3 + (Session.width / 10)).isActive = true
        leftArrowImage.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 0).isActive = true
        leftArrowImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                           constant: -30).isActive = true
    }
    
    private func setupRightArrowImage() {
        let imageName = "FourthPageRightArrow.pdf"
        rightArrowImage.image = UIImage(named: imageName)
        view.addSubview(rightArrowImage)
        
        rightArrowImage.translatesAutoresizingMaskIntoConstraints = false
        rightArrowImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: (Session.width / 5) * 4 + (Session.width / 10)).isActive = true
        rightArrowImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        rightArrowImage.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 1).isActive = true
        rightArrowImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                           constant: -50).isActive = true
    }
    
    private func setupHole() {
        let finalPath = UIBezierPath(rect: view.bounds)
        let window = UIApplication.shared.windows[0]
        let bottomPadding = window.safeAreaInsets.bottom
        let radius = 25.f
        
        let centerX1 = (Session.width / 10) + 3 * (Session.width / 5)
        let centerY = Session.height - bottomPadding - radius
        let path1 = UIBezierPath(arcCenter: CGPoint(x: centerX1, y: centerY), radius: radius, startAngle: 0.0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
        finalPath.append(path1)
        
        let centerX2 = (Session.width / 10) + 4 * (Session.width / 5)
        let path2 = UIBezierPath(arcCenter: CGPoint(x: centerX2, y: centerY), radius: radius, startAngle: 0.0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
        finalPath.append(path2)
        
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
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextButtonPressed() {
        let onboardingVC = FifthPageOnboardingMainScreen()
        navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
}
