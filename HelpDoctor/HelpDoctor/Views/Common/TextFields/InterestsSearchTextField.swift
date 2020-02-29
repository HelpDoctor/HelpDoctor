//
//  InterestsSearchTextField.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol InterestsSearchProtocol {
    func getSpecs() -> (String?, String?)
    func setInterests(interests: [ListOfInterests])
    func addInterest(interest: ListOfInterests)
//    func createInterest()
}

class InterestsSearchTextField: UITextField {
    
    private var dataList: [ListOfInterests]?
    private var resultsList: [ListOfInterests]?
    private var tableView: UITableView?
    var presenter: InterestsSearchProtocol?
    
    private func getCountInterests() -> Int? {
        return dataList?.count
    }
    
    private func getInterestTitle(index: Int) -> String? {
        return dataList?[index].name
    }
    
    private func getInterestsOneSpec(mainSpec: String) {
        let getListOfInterest = Profile()
        
        getData(typeOfContent: .getListOfInterestsExtOne,
                returning: ([String: [ListOfInterests]], Int?, String?).self,
                requestParams: ["spec_code": "\(mainSpec)"]) { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getListOfInterest.listOfInterests = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    let generalSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["general"]
                    let interestMainSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(mainSpec)"]
                    self?.dataList = (interestMainSpec ?? []) + (generalSpec ?? [])
                }
            }
        }
    }
    
    private func getInterestsTwoSpec(mainSpec: String, addSpec: String) {
        let getListOfInterest = Profile()
        
        getData(typeOfContent: .getListOfInterestsExtTwo,
                returning: ([String: [ListOfInterests]], Int?, String?).self,
                requestParams: ["spec_code": "\(mainSpec)/\(addSpec)"]) { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getListOfInterest.listOfInterests = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    let generalSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["general"]
                    let interestMainSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(mainSpec)"]
                    let interestAddSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(addSpec)"]
                    self?.dataList = (interestMainSpec ?? []) + (interestAddSpec ?? []) + (generalSpec ?? [])
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
        
        self.addTarget(self, action: #selector(InterestsSearchTextField.textFieldDidChange),
                       for: .editingChanged)
        self.addTarget(self, action: #selector(InterestsSearchTextField.textFieldDidBeginEditing),
                       for: .editingDidBegin)
        self.addTarget(self, action: #selector(InterestsSearchTextField.textFieldDidEndEditing),
                       for: .editingDidEnd)
        self.addTarget(self, action: #selector(InterestsSearchTextField.textFieldDidEndEditingOnExit),
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
//        print("Text changed ...")
        filter()
        updateSearchTableView()
        tableView?.isHidden = false
    }
    
    @objc open func textFieldDidBeginEditing() {
        let mainSpec = presenter?.getSpecs().0 ?? "general"
        let addSpec = presenter?.getSpecs().1
        if addSpec == nil {
            getInterestsOneSpec(mainSpec: mainSpec)
        } else {
            getInterestsTwoSpec(mainSpec: mainSpec, addSpec: addSpec ?? "040100")
        }
        
//        print("Begin Editing")
        tableView?.isHidden = false
    }
    
    @objc open func textFieldDidEndEditing() {
        tableView?.isHidden = true
//        print("End editing")
    }
    
    @objc open func textFieldDidEndEditingOnExit() {
//        print("End on Exit")
    }
    
    // MARK: - Filtering methods
    fileprivate func filter() {
        guard let dataList = dataList,
            let text = self.text else { return }
        resultsList = []
        resultsList = dataList.filter { (interests: ListOfInterests) -> Bool in
            guard let name = interests.name else { return false }
            return name.lowercased().contains(text.lowercased())
        }
        tableView?.reloadData()
    }
    
}

extension InterestsSearchTextField: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table View related methods
    // MARK: - TableView creation and updating
    // Create SearchTableview
    func buildSearchTableView() {
        
        if let tableView = tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "InterestsSearchTextFieldCell")
            tableView.delegate = self
            tableView.dataSource = self
            self.window?.addSubview(tableView)
        } else {
//            print("tableView created")
            tableView = UITableView(frame: CGRect.zero)
            tableView?.isHidden = true
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "InterestsSearchTextFieldCell",
                                                 for: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = resultsList?[indexPath.row].name
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selected row")
        self.text = resultsList?[indexPath.row].name
        tableView.isHidden = true
        self.endEditing(true)
        guard let interests = resultsList?[indexPath.row] else { return }
        presenter?.addInterest(interest: interests)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44))
        let button = UIButton(frame: CGRect(x: 20, y: 0, width: tableView.frame.size.width, height: 44))
        footerView.backgroundColor = .white
        button.setTitle("+ Добавить свой тег", for: .normal)
        button.setTitleColor(.hdButtonColor, for: .normal)
        button.contentHorizontalAlignment = .left
//        button.addTarget(self, action: #selector(addTag), for: .touchUpInside)
        footerView.addSubview(button)
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
//    @objc private func addTag() {
//        presenter?.createInterest()
//    }
}
