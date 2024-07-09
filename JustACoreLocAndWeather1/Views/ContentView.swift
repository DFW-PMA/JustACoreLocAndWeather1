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
    
    // App Data field(s):
    
    @StateObject var coreLocationModelObservable:CoreLocationModelObservable
    
    var body: some View
    {
        
        Spacer(minLength: 100)
        
        VStack
        {
            
            Image(systemName: "globe.desk.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Spacer(minLength: 10)
            
            Text("Welcome to 'CoreLocation'!")
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
            
        }
        .padding()
        
        Spacer(minLength: 100)
        
    }
    
}

#Preview 
{
    
    ContentView(coreLocationModelObservable:CoreLocationModelObservable())
    
}

