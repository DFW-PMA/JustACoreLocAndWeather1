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
        static let sClsVers      = "v1.0502"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):
    
               var locationManager:CLLocationManager?   = nil

    @Published var bCLManagerHeadingAvailable:Bool      = false
    
    @Published var clCurrentLocation:CLLocation?        = nil       // Contains: Latitude, Longitude...
    @Published var sCurrentLocationName:String          = "-N/A-"   // This is actually the Street Address (Line #1) <# Street> (i.e. 8908 Michelle Ln)...
    @Published var sCurrentCity:String                  = "-N/A-"   // City (i.e. North Richland Hills)...
    @Published var sCurrentCountry:String               = "-N/A-"   // Country (i.e. United States)...
    @Published var sCurrentPostalCode:String            = "-N/A-"   // Zip Code (i.e. 76182) (Zip-5)...
    @Published var tzCurrentTimeZone:TimeZone?          = nil       // This is TimeZone in English (i.e. 'America/Chicago')...
    @Published var clCurrentRegion:CLRegion?            = nil       // ???
    @Published var sCurrentSubLocality:String           = "-N/A-"   // ??? 
    @Published var sCurrentThoroughfare:String          = "-N/A-"   // Street Name (Michelle Ln)...
    @Published var sCurrentSubThoroughfare:String       = "-N/A-"   // Address (Building) # (i.e. 8908)...
    @Published var sCurrentAdministrativeArea:String    = "-N/A-"   // State  (i.e. TX)...
    @Published var sCurrentSubAdministrativeArea:String = "-N/A-"   // County (i.e. Tarrant County)

    @Published var listCoreLocationSiteItems:[CoreLocationSiteItem]?
                                                        = nil       // List of the 'current' Location Site Item(s) as CoreLocationSiteItem(s)...
    
    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        super.init()

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        self.locationManager = CLLocationManager()
        
        self.locationManager?.delegate = self
        
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
    //  self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.requestAlwaysAuthorization()
        
        self.requestLocationUpdate()

        self.bCLManagerHeadingAvailable = CLLocationManager.headingAvailable()
        
        if (self.bCLManagerHeadingAvailable == true)
        {

            self.locationManager?.startUpdatingHeading()

        }

        // Exit...

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")

        return
        
    }   // End of override init().
    
    public func requestLocationUpdate()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        self.locationManager?.requestLocation()
        
    //  self.locationManager?.startUpdatingLocation()

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")

        return
        
    }   // End of public func requestLocationUpdate().
    
    public func stopLocationUpdate()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        self.locationManager?.stopUpdatingLocation()
        
        // Exit...

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")

        return
        
    }   // End of public func stopLocationUpdate().
    
    public func updateGeocoderLocation(latitude: Double, longitude: Double) -> Bool
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"
        
        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        let clGeocoder:CLGeocoder      = CLGeocoder()
        let currentLocation:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        clGeocoder.reverseGeocodeLocation(currentLocation, completionHandler: 
                                             { (placemarks, error) in
                                                 if error == nil 
                                                 {

                                                     let firstLocation                  = placemarks?[0]

                                                     self.clCurrentLocation              = firstLocation?.location
                                                     self.sCurrentLocationName          = firstLocation?.name                  ?? "-N/A-"
                                                     self.sCurrentCity                  = firstLocation?.locality              ?? "-N/A-"
                                                     self.sCurrentCountry               = firstLocation?.country               ?? "-N/A-"
                                                     self.sCurrentPostalCode            = firstLocation?.postalCode            ?? "-N/A-"
                                                     self.tzCurrentTimeZone             = firstLocation?.timeZone
                                                     self.clCurrentRegion               = firstLocation?.region
                                                     self.sCurrentSubLocality           = firstLocation?.subLocality           ?? "-N/A-"
                                                     self.sCurrentThoroughfare          = firstLocation?.thoroughfare          ?? "-N/A-"
                                                     self.sCurrentSubThoroughfare       = firstLocation?.subThoroughfare       ?? "-N/A-"
                                                     self.sCurrentAdministrativeArea    = firstLocation?.administrativeArea    ?? "-N/A-"
                                                     self.sCurrentSubAdministrativeArea = firstLocation?.subAdministrativeArea ?? "-N/A-"

                                                     return

                                                 }
                                                 else 
                                                 {

                                                     return

                                                 }
                                             }
                                         )

        let _ = self.updateCoreLocationSiteItemList()
        
        // Exit...

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")
        
        return true
        
    }   // End of public func updateGeocoderLocations().

    public func updateCoreLocationSiteItemList() -> Bool
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"
        
        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        // Build the CoreLocationSiteItem(s) list...

        self.listCoreLocationSiteItems = []
        
        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "Location",
                                                                   sCLSiteItemDesc:     "(Latitude,Longitude)",
                                                                   objCLSiteItemValue:  self.clCurrentLocation))

        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "Street Address",
                                                                   sCLSiteItemDesc:     "\(String(describing:self.sCurrentLocationName))"))

        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "City",
                                                                   sCLSiteItemDesc:     "\(String(describing:self.sCurrentCity))"))

        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "Zip Code",
                                                                   sCLSiteItemDesc:     "\(String(describing:self.sCurrentPostalCode))"))

        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "County",
                                                                   sCLSiteItemDesc:     "\(String(describing:self.sCurrentSubAdministrativeArea))"))

        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "State",
                                                                   sCLSiteItemDesc:     "\(String(describing:self.sCurrentAdministrativeArea))"))

        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "TimeZone",
                                                                   sCLSiteItemDesc:     "\(String(describing:self.tzCurrentTimeZone))",
                                                                   objCLSiteItemValue:  self.tzCurrentTimeZone))

        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "Country",
                                                                   sCLSiteItemDesc:     "\(String(describing:self.sCurrentCountry))"))

        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "Street Name",
                                                                   sCLSiteItemDesc:     "\(String(describing:self.sCurrentThoroughfare))"))

        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "Building #",
                                                                   sCLSiteItemDesc:     "\(String(describing:self.sCurrentSubThoroughfare))"))

        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "Sub Locality",
                                                                   sCLSiteItemDesc:     "\(String(describing:self.sCurrentSubLocality))"))

        self.listCoreLocationSiteItems?.append(CoreLocationSiteItem(sCLSiteItemName:    "Region",
                                                                   sCLSiteItemDesc:     "-N/A-",
                                                                   objCLSiteItemValue:  self.clCurrentRegion))

        // Exit...

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")
        
        return true

    }   // End of public func updateCoreLocationSiteItemList().
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        guard let location = locations.last
        else { return }
        
        self.xcgLoggerMsg(sMessage:"Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        
        // Exit...

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")

        return
        
    }   // End of func locationManager().
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        self.locationManager?.stopUpdatingLocation()
        
        if let clErr = error as? CLError
        {
            
            switch clErr.code
            {
                
            case .locationUnknown, .denied, .network:
                
                self.xcgLoggerMsg(sMessage:"Location request failed with error: \(clErr.localizedDescription)...")
                
            case .headingFailure:
                
                self.xcgLoggerMsg(sMessage:"Heading request failed with error: \(clErr.localizedDescription)...")
                
            case .rangingUnavailable, .rangingFailure:
                
                self.xcgLoggerMsg(sMessage:"Ranging request failed with error: \(clErr.localizedDescription)...")
                
            case .regionMonitoringDenied, .regionMonitoringFailure, .regionMonitoringSetupDelayed, .regionMonitoringResponseDelayed:
                
                self.xcgLoggerMsg(sMessage:"Region monitoring request failed with error: \(clErr.localizedDescription)...")
                
            default:
                
                self.xcgLoggerMsg(sMessage:"Unknown 'location manager' error: \(clErr.localizedDescription)...")
                
            }
            
        }
        else
        {
            
            self.xcgLoggerMsg(sMessage:"Unknown error occurred while handling the 'location manager' error: \(error.localizedDescription)...")
            
        }
        
        // Exit...

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")

        return
        
    }   // End of func locationManager().
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Invoked...")
        
        switch manager.authorizationStatus
        {
            
        case .notDetermined:
            
            self.xcgLoggerMsg(sMessage:"The User has NOT yet determined authorization...")
            
        case .restricted:
            
            self.xcgLoggerMsg(sMessage:"Authorization is RESTRICTED by Parental control...")
            
        case .denied:
            
            self.xcgLoggerMsg(sMessage:"The User has selected 'Do NOT Allow' (denied)...")
            
        case .authorizedAlways:
            
            self.xcgLoggerMsg(sMessage:"The User has changed the selection to 'Always Allow'...")
            
        case .authorizedWhenInUse:
            
            self.xcgLoggerMsg(sMessage:"The User has selected 'Allow while Using' or 'Allow Once'...")
            
            self.locationManager?.requestAlwaysAuthorization()
            
        default:
            
            self.xcgLoggerMsg(sMessage:"This is the 'default' option...")
            
        }
        
        // Exit...

        self.xcgLoggerMsg(sMessage:"\(ClassInfo.sClsDisp)\(sCurrMethodDisp) Exiting...")

        return
        
    }   // End of func locationManagerDidChangeAuthorization().

    func xcgLoggerMsg(sMessage:String)
    {

        let appDelegate:JustACoreLocAndWeather1AppDelegate
                               = JustACoreLocAndWeather1AppDelegate.ClassSingleton.appDelegate!

        appDelegate.xcgLogger?.info("\(sMessage)")

        return

    }   // End of func xcgLoggerMsg().

}   // End of class CoreLocationModelObservable(NSObject, CLLocationManagerDelegate, ObservableObject).

// --------------------------------------------------------------------------------------------------------------------
//  Examples:
//  *) Points (Lat,Long): https://api.weather.gov/points/39.7456,-97.0892
//  *) Forecast (from 'Points'->"properties"->"forecast": https://api.weather.gov/gridpoints/TOP/32,81/forecast
//  N.Richland Hills, Tx:
//  *) Points: https://api.weather.gov/points/32.8601,-97.2289
//  *) Forecast: https://api.weather.gov/gridpoints/FWD/73,108/forecast
// --------------------------------------------------------------------------------------------------------------------

