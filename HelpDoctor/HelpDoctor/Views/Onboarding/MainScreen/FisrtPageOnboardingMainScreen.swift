//
//  FirstPage.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 27.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FirstPageOnboardingMainScreen: UIViewController {
    
    private let closeButton = UIButton()
    private let firstPageButton = UIButton()
    private let secondPageButton = UIButton()
    private let thirdPageButton = UIButton()
    private let fourthPageButton = UIButton()
    private let fifthPageButton = UIButton()
    private let nextButton = UIButton()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    private let leftImage = UIImageView()
    private let rightImage = UIImageView()
    private var heightImage = 0.f
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        setupCloseButton()
        setupThirdPageButton()
        setupSecondPageButton()
        setupFirstPageButton()
        setupFourthPageButton()
        setupFifthPageButton()
        setupNextButton()
        setupTopLabel()
        setupBottomLabel()
        setupLeftImage()
        setupRightImage()
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
        let size = 20.f
        firstPageButton.layer.cornerRadius = 10
        firstPageButton.backgroundColor = .hdButtonColor
        firstPageButton.layer.borderWidth = 1
        firstPageButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(firstPageButton)
        
        firstPageButton.translatesAutoresizingMaskIntoConstraints = false
        firstPageButton.trailingAnchor.constraint(equalTo: secondPageButton.leadingAnchor, constant: -12).isActive = true
        firstPageButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        firstPageButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        firstPageButton.heightAnchor.constraint(equalToConstant: size).isActive = true
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
    
    private func setupTopLabel() {
        let top = 70.f
        let leading = 25.f
        let height = 40.f
        topLabel.font = .systemFont(ofSize: 14, weight: .black)
        topLabel.numberOfLines = 0
        topLabel.textColor = .white
        topLabel.text = "Спасибо, что решили воспользоваться приложением HelpDoctor!"
        topLabel.textAlignment = .center
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor,
                                       constant: top).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupBottomLabel() {
        let top = 20.f
        let leading = 25.f
        let height = 55.f
        bottomLabel.font = .systemFont(ofSize: 14, weight: .black)
        bottomLabel.numberOfLines = 0
        bottomLabel.textColor = .white
        bottomLabel.text = "Цель приложения - помочь медработникам в организации рабочего процесса "
        bottomLabel.textAlignment = .center
        view.addSubview(bottomLabel)
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                       constant: top).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomLabel.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    private func setupLeftImage() {
        let width = 0.3 * Session.width
        let imageName = "WomenLeft.pdf"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImage(width, opaque: false)
        leftImage.image = resizedImage
        heightImage = resizedImage.size.height
        view.addSubview(leftImage)
        
        leftImage.translatesAutoresizingMaskIntoConstraints = false
        leftImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        leftImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48).isActive = true
        leftImage.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        leftImage.heightAnchor.constraint(equalToConstant: heightImage).isActive = true
    }
    
    private func setupRightImage() {
        let imageName = "MenRight.pdf"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImageHeight(heightImage, opaque: false)
        rightImage.image = resizedImage
        view.addSubview(rightImage)
        
        rightImage.translatesAutoresizingMaskIntoConstraints = false
        rightImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        rightImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48).isActive = true
        rightImage.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        rightImage.heightAnchor.constraint(equalToConstant: heightImage).isActive = true
    }
    
    // MARK: - Buttons methods
    @objc private func closeButtonPressed() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func nextButtonPressed() {
        let onboardingVC = SecondPageOnboardingMainScreen()
        navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
}
