//
//  ProjectCellController.swift
//  companion
//
//  Created by Mushagi MAYIBO on 2018/11/07.
//  Copyright © 2018 Nyameko RARANE. All rights reserved.
//

import UIKit

class ProjectCellController: UITableViewCell {
    
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var name: UILabel!
    public var skill:Skill? {
        didSet {
            if let s = skill {
                name.text = s.name
                level.text = String(s.level)
            }
        }
    }
}
