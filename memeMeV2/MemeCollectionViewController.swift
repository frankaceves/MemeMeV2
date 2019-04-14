//
//  MemeCollectionViewController.swift
//  MemeMe v2.0
//
//  Created by Frank Anthony Aceves on 1/29/18.
//  Copyright © 2018 Frank Aceves. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var memes: [Meme]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionView", for: indexPath) as! MemeCollectionViewCell
        let memeToShow = memes[indexPath.row]
        
        cell.memeImageView.image = memeToShow.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        
        navigationController?.pushViewController(detailController, animated: true)
    }
    
}
