//
//  CoreLocationModelObservable.swift
//  JustACoreLocAndWeather1
//
//  Created by Daryl Cox on 07/08/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation

class CoreLocationModelObservable: NSObject, CLLocationManagerDelegate, ObservableObject
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "CoreLocationModelObservable"
        static let sClsVers      = "v1.0203"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):
    
    var locationManager:CLLocationManager?
    
    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        super.init()

        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        self.locationManager = CLLocationManager()
        
        self.locationManager?.delegate = self
        
        self.locationManager?.requestWhenInUseAuthorization()
        
        self.requestLocationUpdate()
        
        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")
        
    }   // End of override init().
    
    public func requestLocationUpdate()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        self.locationManager?.requestLocation()
        
    //  self.locationManager?.startUpdatingLocation()
        
        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")
        
    }   // End of public func requestLocationUpdate().
    
    public func stopLocationUpdate()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        self.locationManager?.stopUpdatingLocation()
        
        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")
        
    }   // End of public func stopLocationUpdate().
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        guard let location = locations.last
        else { return }
        
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        
        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")
        
    }   // End of func locationManager().
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        self.locationManager?.stopUpdatingLocation()
        
        if let clErr = error as? CLError
        {
            
            switch clErr.code
            {
                
            case .locationUnknown, .denied, .network:
                
                print("Location request failed with error: \(clErr.localizedDescription)...")
                
            case .headingFailure:
                
                print("Heading request failed with error: \(clErr.localizedDescription)...")
                
            case .rangingUnavailable, .rangingFailure:
                
                print("Ranging request failed with error: \(clErr.localizedDescription)...")
                
            case .regionMonitoringDenied, .regionMonitoringFailure, .regionMonitoringSetupDelayed, .regionMonitoringResponseDelayed:
                
                print("Region monitoring request failed with error: \(clErr.localizedDescription)...")
                
            default:
                
                print("Unknown 'location manager' error: \(clErr.localizedDescription)...")
                
            }
            
        }
        else
        {
            
            print("Unknown error occurred while handling the 'location manager' error: \(error.localizedDescription)...")
            
        }
        
        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")
        
    }   // End of func locationManager().
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        switch manager.authorizationStatus
        {
            
        case .notDetermined:
            
            print("The User has NOT yet determined authorization...")
            
        case .restricted:
            
            print("Authorization is RESTRICTED by Parental control...")
            
        case .denied:
            
            print("The User has selected 'Do NOT Allow' (denied)...")
            
        case .authorizedAlways:
            
            print("The User has changed the selection to 'Always Allow'...")
            
        case .authorizedWhenInUse:
            
            print("The User has selected 'Allow while Using' or 'Allow Once'...")
            
            self.locationManager?.requestAlwaysAuthorization()
            
        default:
            
            print("This is the 'default' option...")
            
        }
        
        print("\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")
        
    }   // End of func locationManagerDidChangeAuthorization().
    
}   // End of class CoreLocationModelObservable(NSObject, CLLocationManagerDelegate, ObservableObject).

// --------------------------------------------------------------------------------------------------------------------
//  Examples:
//  *) Points (Lat,Long): https://api.weather.gov/points/39.7456,-97.0892
//  *) Forecast (from 'Points'->"properties"->"forecast": https://api.weather.gov/gridpoints/TOP/32,81/forecast
//  N.Richland Hills, Tx:
//  *) Points: https://api.weather.gov/points/32.8601,-97.2289
//  *) Forecast: https://api.weather.gov/gridpoints/FWD/73,108/forecast
// --------------------------------------------------------------------------------------------------------------------

