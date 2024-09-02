//
//  NWSWeatherCollection.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 08/11/2024.
//  Copyright (c) JustMacApps 2018-2024. All rights reserved.
//

import Foundation

class NWSWeatherCollection: NSObject
{

    struct ClassInfo
    {

        static let sClsId        = "NWSWeatherCollection"
        static let sClsVers      = "v1.0101"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2018-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true

    }

    var listNWSWeatherItems:[NWSWeatherItem] = []

    public func toString()->String
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
        asToString.append("'listNWSWeatherItems': [\(String(describing: self.listNWSWeatherItems))],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    } // End of (public) func toString().

    override init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    } // End of init().

    private func xcgLogMsg(_ sMessage:String)
    {

        print("\(sMessage)")
    //  self.jmAppDelegateVisitor.xcgLogMsg(sMessage)

        // Exit:

        return

    }   // End of private func xcgLogMsg().

    func insertNewNWSWeatherItem(nwsWeatherItem: NWSWeatherItem, at index: Int) -> [NWSWeatherItem]
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)] - 'nwsWeatherItem' [\(nwsWeatherItem)] - 'title' [\(nwsWeatherItem.title)] - 'index' [\(index)]...")

        if nwsWeatherItemExists(withTitle: nwsWeatherItem.title)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) - 'nwsWeatherItem' [\(nwsWeatherItem)] - 'title' [\(nwsWeatherItem.title)] - already exists - Error!")

        }
        else
        {

            if index >= listNWSWeatherItems.count
            {

                listNWSWeatherItems.append(nwsWeatherItem)

            }
            else
            {

                listNWSWeatherItems.insert(nwsWeatherItem, at: index)

            }

            postNotificationOfChanges()

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return listNWSWeatherItems

    } // End of func insertNewNWSWeatherItem().

    func deleteNWSWeatherItem(at index: Int) -> [NWSWeatherItem]
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)] - 'index' [\(index)]...")

        if index < listNWSWeatherItems.count
        {

            listNWSWeatherItems.remove(at: index)

        }

        postNotificationOfChanges()

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return listNWSWeatherItems

    } // End of func deleteNWSWeatherItem().

    func postNotificationOfChanges()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        NotificationCenter.default.post(name: Notification.Name(rawValue: "NWSWeatherCollectionChanged"), object: ["newNWSWeatherCollection": listNWSWeatherItems])

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    } // End of func postNotificationOfChanges().

    func nwsWeatherItemExists(withTitle title: String) -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)] - 'title' [\(title)]...")

        let titles                = listNWSWeatherItems.map {$0.title}
        let bNWSWeatherItemExists = titles.contains(title)

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return bNWSWeatherItemExists

    } // End of func nwsWeatherItemExists().

} // End of class NWSWeatherCollection.
