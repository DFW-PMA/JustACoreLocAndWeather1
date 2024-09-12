//
//  CoreLocationWeatherDetailsView.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 09/02/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI
import CoreLocation

struct CoreLocationWeatherDetailsView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "CoreLocationWeatherDetailsView"
        static let sClsVers      = "v1.0201"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // AppDelegate (via @EnvironmentObject - automatic via the App's @NSApplicationDelegateAdaptor property wrapper

    @EnvironmentObject private var appDelegate:JustACoreLocAndWeather1AppDelegate

    // App Data field(s):
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject   var coreLocationModelObservable:CoreLocationModelObservable
    
    @State private var cCoreLocationWeatherDetailsViewRefreshButtonPresses:Int  = 0

    var nwsWeatherProcessor:NWSWeatherProcessor                                 = NWSWeatherProcessor()
//  var nwsWeatherCollection:NWSWeatherCollection                               = NWSWeatherCollection()
    
    var body: some View
    {
        
        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View)...")
        
        VStack
        {

            HStack(alignment:.center)           // HStack #1.3
            {
            
                Spacer()

                Button("Refresh - #(\(self.cCoreLocationWeatherDetailsViewRefreshButtonPresses))...")
                {

                    self.cCoreLocationWeatherDetailsViewRefreshButtonPresses += 1

                    self.refreshNWSWeather()

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp)CoreLocationWeatherDetailsView.Button(Xcode).'Refresh'.#(\(self.cCoreLocationWeatherDetailsViewRefreshButtonPresses))...")

                }
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()
                
                Button("Dismiss") 
                {

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):CoreLocationWeatherDetailsView.Button(Xcode).'Dismiss' pressed...")

                    dismiss()

                }
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

            }   // End of HStack #1.1

            Spacer()
            
            Text("Current NWS 'weather':")
                .bold()
                .underline(true, color:.black)

            Text("")

            Text("...coming soon...")

        //  Text("  Weather (True)     : \(String(describing:coreLocationModelObservable.locationManager?.heading?.trueWeather))")
        //  Text("  Weather (Magnetic) : \(String(describing:coreLocationModelObservable.locationManager?.heading?.magneticWeather))")
        //  Text("  Weather (TimeStamp): \(String(describing:coreLocationModelObservable.locationManager?.heading?.timestamp))")

            Spacer()

        }
        .padding()
        
        Spacer()
        
    }
    
    func refreshNWSWeather()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        let restURLEndpoint:RestURLEndpoint?     = RestURLEndpoint(name:         "NWSWeatherAPI", 
                                                                   active:       true, 
                                                                   httpProtocol: "https", 
                                                                   httpHost:     "api.weather.gov", 
                                                                   httpPort:     nil, 
                                                                   user:         "", 
                                                                   password:     "")

        self.nwsWeatherProcessor.restURLEndpoint = restURLEndpoint

        self.nwsWeatherProcessor.currLatitude    = coreLocationModelObservable.locationManager?.location?.coordinate.latitude ?? 0.0
        self.nwsWeatherProcessor.currLongitude   = coreLocationModelObservable.locationManager?.location?.coordinate.longitude ?? 0.0

        let nwsWeatherItem:NWSWeatherItem?       = self.nwsWeatherProcessor.getCurrentNWSWeatherViaRestAPIItem()

    //  if (nwsWeatherItem != nil) 
    //  {
    //
    //      let _ = self.nwsWeatherCollection.insertNewNWSWeatherItem(nwsWeatherItem: nwsWeatherItem!, at: 0)
    //
    //      self.xcgLogMsg("\(sCurrMethodDisp) Returned 'nwsWeatherItem' was [\(String(describing: nwsWeatherItem))]...")
    //
    //  }
        
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of func refreshNWSWeather().
    
    func xcgLogMsg(_ sMessage:String)
    {

        self.appDelegate.xcgLogger?.info("\(sMessage)")

        return

    }   // End of func xcgLogMsg().

}

#Preview 
{
    
    CoreLocationWeatherDetailsView(coreLocationModelObservable:CoreLocationModelObservable())
    
}

