//
//  ViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//
import Foundation
import UIKit

extension UIViewController {
    func setPickerToField(pickerView: UIPickerView, textField: UITextField, title: String, selectedIndex: Int = 0) {
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
        pickerView.delegate = self as? UIPickerViewDelegate
        pickerView.dataSource = self as? UIPickerViewDataSource
        pickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pickerView.tag = textField.tag
        textField.inputView = pickerView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6,
                            width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y:
                self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
//        toolBar.backgroundColor = R.color.accentColor()
        let doneButton = UIBarButtonItem(barButtonSystemItem:
                UIBarButtonItem.SystemItem.done, target: self, action:
                    #selector(self.donePressed))
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.donePressed))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        let flexSpace = UIBarButtonItem(barButtonSystemItem:
                UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width /
                    3, height: self.view.frame.size.height))
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = title
        label.textAlignment = NSTextAlignment.center
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([flexSpace, textBtn, flexSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
    func setDatePickerToField(pickerView: UIDatePicker, textField: UITextField, title: String) {
        pickerView.tag = textField.tag
        if #available(iOS 14, *) {
            pickerView.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
        }
        pickerView.datePickerMode = .date
        pickerView.minimumDate = Calendar.current.date(byAdding: .year, value: -71, to: Date())
        textField.inputView = pickerView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6,
                            width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                            target: self, action: #selector(self.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem:
                            UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width /
                        3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = title
        label.textAlignment = NSTextAlignment.center
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([flexSpace, textBtn, flexSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
    @objc func donePressed(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
}
