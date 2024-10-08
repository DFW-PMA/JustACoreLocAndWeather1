//
//  JustACoreLocAndWeather1AppDelegate.swift
//  JustACoreLocAndWeather1
//
//  Created by JustMacApps.net on 08/02/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

// import Cocoa
import Foundation
import SwiftUI
import XCGLogger

class JustACoreLocAndWeather1AppDelegate: NSObject, UIApplicationDelegate, ObservableObject
{

    struct ClassInfo
    {
        
        static let sClsId          = "JustACoreLocAndWeather1AppDelegate"
        static let sClsVers        = "v1.1001"
        static let sClsDisp        = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        static let sClsLogFilespec = "JustACoreLocAndWeather1.log"
        
    }

    struct ClassSingleton
    {

        static var appDelegate:JustACoreLocAndWeather1AppDelegate? = nil

    }

    // App 'name' field:

    let sApplicationName:String                 = AppGlobalInfo.sGlobalInfoAppId

    // Various App field(s):

    var cAppDelegateInitCalls:Int               = 0

    var bAppTitleSetupRequired:Bool             = true
    let bUseApplicationShortTitle:Bool          = true
    var sApplicationTitle:String                = "-N/A-"
    let sApplicationShortTitle:String           = "JACLAW1"

//  let sHelpBasicFileExt:String                = "html"     // 'help' File extension: "md", "html", or "txt"
    let sHelpBasicFileExt:String                = "md"       // 'help' File extension: "md", "html", or "txt"
    var sHelpBasicContents:String               = "-N/A-"

    @AppStorage("helpBasicMode") 
    var helpBasicMode                           = HelpBasicMode.simpletext

    var helpBasicLoader:HelpBasicLoader         = HelpBasicLoader()

    // Misc:

    let bClsTraceInternal:Bool                  = true
    var bAppDelegateTraceLogInitRequired:Bool   = true
    var sInitAppDelegateTraceLogTag:String      = "-unknown-"
    var bAppDelegateLogFilespecIsUsable:Bool    = false
    var urlAppDelegateLogFilespec:URL?          = nil
    var urlAppDelegateLogFilepath:URL?          = nil
    var sAppDelegateLogFilespec:String!         = nil
    var sAppDelegateLogFilepath:String!         = nil
    var xcgLogger:XCGLogger?                    = XCGLogger.default
    
    // Swift/ObjC Bridge:

//  @objc var jmObjCSwiftEnvBridge:JmObjCSwiftEnvBridge? = nil

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
        asToString.append("'bClsFileLog': [\(ClassInfo.bClsFileLog)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sApplicationName': [\(self.sApplicationName)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'cAppDelegateInitCalls': (\(self.cAppDelegateInitCalls)),")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bAppTitleSetupRequired': [\(self.bAppTitleSetupRequired)],")
        asToString.append("'bUseApplicationShortTitle': [\(self.bUseApplicationShortTitle)],")
        asToString.append("'sApplicationTitle': [\(self.sApplicationTitle)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sHelpBasicFileExt': [\(self.sHelpBasicFileExt)],")
        asToString.append("'sHelpBasicContents': [\(self.sHelpBasicContents)],")
        asToString.append("'helpBasicMode': [\(self.helpBasicMode)],")
        asToString.append("'helpBasicLoader': [\(self.helpBasicLoader.toString())],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bClsTraceInternal': [\(self.bClsTraceInternal)],")
        asToString.append("'bAppDelegateTraceLogInitRequired': [\(self.bAppDelegateTraceLogInitRequired)],")
        asToString.append("'sInitAppDelegateTraceLogTag': [\(self.sInitAppDelegateTraceLogTag)],")
        asToString.append("'bAppDelegateLogFilespecIsUsable': [\(String(describing: self.bAppDelegateLogFilespecIsUsable))],")
        asToString.append("'urlAppDelegateLogFilespec': [\(String(describing: self.urlAppDelegateLogFilespec))],")
        asToString.append("'urlAppDelegateLogFilepath': [\(String(describing: self.urlAppDelegateLogFilepath))],")
        asToString.append("'sAppDelegateLogFilespec': [\(String(describing: self.sAppDelegateLogFilespec))],")
        asToString.append("'sAppDelegateLogFilepath': [\(String(describing: self.sAppDelegateLogFilepath))],")
        asToString.append("'xcgLogger': [\(String(describing: self.xcgLogger))],")
    //  asToString.append("],")
    //  asToString.append("[")
    //  asToString.append("'jmObjCSwiftEnvBridge': [\(String(describing: self.jmObjCSwiftEnvBridge))],")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()
        
