//
//  File.swift
//  
//
//  Created by Jacob Davis on 3/20/20.
//

import Foundation

extension Date {
        
    static func dateFromAction(timeStamp: String?, tz: Bool = true) -> Date? {
        
        guard let timeStamp = timeStamp else {
            return nil
        }
        
        //"2018-06-11T22:11:42.500"
        let dateFormatter = DateFormatter()
        if tz {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        }
        return dateFormatter.date(from: timeStamp)
        
    }
    
}