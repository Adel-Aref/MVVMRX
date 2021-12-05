//
//  ViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation

extension String {

    enum DateFormate: String {
        case fullDate = "dd-MM-yyyy"
        case day = "dd"
        case month = "MM"
        case year = "yyyy"
        case anotherFullDate = "MMM dd, yyyy"
        case dateWithoutYear = "dd MMM"
        case dateWithTime = "MMM dd, yyyy hh:mm a"
        case time = "hh:mm a"
    }
    func getDate() -> Date? {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
         dateFormatter.timeZone = TimeZone(abbreviation: "en_US_POSIX")
         let delimiter = "."
         let token = self.components(separatedBy: delimiter)
         let convertedDate = dateFormatter.date(from: token[0])!
         return convertedDate
     }
    func getDateInterval() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy'T'hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
    func getDatee() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
    func getOnlyDate() -> Date? {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
         dateFormatter.timeZone = TimeZone(abbreviation: "en_US_POSIX")
         return dateFormatter.date(from: self)
     }
    func getTimeInterval() -> Date? {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "hh:mm a"
         dateFormatter.timeZone = TimeZone(abbreviation: "en_US_POSIX")
         return dateFormatter.date(from: self)
     }

    func birthDateFormatter(formate: DateFormate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  formate.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "en_US_POSIX")
        let date = dateFormatter.date(from: self)
        let stringDate = dateFormatter.string(from: date ?? Date())
        return stringDate
    }

    func removeFirstZero() -> String {
        if self.first == "0" {
            return String(self.dropFirst())
        } else {
            return self
        }
    }
}
