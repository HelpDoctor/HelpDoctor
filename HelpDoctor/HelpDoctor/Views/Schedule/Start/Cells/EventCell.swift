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
    private let startTimeLabel = UILabel()
    private let endTimeLabel = UILabel()
    private let titleLabel = UILabel()
    private let linkView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
        setupStartTimeLabel()
        setupEndTimeLabel()
        setupTitleLabel()
        setupLinkView()
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
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        cellView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cellView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    private func setupStartTimeLabel() {
        startTimeLabel.numberOfLines = 1
        startTimeLabel.textAlignment = .left
        startTimeLabel.font = .boldSystemFontOfSize(size: 14)
        startTimeLabel.textColor = .black
        cellView.addSubview(startTimeLabel)
        
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        startTimeLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 7).isActive = true
        startTimeLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        startTimeLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
        startTimeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupEndTimeLabel() {
        endTimeLabel.numberOfLines = 1
        endTimeLabel.textAlignment = .left
        endTimeLabel.font = .boldSystemFontOfSize(size: 14)
        endTimeLabel.textColor = .black
        cellView.addSubview(endTimeLabel)
        
        endTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        endTimeLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -6).isActive = true
        endTimeLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        endTimeLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
        endTimeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFontOfSize(size: 14)
        titleLabel.textColor = .black
        cellView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 61).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -30).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: cellView.heightAnchor).isActive = true
    }
    
    private func setupLinkView() {
        cellView.addSubview(linkView)
        
        linkView.translatesAutoresizingMaskIntoConstraints = false
        linkView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        linkView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        linkView.heightAnchor.constraint(equalTo: cellView.heightAnchor).isActive = true
    }
    
    func configure(startTime: String, endTime: String, event: String, eventColor: UIColor, isMajor: Bool) {
        if isMajor {
            cellView.backgroundColor = .majorEventColor
            startTimeLabel.textColor = .white
            endTimeLabel.textColor = .white
            titleLabel.textColor = .white
            let attributedString = NSMutableAttributedString(string: event)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                          value: paragraphStyle,
                                          range: NSMakeRange(0, attributedString.length))
            titleLabel.attributedText = attributedString
            
            startTimeLabel.text = startTime
            endTimeLabel.text = endTime
            linkView.backgroundColor = .majorEventColor
        } else {
            let attributedString = NSMutableAttributedString(string: event)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                          value: paragraphStyle,
                                          range: NSMakeRange(0, attributedString.length))
            titleLabel.attributedText = attributedString
            
            startTimeLabel.text = startTime
            endTimeLabel.text = endTime
            linkView.backgroundColor = eventColor
        }
    }
    
}
