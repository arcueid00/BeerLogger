//
//  InputAPIKeyViewController.swift
//  BeerLogger
//
//  Created by Katsuhiko Tamura on 2018/11/28.
//  Copyright © 2018 Katsuhiko Tamura. All rights reserved.
//

import UIKit

class InputAPIKeyViewController: UIViewController {
    
    @IBOutlet weak var OKButton: UIButton!
    var apiKeyString : String = ""
    
    let userDefaults = UserDefaults.standard

    @IBOutlet weak var APIKeyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        APIKeyTextField.text = apiKeyString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPushOKButton(_ sender: Any) {
        userDefaults.set(APIKeyTextField.text, forKey: "APIKey")
        self.dismiss(animated: true, completion: nil)
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
