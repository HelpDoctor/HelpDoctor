//
//  ChatCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 12.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    static let reuseIdentifier = "ChatCell"
    
    private let photo = UIImageView()
    private let nameLabel = UILabel()
    private let messageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPhotoView()
        setupNameLabel()
        setupMessageLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhotoView() {
        let size = 45.f
        photo.clipsToBounds = true
        photo.layer.cornerRadius = size / 2
        contentView.addSubview(photo)
        
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        photo.widthAnchor.constraint(equalToConstant: size).isActive = true
        photo.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupNameLabel() {
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 12, weight: .medium)
        nameLabel.textColor = UIColor(red: 54 / 255, green: 103 / 255, blue: 150 / 255, alpha: 1)
        contentView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupMessageLabel() {
        messageLabel.numberOfLines = 1
        messageLabel.textAlignment = .left
        messageLabel.font = .systemFont(ofSize: 12, weight: .regular)
        messageLabel.textColor = .black
        contentView.addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 15).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    func configure(_ date: String) {
        photo.image = Session.instance.user?.foto?.toImage()
        nameLabel.text = date
        messageLabel.text = "Здравствуйте. Интересует ваше ..."
    }
    
}
