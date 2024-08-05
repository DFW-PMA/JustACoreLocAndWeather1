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
        static let sClsVers      = "v1.0801"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // AppDelegate (via @EnvironmentObject - automatic via the App's @NSApplicationDelegateAdaptor property wrapper

    @EnvironmentObject private var appDelegate:JustACoreLocAndWeather1AppDelegate

    // App Data field(s):

    @Environment(\.dismiss) var dismiss

    @State private var cContentViewAppAboutButtonPresses:Int = 0

    @State private var isAppAboutViewModal:Bool              = false
    
#if os(macOS)

    private let pasteboard = NSPasteboard.general

#elseif os(iOS)

    private let pasteboard = UIPasteboard.general

#endif

    var body: some View 
    {
        
        Spacer()
        
        VStack(alignment:.leading)              // VStack #1
        {

            Spacer()
                .frame(height:50)
            
            Divider()
                .border(Color.black, width:5)
            
            HStack(alignment:.center)           // HStack #1.1
            {
            
                Spacer()
                    .frame(width:10)
                
                Text("Preferences:")
            
            }   // End of HStack #1.1

            Divider()
                .border(Color.black, width:5)

            Spacer()
                .frame(height:5)

            HStack(alignment:.bottom)   // HStack #1.2
            {

                Spacer()
                    .frame(width:100, height:10)

                Text("Settings field #1...")
                    .frame(alignment:.bottom)

                Spacer()
                    .frame(width:100, height:10)

            }   // End of HStack #1.2

            Spacer()
                .frame(height:50)

            HStack(alignment:.center)           // HStack #1.3
            {
            
                Spacer()
                //  .frame(width:30)
                
                Button
                {

                    self.cContentViewAppAboutButtonPresses += 1

                    let _ = xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp):SettingsSingleView in Button(Xcode).'App About'.#(\(self.cContentViewAppAboutButtonPresses))...")

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
                .controlSize(.extraLarge)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()

                Button("Dismiss") 
                {

                    let _ = xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp):SettingsSingleView.Button(Xcode).'Dismiss' pressed...")

                    dismiss()

                }
                .controlSize(.extraLarge)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()
                //  .frame(width:30)
                
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

                                let _ = xcgLoggerMsg(sMessage:"...\(ClassInfo.sClsDisp):SettingsSingleView in Text.contextMenu.'copy' button #1...")

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

        }   // End of VStack #1
        .padding()
    //  .background(Color.black)
        .frame(minWidth: 50, idealWidth: 200, maxWidth: .infinity, minHeight: 70, idealHeight: 100, maxHeight: .infinity)
        
    }
    
    func copyLogFilespecToClipboard()
    {
        
        xcgLoggerMsg(sMessage:"...\(ClassInfo.sClsDisp):SettingsSingleView in 'copyLogFilespecToClipboard()' for text of [\(self.appDelegate.sAppDelegateLogFilespec!)]...")
        
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
    
    SettingsSingleView()
    
}

