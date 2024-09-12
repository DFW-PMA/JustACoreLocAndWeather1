//
//  JustACoreLocAndWeather1AppGlobalInfo.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 08/02/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI

struct AppGlobalInfo
{
    
    static let sGlobalInfoAppId:String                   = "JustACoreLocAndWeather1"
    static let sGlobalInfoAppVers:String                 = "v1.0601"
    static let sGlobalInfoAppDisp:String                 = sGlobalInfoAppId+".("+sGlobalInfoAppVers+"): "
    static let sGlobalInfoAppCopyRightString             = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
    static let sClsLogFilespec:String                    = "JustACoreLocAndWeather1.log"
    static let sGlobalInfoAppLogFilespec:String          = "JustAMultipartRequestTest1.log"
    static let sGlobalInfoAppLastGoodLogFilespec:String  = "JustAMultipartRequestTest1.last_good.log"
    static let sGlobalInfoAppLastCrashLogFilespec:String = "JustAMultipartRequestTest1.crashed_last.log"
    static let sGlobalInfoAppCrashMarkerFilespec:String  = "JustAMultipartRequestTest1.crash_marker.txt"

    static let bUseApplicationShortTitle:Bool            = false
    static let sApplicationTitle:String                  = "-N/A-"
    static let sApplicationShortTitle:String             = "JACLAW1"

#if os(macOS)

    static let sHelpBasicFileExt:String                  = "html"     // 'help' File extension: "md", "html", or "txt"

#elseif os(iOS)

    static let sHelpBasicFileExt:String                  = "md"       // 'help' File extension: "md", "html", or "txt"

#endif

    static let bPerformAppObjCSwiftBridgeTest:Bool       = false
    
}

