//
//  CustomSearchTextField.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class RegionsSearchTextField: UITextField {
    
    var dataList: [Regions]?
    var resultsList: [Regions]?
    var tableView: UITableView?
    var presenter: CreateProfileWorkPresenterProtocol?
    
    func getCountRegions() -> Int? {
        return dataList?.count
    }
    
    func getRegionTitle(index: Int) -> String? {
        return dataList?[index].regionName
    }
    
    func getRegions() {
        let getRegions = Profile()
        
        getData(typeOfContent: .getRegions,
                returning: ([Regions], Int?, String?).self,
                requestParams: [:] )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getRegions.regions = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    self?.dataList = getRegions.regions
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
        
        self.addTarget(self, action: #selector(RegionsSearchTextField.textFieldDidChange),
                       for: .editingChanged)
        self.addTarget(self, action: #selector(RegionsSearchTextField.textFieldDidBeginEditing),
                       for: .editingDidBegin)
        self.addTarget(self, action: #selector(RegionsSearchTextField.textFieldDidEndEditing),
                       for: .editingDidEnd)
        self.addTarget(self, action: #selector(RegionsSearchTextField.textFieldDidEndEditingOnExit),
                       for: .editingDidEndOnExit)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        buildSearchTableView()
        self.font = UIFont.systemFontOfSize(size: 14)
        self.textColor = .textFieldTextColor
        self.textAlignment = .left
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
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
        resultsList = dataList.filter { (region: Regions) -> Bool in
            guard let regionName = region.regionName else { return false }
            return regionName.lowercased().contains(text.lowercased())
        }
        
        tableView?.reloadData()
    }
    
}

extension RegionsSearchTextField: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table View related methods
    
    
    // MARK: - TableView creation and updating
    
    // Create SearchTableview
    func buildSearchTableView() {
        
        if let tableView = tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RegionsSearchTextFieldCell")
            tableView.delegate = self
            tableView.dataSource = self
            self.window?.addSubview(tableView)
        } else {
            getRegions()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionsSearchTextFieldCell",
                                                 for: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = resultsList?[indexPath.row].regionName
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row")
        self.text = resultsList?[indexPath.row].regionName
        tableView.isHidden = true
        self.endEditing(true)
        guard let region = resultsList?[indexPath.row] else { return }
        presenter?.setRegion(region: region)
    }
        
}
