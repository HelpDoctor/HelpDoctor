//
//  BlockedUsersPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 07.11.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol BlockedUsersPresenterProtocol: Presenter {
    init(view: BlockedUsersViewController)
    func getBlockedUsers()
    func getCountContacts() -> Int
    func getContact(index: Int) -> Contacts?
    func searchTextIsEmpty()
    func filter(searchText: String)
    func removeFromBlockList(_ index: Int)
}

class BlockedUsersPresenter: BlockedUsersPresenterProtocol {

    // MARK: - Dependency
    let view: BlockedUsersViewController
    
    // MARK: - Constants and variables
    private var blockedList: [Contacts] = []
    var filteredArray: [Contacts] = []
    
    // MARK: - Init
    required init(view: BlockedUsersViewController) {
        self.view = view
    }
    
    func getBlockedUsers() {
        NetworkManager.shared.getBlockedUsers { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let contacts):
                    self?.blockedList = contacts
                    self?.filteredArray = contacts
                    self?.view.setCountBlockedList(contactsCount: self?.blockedList.count ?? 0)
                    self?.view.reloadTableView()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    func getCountContacts() -> Int {
        return filteredArray.count
    }
    
    func getContact(index: Int) -> Contacts? {
        return filteredArray[index]
    }
    
    func searchTextIsEmpty() {
        filteredArray = blockedList
        view.reloadTableView()
    }
    
    func filter(searchText: String) {
        filteredArray = blockedList.filter({ contact -> Bool in
            return (contact.fullName.lowercased().contains(searchText.lowercased()))
        })
        view.reloadTableView()
    }
    
    func removeFromBlockList(_ index: Int) {
        guard let id = filteredArray[index].id else { return }
        NetworkManager.shared.removeFromBlockList(id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.filteredArray.remove(at: index)
                    guard let fullIndex = self?.blockedList.firstIndex(where: { $0.id == id }) else { return }
                    self?.blockedList.remove(at: fullIndex)
                    self?.view.setCountBlockedList(contactsCount: self?.blockedList.count ?? 0)
                    self?.view.reloadTableView()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
