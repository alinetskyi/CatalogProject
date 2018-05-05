//
//  NewMovieController.swift
//  Catalog
//
//  Created by Uzver on 30/04/2018.
//  Copyright © 2018 Artem Linetskyi. All rights reserved.
//

import Cocoa

class NewMovieController: NSViewController {   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    var delegate: AnyObject?
    
    
    
    @IBOutlet weak var txtName: NSTextField!
    @IBOutlet weak var txtDirector: NSTextField!
    @IBOutlet weak var txtDesc: NSTextField!
    @IBOutlet weak var CancelBtn: NSButton!
    @IBOutlet weak var AddMovieBtn: NSButton!
    @IBOutlet weak var Image: NSImageView!
    @IBOutlet weak var ReleaseDate: NSTextField!
    var selectedItem: URL?
    
    
    @IBAction func AddMovie(_ sender: NSButton) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.none
        let formattedNumber = numberFormatter.string(from: NSNumber(value:self.ReleaseDate.intValue))
        
        DataModel.sharedInstance.addNewRecord(name: txtName.stringValue, director: txtDirector.stringValue, description: txtDesc.stringValue, imageurl: self.selectedItem, releaseDate: ReleaseDate.intValue)
        
    
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

        
        dismiss(self)
        
    }
    
    @IBAction func CancelAdd(_ sender: NSButton) {
        dismiss(self)
    }
    
    @IBAction func UploadImage(_ sender: Any) {
        guard let window = view.window else { return }
        
        // 2
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        
        // 3
        panel.beginSheetModal(for: window) { (result) in
            if result.rawValue == NSFileHandlingPanelOKButton {
                // 4
                self.selectedItem = panel.urls[0]
                let imageURL = NSImage(byReferencing: self.selectedItem!)
                self.Image.image = imageURL
                
                
            }
        }
    }
    
}
