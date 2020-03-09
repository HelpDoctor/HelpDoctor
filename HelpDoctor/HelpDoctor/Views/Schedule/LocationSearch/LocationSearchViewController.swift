//
//  LocationSearchViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 26.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import MapKit
import UIKit

class LocationSearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Dependency
    var presenter: LocationSearchPresenterProtocol?
    weak var delegate: MapKitSearchDelegate?
    private var locationManager = LocationManager.instance
    
    // MARK: - Constants and variables
    private let mapView = MKMapView()
    private var nearMeParent = UIView()
    private let linkView = UIView()
    private var nearMe = MKUserTrackingButton()
    private var stackView = UIStackView()
    
    private var searchBar = UISearchBar()
    private var tableView = UITableView()
    private var stackViewHeight = NSLayoutConstraint()
    private var stackViewExpandedHeight: CGFloat?
    private var stackViewMaxDraggableHeight: CGFloat {
        return view.frame.height - 120
    }
    private var stackViewMaxExpandedHeight: CGFloat {
        return view.frame.height - 180
    }
    private var stackViewMaxMapInteractedHeight: CGFloat {
        return max((view.frame.height - 180) / 3, searchBarHeight)
    }
    private var tableViewPanInitialOffset: CGFloat?
    private var tableViewContentHeight: CGFloat {
        return tableView.backgroundView?.bounds.size.height ?? tableView.contentSize.height
    }
    private var searchBarHeight: CGFloat {
        return searchBar.frame.height
    }
    private var searchBarText: String {
        return searchBar.text ?? ""
    }
    private var safeAreaInsetsBottom: CGFloat {
        return view.safeAreaInsets.bottom
    }
    private var keyboardHeight: CGFloat = 0
    private var isExpanded = false
    private var isDragged = false {
        didSet {
            if isDragged {
                searchBar.resignFirstResponder() // On drag, dismiss Keyboard
            }
        }
    }
    private var isUserMapInteracted = false {
        didSet {
            if isUserMapInteracted {
                userDidMapInteract()
            }
        }
    }
    private var isUserInteracted: Bool {
        return isDragged || isUserMapInteracted
    }
    private var searchCompletionRequest: MKLocalSearchCompleter? = MKLocalSearchCompleter()
    private var searchCompletions = [MKLocalSearchCompletion]()
    
    private var searchRequestFuture: Timer?
    private var searchRequest: MKLocalSearch?
    private var searchMapItems = [MKMapItem]()
    
    private var tableViewType: TableType = .searchCompletion {
        didSet {
            switch tableViewType {
            case .searchCompletion:
                tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
            case .mapItem:
                tableView.separatorInset = UIEdgeInsets(top: 0, left: 67, bottom: 0, right: 0)
            }
            tableView.reloadData()
        }
    }
    private enum TableType {
        case searchCompletion
        case mapItem
    }
    
    private var geocodeRequestFuture: Timer?
    private var geocodeRequest: CLGeocoder? = CLGeocoder()
    
    private var mapAnnotations = Set<MKPlacemark>()
    
    private var searchBarTextField: UITextField? {
        return searchBar.value(forKey: "searchField") as? UITextField
    }
    
    private var completionEnabled = true {
        didSet {
            if !completionEnabled {
                searchCompletionRequest = nil
            } else if searchCompletionRequest == nil {
                searchCompletionRequest = MKLocalSearchCompleter()
            }
        }
    }
    
    private var geocodeEnabled = true {
        didSet {
            if !geocodeEnabled {
                geocodeRequest = nil
            } else if geocodeRequest == nil {
                geocodeRequest = CLGeocoder()
            }
        }
    }
    
    private var userLocationRequest: CLAuthorizationStatus?
    private var alertSubtitle: String?
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tabBarColor
        tabBarController?.tabBar.isHidden = true
        setupHeaderViewWithAvatar(title: "Выбор локации",
                                  text: nil,
                                  userImage: nil,
                                  presenter: presenter)
        setupMapView()
        setupStackView()
        setupSearchBar()
        setupTableView()
        setupGestureRecognizer()
        setupNearMeParent()
        setupNearMe()
        setupLinkView()
        mapView.delegate = self
        searchBar.delegate = self
        searchCompletionRequest?.region = mapView.region
        searchCompletionRequest?.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        if let userLocationRequest = userLocationRequest {
            locationManager.locationManagerRequestLocation(withPermission: userLocationRequest)
        }
        if let searchBarTextField = searchBarTextField {
            searchBarTextField.font = UIFont.systemFontOfSize(size: 14)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .tabBarColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup views
    /// Установка карты на экран
    private func setupMapView() {
        let currentCoordinate = locationManager.locationManager.location?.coordinate
        let coordinate = currentCoordinate ?? locationManager.defaultCoordinate
        let camera = MKMapCamera(lookingAtCenter: coordinate,
                                 fromEyeCoordinate: coordinate,
                                 eyeAltitude: 2000)
        mapView.setCamera(camera, animated: true)
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    /// Установка StackView со строкой поиска и таблицой результатов
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackViewHeight = stackView.heightAnchor.constraint(equalToConstant: 60)
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        stackView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        stackViewHeight.isActive = true
        stackView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor).isActive = true
    }
    
    /// Установка строки поиска
    private func setupSearchBar() {
        stackView.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: width).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    /// Установка таблицы с результатами поиска
    private func setupTableView() {
        stackView.addSubview(tableView)
        tableView.register(MapItemTableViewCell.self,
                           forCellReuseIdentifier: "MapItemTableViewCell")
        tableView.register(SearchCompletionTableViewCell.self,
                           forCellReuseIdentifier: "SearchCompletionTableViewCell")
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalToConstant: width).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
    }
    
    /// Добавление на экран распознователя жестов
    private func setupGestureRecognizer() {
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(mapView(isPan:)))
//        pan.delegate = self
//        mapView.addGestureRecognizer(pan)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(mapView(isPinch:)))
        pinch.delegate = self
        mapView.addGestureRecognizer(pinch)
        mapView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(mapView(isPan:))))
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mapView(isTap:))))
        searchBar.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(searchBar(isPan:))))
        tableView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(tableView(isPan:))))
    }
    
    /// Установка поля для кнопки перемещения к своему местоположению
    private func setupNearMeParent() {
        nearMeParent.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.85)
        nearMeParent.layer.cornerRadius = 5
        mapView.addSubview(nearMeParent)
        
        nearMeParent.translatesAutoresizingMaskIntoConstraints = false
        nearMeParent.widthAnchor.constraint(equalToConstant: 40).isActive = true
        nearMeParent.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nearMeParent.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50).isActive = true
        nearMeParent.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12).isActive = true
    }
    
    /// Установка кнопки перемещения к своему местоположению
    private func setupNearMe() {
        nearMe = MKUserTrackingButton(mapView: mapView)
        nearMeParent.addSubview(nearMe)
        
        nearMe.translatesAutoresizingMaskIntoConstraints = false
        nearMe.widthAnchor.constraint(equalToConstant: 24).isActive = true
        nearMe.heightAnchor.constraint(equalToConstant: 24).isActive = true
        nearMe.centerXAnchor.constraint(equalTo: nearMeParent.centerXAnchor).isActive = true
        nearMe.centerYAnchor.constraint(equalTo: nearMeParent.centerYAnchor).isActive = true
    }
    
    /// Установка язычка над строкой поиска
    private func setupLinkView() {
        linkView.backgroundColor = UIColor(red: 171 / 255, green: 171 / 255, blue: 171 / 255, alpha: 1)
        stackView.addSubview(linkView)
        
        linkView.translatesAutoresizingMaskIntoConstraints = false
        linkView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        linkView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        linkView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        linkView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 4).isActive = true
    }
    
    // MARK: - Map Gestures
    @objc func mapView(isPan gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            searchBar.resignFirstResponder()
            isUserMapInteracted = true
        case .ended:
            // Add more results on mapView
            searchRequestInFuture(isMapPan: true)
            print("some")
            isUserMapInteracted = false
        default:
            break
        }
    }
    
    @objc private func mapView(isPinch gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            searchBar.resignFirstResponder()
            isUserMapInteracted = true
        case .ended:
            // Add more results on mapView
            searchRequestInFuture(isMapPan: true)
            isUserMapInteracted = false
        default:
            break
        }
    }
    
    @objc func mapView(isTap gesture: UITapGestureRecognizer) {
        // If tap is coinciding with pan or pinch gesture, don't geocode.
        guard !isUserMapInteracted else {
            geocodeRequestCancel()
            return
        }
        // If typing or tableView scrolled, only resize bottom sheet.
        guard !searchBar.isFirstResponder && tableView.contentOffset.y == 0 else {
            geocodeRequestCancel()
            isUserMapInteracted = true
            isUserMapInteracted = false
            return
        }
        let coordinate = mapView.convert(gesture.location(in: mapView), toCoordinateFrom: mapView)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocodeRequestInFuture(withLocation: location)
    }
    
    private func userDidMapInteract() {
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        searchBar.resignFirstResponder()
        if isExpanded, stackViewHeight.constant > stackViewMaxMapInteractedHeight {
            tableViewShow()
        }
    }
    
    // MARK: - IBActions
    /// Переход на предыдущий экран
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
    // MARK: - Geocode
    private func geocodeRequestInFuture(withLocation location: CLLocation,
                                        timeInterval: Double = 1.5,
                                        repeats: Bool = false) {
        guard geocodeEnabled else {
            return
        }
        guard mapView.mapBoundsDistance <= 20000 else {
            // Less than 20KM (Street Level) otherwise don't geocode.
            return
        }
        geocodeRequestCancel()
        geocodeRequestFuture = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: repeats) { [weak self] _ in
            guard let self = self, !self.isUserMapInteracted else {
                return
            }
            self.geocodeRequest?.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                self?.geocodeRequestDidComplete(withPlacemarks: placemarks, error: error)
            }
        }
    }
    
    func geocodeRequestDidComplete(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        guard let originalPlacemark = placemarks?.first else {
            return
        }
        let placemark = MKPlacemark(placemark: originalPlacemark)
        let didChoose = originalPlacemark.areasOfInterest?.first ?? originalPlacemark.name ?? originalPlacemark.address
        mapKitSearch(didChoose: didChoose,
                     mapItem: MKMapItem(placemark: placemark))
    }
    
    private func mapKitSearch(didChoose title: String,
                              mapItem: MKMapItem,
                              cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: alertSubtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler))
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.delegate?.mapKitSearch(self, mapItem: mapItem)
            self.backButtonPressed()
        })
        present(alert, animated: true)
    }
    
    private func geocodeRequestCancel() {
        geocodeRequestFuture?.invalidate()
        geocodeRequest?.cancelGeocode()
    }
    
    // MARK: - Bottom Sheet Gestures
    @objc private func searchBar(isPan gesture: UIPanGestureRecognizer) {
        guard tableView.numberOfRows(inSection: 0) > 0 else {
            return
        }
        let translationY = gesture.translation(in: view).y
        switch gesture.state {
        case .began:
            isDragged = true
        case .ended:
            bottomSheetDidDrag(completedTranslationY: translationY)
        default:
            if translationY > 0, let stackViewExpandedHeight = stackViewExpandedHeight {
                // Drag down. Can't drag below searchBarHeight
                stackViewHeight.constant = max(stackViewExpandedHeight - translationY, searchBarHeight)
            } else if translationY < 0 {
                // Drag up. Can't drag above stackViewMaxDraggableHeight
                if let stackViewExpandedHeight = stackViewExpandedHeight, isExpanded {
                    // stackViewExpandedHeight always contains keyboardHeight
                    stackViewHeight.constant = min(stackViewMaxDraggableHeight, stackViewExpandedHeight - translationY)
                } else {
                    stackViewHeight.constant = min(stackViewMaxDraggableHeight,
                                                   searchBarHeight + keyboardHeight - translationY)
                }
            }
        }
    }
    
    @objc func tableView(isPan gesture: UIPanGestureRecognizer) {
        guard tableView.numberOfRows(inSection: 0) > 0 else {
            return
        }
        let translationY = gesture.translation(in: view).y
        switch gesture.state {
        case .began:
            isDragged = true
            tableViewPanInitialOffset = tableView.contentOffset.y
        case .ended:
            bottomSheetDidDrag(completedTranslationY: translationY)
            // If bounced bottom, rebounce upwards
            if tableView.contentOffset.y > tableViewContentHeight - tableView.frame.size.height {
                tableView.setContentOffset(CGPoint(x: 0,
                                                   y: max(0, tableViewContentHeight - tableView.frame.size.height)),
                                           animated: true)
            }
            tableViewPanInitialOffset = nil
        default:
            guard let tableViewPanInitialOffset = tableViewPanInitialOffset else {
                return
            }
            let stackViewTranslation = tableViewPanInitialOffset - translationY
            tableView.contentOffset.y = max(0, stackViewTranslation)
            if stackViewTranslation < 0, let stackViewExpandedHeight = stackViewExpandedHeight {
                stackViewHeight.constant = max(searchBarHeight, stackViewExpandedHeight + stackViewTranslation)
            }
        }
    }
    
    private func bottomSheetDidDrag(completedTranslationY translationY: CGFloat) {
        isDragged = false
        if let stackViewExpandedHeight = stackViewExpandedHeight { // Has expanded.
            if isExpanded { // If already expanded
                if stackViewExpandedHeight < 100 && translationY > 5 {
                    tableViewHide() // If bottom sheet height <100 and dragged down 5 pixels
                } else if stackViewHeight.constant > (stackViewExpandedHeight * 0.85) {
                    tableViewShow() // If dragged down < 15%
                } else {
                    tableViewHide() // If dragged down >= 15%
                }
            } else {
                if stackViewExpandedHeight < 100 && translationY < -5 {
                    tableViewShow() // If bottom sheet height <100 and dragged up 5 pixels
                } else if stackViewHeight.constant > (stackViewExpandedHeight * 0.15) {
                    tableViewShow() // If dragged up > 15%
                } else {
                    tableViewHide() // If dragged up <= 15%
                }
            }
        } else {
            tableViewHide()
        }
    }
    
    // MARK: - Search Completions
    // Search Completions Request are invoked on textDidChange in searchBar,
    // and region is updated upon regionDidChange in mapView.
    private func searchCompletionRequest(didComplete searchCompletions: [MKLocalSearchCompletion]) {
        searchRequestCancel()
        self.searchCompletions = searchCompletions
        tableViewType = .searchCompletion
        tableViewShow()
    }
    
    private func searchCompletionRequestCancel() {
        searchCompletionRequest?.delegate = nil
        searchCompletionRequest?.region = mapView.region
        searchCompletionRequest?.delegate = self
    }
    
    // MARK: - Search Map Item
    private func searchRequestInFuture(withTimeInterval timeInterval: Double = 2.5,
                                       repeats: Bool = false,
                                       dismissKeyboard: Bool = false,
                                       isMapPan: Bool = false) {
        searchRequestCancel()
        // We use count of 1, as we predict search results won't change.
        if isExpanded, searchMapItems.count > 1, !searchBarText.isEmpty {
            searchRequestFuture = Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                       repeats: repeats) { [weak self] _ in
                                                        self?.searchRequestStart(dismissKeyboard: dismissKeyboard,
                                                                                 isMapPan: isMapPan)
            }
        }
    }
    
    private func searchRequestCancel() {
        searchCompletionRequest?.cancel()
        searchRequestFuture?.invalidate()
        searchRequest?.cancel()
    }
    
    private func searchRequestStart(dismissKeyboard: Bool = false, isMapPan: Bool = false) {
        searchRequestCancel()
        guard !searchBarText.isEmpty else {
            searchBar.resignFirstResponder()
            searchMapItems.removeAll()
            tableView.reloadData()
            tableViewHide()
            return
        }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in
            self?.searchRequestDidComplete(withResponse: response, error,
                                           dismissKeyboard: dismissKeyboard,
                                           isMapPan: isMapPan)
        }
        self.searchRequest = search
    }
    
    private func searchRequestDidComplete(withResponse response: MKLocalSearch.Response?,
                                          _ error: Error?,
                                          dismissKeyboard: Bool = false,
                                          isMapPan: Bool = false) {
        guard let response = response else {
            return
        }
        self.searchMapItems = response.mapItems
        self.tableViewType = .mapItem
        if isMapPan { // Add new annotations from dragging and searching new areas.
            var newAnnotations = [PlaceAnnotation]()
            for mapItem in response.mapItems {
                if !mapAnnotations.contains(mapItem.placemark) {
                    mapAnnotations.insert(mapItem.placemark)
                    newAnnotations.append(PlaceAnnotation(mapItem))
                }
            }
            mapView.addAnnotations(newAnnotations)
        } else { // Remove annotations, and resize mapView to new annotations.
            tableViewShow()
            mapAnnotations.removeAll()
            mapView.removeAnnotations(mapView.annotations)
            var annotations = [PlaceAnnotation]()
            for mapItem in response.mapItems {
                mapAnnotations.insert(mapItem.placemark)
                annotations.append(PlaceAnnotation(mapItem))
            }
            // 1 Search Result. Refer to delegate.
            if response.mapItems.count == 1, let mapItem = response.mapItems.first {
                delegate?.mapKitSearch(self, mapItem: mapItem)
            }
            mapView.showAnnotations(annotations, animated: true)
            if dismissKeyboard {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    // MARK: - Bottom Sheet Animations
    func tableViewHide(duration: TimeInterval = 0.5,
                       options: UIView.AnimationOptions = [.curveEaseOut]) {
        if keyboardHeight > 0 { // If there was a previous keyboard height from dragging
            if stackViewExpandedHeight != nil, stackViewExpandedHeight! > 0 {
                stackViewExpandedHeight! -= keyboardHeight
            }
            keyboardHeight = 0
        }
        isExpanded = false
        if mapView.frame.size.height > CGFloat(searchBarHeight) {
            UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: {
                self.stackViewHeight.constant = CGFloat(self.searchBarHeight)
                if self.searchMapItems.isEmpty {
                    self.stackViewExpandedHeight = nil
                }
                self.tableView.superview?.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func tableViewShow(duration: TimeInterval = 0.5,
                       options: UIView.AnimationOptions = [.curveEaseInOut]) {
        isExpanded = true
        // If user is interacting with map, or showing mapItems without searching or scrolling tableView, expand bottomSheet to maxMapInteractedHeight.
        //swiftlint:disable line_length
        let stackViewMaxExpandedHeight = isUserMapInteracted || (tableViewType == .mapItem && !searchBar.isFirstResponder && tableView.contentOffset.y == 0) ? stackViewMaxMapInteractedHeight : self.stackViewMaxExpandedHeight
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: {
            let safeAreaInsetsBottom = self.keyboardHeight > 0 ? self.safeAreaInsetsBottom : 0
            // Remove safeAreaInsets bottom if keyboard opened due to overlap.
            self.stackViewHeight.constant = min(stackViewMaxExpandedHeight,
                                                self.searchBarHeight + self.keyboardHeight + self.tableViewContentHeight - safeAreaInsetsBottom)
            self.stackViewExpandedHeight = self.stackViewHeight.constant
            self.view.layoutIfNeeded()
            //swiftlint:enable line_length
        })
    }
    
    // MARK: - Keyboard Animations
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
                return
        }
        keyboardHeight = keyboardFrame.cgRectValue.size.height
        tableViewShow(duration: duration, options: UIView.AnimationOptions(rawValue: curve))
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        guard !isDragged,
            let userInfo = notification.userInfo,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
                return
        }
        keyboardHeight = 0
        if isExpanded { // Maintain expanded state, but lower sheet if needed.
            tableViewShow(duration: duration, options: UIView.AnimationOptions(rawValue: curve))
        } else {
            tableViewHide(duration: duration, options: UIView.AnimationOptions(rawValue: curve))
        }
    }
    
}

// MARK: - Map Delegate
extension LocationSearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        geocodeRequestCancel()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if view == nil {
            let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            marker.markerTintColor = .red
            marker.clusteringIdentifier = "MapItem"
            view = marker
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        switch mode {
        case .follow:
            locationManager.locationManagerRequestLocation()
        default:
            break
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        geocodeRequestCancel()
        guard let annotation = view.annotation as? PlaceAnnotation, let title = annotation.title else {
            return
        }
        mapKitSearch(didChoose: title, mapItem: annotation.mapItem) { _ in
            self.mapView.deselectAnnotation(annotation, animated: true)
        }
    }
}

// MARK: - Search Delegate
extension LocationSearchViewController: UISearchBarDelegate, MKLocalSearchCompleterDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchCompletionRequest(didComplete: completer.results)
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchRequestFuture?.invalidate()
        if !searchText.isEmpty {
            searchCompletionRequest?.queryFragment = searchText
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchCompletionRequest?.cancel()
        searchRequestFuture?.invalidate()
        // User interactions can dismiss keyboard, we prevent another search.
        if !isUserInteracted {
            searchRequestStart(dismissKeyboard: true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchRequestStart(dismissKeyboard: true)
    }

}

// MARK: - Table Data Source
extension LocationSearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableViewType {
        case .searchCompletion:
            return searchCompletions.count
        case .mapItem:
            return searchMapItems.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableViewType {
        case .searchCompletion:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCompletionTableViewCell",
                                                     for: indexPath) as? SearchCompletionTableViewCell
                else { return UITableViewCell() }
            cell.viewSetup(withSearchCompletion: searchCompletions[indexPath.row])
            return cell
        case .mapItem:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MapItemTableViewCell",
                                                     for: indexPath) as? MapItemTableViewCell
                else { return UITableViewCell() }
            cell.viewSetup(withMapItem: searchMapItems[indexPath.row], tintColor: .red)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}

// MARK: - Table View Delegate
extension LocationSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableViewType {
        case .searchCompletion:
            guard searchCompletions.count > indexPath.row else {
                return
            }
            searchBar.text = searchCompletions[indexPath.row].title
            searchBarSearchButtonClicked(searchBar)
        case .mapItem:
            guard searchMapItems.count > indexPath.row else {
                return
            }
            delegate?.mapKitSearch(self, mapItem: searchMapItems[indexPath.row])
            presenter?.back()
        }
    }
}

// MARK: - Location Manager Delegate
extension LocationSearchViewController: LocationManagerDelegate {
    func didBeginLocationUpdate() {
        mapView.setCenter(locationManager.userLocation.coordinate, animated: true)
    }
}
