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
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let routeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Route", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    var annotationArray = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        addAddressButton.addTarget(self, action: #selector(addAddressButtonTapped), for: .touchUpInside)
        routeButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        mapView.delegate = self
    }
    
    @objc func addAddressButtonTapped() {
        alertAddAddress(title: "Добавить", placeholder: "Введите адрес") { [weak self] text in
            self?.setupPlaceMark(addressPlace: text)
        }
    }
    
    @objc func routeButtonTapped() {
        
    }
    
    @objc func resetButtonTapped() {
        print("Tap reset")
    }
    
    func setupPlaceMark(addressPlace: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(addressPlace) { [weak self] (placeMarks, error) in
            
            if let error = error {
                print(error)
                self?.alertError(title: "Ошибка", message: "Сервер недоступен. Попробуйте добавить адрес еще раз")
                return
            }
            
            guard let placeMarks = placeMarks else { return }
            let placeMark = placeMarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = addressPlace
            
            guard let placeMarkLocation = placeMark?.location else { return }
            annotation.coordinate = placeMarkLocation.coordinate
            
            self?.annotationArray.append(annotation)
            
            if (self?.annotationArray.count)! > 2 {
                self?.routeButton.isHidden = false
                self?.resetButton.isHidden = false
            }
            
            self?.mapView.showAnnotations(self!.annotationArray, animated: true)
        }
    }
    
    private func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: request)
        direction.calculate { [self] (response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response else {
                alertError(title: "Ошибка", message: "Маршут недоступен.")
                return
            }
            
            var minRoute = response.routes[0]
            for route in response.routes {
                minRoute = (route.distance < minRoute.distance) ? route : minRoute
            }
            
            self.mapView.addOverlay(minRoute.polyline)
            
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .red
        return render
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
            addAddressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 60),
            addAddressButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            addAddressButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        mapView.addSubview(routeButton)
        NSLayoutConstraint.activate([
            routeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -60),
            routeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            routeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        mapView.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -60),
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            resetButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
