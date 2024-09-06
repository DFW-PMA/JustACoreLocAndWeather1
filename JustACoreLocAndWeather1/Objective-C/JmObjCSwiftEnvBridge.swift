//
//  JmObjCSwiftEnvBridge.swift
//  JustAMultiplatformAppTest1
//
//  Created by Daryl Cox on 07/30/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
import XCGLogger

@available(iOS 14.0, *)
@objc(JmObjCSwiftEnvBridge)
@objcMembers
public class JmObjCSwiftEnvBridge: NSObject
{
    
    struct ClassInfo
    {
        
        static let sClsId          = "JmObjCSwiftEnvBridge"
        static let sClsVers        = "v1.0602"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (C) DFW-PMA 2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // Class 'singleton' instance:

    @objc(sharedObjCSwiftEnvBridge)
    static let sharedObjCSwiftEnvBridge            = JmObjCSwiftEnvBridge()

    // Various App field(s):

    var cJmObjCSwiftEnvBridgeMethodCalls:Int       = 0

    var jmAppDelegateVisitor:JmAppDelegateVisitor? = nil

    private override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "(.swift):'"+sCurrMethod+"'"
        
        super.init()
      
        self.cJmObjCSwiftEnvBridgeMethodCalls += 1
      
        self.xcgLogMsg("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmObjCSwiftEnvBridgeMethodCalls))' Invoked...")
      
        // Exit:
      
        self.xcgLogMsg("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmObjCSwiftEnvBridgeMethodCalls))' Exiting...")

        return

    }   // End of init().
    
    private func xcgLogMsg(_ sMessage:String)
    {

        if (self.jmAppDelegateVisitor == nil)
        {

            print("\(sMessage)")

        }
        else
        {

            self.jmAppDelegateVisitor?.xcgLogMsg(sMessage)

        }

        // Exit:

        return

    }   // End of private func xcgLogMsg().

    public func setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:JmAppDelegateVisitor)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "(.swift):'"+sCurrMethod+"'"
        
        self.cJmObjCSwiftEnvBridgeMethodCalls += 1
    
        self.xcgLogMsg("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmObjCSwiftEnvBridgeMethodCalls))' Invoked - supplied parameter 'jmAppDelegateVisitor' is [\(jmAppDelegateVisitor)]...")

        self.jmAppDelegateVisitor = jmAppDelegateVisitor
    //  self.jmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
        // Exit:

        self.xcgLogMsg("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmObjCSwiftEnvBridgeMethodCalls))' Exiting - 'self.jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
    
        return

    } // End of public func setJmAppDelegateVisitorInstance().

    class public func sharedEnvBridge() -> JmObjCSwiftEnvBridge
    {
        
        return sharedObjCSwiftEnvBridge
        
    }   // End of class public func sharedEnvBridge().

    @objc public func jmLogMsg(_ message:NSString)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "(.swift):'"+sCurrMethod+"'"

        self.cJmObjCSwiftEnvBridgeMethodCalls += 1

        self.xcgLogMsg("-------------------------------------------------------------------------------------------------------------")
        self.xcgLogMsg("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmObjCSwiftEnvBridgeMethodCalls))' Invoked - Swift code has been called with a parameter 'message' of [\(message)]...")
        self.xcgLogMsg("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmObjCSwiftEnvBridgeMethodCalls))' JmObjCSwiftEnvBridge 'self' is [\(self)]...")
        self.xcgLogMsg("-------------------------------------------------------------------------------------------------------------")

        // Exit:

        self.xcgLogMsg("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmObjCSwiftEnvBridgeMethodCalls))' Exiting...")

        return

    }   // End of @objc public func jmLogMsg().

    //  public func setXCGLoggerInstance(xcgLogMsg:XCGLogger)
    //  {
    //      
    //      let sCurrMethod:String = #function
    //      let sCurrMethodDisp    = "(.swift):'"+sCurrMethod+"'"
    //      
    //      self.cJmObjCSwiftEnvBridgeMethodCalls += 1
    //
    //      print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmObjCSwiftEnvBridgeMethodCalls))' Invoked - parameter 'xcgLogMsg' is [\(String(describing: xcgLogMsg))]...")
    //
    //      self.xcgLogMsg = xcgLogMsg
    //
    //      if ((self.xcgLogMsg) != nil) 
    //      {
    //
    //          self.xcgLogMsg?("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmObjCSwiftEnvBridgeMethodCalls))' Exiting - parameter 'xcgLogMsg' was [\(String(describing: xcgLogMsg))] and 'self.xcgLogMsg' is [\(String(describing: self.xcgLogMsg))]...")
    //
    //      }
    //      else
    //      {
    //
    //          print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmObjCSwiftEnvBridgeMethodCalls))' Exiting - parameter 'xcgLogMsg' was [\(String(describing: xcgLogMsg))] and 'self.xcgLogMsg' is [\(String(describing: self.xcgLogMsg))] but is Null - Error!")
    //
    //      }
    //
    //  } // End of public func setXCGLoggerInstance().

}   // End of class JmObjCSwiftEnvBridge(NSObject).

