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
        static let sClsVers      = "v1.0306"
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
        
        Spacer(minLength: 100)
        
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

            //  Image(systemName: "gearshape")
            //      .imageScale(.large)
            //      .foregroundStyle(.tint)

                Spacer()

            }
            
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
            
        //  Spacer()
        //
        //  Text("'JustACoreLocAndWeather1' App information:")
        //      .bold()
        //      .controlSize(.mini)
        //
        //  Text("\(ClassInfo.sClsDisp):body(some View)")
        //      .controlSize(.small)
        //
        //  Text("\(ClassInfo.sClsCopyRight)")
        //      .controlSize(.mini)
        //  
        //  Spacer()
            
        }
        .padding()
        
        Spacer(minLength: 100)
        
    }
    
    func refreshCoreLocation()
    {

        coreLocationModelObservable.requestLocationUpdate()

        return

    }   // End of func refreshCoreLocation().

}

#Preview 
{
    
    ContentView(coreLocationModelObservable:CoreLocationModelObservable())
    
}

