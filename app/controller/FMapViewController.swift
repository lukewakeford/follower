//
//  FMapViewController.swift
//  follower
//
//  Created by Luke Wakeford on 28/08/2020.
//

import MapKit

class FMapViewController:UIViewController, HidesNavBar, FLocationManagerDelegate, MKMapViewDelegate {
    
    let stack = UIStackView()
    let map = MKMapView()
    let startStopButton = UIButton()
    let clearButton = UIButton()
    let statsButton = UIButton()
    
    var isFollowing:Bool = false
    var launchInitialZoom:Bool = true
    
    var shape:MKPolyline?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.backgroundColor = UIColor(named: "accent")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Map"
        
        self.stack.axis = .vertical
        self.stack.translatesAutoresizingMaskIntoConstraints = false
        self.stack.spacing = 2
        self.view.addSubview(self.stack)
    
        NSLayoutConstraint.activate([
            self.stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.stack.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.stack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.map.accessibilityIdentifier = "map"
        self.map.isAccessibilityElement = true
        self.map.delegate = self
        self.map.showsTraffic = false
        self.map.showsPointsOfInterest = false
        self.map.translatesAutoresizingMaskIntoConstraints = false
        self.stack.addArrangedSubview(self.map)
        
        self.startStopButton.setTitle("Start Following", for: .normal)
        self.startStopButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        self.startStopButton.translatesAutoresizingMaskIntoConstraints = false
        self.startStopButton.addTarget(self, action: #selector(stopStartButtonPress), for: .touchUpInside)
        self.startStopButton.setTitleColor(.white, for: .normal)
        self.startStopButton.setTitleColor(UIColor.white.withAlphaComponent(0.2), for: .disabled)
        
        self.statsButton.setTitle("View Stats", for: .normal)
        self.statsButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        self.statsButton.translatesAutoresizingMaskIntoConstraints = false
        self.statsButton.addTarget(self, action: #selector(statsButtonPress), for: .touchUpInside)
        self.statsButton.setTitleColor(.white, for: .normal)
        self.statsButton.setTitleColor(UIColor.white.withAlphaComponent(0.2), for: .disabled)
        
        self.clearButton.setTitle("Clear Session", for: .normal)
        self.clearButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.clearButton.translatesAutoresizingMaskIntoConstraints = false
        self.clearButton.addTarget(self, action: #selector(clearButtonPress), for: .touchUpInside)
        self.clearButton.setTitleColor(.white, for: .normal)
        self.clearButton.setTitleColor(UIColor.white.withAlphaComponent(0.2), for: .disabled)
        
        self.stack.addArrangedSubview(self.startStopButton)
        self.stack.addArrangedSubview(self.statsButton)
        self.stack.addArrangedSubview(self.clearButton)
        
        NSLayoutConstraint.activate([
            self.startStopButton.heightAnchor.constraint(equalToConstant: 60),
            self.statsButton.heightAnchor.constraint(equalToConstant: 60),
            self.clearButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    
        // Setup the location manager
        
        FLocationManager.shared.delegate = self
        FLocationManager.shared.checkAuthorisationStatus()
        updateButtonStates()
        
    }
    
    func updateButtonStates() {
        let authStatus = CLLocationManager.authorizationStatus()
        self.startStopButton.isEnabled = isFollowing
            || authStatus == .authorizedAlways
            || authStatus == .authorizedWhenInUse
        self.clearButton.isEnabled = !isFollowing
            && !FLocationManager.shared.locations.isEmpty
    }
    
    @objc func stopStartButtonPress() {
        if isFollowing {
            FLocationManager.shared.stopMonitoring()
            self.startStopButton.setTitle("Start Following", for: .normal)
            showJourneyOnMap()
        } else {
            FLocationManager.shared.startMonitoring()
            self.startStopButton.setTitle("Stop Following", for: .normal)
            clearMarkers()
        }
        isFollowing = !isFollowing
        updateButtonStates()
    }
    
    @objc func clearButtonPress() {
        FLocationManager.shared.locations.removeAll()
        self.map.removeOverlays(
            self.map.overlays
        )
        clearMarkers()
        updateButtonStates()
    }
    
    @objc func statsButtonPress() {
        if let nav = self.navigationController {
            nav.pushViewController(
                FStatsViewController(),
                animated: true
            )
        }
    }
    
    func clearMarkers() {
        self.map.removeAnnotations(
            self.map.annotations
        )
    }
    
    func showJourneyOnMap() {
        guard let shape = self.shape else {
            return
        }
        let padding:CGFloat = 80
        self.map.setVisibleMapRect(
            shape.boundingMapRect,
            edgePadding: UIEdgeInsets(
                top: padding,
                left: padding,
                bottom: padding,
                right: padding
            ),
            animated: true
        )
        if FLocationManager.shared.locations.count >= 2 {
            if let start = FLocationManager.shared.locations.first {
                let startMarker = MKPointAnnotation()
                startMarker.coordinate = start.coordinate
                startMarker.title = "start"
                self.map.addAnnotation(startMarker)
            }
            if let end = FLocationManager.shared.locations.last {
                let endMarker = MKPointAnnotation()
                endMarker.coordinate = end.coordinate
                endMarker.title = "finish"
                self.map.addAnnotation(endMarker)
            }
        }
    }
    
    // MARK: - Location Manager Delegate
    
    func locationPermissionGranted() {
        updateButtonStates()
        self.map.showsUserLocation = true
    }
    
    func locationPermissionsLimited() {
         updateButtonStates()
        // show user a pretty view that tells them the app can't function without permission to use their location data
    }
    
    func locationChanged(location: CLLocation) {
        updateButtonStates()
    }
    
    func shapeDataUpdated(shape: MKPolyline) {
        if let currentShape = self.shape {
            self.map.removeOverlay(currentShape)
        }
        self.shape = shape
        self.map.addOverlay(shape)
        updateButtonStates()
    }
    
    // MARK: - Map View Delegate
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if isFollowing || launchInitialZoom {
            let camera = MKMapCamera(
                lookingAtCenter: userLocation.coordinate,
                fromDistance: 1000,
                pitch: 0,
                heading: 0
            )
            self.map.setCamera(camera, animated: true)
            launchInitialZoom = false
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor(named: "accent")
            renderer.lineWidth = 4.0
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.title == "start" {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.pinTintColor = .green
            return view
        } else if annotation.title == "finish" {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.pinTintColor = .red
            return view
        }
        return nil
    }
    
}
