//
//  NSDateExtended.swift
//  DesafioSwift
//
//  Created by Rodrigo Kapobel on 21/2/17.
//  Copyright © 2017 Rodrigo Kapobel. All rights reserved.
//

import UIKit

extension Date {
    /**
     Devuelve una fecha con formato dd/MM/YYYY - HH:mm en zona horaria UTC para el valor utc ingresado
    */
    func getDateString(fromUtc utc: Double) -> String! {
        let date = Date(timeIntervalSince1970: TimeInterval(utc))
        let dateFormatter = DateFormatter()
        let timeZone: TimeZone = TimeZone(abbreviation: "UTC")!
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "dd/MM/YYYY - HH:mm"
        return dateFormatter.string(from: date as Date)
    }
    
    /**
     Dado un valor UTC calcula la información de la fecha en formato amigable: 
     
     hace tantas horas
     
     hace tantos días
     
     hace tantos años
    */
    func getFriedlyTime(fromUtc utc: Double) -> String {
        
        let dateUtc: Date = Date(timeIntervalSince1970: TimeInterval(utc))
        
        var timeText: String = "hace "
        
        let hoursSinceUtc: Double = Date().timeIntervalSince(dateUtc)/3600.0
        
        let daysInMonthRng: NSRange = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)!.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: Date())
        
        let daysInMonth: Double = Double(daysInMonthRng.length)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        var daysInYear: Double = 0
        
        let yearStr: String = dateFormatter.string(from: dateUtc)
        
        let yearInt: Int = Int(yearStr)!
        
        if yearInt % 400 == 0  {
            daysInYear = 366;
        } // Leap Year
        else if yearInt % 100 == 0 {
            daysInYear = 365; // Non Leap Year
        }
        else if yearInt % 4 == 0 {
            daysInYear = 366; // Leap Year
        }
        else { // Non-Leap Year
            daysInYear = 365;
        }
        
        if hoursSinceUtc >= daysInYear*24.0 {
            if hoursSinceUtc < daysInYear*24*2.0 {
                timeText = timeText.appending("un año")
            }else {
                timeText =  timeText.appending("\(hoursSinceUtc/(daysInYear*24)) años")
            }
        }else if hoursSinceUtc >= daysInMonth*24.0 {
            if hoursSinceUtc < daysInMonth*24*2.0 {
                timeText =  timeText.appending("un mes")
            }else {
                timeText =  timeText.appending("\(hoursSinceUtc/(daysInYear*24)) meses")
            }
        }else if hoursSinceUtc >= 24.0 {
            if hoursSinceUtc < 48.0 {
                timeText =  timeText.appending("un día")
            }else {
                timeText =  timeText.appending("\(hoursSinceUtc/(daysInYear*24)) días")
            }
        }else {
            timeText = timeText.appending("\(Int(hoursSinceUtc)) horas")
        }

        return timeText
    }
}
