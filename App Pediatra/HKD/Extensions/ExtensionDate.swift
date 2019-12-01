//
//  ExtensionDate.swift
//  HKD
//
//  Created by Macbook Air on 4/8/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation

extension Date{
    
    func dateFromString(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let someDateTime = formatter.date(from: dateString)
        return someDateTime!
    }
    
    func calcAge(birthdayDate: Date) -> Int{
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let now: NSDate! = NSDate()
        let calcAge = calendar.components(.year, from: birthdayDate, to: now as Date, options: [])
        let age = calcAge.year
        return age!
    }
    
    func calcAgeMonths(birthdayDate: Date) -> Int {
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let now: NSDate! = NSDate()
        let calcAge = calendar.components(.month, from: birthdayDate, to: now as Date, options: [])
        let age = calcAge.month
        return age!
    }
    
    func calcAgeMonthsD(birthdayDate: Date) -> Double {
        let meses: Int = calcAgeMonths(birthdayDate: birthdayDate)
        return Double(meses)
    }
    
    func calcAgeDay(birthdayDate: Date, date: Date) -> Int {
        /*
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let now: NSDate! = NSDate()
        let calcAge = calendar.components(.month, from: birthdayDate, to: now as Date, options: [])
        let age = calcAge.day
 */
        let diffInDays = Calendar.current.dateComponents([.day], from: birthdayDate, to: date).day
        return diffInDays!
    }

    
    
    func toString(format: String) -> String{
        let df = DateFormatter()
        df.dateFormat = format
        let date = df.string(from: self)
        return date
    }
    


}
