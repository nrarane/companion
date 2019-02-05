//
//  User.swift
//  companion
//
//  Created by Mushagi MAYIBO on 2018/11/05.
//  Copyright © 2018 Nyameko RARANE. All rights reserved.
//

import UIKit

struct User:Decodable {
    var id:Int
    var email:String
    var login:String
    var first_name: String
    var last_name: String
    var displayname: String
    var image_url: String
    var correction_point: Int
    var wallet: Int
    var cursus_users: [CurcusUsers]
    var projects_users: [ProjectUsers]
}

struct CurcusUsers:Decodable {
    var level: Double
    var skills : [Skill]
}

struct Skill:Decodable {
    var id: Int
    var name: String
    var level: Double
}

struct ProjectUsers:Decodable {
    var final_mark:Double?
    var status : String
    var project: Project
}

struct Project:Decodable {
    var name:String;
}
