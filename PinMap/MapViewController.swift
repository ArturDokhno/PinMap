//
//  ViewController.swift
//  PinMap
//
//  Created by Артур Дохно on 16.05.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let mapView: MKMapView = {
       let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let addAddressButton: UIButton = {
        let button = UIButton()
        button.setTitle("ADD ADDRESS", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let routeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Route", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        addAddressButton.addTarget(self, action: #selector(addAddressButtonTapped), for: .touchUpInside)
        routeButton.addTarget(self, action: #selector(addAddressButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    @objc func addAddressButtonTapped() {
        print("Tap add")
    }
    
    @objc func routeButtonTapped() {
        print("Tap route")
    }
    
    @objc func resetButtonTapped() {
        print("Tap reset")
    }
    
}

extension MapViewController {
    
    func setConstraints() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        mapView.addSubview(addAddressButton)
        NSLayoutConstraint.activate([
            addAddressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 70),
            addAddressButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20)
        ])
        
        mapView.addSubview(routeButton)
        NSLayoutConstraint.activate([
            routeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -70),
            routeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20)
        ])
        
        mapView.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -70),
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20)
        ])
    }
}
