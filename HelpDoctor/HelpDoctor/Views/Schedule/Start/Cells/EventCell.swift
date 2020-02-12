//
//  EventCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    static let reuseIdentifier = "EventCell"
    
    private let cellView = UIView()
    private let leadingLabel = UILabel()
    private let flagImage = UIImageView()
    private let trailingLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
        setupLeadingLabel()
        setupFlagImage()
        setupTrailingLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellView() {
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 5
        cellView.clipsToBounds = true
        contentView.addSubview(cellView)
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1).isActive = true
        cellView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cellView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    private func setupLeadingLabel() {
        leadingLabel.numberOfLines = 1
        leadingLabel.textAlignment = .left
        leadingLabel.font = .systemFontOfSize(size: 12)
        leadingLabel.textColor = .black
        cellView.addSubview(leadingLabel)
        
        leadingLabel.translatesAutoresizingMaskIntoConstraints = false
        leadingLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5).isActive = true
        leadingLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5).isActive = true
        leadingLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 14).isActive = true
        leadingLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    private func setupFlagImage() {
        let imageName = "Flag Icon.pdf"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        flagImage.image = image
        cellView.addSubview(flagImage)
        
        flagImage.translatesAutoresizingMaskIntoConstraints = false
        flagImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        flagImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
        flagImage.leadingAnchor.constraint(equalTo: leadingLabel.trailingAnchor, constant: 2).isActive = true
        flagImage.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    private func setupTrailingLabel() {
        trailingLabel.numberOfLines = 1
        trailingLabel.textAlignment = .right
        trailingLabel.font = .boldSystemFontOfSize(size: 12)
        trailingLabel.textColor = .hdLinkColor
        cellView.addSubview(trailingLabel)
        
        trailingLabel.translatesAutoresizingMaskIntoConstraints = false
        trailingLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5).isActive = true
        trailingLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5).isActive = true
        trailingLabel.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 2).isActive = true
        trailingLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -14).isActive = true
    }
    
    func configure(timeEvent: String, flag: Bool, event: String) {
        leadingLabel.text = timeEvent
        flagImage.isHidden = !flag
        trailingLabel.text = event
    }
    
}
