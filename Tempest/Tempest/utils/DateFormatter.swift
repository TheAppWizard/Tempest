//
//  DateFormatter.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 04/01/25.
//

import Foundation

extension String {
    func toFormattedDate() -> String? {
        let formatter = DateFormatter()
        
        // Convert the string to a Date object
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: self) {
            // Now format the Date object to the desired format
            formatter.dateFormat = "d MMM yy"
            return formatter.string(from: date)
        }
        return nil
    }
}
