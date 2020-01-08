//
//  MedicalOrganizationSearchTextField.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol MedicalOrganizationSearchProtocol {
    func getRegionId() -> Int?
    func setMedicalOrganization(medicalOrganization: MedicalOrganization)
    func setAddMedicalOrganization(medicalOrganization: MedicalOrganization)
}

class MedicalOrganizationSearchTextField: UITextField {
    
    var dataList: [MedicalOrganization]?
    var resultsList: [MedicalOrganization]?
    var tableView: UITableView?
    var presenter: MedicalOrganizationSearchProtocol?
    var mainWork: Bool = true
    
    func getCountMedicalOrganizations() -> Int? {
        return dataList?.count
    }
    
    func getMedicalOrganizationTitle(index: Int) -> String? {
        return dataList?[index].nameShort
    }
    
    func getMedicalOrganization(regionId: Int, mainWork: Bool) {
        let getMedicalOrganization = Profile()
        self.mainWork = mainWork
        
        getData(typeOfContent: .getMedicalOrganization,
                returning: ([MedicalOrganization], Int?, String?).self,
                requestParams: ["region": "\(regionId)"])
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getMedicalOrganization.medicalOrganization = result?.0
            getMedicalOrganization.responce = (result?.1, result?.2)
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    self?.dataList = getMedicalOrganization.medicalOrganization
                }
            }
        }
    }
    
    // Connecting the new element to the parent view
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView?.removeFromSuperview()
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        self.addTarget(self, action: #selector(MedicalOrganizationSearchTextField.textFieldDidChange),
                       for: .editingChanged)
        self.addTarget(self, action: #selector(MedicalOrganizationSearchTextField.textFieldDidBeginEditing),
                       for: .editingDidBegin)
        self.addTarget(self, action: #selector(MedicalOrganizationSearchTextField.textFieldDidEndEditing),
                       for: .editingDidEnd)
        self.addTarget(self, action: #selector(MedicalOrganizationSearchTextField.textFieldDidEndEditingOnExit),
                       for: .editingDidEndOnExit)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        buildSearchTableView()
        if mainWork {
            self.placeholder = "Основное место работы*"
        } else {
            self.placeholder = "Доп. место работы"
        }
        self.textAlignment = .left
        self.backgroundColor = .white
        self.leftView = UIView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: 8,
                                             height: self.frame.height))
        self.leftViewMode = .always
    }
    
    // MARK: - Text Field related methods
    @objc open func textFieldDidChange() {
        print("Text changed ...")
        filter()
        updateSearchTableView()
        tableView?.isHidden = false
    }
    
    @objc open func textFieldDidBeginEditing() {
        guard let regionId = presenter?.getRegionId() else { return }
        getMedicalOrganization(regionId: regionId, mainWork: mainWork)
        print("Begin Editing")
    }
    
    @objc open func textFieldDidEndEditing() {
        print("End editing")
    }
    
    @objc open func textFieldDidEndEditingOnExit() {
        print("End on Exit")
    }
    
    // MARK: - Data Handling methods
    
    
    // MARK: - Filtering methods
    fileprivate func filter() {
        guard let dataList = dataList,
            let text = self.text else { return }
        resultsList = []
        resultsList = dataList.filter { (medicalOrganization: MedicalOrganization) -> Bool in
            guard let name = medicalOrganization.nameShort else { return false }
            return name.lowercased().contains(text.lowercased())
        }
        
        tableView?.reloadData()
    }
    
}

extension MedicalOrganizationSearchTextField: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table View related methods
    // MARK: - TableView creation and updating
    // Create SearchTableview
    func buildSearchTableView() {
        
        if let tableView = tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MOSearchTextFieldCell")
            tableView.delegate = self
            tableView.dataSource = self
            self.window?.addSubview(tableView)
        } else {
            print("tableView created")
            tableView = UITableView(frame: CGRect.zero)
        }
        
        updateSearchTableView()
    }
    
    // Updating SearchtableView
    func updateSearchTableView() {
        
        if let tableView = tableView {
            superview?.bringSubviewToFront(tableView)
            var tableHeight: CGFloat = 0
            tableHeight = tableView.contentSize.height
            
            // Set a bottom margin of 10p
            if tableHeight < tableView.contentSize.height {
                tableHeight -= 10
            }
            
            // Set tableView frame
            var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
            tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
            tableViewFrame.origin.x += 2
            tableViewFrame.origin.y += frame.size.height + 2
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.tableView?.frame = tableViewFrame
            })
            
            //Setting tableView style
            tableView.layer.masksToBounds = true
            tableView.separatorInset = UIEdgeInsets.zero
            tableView.layer.cornerRadius = 5.0
            tableView.separatorColor = UIColor.lightGray
            tableView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
            
            if self.isFirstResponder {
                superview?.bringSubviewToFront(self)
            }
            
            tableView.reloadData()
        }
    }
    
    // MARK: - TableViewDataSource methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList?.count ?? 0
    }
    
    // MARK: - TableViewDelegate methods
    //Adding rows in the tableview with the data from dataList
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MOSearchTextFieldCell",
                                                 for: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = resultsList?[indexPath.row].nameShort
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row")
        self.text = resultsList?[indexPath.row].nameShort
        tableView.isHidden = true
        self.endEditing(true)
        guard let medicalOrganization = resultsList?[indexPath.row] else { return }
        if mainWork {
            presenter?.setMedicalOrganization(medicalOrganization: medicalOrganization)
        } else {
            presenter?.setAddMedicalOrganization(medicalOrganization: medicalOrganization)
        }
    }
    
}
