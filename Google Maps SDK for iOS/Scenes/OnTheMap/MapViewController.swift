//
//  MapViewController.swift
//  optima
//
//  Created by Тауекел on 06.02.2024.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    private let camera = GMSCameraPosition.camera(
        withLatitude: 42.882004,
        longitude: 74.582748,
        zoom: 15.0
    )
    
    // Создаем маркер для текущего положения
    private var currentLocationMarker: GMSMarker?

    // Используем CLLocationManager для определения местоположения
    private let locationManager = CLLocationManager()
    
    // MARK: - UI
    private lazy var mapView: GMSMapView = {
        let mapView = GMSMapView()
        mapView.camera = camera
        mapView.delegate = self
        return mapView
    }()
    
    private lazy var zoomInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        button.setImage(UIImage(systemName: "plus")?.withTintColor(
                .black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        return button
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 183/255, green: 183/255, blue: 181/255, alpha: 1)
        return view
    }()
    
    private lazy var zoomOutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.setImage(UIImage(systemName: "minus")?.withTintColor(
                .black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupLocationManager()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(mapView)
        view.addSubview(zoomInButton)
        view.addSubview(dividerView)
        view.addSubview(zoomOutButton)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        zoomInButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(mapView.snp.top).offset(100)
            make.width.height.equalTo(44)
        }
        dividerView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(zoomInButton.snp.bottom)
            make.height.equalTo(1)
            make.width.equalTo(44)
        }
        zoomOutButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(dividerView.snp.bottom)
            make.width.height.equalTo(44)
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    @objc private func zoomIn() {
        var currentCamera = mapView.camera
        currentCamera = GMSCameraPosition.camera(
            withLatitude: currentCamera.target.latitude,
            longitude: currentCamera.target.longitude,
            zoom: currentCamera.zoom + 1
        )
        mapView.animate(to: currentCamera)
    }

    @objc private func zoomOut() {
        var currentCamera = mapView.camera
        currentCamera = GMSCameraPosition.camera(
            withLatitude: currentCamera.target.latitude,
            longitude: currentCamera.target.longitude,
            zoom: currentCamera.zoom - 1
        )
        mapView.animate(to: currentCamera)
    }
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }

        // Обновляем маркер текущего положения
        updateCurrentLocationMarker(with: location)
    }

    private func updateCurrentLocationMarker(with location: CLLocation) {
        if currentLocationMarker == nil {
            currentLocationMarker = GMSMarker()
            if let image = UIImage(named: "currentLocation")?.withRenderingMode(.alwaysTemplate) {
                currentLocationMarker?.icon = image
            } else {
                print("Ошибка: изображение 'currentLocation' не найдено.")
            }

            currentLocationMarker?.map = mapView
        }

        currentLocationMarker?.position = CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }
}

extension MapViewController: GMSMapViewDelegate {
    // Реализуйте методы делегата, если необходимо
}
