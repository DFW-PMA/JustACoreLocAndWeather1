//
//  ContentView.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 07/08/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI
import CoreLocation

struct ContentView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "ContentView"
        static let sClsVers      = "v1.0701"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // AppDelegate (via @EnvironmentObject - automatic via the App's @NSApplicationDelegateAdaptor property wrapper

    @EnvironmentObject private var appDelegate:JustACoreLocAndWeather1AppDelegate

    // App Data field(s):
    
    @StateObject   var coreLocationModelObservable:CoreLocationModelObservable
    
    @State private var cContentViewRefreshButtonPresses:Int     = 0
    @State private var cContentViewSettingsButtonPresses:Int    = 0
    @State private var cContentViewSiteDetailsButtonPresses:Int = 0

    @State private var isAppSettingsModal:Bool                  = false
    @State private var isAppSiteDetailsViewModal:Bool           = false
    
    var body: some View
    {
        
        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) \(ClassInfo.sClsCopyRight)...")
        
        Spacer(minLength: 10)
        
        VStack
        {

            HStack
            {
          
                Spacer()
          
                Button
                {
          
                    self.cContentViewSettingsButtonPresses += 1
          
                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp)ContentView in Button(Xcode).'Settings'.#(\(self.cContentViewSettingsButtonPresses))...")
          
                    self.isAppSettingsModal.toggle()
          
                }
                label: 
                {
          
                    Label("", systemImage: "gearshape")
                        .padding()
                        .imageScale(.large)
                        .foregroundStyle(.tint)
          
                }
                .sheet(isPresented:$isAppSettingsModal, content:
                    {
          
                        SettingsSingleView()
          
                    }
                )
                .padding()
          
            }
            
            Spacer()
            
            HStack
            {

                Spacer()

            if #available(iOS 17.0, *)
            {

                Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal)
                        { size, axis in
                            size * 0.05
                        }

            }
            else
            {

                Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                    .resizable()
                    .scaledToFit()
                    .frame(width:25, height: 25, alignment:.center)

            }

                Spacer()

            }
            
            Spacer(minLength: 1)
            
            Text("Welcome to the '\(AppGlobalInfo.sGlobalInfoAppId)' App!")
                .bold()

            Spacer(minLength: 1)
            
            Text("Current 'location (Latitude/Longitude)':")
                .bold()
                .underline(true, color:.black)
            
            Text("")
            
            Text("  Latitude : \(String(describing: coreLocationModelObservable.locationManager?.location?.coordinate.latitude))")
            Text("  Longitude: \(String(describing: coreLocationModelObservable.locationManager?.location?.coordinate.longitude))")
            
            Text("")
            
            Text("Current 'heading' ('headingAvailable?': [\(coreLocationModelObservable.bCLManagerHeadingAvailable)]):")
                .bold()
                .underline(true, color:.black)
            
            Text("")
            
            Text("  Heading (True)     : \(String(describing:coreLocationModelObservable.locationManager?.heading?.trueHeading))")
            Text("  Heading (Magnetic) : \(String(describing:coreLocationModelObservable.locationManager?.heading?.magneticHeading))")
            Text("  Heading (TimeStamp): \(String(describing:coreLocationModelObservable.locationManager?.heading?.timestamp))")

            Spacer(minLength: 1)
            
            HStack
            {

                Spacer()

                Button
                {

                    self.cContentViewSiteDetailsButtonPresses += 1

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp)ContentView in Button(Xcode).'Site Detail(s)'.#(\(self.cContentViewSiteDetailsButtonPresses))...")

                    self.isAppSiteDetailsViewModal.toggle()

                }
                label: 
                {
                    
                    Text("Site Detail(s)")

                }
                .sheet(isPresented:$isAppSiteDetailsViewModal, content:
                    {

                        CoreLocationSiteDetailsView(coreLocationModelObservable:coreLocationModelObservable)

                    }
                )
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()

                Button("Refresh - #(\(self.cContentViewRefreshButtonPresses))...")
                {

                    self.cContentViewRefreshButtonPresses += 1

                    self.refreshCoreLocation()

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp)ContentView in Button(Xcode).'Refresh'.#(\(self.cContentViewRefreshButtonPresses))...")

                }
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()

            }

            Spacer(minLength: 5)

            Spacer()
            
            HStack(alignment:.center)
            {
                
                Spacer()
                
                VStack(alignment:.center)
                {
                    
                    Text("\(ClassInfo.sClsCopyRight)")
                        .italic()
                        .controlSize(.mini)
                    
                }
                
                Spacer()
                
            }

            Spacer()
            
        }
    // ------------------------------------------------------------------------------------------------------
    // >>> This didn't work:
    //  .toolbar
    //  {
    //
    //      Button
    //      {
    //      
    //          self.cContentViewSettingsButtonPresses += 1
    //      
    //          let _ = xcgLogMsg("\(ClassInfo.sClsDisp)ContentView in Button(Xcode).'Settings'.#(\(self.cContentViewSettingsButtonPresses))...")
    //      
    //          self.isAppSettingsModal.toggle()
    //      
    //      }
    //      label: 
    //      {
    //      
    //          Label("", systemImage: "gearshape")
    //              .padding()
    //              .imageScale(.large)
    //              .foregroundStyle(.tint)
    //      
    //      }
    //      .sheet(isPresented:$isAppSettingsModal, content:
    //          {
    //      
    //              SettingsSingleView()
    //      
    //          }
    //      )
    //
    //  }
    // ------------------------------------------------------------------------------------------------------
        .padding()
        
        Spacer(minLength: 100)
        
    }
    
    func refreshCoreLocation()
    {

        coreLocationModelObservable.requestLocationUpdate()
        
        let currLatitude:Double  = coreLocationModelObservable.locationManager?.location?.coordinate.latitude ?? 0.0
        let currLongitude:Double = coreLocationModelObservable.locationManager?.location?.coordinate.longitude ?? 0.0

        let _ = coreLocationModelObservable.updateGeocoderLocation(latitude:  currLatitude,
                                                                   longitude: currLongitude)

        return

    }   // End of func refreshCoreLocation().
    
    func xcgLogMsg(_ sMessage:String)
    {

        self.appDelegate.xcgLogger?.info("\(sMessage)")

        return

    }   // End of func xcgLogMsg().

}

#Preview 
{
    
    ContentView(coreLocationModelObservable:CoreLocationModelObservable())
    
}

