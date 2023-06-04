//
//  ViewController.swift
//  crud-alamofire
//
//  Created by Rene Alonzo Choque Saire on 24/5/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    lazy var navigateToStocksButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Navigate to HomeView", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.blue
        
//        navigateToStocksButton.addAction(UIAction { _ in
//            // navigate to stock list screen
//            //print("Hello")
//            self.navigationController?.pushViewController(UIHostingController(rootView: HomeView()), animated: true)
//
//        }, for: .touchUpInside)
//        view.addSubview(navigateToStocksButton)
//        navigateToStocksButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        navigateToStocksButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
//        let hostingController = UIHostingController(rootView: RatingView(rating: .constant(3)))
        let hostingController = UIHostingController(rootView: HomeView())
        
        guard let homeView = hostingController.view else { return }
        homeView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChild(hostingController)
        
        self.view.addSubview(homeView)
        
        homeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        homeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        

    }


}

