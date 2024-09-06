//
//  JmAppDelegateVisitor.swift
//  JustAMultiplatformAppTest1
//
//  Created by JustMacApps.net on 08/24/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

// import Cocoa
import Foundation
import SwiftUI
import XCGLogger

#if os(iOS)
import UIKit
#endif

@objc(JmAppDelegateVisitor)
public class JmAppDelegateVisitor: NSObject, ObservableObject
{

    struct ClassInfo
    {
        
        static let sClsId          = "JmAppDelegateVisitor"
        static let sClsVers        = "v1.0502"
        static let sClsDisp        = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    struct ClassSingleton
    {

        static 
        var appDelegateVisitor:JmAppDelegateVisitor      = JmAppDelegateVisitor()

    }

    // App 'name' field:

    let sApplicationName:String                          = AppGlobalInfo.sGlobalInfoAppId

    // Various App field(s):

    var cAppDelegateVisitorInitCalls:Int                 = 0

    var bAppTitleSetupRequired:Bool                      = true
    let bUseApplicationShortTitle:Bool                   = AppGlobalInfo.bUseApplicationShortTitle
    var sApplicationTitle:String                         = AppGlobalInfo.sApplicationTitle
    let sApplicationShortTitle:String                    = AppGlobalInfo.sApplicationShortTitle

    let sHelpBasicFileExt:String                         = AppGlobalInfo.sHelpBasicFileExt      // 'help' File extension: "md", "html", or "txt"
    var sHelpBasicContents:String                        = "-N/A-"

    @AppStorage("helpBasicMode") 
    var helpBasicMode                                    = HelpBasicMode.simpletext

    var helpBasicLoader:HelpBasicLoader?                 = nil
//  var helpBasicLoader:HelpBasicLoader                  = HelpBasicLoader()

    // Misc:

    let bClsTraceInternal:Bool                           = true
    var bAppDelegateVisitorTraceLogInitRequired:Bool     = true
    var sInitAppDelegateVisitorTraceLogTag:String        = "-unknown-"
    var bAppDelegateVisitorLogFilespecIsUsable:Bool      = false
    var urlAppDelegateVisitorLogFilespec:URL?            = nil
    var urlAppDelegateVisitorLogFilepath:URL?            = nil
    var sAppDelegateVisitorLogFilespec:String!           = nil
    var sAppDelegateVisitorLogFilepath:String!           = nil
    var xcgLogger:XCGLogger?                             = XCGLogger.default
    
    // Swift/ObjC Bridge:

    @objc 
    var jmObjCSwiftEnvBridge:JmObjCSwiftEnvBridge?       = nil

    // App <global> 'Alert' control(s):

    @Published var isAppDelegateVisitorShowingAlert:Bool = false
    {

        didSet
        {

            objectWillChange.send()

        }

    }

    var sAppDelegateVisitorGlobalAlertMessage:String?    = nil
    var sAppDelegateVisitorGlobalAlertButtonText:String? = nil

