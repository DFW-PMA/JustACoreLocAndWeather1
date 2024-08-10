//
//  SettingsSingleView.swift
//  JustACoreLocAndWeather1
//
//  Created by JustMacApps.net on 08/02/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

import SwiftUI

#if os(iOS)

    import UIKit

#endif

struct SettingsSingleView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "SettingsSingleView"
        static let sClsVers      = "v1.1103"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // AppDelegate (via @EnvironmentObject - automatic via the App's @NSApplicationDelegateAdaptor property wrapper

    @EnvironmentObject private var appDelegate:JustACoreLocAndWeather1AppDelegate

    // App Data field(s):

    @Environment(\.dismiss) var dismiss

    @State private var cContentViewAppAboutButtonPresses:Int    = 0
    @State private var cContentViewAppHelpButtonPresses:Int     = 0
    @State private var cContentViewAppLogViewButtonPresses:Int  = 0
    @State private var cContentViewAppLogClearButtonPresses:Int = 0

    @State private var isAppAboutViewModal:Bool                 = false
    @State private var isAppHelpViewModal:Bool                  = false
    @State private var isAppLogViewModal:Bool                   = false
    @State private var isAppLogClearShowingAlert:Bool           = false
    
#if os(macOS)

    private let pasteboard = NSPasteboard.general

#elseif os(iOS)

    private let pasteboard = UIPasteboard.general

#endif

    var body: some View 
    {
        
        VStack(alignment:.leading)              // VStack #1
        {

            HStack(alignment:.center)           // HStack #1.3
            {
            
                Spacer()
                
                Button
                {

                    self.cContentViewAppAboutButtonPresses += 1

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):SettingsSingleView in Button(Xcode).'App About'.#(\(self.cContentViewAppAboutButtonPresses))...")

                    self.isAppAboutViewModal.toggle()

                }
                label: 
                {
                    
                    Text("App About")

                }
                .sheet(isPresented:$isAppAboutViewModal, content:
                    {

                        AppAboutView()

                    }
                )
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()

                Button
                {

                    self.cContentViewAppHelpButtonPresses += 1

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):SettingsSingleView in Button(Xcode).'App Help'.#(\(self.cContentViewAppHelpButtonPresses))...")

                    self.isAppHelpViewModal.toggle()

                }
                label: 
                {
                    
                    Text("App Help")

                }
                .sheet(isPresented:$isAppHelpViewModal, content:
                    {

                        HelpBasicView(sHelpBasicContents: self.appDelegate.getAppDelegateHelpBasicContents())

                    }
                )
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()

                Button
                {

                    self.cContentViewAppLogViewButtonPresses += 1

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):SettingsSingleView in Button(Xcode).'App Log View'.#(\(self.cContentViewAppLogViewButtonPresses))...")

                    self.isAppLogViewModal.toggle()

                }
                label: 
                {
                    
                    Text("App Log View")

                }
                .sheet(isPresented:$isAppLogViewModal, content:
                    {

                        LogFileView()

                    }
                )
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()

                Button
                {

                    self.cContentViewAppLogClearButtonPresses += 1

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):SettingsSingleView in Button(Xcode).'App Log 'Clear'.#(\(self.cContentViewAppLogClearButtonPresses))'...")

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

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):SettingsSingleView.Button(Xcode).'Dismiss' pressed...")

                    dismiss()

                }
                .controlSize(.large)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)
                .padding()

            }   // End of HStack #1.1

            Spacer()

            VStack(alignment:.center)
            {

                Spacer()

                HStack(alignment:.center)
                {

                    Spacer()

                    VStack(alignment:.center)
                    {

                        Text("'\(AppGlobalInfo.sGlobalInfoAppId)' App information:")
                            .bold()
                            .controlSize(.regular)

                    //  Text("\(ClassInfo.sClsCopyRight)")
                        Text("\(getAppCopyright())")
                            .italic()
                            .controlSize(.mini)

                    }

                    Spacer()

                }

                HStack(alignment:.center)
                {

                    Spacer()

                    Text(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
                        .bold()
                        .controlSize(.regular)

                    Spacer()

                }

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

                                    let _ = xcgLogMsg("...\(ClassInfo.sClsDisp):SettingsSingleView in Text.contextMenu.'copy' button #1...")

                                    copyLogFilespecToClipboard()

                                }
                                label:
                                {

                                    Text("Copy to Clipboard")

                                }

                            }

                        Text("\(self.appDelegate.sAppDelegateLogFilespec!)")
                            .italic()
                            .controlSize(.mini)

                    }

                    Spacer()

                }

                Spacer()

            }

            Spacer()
            
        }   // End of VStack #1
    //  .padding()
    //  .background(Color.black)
    //  .frame(minWidth: 50, idealWidth: 200, maxWidth: .infinity, minHeight: 70, idealHeight: 100, maxHeight: .infinity)
        
    }
    
    func copyLogFilespecToClipboard()
    {
        
        xcgLogMsg("...\(ClassInfo.sClsDisp):SettingsSingleView in 'copyLogFilespecToClipboard()' for text of [\(self.appDelegate.sAppDelegateLogFilespec!)]...")
        
    #if os(macOS)

        pasteboard.prepareForNewContents()
        pasteboard.setString(self.appDelegate.sAppDelegateLogFilespec!, forType: .string)

    #elseif os(iOS)

        pasteboard.string = self.appDelegate.sAppDelegateLogFilespec!

    #endif

        return

    }   // End of func copyLogFilespecToClipboard().
    
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
    
    SettingsSingleView()
    
}

