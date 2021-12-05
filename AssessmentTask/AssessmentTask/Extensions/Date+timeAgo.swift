//
//  ViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation

extension Date {
    func getDayName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: self)
        return dayInWeek
    }
    func getOnlyDate() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    func getFullMonthDate() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        formatter.dateFormat = "MMMM dd, yyyy"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    func getFullDayDate() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        formatter.dateFormat = "dd MMM"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    func getTimeDate() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        formatter.dateFormat = "yyyy-MM-dd, hh:mm a"// "1997-06-14T15:11:36.714Z"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    func getTimeDateWithAnotherFormate() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        formatter.dateFormat = "dd MMM yyyy, hh:mm a"// "1997-06-14T15:11:36.714Z"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    func getOnlyTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        formatter.dateFormat = "HH:mm:ss"// "1997-06-14T15:11:36.714Z"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    func getOnlyTimeWithoutSecond() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        formatter.dateFormat = "hh:mm a"// "1997-06-14T15:11:36.714Z"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    func timeAgoSinceDate() -> String {
        let fromDate = self
        let toDate = Date()
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }
        return "a moment ago"
    }
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter
    }()
    static let yearMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    static let dayMedium: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd"
           return formatter
       }()
    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter
    }()
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }()
}
extension Date {
    var day: String { return Formatter.dayMedium.string(from: self) }
    var monthMedium: String { return Formatter.monthMedium.string(from: self) }
    var yearMedium: String { return Formatter.yearMedium.string(from: self) }
    var hour12: String { return Formatter.hour12.string(from: self) }
    var minute0x: String { return Formatter.minute0x.string(from: self) }
    var amPM: String { return Formatter.amPM.string(from: self) }
}