    @objc public func toString() -> String
    {

        var asToString:[String] = Array()

        asToString.append("[")
        asToString.append("[")
        asToString.append("'sClsId': [\(ClassInfo.sClsId)],")
        asToString.append("'sClsVers': [\(ClassInfo.sClsVers)],")
        asToString.append("'sClsDisp': [\(ClassInfo.sClsDisp)],")
        asToString.append("'sClsCopyRight': [\(ClassInfo.sClsCopyRight)],")
        asToString.append("'bClsTrace': [\(ClassInfo.bClsTrace)],")
        asToString.append("'bClsFileLog': [\(ClassInfo.bClsFileLog)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sApplicationName': [\(self.sApplicationName)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'cAppDelegateVisitorInitCalls': (\(self.cAppDelegateVisitorInitCalls)),")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bAppTitleSetupRequired': [\(self.bAppTitleSetupRequired)],")
        asToString.append("'bUseApplicationShortTitle': [\(self.bUseApplicationShortTitle)],")
        asToString.append("'sApplicationTitle': [\(self.sApplicationTitle)],")
        asToString.append("'sApplicationShortTitle': [\(self.sApplicationShortTitle)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sHelpBasicFileExt': [\(self.sHelpBasicFileExt)],")
        asToString.append("'sHelpBasicContents': [\(self.sHelpBasicContents)],")
        asToString.append("'helpBasicMode': [\(self.helpBasicMode)],")
        asToString.append("'helpBasicLoader': [\(String(describing: self.helpBasicLoader?.toString()))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bClsTraceInternal': [\(self.bClsTraceInternal)],")
        asToString.append("'bAppDelegateVisitorTraceLogInitRequired': [\(self.bAppDelegateVisitorTraceLogInitRequired)],")
        asToString.append("'sInitAppDelegateVisitorTraceLogTag': [\(self.sInitAppDelegateVisitorTraceLogTag)],")
        asToString.append("'bAppDelegateVisitorLogFilespecIsUsable': [\(String(describing: self.bAppDelegateVisitorLogFilespecIsUsable))],")
        asToString.append("'urlAppDelegateVisitorLogFilespec': [\(String(describing: self.urlAppDelegateVisitorLogFilespec))],")
        asToString.append("'urlAppDelegateVisitorLogFilepath': [\(String(describing: self.urlAppDelegateVisitorLogFilepath))],")
        asToString.append("'sAppDelegateVisitorLogFilespec': [\(String(describing: self.sAppDelegateVisitorLogFilespec))],")
        asToString.append("'sAppDelegateVisitorLogFilepath': [\(String(describing: self.sAppDelegateVisitorLogFilepath))],")
        asToString.append("'xcgLogger': [\(String(describing: self.xcgLogger))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'jmObjCSwiftEnvBridge': [\(String(describing: self.jmObjCSwiftEnvBridge))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'isAppDelegateVisitorShowingAlert': [\(self.isAppDelegateVisitorShowingAlert)],")
        asToString.append("'sAppDelegateVisitorGlobalAlertMessage': [\(String(describing: self.sAppDelegateVisitorGlobalAlertMessage))],")
        asToString.append("'sAppDelegateVisitorGlobalAlertButtonText': [\(String(describing: self.sAppDelegateVisitorGlobalAlertButtonText))],")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of @objc public func toString().

    private override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()
        
        self.cAppDelegateVisitorInitCalls           += 1
        self.bAppDelegateVisitorLogFilespecIsUsable  = false

        print("\(sCurrMethodDisp) Invoked - #(\(self.cAppDelegateVisitorInitCalls)) time(s) - 'self' is [\(self)]...")

        self.initAppDelegateVisitorTraceLog(initappdelegatetracelogtag:"\(sCurrMethodDisp)<>\(self.cAppDelegateVisitorInitCalls)")

        self.xcgLogMsg("\(sCurrMethodDisp) Method Invoked - #(\(self.cAppDelegateVisitorInitCalls)) time(s) - 'sApplicationName' is [\(self.sApplicationName)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) AppDelegateVisitor is starting - 'self' is [\(self)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' instance 'self.xcgLogger' is being used (default instance)...")
        
        // Dump the App 'Info.plist':

        let _ = self.dumpAppInfoPlistToLog()

        // Setup the Objective-C/Swift Bridge:
  
        self.jmObjCSwiftEnvBridge = JmObjCSwiftEnvBridge.sharedObjCSwiftEnvBridge

        self.jmObjCSwiftEnvBridge?.setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:self)
  
        self.xcgLogMsg("\(sCurrMethodDisp) 'self' is [\(self)] and 'self.jmObjCSwiftEnvBridge' is (\(String(describing: self.jmObjCSwiftEnvBridge))) and 'self.xcgLogger' is [\(String(describing: self.xcgLogger))]...")
  
        // Objective-C call(s):
  
        let calledObjCModule = CalledObjCModule()
  
        self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #1 - invoking 'initInstance()' with NO parameter(s)...")
  
        calledObjCModule.initInstance()
  
        self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #1 - invoked 'initInstance()' with NO parameter(s)...")
  
        let sInternalVariable:String? = calledObjCModule.getInternalVariable()
  
        self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #2 - 'sInternalVariable' (via 'getCalledObjCModuleVariable()') is [\(String(describing: sInternalVariable))]...")
  
