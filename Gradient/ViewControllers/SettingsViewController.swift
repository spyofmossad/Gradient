//
//  ViewController.swift
//  Gradient
//
//  Created by Dmitry on 01.03.2020.
//  Copyright © 2020 Dmitry. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var colorPreview: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    var currentColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    private var redValue: CGFloat = 0 {
        didSet {
            redColorTextField.text = string(redValue)
            redSlider.value = Float(redValue)
            redLabel.text = string(redValue)
        }
    }
    private var greenValue: CGFloat = 0 {
        didSet {
            greenColorTextField.text = string(greenValue)
            greenSlider.value = Float(greenValue)
            greenLabel.text = string(greenValue)
        }
    }
    private var blueValue: CGFloat = 0 {
        didSet {
            blueColorTextField.text = string(blueValue)
            blueSlider.value = Float(blueValue)
            blueLabel.text = string(blueValue)
        }
    }
    private var alpha: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        setupUI()
        setViewColor()
     }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            redValue = CGFloat(sender.value)
        case 2:
            greenValue = CGFloat(sender.value)
        case 3:
            blueValue = CGFloat(sender.value)
        default:
            break
        }
        setViewColor()
    }

    private func setupUI() {
        colorPreview.layer.cornerRadius = 10
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        blueSlider.tintColor = .blue
        
        currentColor.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alpha)
    }
    
    private func setViewColor() {
        currentColor = UIColor(
            red: redValue,
            green: greenValue,
            blue: blueValue,
            alpha: alpha)
        
        colorPreview.backgroundColor = currentColor
        delegate.setColor(currentColor)
    }
    
    private func string(_ color: CGFloat) -> String {
        String(format: "%.2f", Double(color))
    }
}

extension SettingsViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard
            let colorStringValue = textField.text,
            var colorFloatValue = Float(colorStringValue) else {
            return
        }
        
        if colorFloatValue > 1.0 {
            colorFloatValue = 1.0
        }
        
        switch textField.tag {
        case 0: redValue = CGFloat(colorFloatValue)
        case 1: greenValue = CGFloat(colorFloatValue)
        case 2: blueValue = CGFloat(colorFloatValue)
        default: break
            }
        
        setViewColor()
        }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = .default
      
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
      
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
      
        doneToolbar.items = items
        doneToolbar.sizeToFit()
      
        [redColorTextField, greenColorTextField, blueColorTextField].forEach( {$0.inputAccessoryView = doneToolbar} )
    }
    
    @objc func doneButtonAction()
    {
        [redColorTextField, greenColorTextField, blueColorTextField].forEach( {$0?.resignFirstResponder()} )
    }
}
