//
//  ViewController.swift
//  Gradient
//
//  Created by Dmitry on 01.03.2020.
//  Copyright © 2020 Dmitry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var alphaValue: CGFloat = 1.0
    private var roundFormatter: String = "%.2f"
    
    @IBOutlet weak var paletteView: UIView!
    
    @IBOutlet weak var redColorValue: UILabel!
    @IBOutlet weak var greenColorValue: UILabel!
    @IBOutlet weak var blueColorValue: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    private var viewColor: UIColor? {
        didSet{
            paletteView.backgroundColor = viewColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        setViewColor();
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            redColorValue.text = String(format: roundFormatter, sender.value)
            break
        case 2:
            greenColorValue.text = String(format: roundFormatter, sender.value)
            break
        case 3:
            blueColorValue.text = String(format: roundFormatter, sender.value)
            break
        default:
            break
        }
        setViewColor();
    }

    private func setupUI() {
        paletteView.layer.cornerRadius = 10;
        redColorValue.text = String(redSlider.value)
        greenColorValue.text = String(greenSlider.value)
        blueColorValue.text = String(blueSlider.value)
    }
    
    private func setViewColor() {
        viewColor = UIColor(displayP3Red: CGFloat(redSlider!.value), green: CGFloat(greenSlider!.value), blue: CGFloat(blueSlider!.value), alpha: alphaValue)
    }
}

