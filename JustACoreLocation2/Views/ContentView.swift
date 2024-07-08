//
//  ContentView.swift
//  JustACoreLocation1
//
//  Created by Daryl Cox on 7/7/24.
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
            
            Spacer(minLength: 20)
            
            Text("Welcome to 'CoreLocation'!")
            
            Spacer(minLength: 20)
            
            Text("Current 'location':")
            
            Text("  Latitude: \(String(describing: coreLocationModelObservable.locationManager?.location?.coordinate.latitude))")
            
            Text("  Longitude: \(String(describing: coreLocationModelObservable.locationManager?.location?.coordinate.longitude))")
            
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

