//
//  StartSettingsViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class StartSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let logoutButton = HDButton(title: "Выйти")
        logoutButton.addTarget(self, action: #selector(logouButtonPressed), for: .touchUpInside)
        view.addSubview(logoutButton)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 35).isActive = true

        // Do any additional setup after loading the view.
    }
    
    @objc private func logouButtonPressed() {
        let logout = Registration(email: nil, password: nil, token: myToken)

        getData(typeOfContent: .logout,
                returning: (Int?, String?).self,
                requestParams: logout.requestParams)
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            logout.responce = result

            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("result=\(String(describing: logout.responce))")
                    guard let code = logout.responce?.0 else { return }
                    if responceCode(code: code) {
                        print("Logout")
                    } else {
                        self?.showAlert(message: logout.responce?.1)
                    }
                }
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
