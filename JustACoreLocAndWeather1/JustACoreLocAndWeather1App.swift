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
    
    var coreLocationModelObservable:CoreLocationModelObservable = CoreLocationModelObservable()
    
    var body: some Scene
    {
        
        WindowGroup 
        {
            
            ContentView(coreLocationModelObservable:coreLocationModelObservable)
            
        }
        
    }
    
}

