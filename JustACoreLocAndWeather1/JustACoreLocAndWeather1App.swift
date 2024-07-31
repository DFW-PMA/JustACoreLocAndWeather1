//
//  JustACoreLocAndWeather1App.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 07/08/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI

@main
struct JustACoreLocAndWeather1App: App 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "JustACoreLocAndWeather1App"
        static let sClsVers      = "v1.0202"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):
    
    var coreLocationModelObservable:CoreLocationModelObservable = CoreLocationModelObservable()
    
    var body: some Scene
    {
        
        let _ = print("\(ClassInfo.sClsDisp):body(some Scene) \(ClassInfo.sClsCopyRight)...")
        
        WindowGroup 
        {
            
            ContentView(coreLocationModelObservable:coreLocationModelObservable)
            
        }
        
    }
    
}

