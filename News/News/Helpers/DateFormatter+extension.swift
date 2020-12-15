//
//  DateFormatter+extension.swift
//  News
//
//  Created by hager gamal on 12/14/20.
//

import UIKit


extension DateFormatter {
    enum Formats: String {
        case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
        case yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        case yyyyMMddTHHmmssSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
        case yyyyMMddhhmma = "yyyy-MM-dd hh:mm a"
        case yyyyMMddhhmmss = "yyyy-MM-dd HH:mm:ss"
        case yyyyMMdd = "yyyy-MM-dd"
        case dMMM = "d MMM"
        case MMMM = "MMMM"
        case MMM = "MMM"
        case HHmmss = "HH:mm:ss"
        case HHmm = "HH:mm"
        case hhmma = "hh:mm a"
        case ddMMMyyyy = "dd MMM. yyyy"
        case ddmmyyyy = "dd/MM/yyyy"
        case MMDDYY = "MM-dd-yyyy"
        case EEEEdMMMyyyy = "EEEE d MMM yyyy"
        case ddmmyyyyHHmmss = "dd/MM/yyyy HH:mm:ss"
        case dMMMyyyy = "d MMM yyyy"
        case dMMMyyy2 = "d MMM, yyyy"
        case MMMdyyy = "MMM d, yyyy"
        case MMddyyyy = "MM/dd/yyyy"
        case dMMMMyyy = "d MMMM yyyy"
    }

    func string(fromDate date: Date, withFormate format: Formats, local: Locale? = nil) -> String {
        self.dateFormat = format.rawValue
        self.locale = local ??  Locale(identifier:"en")
        return string(from: date)
    }

    func date(fromString string: String, withFormat format: Formats) -> Date? {
        self.dateFormat = format.rawValue
        return date(from: string)
    }
    
     func getPublishedDateWithServiceFormat(date: Date) -> String {
        let dateStr = self.string(fromDate: date, withFormate: DateFormatter.Formats.yyyyMMddhhmma, local: Locale(identifier: "en"))
        return dateStr
    }
}

