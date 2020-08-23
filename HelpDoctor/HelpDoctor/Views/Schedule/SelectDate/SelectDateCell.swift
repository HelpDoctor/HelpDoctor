//
//  SelectDateCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 22.08.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SelectDateCell: UITableViewCell {
    
    static let reuseIdentifier = "SelectDateCell"
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupDateLabel()
        layer.cornerRadius = 5
        layer.borderColor = UIColor.hdButtonColor.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDateLabel() {
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFontOfSize(size: 12)
        contentView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    func configure(_ date: Date?) {
        guard let date = date else { return }
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        
        dateLabel.text = "\(getWeekday(weekday)), \(day) \(getMonth(month))"
        
        if weekday == 1 || weekday == 7 {
            dateLabel.textColor = .holidayColor
        } else {
            dateLabel.textColor = .textFieldTextColor
        }
    }
    
    func configure(title: Int?) {
        guard let title = title else { return }
        dateLabel.font = .systemFontOfSize(size: 14)
        dateLabel.text = "\(title)"
    }
    
    func configure(minutes: String?) {
        guard let title = minutes else { return }
        dateLabel.font = .systemFontOfSize(size: 14)
        dateLabel.text = title
    }
    
    private func getWeekday(_ weekday: Int) -> String {
        switch weekday {
        case 1:
            return "Вс"
        case 2:
            return "Пн"
        case 3:
            return "Вт"
        case 4:
            return "Ср"
        case 5:
            return "Чт"
        case 6:
            return "Пт"
        case 7:
            return "Сб"
        default:
            return ""
        }
    }
    
    private func getMonth(_ month: Int) -> String {
        switch month {
        case 1:
            return "янв."
        case 2:
            return "фев."
        case 3:
            return "мар."
        case 4:
            return "апр."
        case 5:
            return "май"
        case 6:
            return "июн."
        case 7:
            return "июл."
        case 8:
            return "авг."
        case 9:
            return "сен."
        case 10:
            return "окт."
        case 11:
            return "ноя."
        case 12:
            return "дек."
        default:
            return ""
        }
    }
    
    override var isSelected: Bool {
        didSet {
            layer.borderWidth = isSelected ? 2 : 0
        }
    }

}
