//
//  LogFileView.swift
//  JustACoreLocAndWeather1
//
//  Created by JustMacApps.net on 03/20/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
import QuickLook

#if os(iOS)

    import UIKit

#endif

struct LogFileView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId          = "LogFileView"
        static let sClsVers        = "v1.1002"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // AppDelegate (via @EnvironmentObject - automatic via the App's @NSApplicationDelegateAdaptor property wrapper

    @EnvironmentObject private var appDelegate:JustACoreLocAndWeather1AppDelegate

    // App Data field(s):

    @Environment(\.dismiss)    var dismiss

    @State private var cLogFileViewAppLogClearButtonPresses:Int = 0

    @State private var isAppLogClearShowingAlert:Bool           = false
    
    @State  var logFileUrl:URL?
    
#if os(macOS)

    private let pasteboard = NSPasteboard.general

#elseif os(iOS)

    private let pasteboard = UIPasteboard.general

#endif

    var body: some View 
    {
        
        VStack
        {

            HStack
            {

                Spacer()

                Button("Preview Log file") 
                {

                    self.logFileUrl = self.appDelegate.urlAppDelegateLogFilespec

                    xcgLogMsg("\(ClassInfo.sClsDisp):LogFileView.Button('Preview Log file') performed for the URL of [\(String(describing: self.logFileUrl))]...")

                }
                .quickLookPreview($logFileUrl)
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()

                Button
                {

                    self.cLogFileViewAppLogClearButtonPresses += 1

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):LogFileView in Button(Xcode).'App Log 'Clear'.#(\(self.cLogFileViewAppLogClearButtonPresses))'...")

                    self.appDelegate.clearAppDelegateTraceLogFile()

                    self.isAppLogClearShowingAlert = true

                }
                label: 
                {

                    Text("App Log 'Clear'")

                }
                .alert("App Log has been 'Cleared'...", isPresented:$isAppLogClearShowingAlert)
                {

                    Button("Ok", role:.cancel) { }

                }
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()

                Button("Dismiss") 
                {

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):LogFileView.Button(Xcode).'Dismiss' pressed...")

                    dismiss()

                }
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)
                .padding()

            }

            Spacer()

            Text("App Log file:")
                .font(.callout)
                .contextMenu
                {
                
                    Button
                    {
                        
                        let _ = xcgLogMsg("...\(ClassInfo.sClsDisp):LogFileView in Text.contextMenu.'copy' button #1...")
                        
                        copyLogFilespecToClipboard()
                        
                    }
                    label:
                    {
                        
                        Text("Copy to Clipboard")
                        
                    }
                
                }

            Text(self.appDelegate.sAppDelegateLogFilespec ?? "...empty...")
                .contextMenu
                {
                
                    Button
                    {
                        
                        let _ = xcgLogMsg("...\(ClassInfo.sClsDisp):LogFileView in Text.contextMenu.'copy' button #2...")
                        
                        copyLogFilespecToClipboard()
                        
                    }
                    label:
                    {
                        
                        Text("Copy to Clipboard")
                        
                    }
                
                }

            Spacer()

        }
        
    }
    
    func copyLogFilespecToClipboard()
    {
        
        xcgLogMsg("...\(ClassInfo.sClsDisp):LogFileView in 'copyLogFilespecToClipboard()' for text of [\(self.appDelegate.sAppDelegateLogFilespec!)]...")
        
    #if os(macOS)

        pasteboard.prepareForNewContents()
        pasteboard.setString(self.appDelegate.sAppDelegateLogFilespec!, forType: .string)

    #elseif os(iOS)

        pasteboard.string = self.appDelegate.sAppDelegateLogFilespec!

    #endif

        return

    }   // End of func copyLogFilespecToClipboard().
    
    func xcgLogMsg(_ sMessage:String)
    {

        self.appDelegate.xcgLogger?.info("\(sMessage)")

        return

    }   // End of func xcgLogMsg().

}

#Preview 
{
    
    LogFileView()
    
}

