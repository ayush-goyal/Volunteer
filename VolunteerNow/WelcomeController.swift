//
//  WelcomeController.swift
//  VolunteerNow
//
//  Created by Macbook on 10/14/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        welcomeLabel.font = UIFont(name: "Nunito-Bold", size: 42.0)
        signupButton.titleLabel?.font = UIFont(name: "Nunito-SemiBold", size: 19.0)
        loginButton.titleLabel?.font = UIFont(name: "Nunito-SemiBold", size: 19.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
