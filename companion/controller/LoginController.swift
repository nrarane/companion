//
//  ViewController.swift
//  companion
//
//  Created by Nyameko RARANE on 2018/11/04.
//  Copyright © 2018 Nyameko RARANE. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    let authService:AuthService = AuthService()
    let apiService:ApiService = ApiService()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    var user:User!
    var processing:Bool = false
    
    @IBOutlet weak var errorText: UILabel!
    
    @IBAction func onSearch(_ sender: Any) {
        
        if let login = textField.text {
            if (processing == false && AppProfile.authToken != nil){
                indicator.startAnimating();
                textField.isHidden = true;
                searchButton.isHidden = true;
                errorText.text = "";
                processing = true
                self.apiService.getUserByLogin(login: login, completion: { (user, error) in
                    self.processing = false
                    self.reset()
                    guard let tempUser = user else {
                        
                        self.displayError()
                        return;
                    }
                    self.showResults(user: tempUser);
                })
            }
        }
    }
    
    func reset() {
        DispatchQueue.main.async { [unowned self] in
            self.textField.isHidden = false;
            self.searchButton.isHidden = false;
            self.indicator.stopAnimating()
        }
    }
    
    func displayError() {
        DispatchQueue.main.async { [unowned self] in
            self.errorText.text = "Could not load profile";
        }
    }
    
    func showResults(user:User){
        DispatchQueue.main.async {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsPage") as! DetailsController
            vc.setUser(user: user)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService.getTokenUsingAppCredentials { (result, error) in
            AppProfile.authToken = result
            print("result " + AppProfile.authToken!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        print("hello")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("hello prepare")
    }
}
