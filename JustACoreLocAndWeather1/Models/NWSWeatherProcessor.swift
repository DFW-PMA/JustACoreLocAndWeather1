//
//  NWSWeatherProcessor.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 08/11/2024.
//  Copyright (c) JustMacApps 2018-2024. All rights reserved.
//

import Foundation

class NWSWeatherProcessor: NSObject
{

    struct ClassInfo
    {

        static let sClsId          = "NWSWeatherProcessor"
        static let sClsVers        = "v1.0104"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (c) JustMacApps 2018-2024. All rights reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true

    }

    var id:String                          = ""
    var nwsWeatherItem:NWSWeatherItem?     = nil

    var currLatitude:Double                = 0.0
    var currLongitude:Double               = 0.0

    var restURLEndpoint:RestURLEndpoint?   = nil
    var restURLProcessor:RestURLProcessor? = nil
    var restURLResponse:RestURLResponse?   = nil

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
        asToString.append("'nwsWeatherItem': [\(String(describing: self.nwsWeatherItem))],")
        asToString.append("'restURLEndpoint': [\(String(describing: self.restURLEndpoint))],")
        asToString.append("'restURLProcessor': [\(String(describing: self.restURLProcessor))],")
        asToString.append("'restURLResponse': [\(String(describing: self.restURLResponse))],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    } // End of (open) func toString().

    override init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        self.id               = UUID().uuidString
        self.restURLProcessor = RestURLProcessor()

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

    public func getCurrentNWSWeatherViaRestAPIItem() -> NWSWeatherItem?
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        self.nwsWeatherItem = nil

        if (self.restURLProcessor == nil)
        {

            self.restURLProcessor = RestURLProcessor()

        }

        if (self.restURLEndpoint == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'self.restURLEndpoint' is Nil - Error!")

            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return nil

        }

        let bGetCurrentNWSWeatherOk = self.getCurrentNWSWeatherViaRestAPI()

        if (bGetCurrentNWSWeatherOk == false)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Invocation of 'self.getCurrentNWSWeatherViaRestAPI()' returned [\(bGetCurrentNWSWeatherOk)] - Error!")

            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return nil

        }

        self.xcgLogMsg("\(sCurrMethodDisp) Rreturned 'self.restURLResponse' is [\(String(describing: self.restURLResponse))]...")

        self.nwsWeatherItem = NWSWeatherItem()

        self.nwsWeatherItem?.title       = "NWSWeather at [...]"
        self.nwsWeatherItem?.completed   = true
        self.nwsWeatherItem?.urlResponse = self.restURLResponse!

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - returned 'self.nwsWeatherItem' is [\(String(describing: self.nwsWeatherItem))]...")

        return self.nwsWeatherItem

    } // End of public func getCurrentNWSWeatherViaRestAPIItem().

    func getCurrentNWSWeatherViaRestAPI() -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        let asJsonHeaders =
        [
            "Content-Type":  "application/json;v1.0 / 2.0",
        //  "Authorization": "Bearer \(self.restURLEndpoint!.sURLAccessToken)",
            "cxOrigin":      "\(AppGlobalInfo.sGlobalInfoAppId)",
            "cache-control": "no-cache"
        ]

        self.restURLProcessor!.restURLData                  = RestURLData()
        self.restURLProcessor!.restURLData!.restURLEndpoint = self.restURLEndpoint
        self.restURLProcessor!.restURLData!.sHttpURI        = "points/\(self.currLatitude),\(self.currLongitude)"
        self.restURLProcessor!.restURLData!.sHttpParams     = ""

        _ = self.restURLProcessor!.restURLData!.generateHttpURL()

        let postJsonRequest = NSMutableURLRequest(url:             NSURL(string: self.restURLProcessor!.restURLData!.sHttpGeneratedURL)! as URL,
                                                  cachePolicy:     .reloadIgnoringLocalCacheData,
                                                  timeoutInterval: 30.0)

        postJsonRequest.httpMethod          = "GET"
        postJsonRequest.allHTTPHeaderFields = asJsonHeaders

        self.restURLProcessor!.jsonRequest               = postJsonRequest
        self.restURLProcessor!.aiJsonResponseStatusCodes = [200]

        self.xcgLogMsg("\(sCurrMethodDisp) Issueing a URL 'request' to [\(self.restURLProcessor!)]...")

        self.restURLResponse = self.restURLProcessor!.handleURLRequestWithJsonResponse(reset: false)

    //  defer
    //  {
    //
    //      _ = self.traceLastCxAPIOutput(adJsonAPIRespResult: self.restURLProcessor!.adJsonResult, sJsonAPIName: "GetAllProjectDetails")
    //
    //  }

        if (self.restURLResponse!.bRestURLQueryOk == false)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) The JSON Request 'postJsonRequest' [\(postJsonRequest)] failed - 'restURLResponse' was [\(self.restURLResponse!)] - Error!")

            return false

        }

        if (self.restURLProcessor!.adJsonResult.count > 0)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) The 'deserialized' JSON result array 'adJsonResult' contains (\(self.restURLProcessor!.adJsonResult.count)) lines...")

            for (i, dictJsonResult) in self.restURLProcessor!.adJsonResult.enumerated()
            {

                var j            = 0
                var idProject    = 0
                var sProjectName = ""

                for (dictJsonKey, dictJsonValue) in dictJsonResult
                {

                    j += 1

                    self.xcgLogMsg("\(sCurrMethodDisp) JSON result #(\(i + 1):\(j)): Key [\(dictJsonKey)], Value [\(dictJsonValue)]...")

                    if (dictJsonKey as! String == "id")
                    {

                        idProject = dictJsonValue as! String

                    }

                    if (dictJsonKey as! String == "name")
                    {

                        sProjectName = dictJsonValue as! String

                    }

                }

            }

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return true

    } // End of func getCurrentNWSWeatherViaRestAPI().

} // End of class NWSWeatherProcessor.

