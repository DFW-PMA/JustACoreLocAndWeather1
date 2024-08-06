//
//  CoreLocationSiteItem.swift
//  JustACoreLocAndWeather1
//
//  Created by JustMacApps.net on 05/09/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

import Foundation
import SwiftUI

struct CoreLocationSiteItem: Identifiable
{

    let id                      = UUID()

    var sCLSiteItemName:String  = "-N/A-"
    var sCLSiteItemDesc:String  = "-N/A-"
    var objCLSiteItemValue:Any? = nil
    
}   // End of struct CoreLocationSiteItem(Identifiable).

