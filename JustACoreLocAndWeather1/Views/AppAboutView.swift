//
//  AppAboutView.swift
//  JustACoreLocAndWeather1
//
//  Created by JustMacApps.net on 08/05/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

import Foundation
import SwiftUI

struct AppAboutView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId          = "AppAboutView"
        static let sClsVers        = "v1.0101"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // AppDelegate (via @EnvironmentObject - automatic via the App's @NSApplicationDelegateAdaptor property wrapper

    @EnvironmentObject private var appDelegate:JustACoreLocAndWeather1AppDelegate

    // App Data field(s):

    @Environment(\.dismiss) var dismiss
    
    var body: some View 
    {
        
        Spacer()
        
        VStack
        {

            Divider()
            
            HStack
            {
                
                Text("App About...")
                
            }

            Divider()

        }
        .padding()
    //  .frame(minWidth: 100, idealWidth: 200, maxWidth: 300, minHeight: 50, idealHeight: 100, maxHeight: 300)
        
        Spacer()
        
        HStack(alignment:.center)           // HStack #1.3
        {

            Spacer()

        //  Button("Refresh - #(\(self.cCoreLocationSiteDetailsViewRefreshButtonPresses))...")
        //  {
        //
        //      self.cCoreLocationSiteDetailsViewRefreshButtonPresses += 1
        //
        //      self.refreshCoreLocation()
        //
        //      let _ = xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)AppAboutView.Button(Xcode).'Refresh'.#(\(self.cCoreLocationSiteDetailsViewRefreshButtonPresses))...")
        //
        //  }
        //  .controlSize(.extraLarge)
        //  .background(Color(red: 0, green: 0.5, blue: 0.5))
        //  .foregroundStyle(.white)
        //  .buttonStyle(.borderedProminent)
        //
        //  Spacer()

            Button("Dismiss") 
            {

                let _ = xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp):AppAboutView.Button(Xcode).'Dismiss' pressed...")

                dismiss()

            }
            .controlSize(.extraLarge)
            .background(Color(red: 0, green: 0.5, blue: 0.5))
            .foregroundStyle(.white)
            .buttonStyle(.borderedProminent)

            Spacer()

        }   // End of HStack #1.1

        Spacer()

    }
    
    func xcgLoggerMsg(sMessage:String)
    {

        self.appDelegate.xcgLogger?.info("\(sMessage)")

        return

    }   // End of func xcgLoggerMsg().

}

#Preview 
{
    
    AppAboutView()
    
}

