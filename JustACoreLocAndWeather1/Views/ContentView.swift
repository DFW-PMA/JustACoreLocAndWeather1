//
//  ContentView.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 07/08/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI

struct ContentView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "ContentView"
        static let sClsVers      = "v1.0202"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):
    
    @StateObject   var coreLocationModelObservable:CoreLocationModelObservable
    
    @State private var cContentViewRefreshButtonPresses:Int = 0
    
    var body: some View
    {
        
        let _ = print("\(ClassInfo.sClsDisp):body(some View) \(ClassInfo.sClsCopyRight)...")
        
        Spacer(minLength: 100)
        
        VStack
        {
            
            Image(systemName: "globe.desk.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Spacer(minLength: 10)
            
            Text("Welcome to the 'JustACoreLocAndWeather1' App!")
                .bold()
            
            Spacer(minLength: 1)
            
            Text("Current 'location':")
                .bold()
                .underline(true, color:.black)
            
            Text("")
            
            Text("  Latitude: \(String(describing: coreLocationModelObservable.locationManager?.location?.coordinate.latitude))")
            
            Text("  Longitude: \(String(describing: coreLocationModelObservable.locationManager?.location?.coordinate.longitude))")
            
            Text("")
            
            Text("Current 'heading':")
                .bold()
                .underline(true, color:.black)
            
            Text("")
            
            Text("  Heading (True): \(String(describing:coreLocationModelObservable.locationManager?.heading?.trueHeading))")
            
            Text("  Heading (Magnetic): \(String(describing:coreLocationModelObservable.locationManager?.heading?.magneticHeading))")
            
            Text("  Heading (TimeStamp): \(String(describing:coreLocationModelObservable.locationManager?.heading?.timestamp))")
            
            Spacer(minLength: 20)

            Button("Refresh - #(\(self.cContentViewRefreshButtonPresses))...")
            {
                
                self.cContentViewRefreshButtonPresses += 1

                self.refreshCoreLocation()
                
                let _ = print("...\(ClassInfo.sClsDisp)ContentView in Button(Xcode).'Refresh'.#(\(self.cContentViewRefreshButtonPresses))...")

            }
            .controlSize(.extraLarge)
            .background(Color(red: 0, green: 0.5, blue: 0.5))
            .foregroundStyle(.white)
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
        }
        .padding()
        
        Spacer(minLength: 100)
        
    }
    
    func refreshCoreLocation()
    {

        coreLocationModelObservable.requestLocationUpdate()

        return

    }   // End of func xcgLoggerMsg().

}

#Preview 
{
    
    ContentView(coreLocationModelObservable:CoreLocationModelObservable())
    
}

