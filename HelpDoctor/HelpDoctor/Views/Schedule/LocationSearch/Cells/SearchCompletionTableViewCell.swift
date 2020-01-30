//
//  SearchCompletionTableViewCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 27.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import MapKit
import UIKit

class SearchCompletionTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SearchCompletionTableViewCell"
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFontOfSize(size: 14)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - 32).isActive = true
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textAlignment = .left
        subtitleLabel.font = .systemFontOfSize(size: 12)
        subtitleLabel.textColor = .black
        contentView.addSubview(subtitleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - 32).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    func viewSetup(withSearchCompletion searchCompletion: MKLocalSearchCompletion) {
        let attributedString = NSMutableAttributedString(string: searchCompletion.title)
        for highlightRange in searchCompletion.titleHighlightRanges {
            attributedString.addAttribute(
                NSAttributedString.Key.font,
                value: UIFont.boldSystemFont(ofSize: textLabel?.font.pointSize ?? 14),
                range: highlightRange.rangeValue)
        }
        titleLabel.attributedText = attributedString
        
        let attributedStringDetail = NSMutableAttributedString(string: searchCompletion.subtitle)
        for highlightRange in searchCompletion.subtitleHighlightRanges {
            attributedStringDetail.addAttribute(
                NSAttributedString.Key.font,
                value: UIFont.boldSystemFont(ofSize: detailTextLabel?.font.pointSize ?? 13),
                range: highlightRange.rangeValue)
        }
        subtitleLabel.attributedText = attributedStringDetail
    }
    
}
