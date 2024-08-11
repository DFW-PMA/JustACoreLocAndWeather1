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
        static let sClsVers      = "v1.0901"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // AppDelegate (via @EnvironmentObject - automatic via the App's @NSApplicationDelegateAdaptor property wrapper

    @EnvironmentObject private var appDelegate:JustACoreLocAndWeather1AppDelegate

    // App Data field(s):
    
    @StateObject   var coreLocationModelObservable:CoreLocationModelObservable
    
    @State private var cContentViewRefreshButtonPresses:Int        = 0
    @State private var cContentViewSiteDetailsButtonPresses:Int    = 0
    @State private var cContentViewHeadingDetailsButtonPresses:Int = 0

    @State private var isAppSiteDetailsViewModal:Bool              = false
    @State private var isAppHeadingDetailsViewModal:Bool           = false
    
    var body: some View
    {
        
        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) \(ClassInfo.sClsCopyRight)...")

        NavigationStack
        {

            Spacer()

            VStack(alignment:.center) 
            {
                
                Spacer()

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

                    Button
                    {

                        self.cContentViewHeadingDetailsButtonPresses += 1

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp)ContentView in Button(Xcode).'Heading Detail(s)'.#(\(self.cContentViewHeadingDetailsButtonPresses))...")

                        self.isAppHeadingDetailsViewModal.toggle()

                    }
                    label: 
                    {

                        Text("Heading Detail(s)")

                    }
                    .sheet(isPresented:$isAppHeadingDetailsViewModal, content:
                        {

                            CoreLocationHeadingDetailsView(coreLocationModelObservable:coreLocationModelObservable)

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

                Spacer()
                
                HStack(alignment:.center)
                {

                    Spacer()

                if #available(iOS 17.0, *)
                {

                    Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal)
                            { size, axis in
                                size * 0.10
                            }

                }
                else
                {

                    Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                        .resizable()
                        .scaledToFit()
                        .frame(width:50, height: 50, alignment:.center)

                }

                    Spacer()

                }
                
                Spacer(minLength: 10)
                
                Text("Welcome to the '\(AppGlobalInfo.sGlobalInfoAppId)' App!")
                    .bold()

                Spacer(minLength: 5)
                
                Text("Current 'location (Latitude/Longitude)':")
                    .bold()
                    .underline(true, color:.black)
                
                Text("")
                
                Text("  Latitude : \(String(describing: coreLocationModelObservable.locationManager?.location?.coordinate.latitude))")
                Text("  Longitude: \(String(describing: coreLocationModelObservable.locationManager?.location?.coordinate.longitude))")
                
            //  Text("")
            //  
            //  Spacer(minLength: 5)
            //
            //  Text("Current 'heading' ('headingAvailable?': [\(coreLocationModelObservable.bCLManagerHeadingAvailable)]):")
            //      .bold()
            //      .underline(true, color:.black)
            //  
            //  Text("")
            //  
            //  Text("  Heading (True)     : \(String(describing:coreLocationModelObservable.locationManager?.heading?.trueHeading))")
            //  Text("  Heading (Magnetic) : \(String(describing:coreLocationModelObservable.locationManager?.heading?.magneticHeading))")
            //  Text("  Heading (TimeStamp): \(String(describing:coreLocationModelObservable.locationManager?.heading?.timestamp))")

                Spacer()
                
                HStack(alignment:.center)
                {
                    
                    Spacer()
                    
                    VStack(alignment:.center)
                    {
                        
                    //  Text("\(ClassInfo.sClsCopyRight)")
                        Text("\(getAppCopyright())")
                            .italic()
                            .controlSize(.mini)
                        
                    }
                    
                    Spacer()
                    
                }

            }
            .navigationTitle("App::\(AppGlobalInfo.sGlobalInfoAppId)")
            // ------------------------------------------------------------------------------------------------------
            // >>> This does work (the .toolbar() MUST be under a NavigationStack:
            // ------------------------------------------------------------------------------------------------------
            .toolbar
            {

                ToolbarItem(placement:.navigationBarTrailing)
                {

                    NavigationLink(destination: presentSettingsSingleView())
                    {

                        Image(systemName: "gearshape.fill")

                    }
                                                                                                                                                 
                }
          
            }

        }
        
    }

    func presentSettingsSingleView() -> some View
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        self.xcgLogMsg("\(ClassInfo.sClsDisp)ContentView called by ToolbarItem.NavigationLink(Xcode).'Settings'...")
        
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return SettingsSingleView()

    }   // End of func presentSettingsSingleView().
    
    func refreshCoreLocation()
    {

        coreLocationModelObservable.requestLocationUpdate()
        
        let currLatitude:Double  = coreLocationModelObservable.locationManager?.location?.coordinate.latitude ?? 0.0
        let currLongitude:Double = coreLocationModelObservable.locationManager?.location?.coordinate.longitude ?? 0.0

        let _ = coreLocationModelObservable.updateGeocoderLocation(latitude:  currLatitude,
                                                                   longitude: currLongitude)

        return

    }   // End of func refreshCoreLocation().
    
    func getAppCopyright() -> String 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        let sAppCopyRight:String = (Bundle.main.infoDictionary?["NSHumanReadableCopyright"] as? String) ?? "-N/A-"

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sAppCopyRight' is [\(sAppCopyRight)]...")

        return sAppCopyRight

    }   // End of func getAppCopyright().

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

