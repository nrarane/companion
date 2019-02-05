//
//  ProjectsController.swift
//  companion
//
//  Created by Mushagi MAYIBO on 2018/11/07.
//  Copyright © 2018 Nyameko RARANE. All rights reserved.
//

import UIKit

class ProjectsTableController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    public var projectUsers:[ProjectUsers] = [ProjectUsers]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let projectUser = projectUsers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectUserCell", for: indexPath)
        var mark = 0.0;
        if let tempMark = projectUser.final_mark {
            mark = tempMark
        }
        cell.textLabel?.text = projectUser.project.name + "          " + String(mark)
        
        return cell
    }
    
    
}