        let sHelloMessage:String = "Message from 'JmAppDelegateVisitor'..."
        
        calledObjCModule.sayHello(sHelloMessage)
        
        self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #3 - 'sayHello()' with a parameter of [\(String(describing: sHelloMessage))]...")
        
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - #(\(self.cAppDelegateVisitorInitCalls)) time(s) - 'sApplicationName' is [\(self.sApplicationName)]...")

        return

    }   // End of private init().
        
    @objc public func xcgLogMsg(_ sMessage:String)
    {

    //  print("\(sMessage)")
        self.xcgLogger?.info(sMessage)

        // Exit:

        return

    }   // End of @objc public func xcgLogMsg().

    // Method(s) to setup the file and console 'logging' output:

    private func initAppDelegateVisitorTraceLog(initappdelegatetracelogtag:String = "-unknown-")
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        if (self.bAppDelegateVisitorTraceLogInitRequired == true)
        {
            
            self.setupAppDelegateVisitorTraceLogFile()
            self.setupAppDelegateVisitorXCGLogger()

            self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'initappdelegatetracelogtag' is [\(initappdelegatetracelogtag)]...")

            self.sInitAppDelegateVisitorTraceLogTag = initappdelegatetracelogtag

            if (self.sInitAppDelegateVisitorTraceLogTag.count < 1)
            {

                self.sInitAppDelegateVisitorTraceLogTag = "-unknown-"

                let sSearchMessage:String = "Supplied 'init' AppDelegateVisitor Trace Log loader TAG string is an 'empty' string - defaulting it to [\(self.sInitAppDelegateVisitorTraceLogTag)] - Warning!"

                self.xcgLogMsg("\(sCurrMethodDisp) \(sSearchMessage)")

            }

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - AppDelegateVisitor TraceLog setup was called by [\(self.sInitAppDelegateVisitorTraceLogTag)]...")

            self.bAppDelegateVisitorTraceLogInitRequired = false

        }

        // Exit:

