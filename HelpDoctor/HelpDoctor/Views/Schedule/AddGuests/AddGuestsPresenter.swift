//
//  AddGuestsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol AddGuestsPresenterProtocol: Presenter {
    init(view: AddGuestsViewController)
    func setSelectedContact(_ guestList: [Contacts])
    func getContactList()
    func getCountContacts() -> Int
    func getCountSelectedContacts() -> Int
    func getContact(index: Int) -> Contacts?
    func getSelectedContact(index: Int) -> Contacts?
    func addToSelected(index: Int)
    func deleteFromSelected(index: Int)
    func searchTextIsEmpty()
    func filter(searchText: String)
    func toInviteFriend()
    func saveGuests()
}

class AddGuestsPresenter: AddGuestsPresenterProtocol {

    // MARK: - Dependency
    let view: AddGuestsViewController
    
    // MARK: - Constants and variables
    private var contactList: [Contacts] = []
    var filteredArray: [Contacts] = []
    private var selectedContacts: [Contacts] = []
    
    // MARK: - Init
    required init(view: AddGuestsViewController) {
        self.view = view
    }
    
    func setSelectedContact(_ guestList: [Contacts]) {
        selectedContacts = guestList
        view.reloadCollectionView()
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
                    self?.selectRows()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    func getCountContacts() -> Int {
        return filteredArray.count
    }
    
    func getCountSelectedContacts() -> Int {
        return selectedContacts.count
    }
    
    func getContact(index: Int) -> Contacts? {
        return filteredArray[index]
    }
    
    func getSelectedContact(index: Int) -> Contacts? {
        return selectedContacts[index]
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
}

// MARK: - Presenter
extension AddGuestsPresenter {
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func toProfile() {
        if Session.instance.userCheck {
            let viewController = ProfileViewController()
            viewController.presenter = ProfilePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = CreateProfileNameViewController()
            viewController.presenter = CreateProfileNamePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
