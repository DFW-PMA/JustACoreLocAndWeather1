//
//  CoreLocationHeadingDetailsView.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 08/11/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI
import CoreLocation

struct CoreLocationHeadingDetailsView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "CoreLocationHeadingDetailsView"
        static let sClsVers      = "v1.0101"
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
    
    @State private var cCoreLocationHeadingDetailsViewRefreshButtonPresses:Int  = 0
    
    var body: some View
    {
        
        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) \(ClassInfo.sClsCopyRight)...")
        
        VStack
        {

            HStack(alignment:.center)           // HStack #1.3
            {
            
                Spacer()

                Button("Refresh - #(\(self.cCoreLocationHeadingDetailsViewRefreshButtonPresses))...")
                {

                    self.cCoreLocationHeadingDetailsViewRefreshButtonPresses += 1

                    self.refreshCoreLocation()

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp)CoreLocationHeadingDetailsView.Button(Xcode).'Refresh'.#(\(self.cCoreLocationHeadingDetailsViewRefreshButtonPresses))...")

                }
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()
                
                Button("Dismiss") 
                {

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):CoreLocationHeadingDetailsView.Button(Xcode).'Dismiss' pressed...")

                    dismiss()

                }
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

            }   // End of HStack #1.1

            Spacer()
            
            Text("Current 'heading' ('headingAvailable?': [\(coreLocationModelObservable.bCLManagerHeadingAvailable)]):")
                .bold()
                .underline(true, color:.black)

            Text("")

            Text("  Heading (True)     : \(String(describing:coreLocationModelObservable.locationManager?.heading?.trueHeading))")
            Text("  Heading (Magnetic) : \(String(describing:coreLocationModelObservable.locationManager?.heading?.magneticHeading))")
            Text("  Heading (TimeStamp): \(String(describing:coreLocationModelObservable.locationManager?.heading?.timestamp))")

            Spacer()

        }
        .padding()
        
        Spacer()
        
    }
    
    func refreshCoreLocation()
    {

        coreLocationModelObservable.requestLocationUpdate()
        
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
    
    CoreLocationHeadingDetailsView(coreLocationModelObservable:CoreLocationModelObservable())
    
}

