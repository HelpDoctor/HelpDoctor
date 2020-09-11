//
//  CitiesSearchTextField.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//
/*
import UIKit

protocol CitiesSearchProtocol {
    func getRegionId() -> Int?
    func setCity(city: Cities)
}

class CitiesSearchTextField: UITextField {
    
    var dataList: [Cities]?
    var resultsList: [Cities]?
    var tableView: UITableView?
    var presenter: CitiesSearchProtocol?
    
    func getCountCities() -> Int? {
        return dataList?.count
    }
    
    func getCityTitle(index: Int) -> String? {
        return dataList?[index].cityName
    }
    
    func getCities(regionId: Int) {
        let getCities = Profile()
        
        getData(typeOfContent: .getListCities,
                returning: ([Cities], Int?, String?).self,
                requestParams: ["region": "\(regionId)"]) { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getCities.cities = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    self?.dataList = getCities.cities
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
        
        self.addTarget(self, action: #selector(CitiesSearchTextField.textFieldDidChange),
                       for: .editingChanged)
        self.addTarget(self, action: #selector(CitiesSearchTextField.textFieldDidBeginEditing),
                       for: .editingDidBegin)
        self.addTarget(self, action: #selector(CitiesSearchTextField.textFieldDidEndEditing),
                       for: .editingDidEnd)
        self.addTarget(self, action: #selector(CitiesSearchTextField.textFieldDidEndEditingOnExit),
                       for: .editingDidEndOnExit)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        buildSearchTableView()
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
        getCities(regionId: regionId)
        print("Begin Editing")
    }
    
    @objc open func textFieldDidEndEditing() {
        print("End editing")
        tableView?.isHidden = true
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
        resultsList = dataList.filter { (city: Cities) -> Bool in
            guard let cityName = city.cityName else { return false }
            return cityName.lowercased().contains(text.lowercased())
        }
        
        tableView?.reloadData()
    }
    
}

extension CitiesSearchTextField: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table View related methods
    // MARK: - TableView creation and updating
    // Create SearchTableview
    func buildSearchTableView() {
        
        if let tableView = tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CitiesSearchTextFieldCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitiesSearchTextFieldCell",
                                                 for: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = resultsList?[indexPath.row].cityName
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row")
        self.text = resultsList?[indexPath.row].cityName
        tableView.isHidden = true
        self.endEditing(true)
        guard let city = resultsList?[indexPath.row] else { return }
        presenter?.setCity(city: city)
    }
        
}
*/
