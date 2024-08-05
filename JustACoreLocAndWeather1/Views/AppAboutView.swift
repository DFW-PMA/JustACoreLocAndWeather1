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
        static let sClsVers        = "v1.0102"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // AppDelegate (via @EnvironmentObject - automatic via the App's @NSApplicationDelegateAdaptor property wrapper

    @EnvironmentObject private var appDelegate:JustACoreLocAndWeather1AppDelegate

    // App Data field(s):

    @Environment(\.dismiss) var dismiss
    
#if os(macOS)

    private let pasteboard = NSPasteboard.general

#elseif os(iOS)

    private let pasteboard = UIPasteboard.general

#endif

    var body: some View 
    {
        
        Spacer()
        
        VStack
        {

            Divider()
            
            if #available(iOS 17.0, *)
            {

                Image(ImageResource(name: "AppIcon@3x", bundle: Bundle.main))
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal)
                        { size, axis in
                            size * 0.2
                        }

            }
            else
            {

                Image(ImageResource(name: "AppIcon@3x", bundle: Bundle.main))
                    .resizable()
                    .scaledToFit()
                    .frame(width:100, height: 100, alignment:.center)

            }

            Spacer(minLength:10)

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

        HStack(alignment:.center)
        {

            Spacer()

            VStack(alignment:.center)
            {

                Text("'JustACoreLocAndWeather1' App information:")
                    .bold()
                    .controlSize(.regular)

            //  Text("\(ClassInfo.sClsDisp):body(some View)")
            //      .italic()
            //      .controlSize(.mini)

                Text("\(ClassInfo.sClsCopyRight)")
                    .italic()
                    .controlSize(.mini)

            }

            Spacer()

        }

    //  Spacer()

        HStack(alignment:.center)
        {

            Spacer()

            Text(" - - - - - - - - - - - - - - - - - - - - ")
                .bold()
                .controlSize(.regular)

            Spacer()

        }

    //  Spacer()

        HStack(alignment:.center)
        {

            Spacer()

            VStack(alignment:.center)
            {

                Text("'JustACoreLocAndWeather1' App LOG file at:")
                    .bold()
                    .controlSize(.regular)
                    .contextMenu
                    {

                        Button
                        {

                            let _ = xcgLoggerMsg(sMessage:"...\(ClassInfo.sClsDisp):AppAboutView in Text.contextMenu.'copy' button #1...")

                            copyLogFilespecToClipboard()

                        }
                        label:
                        {

                            Text("Copy to Clipboard")

                        }

                    }

            //  Text("\(JustACoreLocAndWeather1AppDelegate.ClassSingleton.appDelegate!.sAppDelegateLogFilespec!)")
                Text("\(self.appDelegate.sAppDelegateLogFilespec!)")
                    .italic()
                    .controlSize(.mini)

            }

            Spacer()

        }

        Spacer()

    }
    
    func copyLogFilespecToClipboard()
    {
        
        xcgLoggerMsg(sMessage:"...\(ClassInfo.sClsDisp):AppAboutView in 'copyLogFilespecToClipboard()' for text of [\(self.appDelegate.sAppDelegateLogFilespec!)]...")
        
    #if os(macOS)

        pasteboard.prepareForNewContents()
        pasteboard.setString(self.appDelegate.sAppDelegateLogFilespec!, forType: .string)

    #elseif os(iOS)

        pasteboard.string = self.appDelegate.sAppDelegateLogFilespec!

    #endif

        return

    }   // End of func copyLogFilespecToClipboard().
    
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