        ClassSingleton.appDelegate = self

        self.cAppDelegateInitCalls           += 1
        self.bAppDelegateLogFilespecIsUsable  = false

        print("\(sCurrMethodDisp) - Invoked - #(\(self.cAppDelegateInitCalls)) time(s) - 'self' is [\(self)]...")

        self.initAppDelegateTraceLog(initappdelegatetracelogtag:"\(sCurrMethodDisp)<>\(self.cAppDelegateInitCalls)")

        self.xcgLogMsg("\(sCurrMethodDisp) Method Invoked - #(\(self.cAppDelegateInitCalls)) time(s) - 'sApplicationName' is [\(self.sApplicationName)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) AppDelegate is starting - 'self' is [\(self)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' instance 'self.xcgLogger' is being used (default instance)...")
        
        // Dump the App 'Info.plist':

        let _ = self.dumpAppInfoPlistToLog()

        // Help:

        if (self.helpBasicLoader.bHelpSetupRequired == true)
        {

            self.sHelpBasicContents = self.helpBasicLoader.loadHelpBasicContents(helpbasicfileext:self.sHelpBasicFileExt, helpbasicloadertag:"'appDidFinish...()'")

        }

    //  // Setup the Objective-C/Swift Bridge:
    //
    //  self.jmObjCSwiftEnvBridge = JmObjCSwiftEnvBridge(xcgLogger:self.xcgLogger!)
    //
    //  // Objective-C call(s):
    //
    //  let calledObjCModule = CalledObjCModule()
    //
    //  self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #1 - invoking 'setObjCSwiftEnvBridge()' with a parameter 'self.jmObjCSwiftEnvBridge' of [\(String(describing: self.jmObjCSwiftEnvBridge))]...")
    //
    //  let _ = #selector(setter: calledObjCModule.setObjCSwiftEnvBridge(_ :self.jmObjCSwiftEnvBridge!))
    //
    //  self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #1 - invoked 'setObjCSwiftEnvBridge()' with a parameter 'self.jmObjCSwiftEnvBridge' of [\(String(describing: self.jmObjCSwiftEnvBridge))]...")
    //
    //  let sInternalVariable:String? = calledObjCModule.getInternalVariable()
    //
    //  self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #2 - 'sInternalVariable' (via 'getCalledObjCModuleVariable()') is [\(String(describing: sInternalVariable))]...")
    //
    //  let sHelloMessage:String = "Message from 'JustACoreLocAndWeather1AppDelegate'..."
    //  
    //  calledObjCModule.sayHello(sHelloMessage)
    //  
    //  self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #3 - 'sayHello()' with a parameter of [\(String(describing: sHelloMessage))]...")
        
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting - #(\(self.cAppDelegateInitCalls)) time(s) - 'sApplicationName' is [\(self.sApplicationName)] - 'sAppVersionAndBuildNumber' is [\(self.getAppVersionAndBuildNumber())]...")

