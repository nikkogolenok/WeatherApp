//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 28.09.21.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Variables
    
    // MARK: - Outlet
    
    @IBOutlet weak var mainView: UIView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.addCornerRadius(radius: mainView.frame.width / 2)
        mainView.backgroundColor = .green
    }
    
    // MARK: - Methods
    
    // MARK: - Actions
}

