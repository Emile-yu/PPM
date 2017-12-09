//
//  DetailViewController.swift
//  MesActivite
//
//  Created by m2sar on 01/12/2017.
//  Copyright © 2017 UPMC. All rights reserved.
//

import UIKit

class DetailViewController:UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    fileprivate var maValeur = 0
    
    fileprivate let seg = UISegmentedControl(items:["0","1","2","3","4"])

    
    var newName = UITextField()
    let uneVue = UIView()
    let unLabel = UILabel()
    let deuxLabel = UILabel()
    
    var imagePicker : UIImagePickerController?
    
    var monMaster: MasterViewController?
    
    var image  = UIScrollView()
    
    convenience init(s: Int){
        self.init()
        maValeur = s
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unLabel.textAlignment = .left
        unLabel.text = "Title: "
        deuxLabel.textAlignment = .left
        deuxLabel.text = "Priority: "

        newName.backgroundColor = .white
        newName.delegate = (self as UITextFieldDelegate)
        newName.keyboardType = .default
        newName.borderStyle = .roundedRect
        newName.text = "Nouvelle tache"
        
        /*let s = CGSize(width:(self.navigationController?.navigationBar.frame.size.width)!,height:UIScreen.main.bounds.size.height)
        */
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .camera, target: self, action: #selector(takePhoto))
        
        newName.addTarget(self, action: #selector(changeText(sender:)), for: .allEditingEvents)
        
        seg.addTarget(self, action: #selector(changePrio(sender:)), for: UIControlEvents.valueChanged)
        self.positionner(size: UIScreen.main.bounds.size)
        
        uneVue.addSubview(unLabel)
        uneVue.addSubview(deuxLabel)
        uneVue.addSubview(seg)
        uneVue.addSubview(newName)
        uneVue.addSubview(image)

        
        self.view = uneVue
        
    }
    
    func takePhoto(){
        if (!(imagePicker != nil)){
            imagePicker = UIImagePickerController()
            imagePicker?.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        }
        if( UIImagePickerController.isSourceTypeAvailable(.camera)){
            imagePicker?.sourceType = .camera
            imagePicker?.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            imagePicker?.allowsEditing = true
            
        }else{
            imagePicker?.sourceType = .photoLibrary
            imagePicker?.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            imagePicker?.allowsEditing = true
        }
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    func updateView(cel : UneCellule){
        newName.text = cel.label
        seg.selectedSegmentIndex = cel.priorite
        if(cel.image != nil){
            self.image.addSubview(UIImageView(image: cel.image))
            self.image.setZoomScale(0.2, animated: true)
        }else{
            if(self.image.subviews.count > 0){
                for image in self.image.subviews{
                    image.removeFromSuperview()
                }
            }
        }
        
    }
    
    
    func changeText(sender: UITextField){
        monMaster?.changeTextCellue(string: sender.text!)
    }
    
    func changePrio(sender : UISegmentedControl){
        monMaster?.changePrioCellule(selected: sender.selectedSegmentIndex)
        
    }
    
    
    func positionner(size: CGSize) {
        unLabel.frame = CGRect(x:30, y: 100, width:50 , height: 20)
        newName.frame = CGRect(x:100, y: 90, width:size.width/2 , height: 20)
        deuxLabel.frame = CGRect(x:30, y: 150, width: size.width/2, height: 20)
        seg.frame = CGRect(x:30, y: 200, width:size.width/2, height: 50)
        image.frame = CGRect(x: 10, y: 280, width: size.width - 20, height: size.height/2)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view?.frame = CGRect(x: 0,y: 0,width:size.width, height: size.height)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let mediaType = info[UIImagePickerControllerMediaType] as? String
        if mediaType  == "public.image" {
            let img = info[UIImagePickerControllerEditedImage] as! UIImage
            self.image.addSubview(UIImageView(image: img))
            
            
            self.image.setZoomScale(0.2, animated: true)
            
            monMaster?.changeImageCellule(selected: img)
        }else{
            let a = UIAlertController(title: "PROBLEME", message: "C'est un film", preferredStyle: .actionSheet)
            a.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(a, animated: true, completion: nil)
        }
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
