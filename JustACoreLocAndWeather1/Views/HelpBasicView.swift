//
//  HelpBasicView.swift
//  JustACoreLocAndWeather1
//
//  Created by JustMacApps.net on 05/07/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

import Foundation
import SwiftUI

struct HelpBasicView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId          = "HelpBasicView"
        static let sClsVers        = "v1.0505"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // AppDelegate (via @EnvironmentObject - automatic via the App's @NSApplicationDelegateAdaptor property wrapper

    @EnvironmentObject private   var appDelegate:JustACoreLocAndWeather1AppDelegate

    // App Data field(s):

    @Environment(\.dismiss)      var dismiss
    
    @AppStorage("helpBasicMode") var helpBasicMode             = HelpBasicMode.hypertext
    @State                       var sHelpBasicContents:String = "----NOT-Loaded-(View)----"

    var body: some View 
    {
        
        VStack
        {

            Spacer()

            HStack
            {
                
                ScrollView(.vertical)
                {
                    
                    renderHELPContentsInTextView()
                    
                }
                
            }
        //  .padding()

            Spacer()

        }
        .padding()
    //  .frame(minWidth: 100, idealWidth: 200, maxWidth: 300, minHeight: 50, idealHeight: 100, maxHeight: 300)
        
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
        //      let _ = xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)HelpBasicView.Button(Xcode).'Refresh'.#(\(self.cCoreLocationSiteDetailsViewRefreshButtonPresses))...")
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

                let _ = xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp):HelpBasicView.Button(Xcode).'Dismiss' pressed...")

                dismiss()

            }
            .controlSize(.large)
            .background(Color(red: 0, green: 0.5, blue: 0.5))
            .foregroundStyle(.white)
            .buttonStyle(.borderedProminent)

            Spacer()

        }   // End of HStack #1.1

        Spacer()

    }
    
    func renderHELPContentsInTextView() -> Text
    {

        var textField:Text

        switch helpBasicMode
        {
            
        case .hypertext:
            do 
            {
                
            //  if let nsAttributedString = try? NSAttributedString(data: Data(sHelpBasicContents.utf8), 
            //                                                      options: [.documentType: NSAttributedString.DocumentType.html], 
            //                                                      documentAttributes: nil),
            //  //  let attributedString   = try? AttributedString(nsAttributedString, including: .appKit)
            //  {
            //      
            //      textField = Text(attributedString)
            //      
            //  }
            //  else
            //  {
            //      
            //      textField = Text(sHelpBasicContents)
            //      
            //  }
              
                textField = Text(sHelpBasicContents)

            }
            
        case .markdown:
            do
            {
                
                textField = Text(try! AttributedString(markdown: sHelpBasicContents))
                
            }
            
        case .simpletext:
            do
            {
                
                textField = Text(sHelpBasicContents)
                
            }
            
        }

        return textField

    }   // End of func renderHELPContentsInTextView().

    func xcgLoggerMsg(sMessage:String)
    {

        self.appDelegate.xcgLogger?.info("\(sMessage)")

        return

    }   // End of func xcgLoggerMsg().

}

#Preview 
{
    
    HelpBasicView(sHelpBasicContents: "---HELP 'Basic' Preview---")
    
}

