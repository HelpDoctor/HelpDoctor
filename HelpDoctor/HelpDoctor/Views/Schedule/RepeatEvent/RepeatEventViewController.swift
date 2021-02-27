//
//  RepeatEventViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class RepeatEventViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: RepeatEventPresenterProtocol?
    weak var delegate: RepeatEventControllerDelegate?
    
    // MARK: - Constants and variables
    private let heightTopLabel = 30.f
    private let heightButton = 20.f
    private let verticalInset = 206.f / 7.f
    private let leadingButton = 30.f
    private let leadingLabel = 20.f
    private var widthLabel = 0.f
    private let topLabel = UILabel()
    private let dayButton = RadioButton()
    private let dayLabel = UILabel()
    private let weekButton = RadioButton()
    private let weekLabel = UILabel()
    private let monthButton = RadioButton()
    private let monthLabel = UILabel()
    private let yearButton = RadioButton()
    private let yearLabel = UILabel()
    private let neverButton = RadioButton()
    private let neverLabel = UILabel()
    private let timeButton = RadioButton()
    private let timeLabel = UILabel()
    var replay: String?
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        widthLabel = Session.width - (leadingButton * 2) - heightButton - leadingLabel
        setupTopLabel()
        setupDayButton()
        setupDayLabel()
        setupWeekButton()
        setupWeekLabel()
        setupMonthButton()
        setupMonthLabel()
        setupYearButton()
        setupYearLabel()
        setupNeverButton()
        setupNeverLabel()
        setupTimeButton()
        setupTimeLabel()
        configureRadioButtons()
        switch replay {
        case "daily":
            dayButton.isSelected = true
        case "weekly":
            weekButton.isSelected = true
        case "monthly":
            monthButton.isSelected = true
        case "yearly":
            yearButton.isSelected = true
        case "date":
            timeButton.isSelected = true
        default:
            dayButton.isSelected = false
            weekButton.isSelected = false
            monthButton.isSelected = false
            yearButton.isSelected = false
            neverButton.isSelected = false
            timeButton.isSelected = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Setup views
    private func setupTopLabel() {
        topLabel.backgroundColor = .searchBarTintColor
        topLabel.font = .mediumSystemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "Повторять событие"
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 1
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    private func setupDayButton() {
        dayButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        dayButton.isSelected = false
        view.addSubview(dayButton)
        
        dayButton.translatesAutoresizingMaskIntoConstraints = false
        dayButton.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                       constant: verticalInset).isActive = true
        dayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: leadingButton).isActive = true
        dayButton.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        dayButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupDayLabel() {
        dayLabel.font = .mediumSystemFontOfSize(size: 14)
        dayLabel.textColor = .white
        dayLabel.text = "Каждый день"
        dayLabel.textAlignment = .left
        dayLabel.numberOfLines = 1
        view.addSubview(dayLabel)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.leadingAnchor.constraint(equalTo: dayButton.trailingAnchor,
                                          constant: leadingLabel).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: dayButton.centerYAnchor).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupWeekButton() {
        weekButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        weekButton.isSelected = false
        view.addSubview(weekButton)
        
        weekButton.translatesAutoresizingMaskIntoConstraints = false
        weekButton.topAnchor.constraint(equalTo: dayLabel.bottomAnchor,
                                       constant: verticalInset).isActive = true
        weekButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: leadingButton).isActive = true
        weekButton.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        weekButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupWeekLabel() {
        weekLabel.font = .mediumSystemFontOfSize(size: 14)
        weekLabel.textColor = .white
        weekLabel.text = "Каждую неделю"
        weekLabel.textAlignment = .left
        weekLabel.numberOfLines = 1
        view.addSubview(weekLabel)
        
        weekLabel.translatesAutoresizingMaskIntoConstraints = false
        weekLabel.leadingAnchor.constraint(equalTo: weekButton.trailingAnchor,
                                          constant: leadingLabel).isActive = true
        weekLabel.centerYAnchor.constraint(equalTo: weekButton.centerYAnchor).isActive = true
        weekLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        weekLabel.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupMonthButton() {
        monthButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        monthButton.isSelected = false
        view.addSubview(monthButton)
        
        monthButton.translatesAutoresizingMaskIntoConstraints = false
        monthButton.topAnchor.constraint(equalTo: weekLabel.bottomAnchor,
                                       constant: verticalInset).isActive = true
        monthButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: leadingButton).isActive = true
        monthButton.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        monthButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupMonthLabel() {
        monthLabel.font = .mediumSystemFontOfSize(size: 14)
        monthLabel.textColor = .white
        monthLabel.text = "Каждый месяц"
        monthLabel.textAlignment = .left
        monthLabel.numberOfLines = 1
        view.addSubview(monthLabel)
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.leadingAnchor.constraint(equalTo: monthButton.trailingAnchor,
                                          constant: leadingLabel).isActive = true
        monthLabel.centerYAnchor.constraint(equalTo: monthButton.centerYAnchor).isActive = true
        monthLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        monthLabel.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupYearButton() {
        yearButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        yearButton.isSelected = false
        view.addSubview(yearButton)
        
        yearButton.translatesAutoresizingMaskIntoConstraints = false
        yearButton.topAnchor.constraint(equalTo: monthLabel.bottomAnchor,
                                       constant: verticalInset).isActive = true
        yearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: leadingButton).isActive = true
        yearButton.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        yearButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupYearLabel() {
        yearLabel.font = .mediumSystemFontOfSize(size: 14)
        yearLabel.textColor = .white
        yearLabel.text = "Каждый год"
        yearLabel.textAlignment = .left
        yearLabel.numberOfLines = 1
        view.addSubview(yearLabel)
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.leadingAnchor.constraint(equalTo: yearButton.trailingAnchor,
                                          constant: leadingLabel).isActive = true
        yearLabel.centerYAnchor.constraint(equalTo: yearButton.centerYAnchor).isActive = true
        yearLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        yearLabel.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupNeverButton() {
        neverButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        neverButton.isSelected = false
        view.addSubview(neverButton)
        
        neverButton.translatesAutoresizingMaskIntoConstraints = false
        neverButton.topAnchor.constraint(equalTo: yearLabel.bottomAnchor,
                                       constant: verticalInset).isActive = true
        neverButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: leadingButton).isActive = true
        neverButton.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        neverButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupNeverLabel() {
        neverLabel.font = .mediumSystemFontOfSize(size: 14)
        neverLabel.textColor = .white
        neverLabel.text = "Никогда"
        neverLabel.textAlignment = .left
        neverLabel.numberOfLines = 1
        view.addSubview(neverLabel)
        
        neverLabel.translatesAutoresizingMaskIntoConstraints = false
        neverLabel.leadingAnchor.constraint(equalTo: neverButton.trailingAnchor,
                                          constant: leadingLabel).isActive = true
        neverLabel.centerYAnchor.constraint(equalTo: neverButton.centerYAnchor).isActive = true
        neverLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        neverLabel.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupTimeButton() {
        timeButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        timeButton.isSelected = false
        view.addSubview(timeButton)
        
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        timeButton.topAnchor.constraint(equalTo: neverLabel.bottomAnchor,
                                       constant: verticalInset).isActive = true
        timeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: leadingButton).isActive = true
        timeButton.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        timeButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupTimeLabel() {
        timeLabel.font = .mediumSystemFontOfSize(size: 14)
        timeLabel.textColor = .white
        timeLabel.text = "Указать точное время"
        timeLabel.textAlignment = .left
        timeLabel.numberOfLines = 1
        view.addSubview(timeLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leadingAnchor.constraint(equalTo: timeButton.trailingAnchor,
                                          constant: leadingLabel).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: timeButton.centerYAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func configureRadioButtons() {
        dayButton.alternateButton = [weekButton, monthButton, yearButton, neverButton, timeButton]
        weekButton.alternateButton = [dayButton, monthButton, yearButton, neverButton, timeButton]
        monthButton.alternateButton = [dayButton, weekButton, yearButton, neverButton, timeButton]
        yearButton.alternateButton = [dayButton, weekButton, monthButton, neverButton, timeButton]
        neverButton.alternateButton = [dayButton, weekButton, monthButton, yearButton, timeButton]
        timeButton.alternateButton = [dayButton, weekButton, monthButton, yearButton, neverButton]
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender {
        case dayButton:
            presenter?.buttonTapped(.day)
        case weekButton:
            presenter?.buttonTapped(.week)
        case monthButton:
            presenter?.buttonTapped(.month)
        case yearButton:
            presenter?.buttonTapped(.year)
        case neverButton:
            presenter?.buttonTapped(.never)
        case timeButton:
            presenter?.buttonTapped(.time)
        default:
            showAlert(message: "Error")
        }
    }
    
}
