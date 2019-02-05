//
//  SkillsTableController.swift
//  companion
//
//  Created by Mushagi MAYIBO on 2018/11/07.
//  Copyright © 2018 Nyameko RARANE. All rights reserved.
//

import UIKit

class SkillsTableController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    public var skills:[Skill] = [Skill]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let skill = skills[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath)
        
        cell.textLabel?.text = skill.name + "    " + String(skill.level)
        
        return cell
    }
}
