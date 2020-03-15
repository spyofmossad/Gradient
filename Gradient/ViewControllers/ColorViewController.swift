//
//  ColorViewController.swift
//  Gradient
//
//  Created by Dmitry on 14.03.2020.
//  Copyright © 2020 Dmitry. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .systemBlue
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! SettingsViewController
        settingsVC.currentColor = mainView.backgroundColor
        settingsVC.delegate = self
    }
    
    @IBAction func unwindSegie(segue: UIStoryboardSegue) {
        _ = segue.source as! SettingsViewController
    }
}

extension ColorViewController: SettingsViewControllerDelegate {
    func setColor(_ color: UIColor) {
        mainView.backgroundColor = color
    }
    
}
