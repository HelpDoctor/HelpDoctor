//
//  ContactsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 19.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol ContactsPresenterProtocol: Presenter {
    init(view: ContactsViewController)
    func getContactList()
    func getCountContacts() -> Int
    func getContact(index: Int) -> Contacts?
    func getCountRecentContacts() -> Int
    func getRecentContact(index: Int) -> Contacts?
    func addToSelected(index: Int)
    func deleteFromSelected(index: Int)
    func searchTextIsEmpty()
    func filter(searchText: String)
    func sortByName()
    func sortBySpec()
    func toInviteFriend()
    func saveGuests()
}

class ContactsPresenter: ContactsPresenterProtocol {

    // MARK: - Dependency
    let view: ContactsViewController
    
    // MARK: - Constants and variables
    private var contactList: [Contacts] = []
    var filteredArray: [Contacts] = []
    private var selectedContacts: [Contacts] = []
    
    // MARK: - Init
    required init(view: ContactsViewController) {
        self.view = view
    }
    
    func getContactList() {
        NetworkManager.shared.getContactList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let contacts):
                    self?.contactList = contacts
                    self?.filteredArray = contacts
                    self?.view.setCountContactList(contactsCount: self?.contactList.count ?? 0)
                    self?.view.reloadTableView()
                    self?.view.reloadCollectionView()
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
    
    func getCountRecentContacts() -> Int {
        return filteredArray.count // TODO: - Заменить на нормальную функцию
    }
    
    func getRecentContact(index: Int) -> Contacts? {
        return filteredArray[index] // TODO: - Заменить на нормальную функцию
    }
    
    func addToSelected(index: Int) {
        if selectedContacts.firstIndex(where: { $0.id == filteredArray[index].id }) != nil {
            view.showAlert(message: "Контакт уже выбран")
            return
        } else {
            selectedContacts.append(filteredArray[index])
            view.reloadCollectionView()
        }
    }
    
    func deleteFromSelected(index: Int) {
        if let findIndex = selectedContacts.firstIndex(where: { $0.id == filteredArray[index].id }) {
            selectedContacts.remove(at: findIndex)
        }
        view.reloadCollectionView()
    }
    
    func searchTextIsEmpty() {
        filteredArray = contactList
        view.reloadTableView()
        selectRows()
    }
    
    func filter(searchText: String) {
        filteredArray = contactList.filter({ contact -> Bool in
            return (contact.fullName.lowercased().contains(searchText.lowercased()))
        })
        view.reloadTableView()
        selectRows()
    }
    
    private func selectRows() {
        for value in selectedContacts {
            guard let index = filteredArray.firstIndex(where: { $0.id == value.id }) else { continue }
            view.setSelected(index: index)
        }
    }
    
    func sortByName() {
        filteredArray = filteredArray.sorted(by: { $0.fullName < $1.fullName })
        view.reloadTableView()
    }
    
    func sortBySpec() {
        filteredArray = filteredArray.sorted(by: { $0.specialization ?? "" < $1.specialization ?? "" })
        view.reloadTableView()
    }
    
    func toInviteFriend() {
        let viewController = InviteViewController()
        viewController.presenter = InvitePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func saveGuests() {
        view.navigationController?.popViewController(animated: true)
        guard let previous = view.navigationController?.viewControllers.last as? AddEventViewController else { return }
        let presenter = previous.presenter
        presenter?.setGuestList(guests: selectedContacts)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
