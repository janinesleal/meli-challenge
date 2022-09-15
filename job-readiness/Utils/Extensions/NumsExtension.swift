//
//  NumsExtension.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 15/09/22.
//

import Foundation

extension Double {
   
    func toBRL() -> String {
        let stringNum = "\(self)"
        var toArray = stringNum.components(separatedBy: ".")
        
        if toArray[1].count == 1 {
            toArray[1].append("0")
        }
        let brl = "R$"
        let brlPrice = brl + toArray.joined(separator: ",")
   
        return brlPrice
    }
}
