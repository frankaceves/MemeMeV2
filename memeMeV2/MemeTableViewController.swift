//
//  MemeTableViewController.swift
//  MemeMe v2.0
//
//  Created by Frank Anthony Aceves on 1/29/18.
//  Copyright © 2018 Frank Aceves. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController {
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        self.tableView.reloadData()
    }
    
    
    // MARK: - POPULATE TABLE WITH MEME DATA
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "MemeTableView"
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        let tableMeme = self.memes[indexPath.row]

        cell.imageView?.image = tableMeme.memedImage
        cell.textLabel?.text = "\(tableMeme.topText)...\(tableMeme.bottomText)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[indexPath.row]
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
