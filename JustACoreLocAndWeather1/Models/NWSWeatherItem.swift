//
//  NWSWeatherItem.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 09/02/2024.
//  Copyright (c) JustMacApps 2018-2024. All rights reserved.
//

import Foundation

public class NWSWeatherItem: NSObject
{

    struct ClassInfo
    {

        static let sClsId        = "NWSWeatherItem"
        static let sClsVers      = "v1.0101"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2018-2024. All rights reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true

    }

    // Variables that are used in scripting (and saved to the plist file):

    var id:String

    var title:String
    {
        didSet { postNotificationOfChanges() }
    }

    var completed:Bool
    {
        didSet { postNotificationOfChanges() }
    }

    var urlResponse:RestURLResponse
    {
        didSet { postNotificationOfChanges() }
    }

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
        asToString.append("'id': [\(String(describing: self.id))],")
        asToString.append("'title': [\(self.title)],")
        asToString.append("'completed': [\(self.completed)],")
        asToString.append("'urlResponse': [\(self.urlResponse)],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    } // End of (open) func toString().

    override init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.id          = UUID().uuidString
        self.title       = ""
        self.completed   = false
        self.urlResponse = RestURLResponse()

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    } // End of (override) init().

    convenience init(nwsWeatherItem:NWSWeatherItem)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        self.id          = UUID().uuidString
        self.title       = "\(nwsWeatherItem.title) Sub #(\(self.id))"
        self.completed   = false
        self.urlResponse = nwsWeatherItem.urlResponse

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    } // End of (override) init().

    private func xcgLogMsg(_ sMessage:String)
    {

        print("\(sMessage)")
    //  self.jmAppDelegateVisitor.xcgLogMsg(sMessage)

        // Exit:

        return

    }   // End of private func xcgLogMsg().

    func postNotificationOfChanges()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        NotificationCenter.default.post(name: Notification.Name(rawValue: "SingleNWSWeatherItemDataChanged"), object: ["newNWSWeatherItemData": self])

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    } // End of func postNotificationOfChanges().

    func markAsCompleted()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        self.completed = true

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    } // End of func markAsCompleted().

//  func submitAsIndicated(_ command: NSScriptCommand)
//  {
//
//      let sCurrMethod:String = #function
//      let sCurrMethodDisp    = "'"+sCurrMethod+"()'"
//
//      self.jsTraceLog.jsTraceLogMsg(clsName: self.sTraceCls, sTraceClsDisp:sCurrMethodDisp, sTraceClsMsg:"Invoked - 'self' is [\(self)] - 'command' [\(command)]...")
//
//      if let nwsWeatherItem         = command.evaluatedReceivers as? NWSWeatherItem,
//         let fullNWSWeatherItemFlag = command.evaluatedArguments?["fullNWSWeatherItemFlag"] as? String
//      {
//
//          if self == nwsWeatherItem
//          {
//
//              // if fullNWSWeatherItemFlag doesn't match either string, leave un-changed:
//
//              if fullNWSWeatherItemFlag == "full"
//              {
//
//                  self.fullNWSWeatherItem = true
//
//              }
//              else if fullNWSWeatherItemFlag == "incremental"
//              {
//
//                  self.fullNWSWeatherItem = false
//
//              }
//
//              let cxAppDelegate:AppDelegate = AppDelegate.ClassSingleton.cxAppDelegate!
//
//              self.jsTraceLog.jsTraceLogMsg(clsName: self.sTraceCls, sTraceClsDisp:sCurrMethodDisp, sTraceClsMsg:"Calling the 'cxAppDelegate' [\(cxAppDelegate)]...")
//
//              _ = cxAppDelegate.invokeNWSWeatherItemSubmitViaAPICall(nwsWeatherItem: self)
//
//          }
//
//      }
//
//  } // End of func submitAsIndicated().

} // End of class NWSWeatherItem.