        return

    }   // End of init().
        
    private func initAppDelegateTraceLog(initappdelegatetracelogtag:String = "-unknown-")
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        if (self.bAppDelegateTraceLogInitRequired == true)
        {
            
            self.setupAppDelegateTraceLogFile()
            self.setupAppDelegateXCGLogger()

            self.xcgLogMsg("\(sCurrMethodDisp) parameter 'initappdelegatetracelogtag' is [\(initappdelegatetracelogtag)]...")

            self.sInitAppDelegateTraceLogTag = initappdelegatetracelogtag

            if (self.sInitAppDelegateTraceLogTag.count < 1)
            {

                self.sInitAppDelegateTraceLogTag = "-unknown-"

                let sSearchMessage:String = "Supplied 'init' AppDelegate Trace Log loader TAG string is an 'empty' string - defaulting it to [\(self.sInitAppDelegateTraceLogTag)] - Warning!"

                self.xcgLogMsg("\(sCurrMethodDisp) \(sSearchMessage)")

            }

            self.xcgLogMsg("\(sCurrMethodDisp) AppDelegate TraceLog setup was called by [\(self.sInitAppDelegateTraceLogTag)]...")

            self.bAppDelegateTraceLogInitRequired = false

        }

        // Exit:

        return

    }   // End of func initAppDelegateTraceLog().

    private func setupAppDelegateTraceLogFile()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        // Setup the AppDelegate (physical) 'log' file:

        do 
        {

            self.urlAppDelegateLogFilepath = try FileManager.default.url(for: .documentDirectory ,in: .userDomainMask ,appropriateFor: nil, create: true)
            self.urlAppDelegateLogFilespec = self.urlAppDelegateLogFilepath?.appendingPathComponent(ClassInfo.sClsLogFilespec)
            self.sAppDelegateLogFilespec   = self.urlAppDelegateLogFilespec?.path
            self.sAppDelegateLogFilepath   = self.urlAppDelegateLogFilepath?.path

            print("'[\(String(describing: ClassInfo.sClsDisp))]' - ...'self.sAppDelegateLogFilespec' (computed) is [\(String(describing: self.sAppDelegateLogFilespec))]...")
            print("'[\(String(describing: ClassInfo.sClsDisp))]' - ...'self.sAppDelegateLogFilepath' (resolved #2) is [\(String(describing: self.sAppDelegateLogFilepath))]...")

            try FileManager.default.createDirectory(atPath: sAppDelegateLogFilepath, withIntermediateDirectories: true, attributes: nil)

            let sContents = "\(sCurrMethodDisp) Method Invoked - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]..."

            try sContents.write(toFile: self.sAppDelegateLogFilespec, atomically:true, encoding:String.Encoding.utf8)

            self.bAppDelegateLogFilespecIsUsable = true

        }
        catch
        {

            self.bAppDelegateLogFilespecIsUsable = false

            print("'[\(String(describing: ClassInfo.sClsDisp))].appInit(...)' - Failed to create the 'path' of [.documentDirectory] - Error: \(error)...")

        }

        // Exit:

        return

    }   // End of func setupAppDelegateTraceLogFile().

    private func setupAppDelegateXCGLogger()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        // Setup the AppDelegate XCGLogger instance:

        self.xcgLogger?.setup(level:             .verbose,
                              showLogIdentifier: true,
                              showFunctionName:  true,
                              showThreadName:    true,
                              showLevel:         true,
                              showFileNames:     true,
                              showLineNumbers:   true,
                              showDate:          true,
                              writeToFile:       self.urlAppDelegateLogFilespec,
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

        return

    }   // End of func setupAppDelegateXCGLogger().

    func getAppDelegateApplicationTitle() -> String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        if (self.bAppTitleSetupRequired == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Setting up the Application 'title'...")

            if (self.bUseApplicationShortTitle == true)
            {

            //  self.sApplicationTitle = self.sApplicationName
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

        return self.sApplicationTitle

    }   // End of func getAppDelegateApplicationTitle().

    func getAppDelegateHelpBasicContents() -> String
    {

    //  let sCurrMethod:String = #function
    //  let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        if (self.helpBasicLoader.bHelpSetupRequired == true)
        {

        //  self.initAppDelegateTraceLog(initappdelegatetracelogtag:sCurrMethodDisp)

            self.sHelpBasicContents                 = self.helpBasicLoader.loadHelpBasicContents(helpbasicfileext:self.sHelpBasicFileExt, helpbasicloadertag:"'get...()'")
            self.helpBasicLoader.bHelpSetupRequired = false

        }

        return self.sHelpBasicContents

    }   // End of func getAppDelegateHelpBasicContents().

    func applicationWillFinishLaunchingWithOptions(_ uiApplication:UIApplication, willFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey:Any?]) -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'uiApplication' is [\(uiApplication)] - 'willFinishLaunchingWithOptions' is [\(willFinishLaunchingWithOptions)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting...")
        
        return true

    }   // End of func applicationWillFinishLaunching().

