//
//  MapItemTableViewCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 27.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import MapKit
import UIKit

class MapItemTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MapItemTableViewCell"
    
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupIconView()
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupIconView() {
        let iconImageName = "LocationMark"//"round_place_black_36pt"
        iconView.image = UIImage(named: iconImageName)
        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFontOfSize(size: 14)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - 30).isActive = true
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textAlignment = .left
        subtitleLabel.font = .systemFontOfSize(size: 12)
        subtitleLabel.textColor = .black
        contentView.addSubview(subtitleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - 30).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    func viewSetup(withMapItem mapItem: MKMapItem, tintColor: UIColor? = nil) {
        textLabel?.text = mapItem.name
        detailTextLabel?.text = mapItem.placemark.title
        imageView?.tintColor = tintColor
    }
    
}
