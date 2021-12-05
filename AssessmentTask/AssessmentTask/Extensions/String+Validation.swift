//
//  ViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation

extension String {
    func isValidCountryCode() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^+[+0-9]*$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func isValidName() -> Bool {
        if self.language() == "ar" {
                return true
        } else {
        let regex = try? NSRegularExpression(pattern: "^(?!\\s)[a-zA-Z ]{3,200}$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
    }
    func isValidStringName() -> Bool {
        if self == "" {
            return false
        }
        if Int(self) == nil {
            return true
        } else {
            return false
        }
    }
    func isValidMobile() -> Bool {
        if count == 0 { return false }
        let regex = try? NSRegularExpression(pattern: "^+[+0-9]{8,15}$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        guard  emailPredicate.evaluate(with: self) else {
            return false
        }
        return true
    }
    func isValidPassword() -> Bool {
        if self.count < 4 { return false }
        return true
    }
    func language() -> String? {
        return NSLinguisticTagger.dominantLanguage(for: self)
    }
    func round() -> String {
        return String(format: "%.2f", Float(self) ?? 0.0)
    }
}
