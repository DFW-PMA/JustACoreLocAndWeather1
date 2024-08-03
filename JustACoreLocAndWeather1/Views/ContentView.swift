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
        static let sClsVers      = "v1.0401"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):
    
    @StateObject   var coreLocationModelObservable:CoreLocationModelObservable
    
    @State private var cContentViewRefreshButtonPresses:Int  = 0
    @State private var cContentViewSettingsButtonPresses:Int = 0
    @State private var isAppSettingsModal:Bool               = false
    
    var body: some View
    {
        
        let _ = print("\(ClassInfo.sClsDisp):body(some View) \(ClassInfo.sClsCopyRight)...")
        
        Spacer(minLength: 50)
        
        VStack
        {

            HStack
            {

                Spacer()

            //  Button("Settings...")
                Button
                {

                    self.cContentViewSettingsButtonPresses += 1

                    let _ = print("...\(ClassInfo.sClsDisp)ContentView in Button(Xcode).'Settings'.#(\(self.cContentViewSettingsButtonPresses))...")

                    self.isAppSettingsModal.toggle()

                }
                label: 
                {

                    Label("", systemImage: "gearshape")
                        .padding()
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    //  .foregroundStyle(.black)
                    //  .background(.white)

                }
                .sheet(isPresented:$isAppSettingsModal, content:
                {

                    SettingsSingleView()

                })

            //  Button
            //  {
            //
            //      self.cContentViewSettingsButtonPresses += 1
            //
            //      self.refreshCoreLocation()
            //
            //      let _ = print("...\(ClassInfo.sClsDisp)ContentView in Button(Xcode).'Settings'.#(\(self.cContentViewSettingsButtonPresses))...")
            //
            //  }  
            //  label: 
            //  {
            //
            //  //  Label("Settings - #(\(self.cContentViewSettingsButtonPresses))...", systemImage: "gearshape")
            //      Label("", systemImage: "gearshape")
            //          .padding()
            //          .foregroundStyle(.black)
            //          .background(.white)
            //
            //  }

            }
            
            Spacer()
            
            HStack
            {

                Spacer()

                Image(systemName: "globe.desk.fill")
                    .imageScale(.large)
                    .foregroundStyle(.tint)

                Spacer()

            }
            
            Spacer(minLength: 2)
            
            Text("Welcome to the 'JustACoreLocAndWeather1' App!")
                .bold()

            Spacer(minLength: 2)
            
            Text("Current 'location (Latitude/Longitude)':")
                .bold()
                .underline(true, color:.black)
            
            Text("")
            
            Text("  Latitude : \(String(describing: coreLocationModelObservable.locationManager?.location?.coordinate.latitude))")
            Text("  Longitude: \(String(describing: coreLocationModelObservable.locationManager?.location?.coordinate.longitude))")
            
            Text("")
            
            Text("Current 'heading':")
                .bold()
                .underline(true, color:.black)
            
            Text("")
            
            Text("  Heading (True)     : \(String(describing:coreLocationModelObservable.locationManager?.heading?.trueHeading))")
            Text("  Heading (Magnetic) : \(String(describing:coreLocationModelObservable.locationManager?.heading?.magneticHeading))")
            Text("  Heading (TimeStamp): \(String(describing:coreLocationModelObservable.locationManager?.heading?.timestamp))")

            Text("")
            
            Text("Current 'site' (City,Country,TimeZone, etc.):")
                .bold()
                .underline(true, color:.black)
            
            Text("")
            
            Text("  Location (Lat/Long)    : \(String(describing:coreLocationModelObservable.sCurrentLocation))")
            Text("  Location 'Name'        : \(String(describing:coreLocationModelObservable.sCurrentLocationName))")
            Text("  City                   : \(String(describing:coreLocationModelObservable.sCurrentCity))")
            Text("  Country                : \(String(describing:coreLocationModelObservable.sCurrentCountry))")
            Text("  Postal Code            : \(String(describing:coreLocationModelObservable.sCurrentPostalCode))")
            Text("  TimeZone               : \(String(describing:coreLocationModelObservable.tzCurrentTimeZone))")
            Text("  Region                 : \(String(describing:coreLocationModelObservable.clCurrentRegion))")
            Text("  SUB Locality           : \(String(describing:coreLocationModelObservable.sCurrentSubLocality))")
            Text("  Thorough Fare          : \(String(describing:coreLocationModelObservable.sCurrentThoroughfare))")
            Text("  SUB Thorough Fare      : \(String(describing:coreLocationModelObservable.sCurrentSubThoroughfare))")
            Text("  Administrative Area    : \(String(describing:coreLocationModelObservable.sCurrentAdministrativeArea))")
            Text("  SUB Administrative Area: \(String(describing:coreLocationModelObservable.sCurrentSubAdministrativeArea))")
            
            Spacer(minLength: 5)

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
            
            HStack(alignment:.center)
            {
                
                Spacer()
                
                VStack(alignment:.center)
                {
                    
                    Text("'JustACoreLocAndWeather1' App information:")
                        .bold()
                        .controlSize(.regular)

                    Text("\(ClassInfo.sClsDisp):body(some View)")
                        .italic()
                        .controlSize(.mini)

                    Text("\(ClassInfo.sClsCopyRight)")
                        .italic()
                        .controlSize(.mini)
                    
                }
                
                Spacer()
                
            }

            Spacer()
            
        }
        .padding()
        
        Spacer(minLength: 100)
        
    }
    
    func refreshCoreLocation()
    {

        coreLocationModelObservable.requestLocationUpdate()
        
        let currLatitude:Double = coreLocationModelObservable.locationManager?.location?.coordinate.latitude ?? 0.0
        let currLongitude:Double = coreLocationModelObservable.locationManager?.location?.coordinate.longitude ?? 0.0

        let _ = coreLocationModelObservable.updateGeocoderLocation(latitude:  currLatitude,
                                                                   longitude: currLongitude)

        return

    }   // End of func refreshCoreLocation().

}

#Preview 
{
    
    ContentView(coreLocationModelObservable:CoreLocationModelObservable())
    
}

