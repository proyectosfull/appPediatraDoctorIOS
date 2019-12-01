//
//  CVSReader.swift
//  HKD
//
//  Created by Macbook Air on 4/4/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation

class CSVReader {
    
    func dataFromColumn(fileName: String,column: Int)->[String]{
        var result:[String] = []
        do {
            let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "csv")!
            var file = try String(contentsOf: fileUrl, encoding: .utf8)
            file = file.replacingOccurrences(of: "\r", with: "\n")
            file = file.replacingOccurrences(of: "\n\n", with: "\n")
            let rows = file.components(separatedBy: .newlines)
            
            for index in 0...rows.count-2{
                //let fields = row.replacingOccurrences(of: "\"", with: "").components(separatedBy: ",")
                let fields = rows[index].components(separatedBy: ",")
                result.append(fields[column])
            }
            /*
            for row in rows {
                //let fields = row.replacingOccurrences(of: "\"", with: "").components(separatedBy: ",")
                let fields = row.components(separatedBy: ",")
                result.append(fields[column])
            }
 */
        } catch {
            print(error)
        }
        if(!result.isEmpty){
            result.remove(at: 0)
        }
        print(result)
        return result
    }
    
    func stringArrayToDouble( stringArray: [String]) -> [Double] {
        let doubleArray = stringArray.map { Double($0)!}
        return doubleArray
    }
    
}
