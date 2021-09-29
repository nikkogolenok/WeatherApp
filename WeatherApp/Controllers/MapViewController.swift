//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 29.09.21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    // MARK: - Outlet
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var satelliteImage: UIButton!
    @IBOutlet weak var precipitationImage: UIButton!
    @IBOutlet weak var radarImage: UIButton!
    @IBOutlet weak var hurricaneImage: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
