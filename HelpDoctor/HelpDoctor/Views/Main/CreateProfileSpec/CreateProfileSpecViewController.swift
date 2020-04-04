//
//  CreateProfileSpecViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 01.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class CreateProfileSpecViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: CreateProfileSpecPresenterProtocol?
    
    // MARK: - Constants
    private let backgroundColor = UIColor.backgroundColor
    private let headerHeight = 60.f
    private let scrollView = UIScrollView()
    private let step8TitleLabel = UILabel()
    private let step8Label = UILabel()
    private let subscriptLabel = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let addButton = UIButton()
    private let nextButton = HDButton(title: "Далее")
    private let contentWidth = Session.width - 40
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        presenter?.loadPopularInterests()
        setupScrollView()
        setupHeaderView(color: backgroundColor, height: headerHeight, presenter: presenter)
        setupStep8TitleLabel()
        setupStep8Label()
        setupSubscriptLabel()
        setupCollectionView()
        setupAddButton()
        setupNextButton()
        addSwipeGestureToBack()
        presenter?.getInterestFromView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .clear)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Public methods
    /// Обновление отображения коллекции
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    // MARK: - Setup views
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: Session.height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: headerHeight).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
    }
    
    private func setupStep8TitleLabel() {
        let height = 20.f
        step8TitleLabel.backgroundColor = .searchBarTintColor
        step8TitleLabel.font = .boldSystemFontOfSize(size: 14)
        step8TitleLabel.textColor = .white
        step8TitleLabel.text = "Шаг 8"
        step8TitleLabel.textAlignment = .center
        scrollView.addSubview(step8TitleLabel)
        
        step8TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step8TitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        step8TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step8TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step8TitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupStep8Label() {
        let text =
        """
        Сообщите коллегам о своих научных интересах\n
        Ниже представлены интересы, часто выбираемые в Вашей специализации\n
        """
        let top = 6.f
        let height = text.height(withConstrainedWidth: contentWidth, font: .systemFontOfSize(size: 14))
        step8Label.numberOfLines = 0
        step8Label.font = .systemFontOfSize(size: 14)
        step8Label.textColor = .white
        step8Label.text = text
        step8Label.textAlignment = .left
        scrollView.addSubview(step8Label)
        
        step8Label.translatesAutoresizingMaskIntoConstraints = false
        step8Label.topAnchor.constraint(equalTo: step8TitleLabel.bottomAnchor,
                                        constant: top).isActive = true
        step8Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step8Label.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        step8Label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupSubscriptLabel() {
        let text =
        """
        (Чтобы выбрать нужный интерес, нажмите на него)
        """
        let height = text.height(withConstrainedWidth: contentWidth, font: .italicSystemFontOfSize(size: 14))
        subscriptLabel.numberOfLines = 0
        subscriptLabel.font = .italicSystemFontOfSize(size: 14)
        subscriptLabel.textColor = .white
        subscriptLabel.text = text
        subscriptLabel.textAlignment = .left
        scrollView.addSubview(subscriptLabel)
        
        subscriptLabel.translatesAutoresizingMaskIntoConstraints = false
        subscriptLabel.topAnchor.constraint(equalTo: step8Label.bottomAnchor).isActive = true
        subscriptLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        subscriptLabel.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        subscriptLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupCollectionView() {
        let top = 10.f
        let height = 111.f
        let customSuperLayout = InterestCollectionViewLayout()
        customSuperLayout.delegate = self
        collectionView.setCollectionViewLayout(customSuperLayout, animated: true)
        view.addSubview(collectionView)
        collectionView.register(InterestCollectionViewCell.self, forCellWithReuseIdentifier: "InterestCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: subscriptLabel.bottomAnchor,
                                            constant: top).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupAddButton() {
        let width = 92.f
        let height = 29.f
        let top = 17.f
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        addButton.backgroundColor = UIColor(red: 0.4, green: 0.063, blue: 0.949, alpha: 1)
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitle("Добавить интересы", for: .normal)
        addButton.titleLabel?.font = .systemFontOfSize(size: 10)
        addButton.titleLabel?.numberOfLines = 2
        addButton.layer.cornerRadius = height / 2
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.clipsToBounds = true
        scrollView.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor,
                                       constant: top).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Установка кнопки перехода к следующему экрану
    private func setupNextButton() {
        let width = 90.f
        let height = 30.f
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nextButton.update(isEnabled: true)
        scrollView.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Session.width - 10).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: Session.height - Session.bottomPadding - 98).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    // MARK: - IBActions
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: - Buttons methods
    @objc private func nextButtonPressed() {
        presenter?.next()
    }
    
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
    @objc private func addButtonPressed() {
        presenter?.toAddInterest()
    }
    
    // MARK: - Navigation
    
}

// MARK: - Collection view
extension CreateProfileSpecViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.addInterest(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        presenter?.deleteInterest(index: indexPath.item)
    }
    
}

extension CreateProfileSpecViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getInterestsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell",
                                                      for: indexPath) as! InterestCollectionViewCell
        cell.configure(presenter?.getInterestTitle(index: indexPath.row) ?? "")
        return cell
    }
    
}

extension CreateProfileSpecViewController: InterestCollectionViewLayoutDelegate {
    
    func width(forItemAt indexPath: IndexPath) -> CGFloat {
        let font = UIFont.systemFontOfSize(size: 12)
        var constraintRect = CGSize(width: contentWidth / 3, height: 29)
        let data = " \(presenter?.getInterestTitle(index: indexPath.row) ?? " ") "
        let newWidth = data.width(withConstrainedHeight: 29, font: font, minimumTextWrapWidth: 30)
        if newWidth > constraintRect.width {
            constraintRect = CGSize(width: contentWidth / 2, height: 29)
        }
        let box = data.boundingRect(with: constraintRect,
                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                    attributes: [NSAttributedString.Key.font: font],
                                    context: nil)
        return box.width
    }
    
}
