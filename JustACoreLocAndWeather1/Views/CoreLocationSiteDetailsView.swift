//
//  CoreLocationSiteDetailsView.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 08/03/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI
import CoreLocation

struct CoreLocationSiteDetailsView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "CoreLocationSiteDetailsView"
        static let sClsVers      = "v1.0801"
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
    
    @State private var cCoreLocationSiteDetailsViewRefreshButtonPresses:Int  = 0
    
    var body: some View
    {
        
        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) \(ClassInfo.sClsCopyRight)...")
        
        VStack
        {

            HStack(alignment:.center)           // HStack #1.3
            {
            
                Spacer()

                Button("Refresh - #(\(self.cCoreLocationSiteDetailsViewRefreshButtonPresses))...")
                {

                    self.cCoreLocationSiteDetailsViewRefreshButtonPresses += 1

                    self.refreshCoreLocation()

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp)CoreLocationSiteDetailsView.Button(Xcode).'Refresh'.#(\(self.cCoreLocationSiteDetailsViewRefreshButtonPresses))...")

                }
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()
                
                Button("Dismiss") 
                {

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):CoreLocationSiteDetailsView.Button(Xcode).'Dismiss' pressed...")

                    dismiss()

                }
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

            }   // End of HStack #1.1

            Spacer()
            
            Text("Current 'site' (City,Country,TimeZone, etc.):")
                .bold()
                .italic()
                .underline(true, color:.black)
            
            Text("")

            Grid(alignment:.leadingFirstTextBaseline, horizontalSpacing:5, verticalSpacing: 3)
            {

                // Column Headings:

                Divider() 

                GridRow 
                {

                    Text("ItemName")
                    Text("Description")
                    Text("ItemObjValue")

                }
                .font(.title2) 

                Divider() 

                // Item Rows:

                ForEach(coreLocationModelObservable.listCoreLocationSiteItems) 
                { siteItem in

                    GridRow(alignment:.bottom)
                    {

                        Text(siteItem.sCLSiteItemName)
                            .bold()
                        Text(siteItem.sCLSiteItemDesc)
                            .gridColumnAlignment(.center)
                        Text(siteItem.sCLSiteItemValue)

                    }

                }

            }
            
            Spacer()

        }
        .padding()
        
        Spacer()
    //  Spacer(minLength: 10)
        
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
    
    CoreLocationSiteDetailsView(coreLocationModelObservable:CoreLocationModelObservable())
    
}