        return

    }   // End of private func initAppDelegateVisitorTraceLog().

    private func setupAppDelegateVisitorTraceLogFile()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        // Setup the AppDelegateVisitor (physical) 'log' file:

        do 
        {

            self.urlAppDelegateVisitorLogFilepath = try FileManager.default.url(for: .documentDirectory ,in: .userDomainMask ,appropriateFor: nil, create: true)
            self.urlAppDelegateVisitorLogFilespec = self.urlAppDelegateVisitorLogFilepath?.appendingPathComponent(AppGlobalInfo.sClsLogFilespec)
            self.sAppDelegateVisitorLogFilespec   = self.urlAppDelegateVisitorLogFilespec?.path
            self.sAppDelegateVisitorLogFilepath   = self.urlAppDelegateVisitorLogFilepath?.path

            print("'[\(sCurrMethodDisp)]' - 'self.sAppDelegateVisitorLogFilespec' (computed) is [\(String(describing: self.sAppDelegateVisitorLogFilespec))]...")
            print("'[\(sCurrMethodDisp)]' - 'self.sAppDelegateVisitorLogFilepath' (resolved #2) is [\(String(describing: self.sAppDelegateVisitorLogFilepath))]...")

            try FileManager.default.createDirectory(atPath: sAppDelegateVisitorLogFilepath, withIntermediateDirectories: true, attributes: nil)

            let sContents = "\(sCurrMethodDisp) Invoked - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]..."

            try sContents.write(toFile: self.sAppDelegateVisitorLogFilespec, atomically:true, encoding:String.Encoding.utf8)

            self.bAppDelegateVisitorLogFilespecIsUsable = true

            print("'[\(sCurrMethodDisp)] - Exiting...")

        }
        catch
        {

            self.bAppDelegateVisitorLogFilespecIsUsable = false

            print("'[\(sCurrMethodDisp)] - Exiting - Failed to create the 'path' of [.documentDirectory] - Error: \(error)...")

        }

        // Exit:

        return

    }   // End of private func setupAppDelegateVisitorTraceLogFile().

    private func setupAppDelegateVisitorXCGLogger()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        // Setup the AppDelegateVisitor XCGLogger instance:

        self.xcgLogger?.setup(level:             .verbose,
                              showLogIdentifier: true,
                              showFunctionName:  true,
                              showThreadName:    true,
                              showLevel:         true,
                              showFileNames:     true,
                              showLineNumbers:   true,
                              showDate:          true,
                              writeToFile:       self.urlAppDelegateVisitorLogFilespec,
                              fileLevel:         .verbose)

        let listXCGLoggerDestinations = self.xcgLogger?.destinations
        
        self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance has these destinations (\(listXCGLoggerDestinations!.count)): [\(String(describing: listXCGLoggerDestinations))]...")
        
        for index in 0 ..< (listXCGLoggerDestinations!.count) 
        {

            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) TYPE is [\(String(describing: type(of: listXCGLoggerDestinations?[index])))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) 'is' FileDestination [\(String(describing: (listXCGLoggerDestinations?[index] is FileDestination)))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) Destination 'identifier' is [\(String(describing: listXCGLoggerDestinations?[index].identifier))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) is [\(String(describing: listXCGLoggerDestinations?[index]))]...")

            if ((listXCGLoggerDestinations?[index] is FileDestination) == true)
            {

                let xcgFileDestination = listXCGLoggerDestinations?[index] as! FileDestination

                self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' FileDestination with 'identifier' of [\(xcgFileDestination.identifier)] is writing to file [\(String(describing: xcgFileDestination.writeToFileURL))]...")

            }

        }
        
        // Add basic app info, version info etc, to the start of the logs:

        self.xcgLogger?.logAppDetails()

        // Exit:

        self.xcgLogMsg("'[\(sCurrMethodDisp)] - Exiting...")

        return

    }   // End of private func setupAppDelegateVisitorXCGLogger().

    @objc public func clearAppDelegateVisitorTraceLogFile()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Locate and remove the FileDestination from the 'default' xcgLogger?:

        let listXCGLoggerDestinations    = self.xcgLogger?.destinations
        var xcgFileDestinationIdentifier = XCGLogger.Constants.fileDestinationIdentifier
        
        self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance has these destinations (\(listXCGLoggerDestinations!.count)): [\(String(describing: listXCGLoggerDestinations))]...")
        
        for index in 0 ..< (listXCGLoggerDestinations!.count) 
        {

            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) TYPE is [\(String(describing: type(of: listXCGLoggerDestinations?[index])))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) 'is' FileDestination [\(String(describing: (listXCGLoggerDestinations?[index] is FileDestination)))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) Destination 'identifier' is [\(String(describing: listXCGLoggerDestinations?[index].identifier))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) is [\(String(describing: listXCGLoggerDestinations?[index]))]...")

            if ((listXCGLoggerDestinations?[index] is FileDestination) == true)
            {

                let xcgFileDestination = listXCGLoggerDestinations?[index] as! FileDestination

                xcgFileDestinationIdentifier = xcgFileDestination.identifier

                self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' FileDestination with 'identifier' of [\(xcgFileDestination.identifier)] is writing to file [\(String(describing: xcgFileDestination.writeToFileURL))]...")

                if (xcgFileDestinationIdentifier == XCGLogger.Constants.fileDestinationIdentifier)
                {

                    self.xcgLogger?.remove(destination: xcgFileDestination)

                }

            }

        }

        // Clear the AppDelegateVisitor (trace) 'Log' file:

        if (self.bAppDelegateVisitorLogFilespecIsUsable == false)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.bAppDelegateVisitorLogFilespecIsUsable' is [\(self.bAppDelegateVisitorLogFilespecIsUsable)]...")

            return

        }

        do 
        {

            let sContents = "\(sCurrMethodDisp) ...Clearing the AppDelegateVisitor (trace) 'Log' file [\(String(describing: self.sAppDelegateVisitorLogFilespec))]..."

            try sContents.write(toFile: self.sAppDelegateVisitorLogFilespec, atomically:true, encoding:String.Encoding.utf8)

        }
        catch _
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - Exception in clearing the AppDelegateVisitor (trace) 'Log' file [\(String(describing: self.sAppDelegateVisitorLogFilespec))]...")

            return

        }

        // Construct and set-up a <new> 'default' FileDestination:

        let xcgFileDestination = FileDestination(writeToFile: self.urlAppDelegateVisitorLogFilespec!, 
                                                 identifier:  XCGLogger.Constants.fileDestinationIdentifier)
        
        xcgFileDestination.outputLevel       = .verbose
        xcgFileDestination.showLogIdentifier = true
        xcgFileDestination.showFunctionName  = true
        xcgFileDestination.showThreadName    = true
        xcgFileDestination.showLevel         = true
        xcgFileDestination.showFileName      = true
        xcgFileDestination.showLineNumber    = true
        xcgFileDestination.showDate          = true
        
        // Process this destination in the background:
        
        xcgFileDestination.logQueue = XCGLogger.logQueue
        
        // Re-add the 'default' FileDestination to xcgLogger?:

        self.xcgLogger?.add(destination: xcgFileDestination)
        
        self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' FileDestination with 'identifier' of [\(xcgFileDestination.identifier)] is writing to [\(String(describing: xcgFileDestination.writeToFileURL))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func clearAppDelegateVisitorTraceLogFile().

    // Method(s) that act as AppDelegate 'helpers':

    @objc public func dumpAppInfoPlistToLog() -> Bool
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        let infoFileURL = Bundle.main.url(forResource: "Info", withExtension: "plist")

        if (infoFileURL == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Locating the 'resource' URL for the 'Info.plist' (in Bundle.Resources) failed - Warning!")

            return false

        }

        var formatinfoplist                  = PropertyListSerialization.PropertyListFormat.xml
        var dictInfoPlist:[String:AnyObject] = [:]

        do 
        {

            let pListInfo = try Data(contentsOf: infoFileURL!)
          
            dictInfoPlist = try PropertyListSerialization.propertyList(from:    pListInfo,
                                                                       options: PropertyListSerialization.ReadOptions.mutableContainersAndLeaves,
                                                                       format:  &formatinfoplist) as! [String:AnyObject]

        }
        catch
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Error reading plist: \(error), format: \(formatinfoplist)...")

            return false

        }

        self.xcgLogMsg("\(sCurrMethodDisp) Read the dictionary 'dictInfoPlist' with (\(dictInfoPlist.count)) element(s) of [\(dictInfoPlist)] from file [\(String(describing: infoFileURL))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return true

    }   // End of @objc public func dumpAppInfoPlistToLog().

    @objc public func dumpAppCommandLineArgs()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        let cArgs              = Int(CommandLine.argc)

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) The Command line input #(\(cArgs)) parameters are:")
        
        for i in 0..<cArgs
        {
            
            let sArg  = String(cString: CommandLine.unsafeArgv[i]!)
            let sArgV = sArg
            
            self.xcgLogMsg("\(sCurrMethodDisp) Input parameter #(\(i)) is [\(sArgV)]...")
            
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorDidFinishLaunching().

    @objc public func getAppDelegateVisitorApplicationTitle() -> String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        if (self.bAppTitleSetupRequired == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Setting up the Application 'title'...")

            if (self.bUseApplicationShortTitle == true)
            {

                self.sApplicationTitle = self.sApplicationShortTitle

            }
            else
            {

                self.sApplicationTitle = self.sApplicationName

            }

            self.xcgLogMsg("\(sCurrMethodDisp) Set up of the Application 'title' of [\(self.sApplicationTitle)] done...")

            self.bAppTitleSetupRequired = false

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return self.sApplicationTitle

    }   // End of @objc public func getAppDelegateVisitorApplicationTitle().

    @objc public func getAppDelegateVisitorHelpBasicContents() -> String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        if (self.helpBasicLoader == nil)
        {

            self.helpBasicLoader = HelpBasicLoader()

        }

        if (self.helpBasicLoader?.bHelpSetupRequired == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Setting up HELP 'basic' content(s)...")

            self.sHelpBasicContents                  = self.helpBasicLoader?.loadHelpBasicContents(helpbasicfileext:self.sHelpBasicFileExt, helpbasicloadertag:"'get...()'") ?? "---Error: HELP was NOT loaded properly---"
            self.helpBasicLoader?.bHelpSetupRequired = false

            self.xcgLogMsg("\(sCurrMethodDisp) Set up the HELP 'basic' content(s)...")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return self.sHelpBasicContents

    }   // End of @objc public func getAppDelegateVisitorHelpBasicContents().

#if os(macOS)

    // NSApplicationDelegate method(s):

    @objc public func appDelegateVisitorWillFinishLaunching(_ aNotification: Notification) 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorWillFinishLaunching().

    @objc public func appDelegateVisitorDidFinishLaunching(_ aNotification: Notification) 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        self.dumpAppCommandLineArgs()

    //  self.xcgLogMsg("\(sCurrMethodDisp) The Command line input #(\(cArgs)) parameters...")
    //  
    //  for i in 0..<cArgs
    //  {
    //      
    //      let sArg  = String(cString: CommandLine.unsafeArgv[i]!)
    //      let sArgV = sArg
    //      
    //      self.xcgLogMsg("\(sCurrMethodDisp) Input parameter #(\(i)) is [\(sArgV)]...")
    //      
    //  }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorDidFinishLaunching().

    @objc public func appDelegateVisitorWillTerminate(_ aNotification: Notification) 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")
        self.xcgLogMsg("\(sCurrMethodDisp) AppDelegateVisitor is stopping...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorWillTerminate().

    @objc public func appDelegateVisitorApplication(_ application: NSApplication, open urls: [URL])
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'application' is [\(application)] - 'urls' are [\(urls)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")
        self.xcgLogMsg("\(sCurrMethodDisp) -> Unhandled url(s) -> \(urls)")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitor().

#elseif os(iOS)

    // UIApplicationDelegate method(s):

    // NOTE: This method can NOT be marked @objc because 'willFinishLaunchingWithOptions' is a Swift struct...
    
//  @objc public func appDelegateVisitorWillFinishLaunching(_ aNotification: Notification)
    public func appDelegateVisitorWillFinishLaunchingWithOptions(_ uiApplication:UIApplication, willFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey:Any?]) -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

    //  self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'uiApplication' is [\(uiApplication)] - 'willFinishLaunchingWithOptions' is [\(willFinishLaunchingWithOptions)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return true

    }   // End of public func appDelegateVisitorWillFinishLaunching().
    
    // NOTE: This method can NOT be marked @objc because 'willFinishLaunchingWithOptions' is a Swift struct...
    
//  @objc public func appDelegateVisitorDidFinishLaunching(_ aNotification: Notification)
    public func appDelegateVisitorDidFinishLaunchingWithOptions(_ uiApplication:UIApplication, didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey:Any?]) -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

    //  self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'uiApplication' is [\(uiApplication)] - 'didFinishLaunchingWithOptions' is [\(didFinishLaunchingWithOptions)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        self.dumpAppCommandLineArgs()

    //  self.xcgLogMsg("\(sCurrMethodDisp) The Command line input #(\(cArgs)) parameters...")
    //  
    //  for i in 0..<cArgs
    //  {
    //      
    //      let sArg  = String(cString: CommandLine.unsafeArgv[i]!)
    //      let sArgV = sArg
    //      
    //      self.xcgLogMsg("\(sCurrMethodDisp) Input parameter #(\(i)) is [\(sArgV)]...")
    //      
    //  }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return true

    }   // End of public func appDelegateVisitorDidFinishLaunching().

//  @objc public func appDelegateVisitorWillTerminate(_ aNotification: Notification) 
    @objc public func appDelegateVisitorWillTerminate(_ uiApplication: UIApplication)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

    //  self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'uiApplication' is [\(uiApplication)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")

        self.xcgLogMsg("\(sCurrMethodDisp) AppDelegateVisitor is stopping...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorWillTerminate().

//  @objc public func appDelegateVisitorApplication(_ application: NSApplication, open urls: [URL])
    @objc public func appDelegateVisitorApplication(_ application: UIApplication, open urls: [URL])
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'application' is [\(application)] - 'urls' are [\(urls)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")
        self.xcgLogMsg("\(sCurrMethodDisp) -> Unhandled url(s) -> \(urls)")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorApplication().

#endif

}   // End of class JmAppDelegateVisitor(NSObject, ObservableObject).

