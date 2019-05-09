//
//  ClickCounter.swift
//  dafttap-challange
//
//  Created by Bartosz Cybulski on 10/05/2019.
//  Copyright © 2019 Bartosz Cybulski. All rights reserved.
//

import Foundation

class ClickCounter {
    var click : Int
    let time : Date
    var timeStamp : String {
        get{
            return setUpCurrentDate()
        }
    }
    init(){
        click = 0
        time = Date()
    }
    
    func setUpCurrentDate() -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: time)
        return formattedDate
    }
    
    func increaseClicksByOne() -> Int {
        click += 1
        return click
    }

}
