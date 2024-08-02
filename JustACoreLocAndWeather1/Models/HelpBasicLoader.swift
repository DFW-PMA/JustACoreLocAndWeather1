//
//  HelpBasicLoader.swift
//  JustAXCGLoggerWithLogonTest2
//
//  Created by JustMacApps.net on 06/11/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

import Cocoa
import Foundation
import SwiftUI

class HelpBasicLoader: NSObject
{

    struct ClassInfo
    {
        
        static let sClsId        = "HelpBasicLoader"
        static let sClsVers      = "v1.0501"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // Various App field(s):

    var bHelpSetupRequired:Bool   = true
    var sHelpBasicLoaderTag       = ""
    var sHelpBasicFileExt:String  = "html"     // 'help' File extension: "md", "html", or "txt"
    var sHelpBasicContents:String = "-N/A-"

    @AppStorage("helpBasicMode") 
    var helpBasicMode             = HelpBasicMode.simpletext

    open func toString()->String
    {

        var asToString:[String] = Array()

        asToString.append("[")
        asToString.append("[")
        asToString.append("'sClsId': [\(ClassInfo.sClsId)],")
        asToString.append("'sClsVers': [\(ClassInfo.sClsVers)],")
        asToString.append("'sClsDisp': [\(ClassInfo.sClsDisp)],")
        asToString.append("'sClsCopyRight': [\(ClassInfo.sClsCopyRight)],")
        asToString.append("'bClsTrace': [\(ClassInfo.bClsTrace)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bHelpSetupRequired': [\(self.bHelpSetupRequired)],")
        asToString.append("'sHelpBasicLoaderTag': [\(self.sHelpBasicLoaderTag)],")
        asToString.append("'sHelpBasicFileExt': [\(self.sHelpBasicFileExt)],")
        asToString.append("'sHelpBasicContents': [\(self.sHelpBasicContents)],")
        asToString.append("'helpBasicMode': [\(self.helpBasicMode)],")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    func loadHelpBasicContents(helpbasicfileext:String = "html", helpbasicloadertag:String = "-unknown-") -> String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"
        let appDelegate:JustAXCGLoggerWithLogonTest2AppDelegate
                               = JustAXCGLoggerWithLogonTest2AppDelegate.ClassSingleton.appDelegate!

        appDelegate.xcgLogger?.info("\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Invoked...")

        if (self.bHelpSetupRequired == true)
        {

            self.sHelpBasicLoaderTag = helpbasicloadertag

            if (self.sHelpBasicLoaderTag.count < 1)
            {

                self.sHelpBasicLoaderTag  = "-unknown-"

                let sSearchMessage:String = "\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Supplied 'help' Basic loader TAG string is an 'empty' string - defaulting it to [\(self.sHelpBasicLoaderTag)] - Warning!"

                appDelegate.xcgLogger?.info(sSearchMessage)

            }

            self.sHelpBasicFileExt = helpbasicfileext

            if (self.sHelpBasicFileExt.count < 1)
            {

                self.sHelpBasicFileExt    = "html"

                let sSearchMessage:String = "\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Supplied 'help' Basic loader TAG string is an 'empty' string - defaulting it to [\(self.sHelpBasicFileExt)] - Warning!"

                appDelegate.xcgLogger?.info(sSearchMessage)

            }

            appDelegate.xcgLogger?.info("\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Loading the HELP 'Basic' contents from file extension of [\(self.sHelpBasicFileExt)] via [\(self.sHelpBasicLoaderTag)]...")

            if let fpBasicHelp = Bundle.main.path(forResource: "HelpBasic", ofType: self.sHelpBasicFileExt)
            {

                do 
                {

                    self.sHelpBasicContents = try String(contentsOfFile: fpBasicHelp)

                    print("\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - HELP 'basic' contents 'self.sHelpBasicContents' via [\(self.sHelpBasicLoaderTag)] are [\(self.sHelpBasicContents)]...")

                    appDelegate.xcgLogger?.info("\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - HELP 'basic' contents 'self.sHelpBasicContents' via [\(self.sHelpBasicLoaderTag)] are [\(self.sHelpBasicContents)]...")

                    if (self.sHelpBasicFileExt == "html")
                    {

                        self.helpBasicMode = HelpBasicMode.hypertext

                    }
                    else
                    {

                        if (self.sHelpBasicFileExt == "md")
                        {

                            self.helpBasicMode = HelpBasicMode.markdown

                        }
                        else
                        {

                            self.helpBasicMode = HelpBasicMode.simpletext

                        }

                    }

                } 
                catch 
                {

                    self.helpBasicMode      = HelpBasicMode.simpletext
                    self.sHelpBasicContents = "\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Resource file 'HelpBasic.\(self.sHelpBasicFileExt)' could NOT be loaded via [\(self.sHelpBasicLoaderTag)] - Error!"

                }

            }
            else 
            {

                self.helpBasicMode      = HelpBasicMode.simpletext
                self.sHelpBasicContents = "\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Resource file 'HelpBasic.\(self.sHelpBasicFileExt)' could NOT be found via [\(self.sHelpBasicLoaderTag)] - Error!"

            }

            appDelegate.xcgLogger?.info("")

        }

        appDelegate.xcgLogger?.info("\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Exiting...")

        return self.sHelpBasicContents

    }   // End of func loadHelpBasicContents().

}   // End of class HelpBasicLoader(NSObject).

