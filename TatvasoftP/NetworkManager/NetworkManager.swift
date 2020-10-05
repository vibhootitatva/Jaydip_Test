//
//  NetworkManager.swift
//  PracticleVedSoft
//
//  Created by Jaydip's Mackbook on 07/08/20.
//  Copyright © 2020 Jaydip's Mackbook. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func APICall(strUrl:String,isLoaderShow:Bool, success:@escaping (_ responseObject:[String:Any]?)-> Void){
        
        
        switch checkInternetConnection(){
            
        case .available:
            if isLoaderShow{
                APPDEL.window?.rootViewController?.showLoader()
            }
            var request = URLRequest(url: URL(string: strUrl)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                DispatchQueue.main.async {
                    APPDEL.window?.rootViewController?.dissmissLoader()
                }
                print(response!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    success(json)
                } catch {
                    print("error")
                    success(nil)
                }
            })
            task.resume()
        case .notAvailable:
            
            APPDEL.window?.rootViewController?.showAlertView("Network error” and message “Unable to contact the server", completionHandler: { (_) in
                
            })
        }
        
    }
    
    // MARK: - No Internet Connection
    func checkInternetConnection() -> NetworkConnection {
        if Config.isNetworkAvailable() {
            return .available
        }
        return .notAvailable
    }
}

enum NetworkConnection {
    case available
    case notAvailable
}

// Configure
struct Config {
    
    // MARK: Reachability class
    static func isNetworkAvailable() -> Bool {
        let reachability: Reachability = Reachability.forInternetConnection()
        let networkStatus = reachability.currentReachabilityStatus().rawValue;
        var isAvailable  = false;
        
        switch networkStatus {
        case (NotReachable.rawValue):
            isAvailable = false;
            break;
        case (ReachableViaWiFi.rawValue):
            isAvailable = true;
            break;
        case (ReachableViaWWAN.rawValue):
            isAvailable = true;
            break;
        default:
            isAvailable = false;
            break;
        }
        return isAvailable;
    }
}
