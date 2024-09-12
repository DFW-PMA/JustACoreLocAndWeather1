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
        static let sClsVers      = "v1.0801"
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

//  @State private var cAppSceneSettingsButtonPresses:Int       = 0
//  @State private var isAppSettingsModal:Bool                  = false
    
    func xcgLogMsg(_ sMessage:String)
    {

        self.appDelegate.xcgLogMsg("\(sMessage)")

        return

    }   // End of func xcgLogMsg().

    var body: some Scene
    {
        
        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) - 'sAppBundlePath' is [\(sAppBundlePath)]...")
        
        WindowGroup 
        {

        //  NavigationStack
        //  {
        //
            ContentView(coreLocationModelObservable:coreLocationModelObservable)
            //  .navigationTitle("App::\(AppGlobalInfo.sGlobalInfoAppId)")
            //  // ------------------------------------------------------------------------------------------------------
            //  // >>> This works (the .toolbar() MUST be under a NavigationStack:
            //  // ------------------------------------------------------------------------------------------------------
            //  .toolbar
            //  {
            //
            //      ToolbarItem(placement:.navigationBarTrailing)
            //      {
            //
            //          Button
            //          {
            //
            //              self.cAppSceneSettingsButtonPresses += 1
            //
            //              xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) in Button(Xcode).'Settings'.#(\(self.cAppSceneSettingsButtonPresses))...")
            //
            //              self.isAppSettingsModal.toggle()
            //
            //          }
            //          label: 
            //          {
            //
            //              Label("", systemImage: "gearshape")
            //                  .padding()
            //                  .imageScale(.large)
            //                  .foregroundStyle(.tint)
            //
            //          }
            //          .sheet(isPresented:$isAppSettingsModal, content:
            //              {
            //
            //                  SettingsSingleView()
            //
            //              }
            //          )
            //
            //      }
            //
            //  }
                .onOpenURL(perform: 
                { url in
                    
                    xcgLogMsg("\(ClassInfo.sClsDisp):ContentView.onOpenURL() performed for the URL of [\(url)]...")

                })
        //
        //  }
            
        }
        .handlesExternalEvents(matching: [])
        
    }
    
}

#Preview 
{
    
    ContentView(coreLocationModelObservable:CoreLocationModelObservable())
    
}


