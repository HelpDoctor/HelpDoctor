//
//  DayCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 20.08.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import JTAppleCalendar
import UIKit

class DayCell: JTACDayCell {
    
    static let reuseIdentifier = "DayCell"
    let dayOfWeekLabel = UILabel()
    let dateLabel = UILabel()
    let selectedView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelectedView()
        setupDayOfWeekLabel()
        setupDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSelectedView() {
        selectedView.isHidden = true
        selectedView.layer.cornerRadius = 11.5
        selectedView.clipsToBounds = true
        selectedView.backgroundColor = .hdButtonColor
        contentView.addSubview(selectedView)
        
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        selectedView.heightAnchor.constraint(equalToConstant: 23).isActive = true
        selectedView.widthAnchor.constraint(equalToConstant: 23).isActive = true
        selectedView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        selectedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1).isActive = true
    }
    
    private func setupDayOfWeekLabel() {
        dayOfWeekLabel.numberOfLines = 1
        dayOfWeekLabel.textAlignment = .center
        dayOfWeekLabel.font = .boldSystemFontOfSize(size: 14)
        dayOfWeekLabel.textColor = .black
        contentView.addSubview(dayOfWeekLabel)
        
        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        dayOfWeekLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dayOfWeekLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        dayOfWeekLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        dayOfWeekLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        dayOfWeekLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    private func setupDateLabel() {
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .center
        dateLabel.font = .boldSystemFontOfSize(size: 14)
        dateLabel.textColor = .black
        contentView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
}
