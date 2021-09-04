//
//  String+Extension.swift
//  String+Extension
//
//  Created by cole cabral on 2021-08-29.
//

import Foundation

extension String {
    
    func cityname() -> String {
        let cities = self.components(separatedBy: "/").last ?? ""
        let name = cities.components(separatedBy: "_")
        return "\(name.joined(separator: " "))"
    }
    
    func countryname() -> String {
        let cities = self.components(separatedBy: "/").last ?? ""
        let country = self.components(separatedBy: "/").first ?? ""
        let name = cities.components(separatedBy: "_")
        return "\(name.joined(separator: " ")), \(country)"
    }
    
    func timezone(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        guard let formatter =  DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current) else {return ""}
        if formatter.contains("a") {
            dateFormatter.dateFormat = "h:mm a"
        } else {
            dateFormatter.dateFormat = "HH:mm"
        }
        dateFormatter.timeZone = TimeZone(identifier: self)
        return dateFormatter.string(from: date)
    }
    
    func difference(_ city: String, _ date: Date) -> String {
        let localformatter = DateFormatter()
        localformatter.timeZone = TimeZone(identifier: self)
        let string = localformatter.string(from: date)
        let date = localformatter.date(from: string)!
        
        let cityformatter = DateFormatter()
        cityformatter.timeZone = TimeZone(identifier: city)
        let citystring = cityformatter.string(from: date)
        let citydate = cityformatter.date(from: citystring)!
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour]
        formatter.unitsStyle = .full
        return formatter.string(from: citydate, to: date)!
    }
    
    func containscharacters(_ string: String) -> Bool {
        let characters = CharacterSet(charactersIn: string)
        return self.rangeOfCharacter(from: characters) != nil
    }
    
}
