//
//  CoreLocationModelObservable.swift
//  JustACoreLocation1
//
//  Created by Daryl Cox on 7/7/24.
//

import Foundation
import SwiftUI
import CoreLocation

class CoreLocationModelObservable: NSObject, CLLocationManagerDelegate, ObservableObject
{
    
    var locationManager:CLLocationManager?
    
    override init()
    {
        
        super.init()
        
        self.locationManager = CLLocationManager()
        
        self.locationManager?.delegate = self
        
        self.locationManager?.requestWhenInUseAuthorization()
        
        self.requestLocationUpdate()
        
    }
    
    private func requestLocationUpdate()
    {
        
        self.locationManager?.requestLocation()
        
    //  self.locationManager?.startUpdatingLocation()
        
    }
    
    private func stopLocationUpdate()
    {
        
        self.locationManager?.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        guard let location = locations.last
        else { return }
        
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        
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
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        
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
        
    }
    
}

