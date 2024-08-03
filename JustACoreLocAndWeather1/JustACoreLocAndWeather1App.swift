//
//  JustACoreLocAndWeather1App.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 08/02/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI

@main
struct JustACoreLocAndWeather1App: App 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "JustACoreLocAndWeather1App"
        static let sClsVers      = "v1.0301"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // AppDelegate:
    //     (NOTE: This causes the AppDelegate class to instantiate
    //            - use this ONLY once in an App or it will cause multiple instantiation(s) of AppDelegate...

    @UIApplicationDelegateAdaptor(JustACoreLocAndWeather1AppDelegate.self)
    var appDelegate

    // App Data field(s):

    let sAppBundlePath:String                                   = Bundle.main.bundlePath
    var coreLocationModelObservable:CoreLocationModelObservable = CoreLocationModelObservable()
    
    var body: some Scene
    {
        
        let _ = xcgLogger(sMessage:"\(ClassInfo.sClsDisp):body(some Scene) \(ClassInfo.sClsCopyRight)...")
        let _ = xcgLogger(sMessage:"\(ClassInfo.sClsDisp):body(some Scene) - 'sAppBundlePath' is [\(sAppBundlePath)]...")
        
        WindowGroup 
        {
            
            ContentView(coreLocationModelObservable:coreLocationModelObservable)
                .navigationTitle(AppGlobalInfo.sGlobalInfoAppId)
                .onOpenURL(perform: 
                { url in
                    
                    xcgLogger(sMessage:"\(ClassInfo.sClsDisp):ContentView.onOpenURL() performed for the URL of [\(url)]...")

                })
            
        }
        .handlesExternalEvents(matching: [])
        
    }
    
    func xcgLogger(sMessage:String)
    {

        self.appDelegate.xcgLogger?.info("\(sMessage)")

        return

    }   // End of func xcgLogger().

}

