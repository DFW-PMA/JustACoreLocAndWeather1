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
    
    static let sGlobalInfoAppId               = "JustACoreLocAndWeather1"
    static let sGlobalInfoAppVers             = "v1.0501"
    static let sGlobalInfoAppDisp             = sGlobalInfoAppId+".("+sGlobalInfoAppVers+"): "
    static let sGlobalInfoAppCopyRight        = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
    static let sClsLogFilespec:String         = "JustACoreLocAndWeather1.log"

    static let bUseApplicationShortTitle:Bool = false
    static let sApplicationTitle:String       = "-N/A-"
    static let sApplicationShortTitle:String  = "JACLAW1"

#if os(macOS)

    static let sHelpBasicFileExt:String       = "html"     // 'help' File extension: "md", "html", or "txt"

#elseif os(iOS)

    static let sHelpBasicFileExt:String       = "md"       // 'help' File extension: "md", "html", or "txt"

#endif
    
}

