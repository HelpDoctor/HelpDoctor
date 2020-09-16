//
//  ProfileInterestsView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ProfileInterestsView: UIView {
    private let interestsLabel = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var interestsArray: [ProfileInterest]?
    private let leading = 20.f
    private let heightLabel = 15.f
    private let verticalSpacing = 5.f
    private var size = 18.f
    
    convenience init(interests: [ProfileInterest]) {
        self.init()
        self.interestsArray = interests
        backgroundColor = .white
        setupJobLabel()
        setupCollectionView()
    }
    
    private func setupJobLabel() {
        interestsLabel.font = .boldSystemFontOfSize(size: 14)
        interestsLabel.numberOfLines = 1
        interestsLabel.text = "Область научных интересов"
        interestsLabel.textColor = .black
        self.addSubview(interestsLabel)
        
        interestsLabel.translatesAutoresizingMaskIntoConstraints = false
        interestsLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        interestsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: leading).isActive = true
        interestsLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: 16).isActive = true
        interestsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -leading).isActive = true
    }
    
    private func setupCollectionView() {
        let top = 10.f
        self.addSubview(collectionView)
        collectionView.register(InterestCollectionViewCell.self, forCellWithReuseIdentifier: "InterestCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: interestsLabel.bottomAnchor,
                                            constant: top).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leading - 8).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(leading - 8)).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -top).isActive = true
    }
    
}

// MARK: - Collection view
extension ProfileInterestsView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        presenter?.addInterest(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //        presenter?.deleteInterest(index: indexPath.item)
    }
    
}

extension ProfileInterestsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestsArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell",
                                                            for: indexPath) as? InterestCollectionViewCell else {
                                                                return UICollectionViewCell()
        }
        size = 18
        cell.delegate = self
        cell.configure(interestsArray?[indexPath.item].interest?.name ?? "", icon: "Search")
        return cell
    }
    
}

extension ProfileInterestsView: InterestCollectionViewCellDelegate {
    
    func fontSize(interest: String) -> CGFloat {
        let width = ((collectionView.bounds.size.width - 32) / 3) - 26
        /*
         32 - 8 и 8 отступы collectionView от краев, 8 и 8 расстояние между ячейками
         3 - количество ячеек в строке
         26 - отступы текста от кграниц ячейки (4 слева, 22 справа)
         */
        let height = 42.f
        
        let font = UIFont.systemFontOfSize(size: size)
        if interest.width(withConstrainedHeight: height, font: font, minimumTextWrapWidth: 10) > width {
            size -= 1
            return fontSize(interest: interest)
        } else {
            return size
        }
    }
    
}

extension ProfileInterestsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.size.width - 32) / 3, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
}
