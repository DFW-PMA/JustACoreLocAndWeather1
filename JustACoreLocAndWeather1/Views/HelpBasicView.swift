//
//  HelpBasicView.swift
//  JustAXCGLoggerWithLogonTest2
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
        static let sClsVers        = "v1.0402"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // AppDelegate (via @EnvironmentObject - automatic via the App's @NSApplicationDelegateAdaptor property wrapper

    @EnvironmentObject private   var appDelegate:JustAXCGLoggerWithLogonTest2AppDelegate

    // App Data field(s):

    @AppStorage("helpBasicMode") var helpBasicMode             = HelpBasicMode.hypertext
    @State                       var sHelpBasicContents:String = "----NOT-Loaded-(View)----"

    private var sLogFileText:String
    {
        
    //  JmFileIO.readFile(sFilespec: JustAXCGLoggerWithLogonTest2AppDelegate.ClassSingleton.appDelegate!.sAppDelegateLogFilespec!) ?? "--- empty LOG file ---"
        JmFileIO.readFile(sFilespec: self.appDelegate.sAppDelegateLogFilespec!) ?? "--- empty LOG file ---"
        
    }

    var body: some View 
    {
        
        VStack
        {

            Divider()
            
            HStack
            {
                
                ScrollView(.vertical)
                {
                    
                    renderHELPContentsInTextView()
                    
                }
                
            }
            .padding()

            Divider()

        }
        .padding()
        .frame(minWidth: 100, idealWidth: 200, maxWidth: 300, minHeight: 50, idealHeight: 100, maxHeight: 300)
        
    }
    
    func renderHELPContentsInTextView() -> Text
    {

        var textField:Text

        switch helpBasicMode
        {
            
        case .hypertext:
            do 
            {
                
                if let nsAttributedString = try? NSAttributedString(data: Data(sHelpBasicContents.utf8), 
                                                                    options: [.documentType: NSAttributedString.DocumentType.html], 
                                                                    documentAttributes: nil),
                   let attributedString   = try? AttributedString(nsAttributedString, including: \.appKit) 
                {
                    
                    textField = Text(attributedString)
                    
                }
                else
                {
                    
                    textField = Text(sHelpBasicContents)
                    
                }
                
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

}

#Preview 
{
    
    HelpBasicView(sHelpBasicContents: "---HELP 'Basic' Preview---")
    
}