//  private func applicationDidFinishLaunching(_ aNotification: Notification)
    func applicationDidFinishLaunchingWithOptions(_ uiApplication:UIApplication, didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey:Any?]) -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        let cArgs              = Int(CommandLine.argc)
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'uiApplication' is [\(uiApplication)] - 'didFinishLaunchingWithOptions' is [\(didFinishLaunchingWithOptions)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) The Command line input #(\(cArgs)) parameters...")
        
        for i in 0..<cArgs
        {
            
            let sArg  = String(cString: CommandLine.unsafeArgv[i]!)
            let sArgV = sArg
            
            self.xcgLogMsg("\(sCurrMethodDisp) Input parameter #(\(i)) is [\(sArgV)]...")
            
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting...")
        
        return true

    }   // End of func applicationDidFinishLaunching().

    func applicationWillTerminate(_ uiApplication:UIApplication)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'uiApplication' is [\(uiApplication)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")

        self.xcgLogMsg("\(sCurrMethodDisp) AppDelegate is stopping...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting...")

        ClassSingleton.appDelegate = nil

    }   // End of func applicationWillTerminate().

    func application(_ application: UIApplication, open urls: [URL])
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'application' is [\(application)] - 'urls' are [\(urls)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")

        self.xcgLogMsg("\(sCurrMethodDisp) -> Unhandled url(s) -> \(urls)")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting...")

    }   // End of func application().

    open func clearAppDelegateTraceLogFile()
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

        // Clear the AppDelegate (trace) 'Log' file:

        if (self.bAppDelegateLogFilespecIsUsable == false)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting - 'self.bAppDelegateLogFilespecIsUsable' is [\(self.bAppDelegateLogFilespecIsUsable)]...")

            return

        }

        do 
        {

            let sContents = "\(sCurrMethodDisp) ...Clearing the AppDelegate (trace) 'Log' file [\(String(describing: self.sAppDelegateLogFilespec))]..."

            try sContents.write(toFile: self.sAppDelegateLogFilespec, atomically:true, encoding:String.Encoding.utf8)

        }
        catch _
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting - Exception in clearing the AppDelegate (trace) 'Log' file [\(String(describing: self.sAppDelegateLogFilespec))]...")

            return

        }

        // Construct and set-up a <new> 'default' FileDestination:

        let xcgFileDestination = FileDestination(writeToFile: self.urlAppDelegateLogFilespec!, 
                                                 identifier:  XCGLogger.Constants.fileDestinationIdentifier)
                                             //  identifier:  "net.justmacapps.\(JustAXCGLoggerTest1AppDelegate.sApplicationName).advancedSysLogger.xcgFileDestination")
        
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

        self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting...")

    }   // End of open func clearAppDelegateTraceLogFile().

    open func dumpAppInfoPlistToLog() -> Bool
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

    }   // End of open func dumpAppInfoPlistToLog().

    open func getAppVersionAndBuildNumber() -> String 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        let sAppVersionNumber:String         = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "-N/A-"
        let sAppBuildNumber:String           = (Bundle.main.infoDictionary?["CFBundleVersion"]            as? String) ?? "-N/A-"
        let sAppVersionAndBuildNumber:String = "Version v\(sAppVersionNumber) (\(sAppBuildNumber))"

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sAppVersionAndBuildNumber' is [\(sAppVersionAndBuildNumber)]...")

        return sAppVersionAndBuildNumber

    }   // End of open func getAppVersionAndBuildNumber().

    func xcgLogMsg(_ sMessage:String)
    {

        self.xcgLogger?.info("\(sMessage)")

        return

    }   // End of func xcgLogMsg().

}   // End of class JustACoreLocAndWeather1AppDelegate(NSObject, NSApplicationDelegate, ObservableObject).

