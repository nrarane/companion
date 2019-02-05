//
//  DetailsController.swift
//  companion
//
//  Created by Mushagi MAYIBO on 2018/11/06.
//  Copyright © 2018 Nyameko RARANE. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var correction: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var skillTableView: UITableView!
    @IBOutlet weak var projectsTable: UITableView!
    @IBOutlet weak var level: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    let skillsController:SkillsTableController = SkillsTableController()
    let projectsController:ProjectsTableController = ProjectsTableController()
    
    @IBOutlet weak var fullName: UILabel!
    var user:User!
    override func viewDidLoad() {
        super.viewDidLoad()
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.blue.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        
                self.skillTableView.delegate = self.skillsController
                self.skillTableView.dataSource = self.skillsController
                self.projectsTable.delegate = self.projectsController
                self.projectsTable.dataSource = self.projectsController
        self.loadInfo()
    }
    func setUser(user:User){
        self.user = user;
        // loadInfo()
    }
    
    func loadInfo() {
        userName.text = user.login
        email.text = user.email
        //        correction.text = "correction :" + String(user.correction_point)
        //        wallet.text = "wallet " + String(user.wallet)
        //        level.text = "level " + String(user.cursus_users[0].level)
        fullName.text = user.first_name + " " + user.last_name
        
        if let url = URL(string: user.image_url) {
            image.contentMode = .scaleAspectFit
            downloadImage(from: url)
        }
        
                self.skillsController.skills = self.user.cursus_users[0].skills
                self.skillTableView.reloadData()
                self.projectsController.projectUsers = self.user.projects_users
                self.projectsTable.reloadData()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [unowned self] in
                self.image.image = UIImage(data: data)
                let blurredImage = self.blurImage(usingImage: UIImage(data: data)!, blurAmount: 10)
                
                self.backgroundImage.image = blurredImage
            }
            
        }
    }
    
    func blurImage(usingImage image: UIImage, blurAmount:CGFloat) -> UIImage? {
        guard let ciImage = CIImage(image: image) else {
            return nil
        }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur");
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        
        guard  let outputImage = blurFilter?.outputImage else {
            return nil
        }
        return UIImage(ciImage: outputImage)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
}
