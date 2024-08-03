//
//  SettingsSingleView.swift
//  JustACoreLocAndWeather1
//
//  Created by JustMacApps.net on 08/02/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

import SwiftUI

struct SettingsSingleView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "SettingsSingleView"
        static let sClsVers      = "v1.0601"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

    @Environment(\.dismiss) var dismiss
    
    var body: some View 
    {
        
        Spacer()
        
        VStack(alignment:.leading)              // VStack #1
        {

            Spacer()
                .frame(height:150)
            
            Divider()
                .border(Color.black, width:5)
            
            HStack(alignment:.center)           // HStack #1.1
            {
            
                Spacer()
                    .frame(width:50)
                
                Text("Preferences:")
            
            }   // End of HStack #1.1

            Divider()
                .border(Color.black, width:5)

            Spacer()
                .frame(height:5)

            HStack(alignment:.bottom)   // HStack #1.2
            {

                Spacer()
                    .frame(width:100, height:10)

                Text("Settings field #1...")
                    .frame(alignment:.bottom)

                Spacer()
                    .frame(width:100, height:10)

            }   // End of HStack #1.2

            Spacer()
                .frame(height:150)

            HStack(alignment:.center)           // HStack #1.3
            {
            
                Spacer()
                //  .frame(width:30)
                
                Button("Dismiss") 
                {

                    let _ = print("\(ClassInfo.sClsDisp):SettingsSingleView.Button('Dismiss') performed...")

                    dismiss()

                }
                .controlSize(.extraLarge)
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)

                Spacer()
                //  .frame(width:30)
                
            }   // End of HStack #1.1

            Spacer()
            
            HStack(alignment:.center)
            {
                
                Spacer()
                
                VStack(alignment:.center)
                {
                    
                    Text("'JustACoreLocAndWeather1' App information:")
                        .bold()
                        .controlSize(.regular)

                    Text("\(ClassInfo.sClsDisp):body(some View)")
                        .italic()
                        .controlSize(.mini)

                    Text("\(ClassInfo.sClsCopyRight)")
                        .italic()
                        .controlSize(.mini)
                    
                }
                
                Spacer()
                
            }

            Spacer()

            HStack(alignment:.center)
            {
                
                Spacer()
                
                Text(" - - - - - - - - - - ")
                    .bold()
                    .controlSize(.regular)

                Spacer()
                
            }

            Spacer()

            HStack(alignment:.center)
            {
                
                Spacer()
                
                VStack(alignment:.center)
                {
                    
                    Text("'JustACoreLocAndWeather1' App LOG file at:")
                        .bold()
                        .controlSize(.regular)

                    Text("\(JustACoreLocAndWeather1AppDelegate.ClassSingleton.appDelegate!.sAppDelegateLogFilespec!)")
                        .italic()
                        .controlSize(.mini)

                }
                
                Spacer()
                
            }

            Spacer()

        }   // End of VStack #1
        .padding()
    //  .background(Color.black)
        .frame(minWidth: 50, idealWidth: 200, maxWidth: .infinity, minHeight: 70, idealHeight: 100, maxHeight: .infinity)
        
    }
    
}

#Preview 
{
    
    SettingsSingleView()
    
}

