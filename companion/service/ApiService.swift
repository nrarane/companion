//
//  ApiService.swift
//  companion
//
//  Created by Mushagi MAYIBO on 2018/11/05.
//  Copyright © 2018 Nyameko RARANE. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    func getUserByLogin(login: String, completion: @escaping ((User?, Error?) -> Void)) {
        let auth:String = AppProfile.authToken!;
        
        let authEndPoint: String = "https://api.intra.42.fr/v2/users/" + login
        
        let url = URL(string: authEndPoint)
        
        var request = URLRequest(url: url!)
        
        let bearerString = "Bearer " + auth
        request.setValue(bearerString, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
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
            do {
                guard let user = try? JSONDecoder().decode(User.self, from: data!) else {
                    print("Error: Couldn't decode data")
                    completion(nil, nil)
                    return
                }
                completion(user , nil)
                return;
            }
        }
        task.resume()
    }
}
