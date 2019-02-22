//
//  ViewController.swift
//  imagePickerTest
//
//  Created by Frank Anthony Aceves on 1/18/18.
//  Copyright © 2018 Frank Aceves. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: PROPERTIES
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    // MARK: TOP NAVBAR
    @IBOutlet weak var navBarTop: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    // MARK: BOTTOM TOOLBAR
    @IBOutlet weak var toolbarBottom: UIToolbar!
    
    
    // MARK: TEXT FIELDS
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    
    // MARK: Text Field Delegate Objects
    let memeTextDelegate = MemeTextDelegate()
    
    
    // MARK: ACTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        shareButton.isEnabled = false
        configureText(topText)
        configureText(bottomText)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: TEXT FIELD ACTIONS
    func configureText(_ textField: UITextField) {
        textField.delegate = memeTextDelegate
        textField.defaultTextAttributes = memeTextDelegate.memeTextAttributes
        textField.textAlignment = .center
        
        if textField == topText {
            textField.text = "TOP"
        } else {
            textField.text = "BOTTOM"
        }
    }
    
    //Cancel button sends user back to Collection or Table View.
    @IBAction func cancelMeme(_ sender: Any) {
        //imagePickerView.image = nil
        //configureText()
        //shareButton.isEnabled = false
        self.dismiss(animated: true, completion: nil)
    }


    // MARK: IMAGE PICKING ACTIONS
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        if sender == albumButton {
            pickerController.sourceType = .photoLibrary
        } else {
            pickerController.sourceType = .camera
        }
        present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: SHOW/HIDE KEYBOARD FUNCTIONS
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomText.isEditing {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: SAVE IMAGE FUNCTIONS
    func toggleToolAndNavBar(_ status: Bool) {
        self.navBarTop.isHidden = status
        self.toolbarBottom.isHidden = status
    }
    
    func generateMemedImage() -> UIImage {
        
        toggleToolAndNavBar(true)
        
        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toggleToolAndNavBar(false)
        
        return memedImage
    }
    
    func save(_ memedImage : UIImage) {
        //Create the Meme Object
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        print(appDelegate.memes.count)
    }
    
    @IBAction func shareMeme(_ sender: UIBarButtonItem) {
        let image = generateMemedImage()
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        
        //completion code suggestion taken from udacity forum mentor
        shareController.completionWithItemsHandler = { (_,successful,_,_) in
            if successful {
                self.save(image)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        self.present(shareController, animated: true, completion: nil)
    }
}
