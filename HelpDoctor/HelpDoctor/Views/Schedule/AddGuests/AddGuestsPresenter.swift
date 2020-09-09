//
//  AddGuestsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

//import Combine
import UIKit

protocol AddGuestsPresenterProtocol: Presenter {
    init(view: AddGuestsViewController)
    func getContactList()
    func getCountContacts() -> Int
    func getCountSelectedContacts() -> Int
    func getContact(index: Int) -> Contacts?
    func getSelectedContact(index: Int) -> Contacts?
    func addToSelected(index: Int)
    func deleteFromSelected(index: Int)
    func toInviteFriend()
}

class AddGuestsPresenter: AddGuestsPresenterProtocol {

    // MARK: - Dependency
    let view: AddGuestsViewController
    
    // MARK: - Constants and variables
    private var contactList: [Contacts] = []
    private var selectedContacts: [Contacts] = []
    
    // MARK: - Init
    required init(view: AddGuestsViewController) {
        self.view = view
    }
    
    func getContactList() {
        
        let getContactList = ContactsList()
        getData(typeOfContent: .getContactList,
                returning: ([Contacts], Int?, String?).self,
                requestParams: [:]) { [weak self] result in
            let dispathGroup = DispatchGroup()
                    
            getContactList.contacts = result?.0
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    print("getContactList =\(String(describing: getContactList.contacts))")
                    self?.view.setCountContactList(contactsCount: getContactList.contacts?.count ?? 0)
                    self?.contactList = getContactList.contacts ?? []
                    self?.view.reloadTableView()
                }
            }
        }
 
    }
    
    func getCountContacts() -> Int {
        return contactList.count
    }
    
    func getCountSelectedContacts() -> Int {
        return selectedContacts.count
    }
    
    func getContact(index: Int) -> Contacts? {
        return contactList[index]
    }
    
    func getSelectedContact(index: Int) -> Contacts? {
        return selectedContacts[index]
    }
    
    func addToSelected(index: Int) {
        if selectedContacts.firstIndex(where: { $0.id == contactList[index].id }) != nil {
            view.showAlert(message: "Контакт уже выбран")
            return
        } else {
            selectedContacts.append(contactList[index])
            view.reloadCollectionView()
        }
    }
    
    func deleteFromSelected(index: Int) {
        if let findIndex = selectedContacts.firstIndex(where: { $0.id == contactList[index].id }) {
            selectedContacts.remove(at: findIndex)
        }
        view.reloadCollectionView()
    }
    
    func toInviteFriend() {
        let viewController = InviteViewController()
        viewController.presenter = InvitePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
    
/*
 func selectRows() {
     for element in userInterests {
         guard let index = arrayInterests?.firstIndex(where: { $0.id == element.id }) else { return }
         view.setSelected(index: index)
     }
     
     for value in userInterests {
         guard let index = filteredArray.firstIndex(where: { $0.id == value.id }) else { continue }
         view.setSelected(index: index)
     }
 }
 */
