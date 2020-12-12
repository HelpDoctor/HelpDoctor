//
//  LocationSearchPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 26.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import MapKit
import UIKit

// MARK: - Protocol
protocol MapKitSearchDelegate: AnyObject {
    func mapKitSearch(_ locationSearchViewController: LocationSearchViewController, mapItem: MKMapItem)
}

protocol LocationSearchPresenterProtocol: Presenter {
    init(view: LocationSearchViewController)
}

class LocationSearchPresenter: LocationSearchPresenterProtocol {
    
    // MARK: - Dependency
    let view: LocationSearchViewController
    
    // MARK: - Init
    required init(view: LocationSearchViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func backToRoot() {
        view.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Presenter
extension LocationSearchPresenter {
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
