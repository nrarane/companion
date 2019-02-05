//
//  AuthService.swift
//  companion
//
//  Created by Mushagi MAYIBO on 2018/11/05.
//  Copyright © 2018 Nyameko RARANE. All rights reserved.
//

import UIKit

class AuthService: NSObject {
    func getTokenUsingAppCredentials(completion: @escaping ((String?, Error?) -> Void)) {
        let authEndPoint: String = "https://api.intra.42.fr/oauth/token"
        
        let url = URL(string: authEndPoint)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        let requestAppClient = "grant_type=client_credentials&client_id=" + AppProfile.uid + "&client_secret=" + AppProfile.secret;
        
        request.httpBody = requestAppClient.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            guard error == nil else {
                completion(nil, nil)
                return
            }
            guard data != nil else {
                completion(nil, nil)
                return
            }
            if let data = data {
                do {
                    let dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                    
                    if let tempToken = dictonary{
                        let token = (tempToken["access_token"] as! String)
                        completion(token, nil)
                        return
                    }
                }catch let error {
                    print(error)
                }
            }
            completion(nil, nil)
            
        }
        task.resume()
    }
    

}
