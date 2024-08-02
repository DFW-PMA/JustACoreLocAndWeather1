//
//  HelpBasicMode.swift
//  JustAXCGLoggerWithLogonTest2
//
//  Created by JustMacApps.net on 05/09/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

import Foundation
import SwiftUI

enum HelpBasicMode: String, CaseIterable
{
    
    case hypertext  = "html"
    case markdown   = "md"
    case simpletext = "text"
    
    static func changeHelpBasicMode(to mode: HelpBasicMode)
    {
        
        @AppStorage("helpBasicMode") var helpBasicMode = HelpBasicMode.simpletext
        
        helpBasicMode = mode
        
    }
    
}

