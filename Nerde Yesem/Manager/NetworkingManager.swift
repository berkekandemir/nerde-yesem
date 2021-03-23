//
//  NetworkingManager.swift
//  Nerde Yesem
//
//  Created by Berke Can Kandemir on 22.12.2020.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

class NetworkingManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var datas = [datatype]()
    let objectWillChange = PassthroughSubject<Void, Never>()
    private let locationManager = CLLocationManager()
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        var latitude: String { return "\(locationManager.location?.coordinate.latitude ?? 0)" }
        var longitude: String { return "\(locationManager.location?.coordinate.longitude ?? 0)" }
        
        let url1 = "https://developers.zomato.com/api/v2.1/geocode?lat=\(latitude)&lon=\(longitude)"
        print(url1)
        let api = "3a2700c7b785676cabe23df4e6c380b1"
        
        let url = URL(string: url1)
        var request = URLRequest(url: url!)
    
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(api, forHTTPHeaderField: "user-key")
        request.httpMethod = "GET"
                
        let sess = URLSession(configuration: .default)
        sess.dataTask(with: request) { (data, _, _) in
            
            do{
                
                let fetch = try JSONDecoder().decode(Type.self, from: data!)
                print(fetch)
                
                for i in fetch.nearby_restaurants{
                    
                    
                    DispatchQueue.main.async {
                        
                        self.datas.append(datatype(id: i.restaurant.id,
                                                   name: i.restaurant.name,
                                                   webUrl: i.restaurant.url,
                                                   location: i.restaurant.location))
                    }
                    print(i.restaurant.name)
                }
            }
            catch{
                
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }

    var lastLocation: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }
}

extension NetworkingManager {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        print(#function, statusString)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        print(#function, location)
    }

}
