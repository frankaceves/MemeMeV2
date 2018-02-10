//
//  MemeDetailViewController.swift
//  MemeMe v2.0
//
//  Created by Frank Anthony Aceves on 2/10/18.
//  Copyright © 2018 Frank Aceves. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    // MARK: - PROPERTIES
    
    var meme: Meme!
    
    // MARK: - OUTLETS
    //set image view
    @IBOutlet weak var memeImageView: UIImageView!
    
    // MARK: - LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // pass meme data from table/collection View Controller.
        self.memeImageView.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
