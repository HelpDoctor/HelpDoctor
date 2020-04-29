//
//  InterestCollectionViewCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 10.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "InterestCell"
    
    private let cellView = UIView()
    private let cellLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLabel()
        backgroundColor = .hdButtonColor
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLabel() {
        cellLabel.numberOfLines = 2
        cellLabel.textAlignment = .center
        cellLabel.font = .systemFontOfSize(size: 12)
        cellLabel.textColor = .white
        contentView.addSubview(cellLabel)
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
    }
    
    func configure(_ interest: String) {
        cellLabel.text = interest
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.hdGreenColor : UIColor.hdButtonColor
        }
    }
    
}
