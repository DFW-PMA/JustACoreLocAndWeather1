//
//  JustACoreLocation1App.swift
//  JustACoreLocation1
//
//  Created by Daryl Cox on 7/7/24.
//

import SwiftUI

@main
struct JustACoreLocation1App: App 
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

