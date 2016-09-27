//
//  GameCenter.swift
//  challengeTV
//
//  Created by Amanda Campos on 09/06/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit
import GameKit

class GameCenter {
    
    func Conquista(){
            let gg = GKAchievement(identifier: "testeC")
        gg.percentComplete = 100
        
        GKAchievement.report([gg], withCompletionHandler: { (error) -> Void in
            print("Hello, its reported.")
        })
    }
    
}
