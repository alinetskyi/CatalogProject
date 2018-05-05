//
//  EditMovieController.swift
//  Catalog
//
//  Created by Uzver on 05/05/2018.
//  Copyright © 2018 Artem Linetskyi. All rights reserved.
//

import Cocoa

class EditMovieController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    var delegate: AnyObject?
    var selectedFile: URL?
    
    
    override func viewWillAppear() {
        
        let dict =
            DataModel.sharedInstance.dataArray[DataModel.sharedInstance.optionalIndexPath!.item] as! NSDictionary
        
        self.updateName.stringValue =
            dict.value(forKey: "Name") as! String
        self.updateDescription.stringValue =
            dict.value(forKey: "Description") as! String
        self.updateDirector.stringValue =
            dict.value(forKey: "Director") as! String
        self.updatedImage.image = NSImage(byReferencing: dict.value(forKey: "Image") as! URL)
        self.updatedReleaseDate.intValue = dict.value(forKey: "Release date") as! Int32
        self.selectedFile = dict.value(forKey: "Image") as! URL
        
    }
    
    
    
    
    
    @IBOutlet weak var updateDescription: NSTextField!
    @IBOutlet weak var updateName: NSTextField!
    @IBOutlet weak var updateDirector: NSTextField!
    @IBOutlet weak var updatedImage: NSImageView!
    @IBOutlet weak var updatedReleaseDate: NSTextField!
    
    
    
    
   
    @IBAction func btnUpdate(_ sender: AnyObject) {
        let dict = ["Name": updateName.stringValue, "Director": updateDirector.stringValue, "Description": updateDescription.stringValue, "Image": self.selectedFile,"Release date": self.updatedReleaseDate] as [String : Any]
        
        DataModel.sharedInstance.updateRecord(
            DataModel.sharedInstance.optionalIndexPath!.item, withData: dict as AnyObject)
        
        (self.delegate as! ViewController).reloadItemAtSelectedPath()
        
        dismiss(self)
    }
    
    @IBAction func btnCancel(_ sender: AnyObject) {
        dismiss(self)
    }
    
    
   
    

    
    @IBAction func updateImage(_ sender: Any) {
        guard let window = view.window else { return }
        
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        
        
        panel.beginSheetModal(for: window) { (result) in
            if result.rawValue == NSFileHandlingPanelOKButton {
                // 4
                self.selectedFile = panel.urls[0]
                let imageURL = NSImage(byReferencing: self.selectedFile!)
                self.updatedImage.image = imageURL
                
                
            }
        }
    }
    
    
}

