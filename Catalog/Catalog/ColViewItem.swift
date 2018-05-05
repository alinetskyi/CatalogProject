//
//  ColViewItem.swift
//  Catalog
//
//  Created by Uzver on 29/04/2018.
//  Copyright © 2018 Artem Linetskyi. All rights reserved.
//

import Cocoa

class ColViewItem: NSCollectionViewItem {

    @IBOutlet weak var Name: NSTextField!
    @IBOutlet weak var Image: NSImageView!
    @IBOutlet weak var Description: NSTextField!
    @IBOutlet weak var itemReleaseDate: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    override var isSelected: Bool {
        didSet{
            // debug print
            print(" selected")
            if isSelected {
                self.view.layer?.shadowOpacity = 0.8
                self.view.layer?.shadowColor = NSColor.black.cgColor
                self.view.layer?.shadowRadius = 3
            }
            else{
                self.view.layer?.shadowOpacity = 0.0
                self.view.layer?.shadowColor = NSColor.black.cgColor
                self.view.layer?.shadowRadius = 0.0
            }
        }
    }
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        if event.clickCount == 2 {
            
            if self.isSelected == true {
                (self.collectionView?.delegate as! ViewController).editItem(self)
            }
            
        }
        
    }
    
}
