//
//  ConverterService.swift
//  InterviewApp
//
//  Created by Valya on 23.05.22.
//

import UIKit

class ConverterService {
    
    static func dateConvertToString(date: Date) -> String? {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        if let year = components.year,
           let month = components.month,
           let day = components.day,
           let hour = components.hour,
           let minute = components.minute {
                return "\(day).\(month).\(year).\(hour).\(minute)"
        }
        return nil
    }
    
    static func stringConvertToDate(_ date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
        return dateFormatter.date(from: date)!
    }
    
    static func convertStringDateForCalendar(_ date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
        let dateToConvert = dateFormatter.date(from: date)!
        let components = Calendar.current.dateComponents([.year, .month, .day], from: dateToConvert)
        if let year = components.year,
           let month = components.month,
           let day = components.day {
                return "\(day).\(month).\(year)"
        }
        return nil
    }
    
    static func convertDateForCalendar(_ date: Date) -> String? {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        if let year = components.year,
           let month = components.month,
           let day = components.day {
                return "\(day).\(month).\(year)"
        }
        return nil
    }
    
    static func dateForTableView(_ date: String) -> String {
        let dateComponets = date.components(separatedBy: ".")
        let day = dateComponets[0]
        let month = dateComponets[1]
        let year = dateComponets[2]
        let hour = dateComponets[3]
        let minute = dateComponets[4]
        let date = day + "." + month + "." + year + " at " + hour + ":" + minute
        return date
    }
    
}
