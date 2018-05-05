//
//  ViewController.swift
//  Catalog
//
//  Created by Uzver on 29/04/2018.
//  Copyright © 2018 Artem Linetskyi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource {
   
   
    @IBOutlet weak var ColView: NSCollectionView!
    @IBOutlet weak var SearchFld: NSSearchField!
    
    
    
    let DM = DataModel.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ColView.delegate = self
        ColView.dataSource = self
        
        let item = NSNib(nibNamed:NSNib.Name(rawValue: "ColViewItem"),bundle:nil)
        
        ColView.register(item,forItemWithIdentifier:NSUserInterfaceItemIdentifier(rawValue: "ColViewItem"))
        
        ColView.isSelectable = true
        ColView.allowsMultipleSelection = true
        ColView.allowsEmptySelection = true
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func loadList(){
        //load data here
        self.ColView.reloadData()
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return DM.dataArray.count;
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ColViewItem"), for: indexPath) as! ColViewItem
        let dict = DM.dataArray[indexPath.item] as! NSDictionary
        if dict.value(forKey: "Name") != nil
        {
                let strName = dict.value(forKey: "Name") as! String
                let strDescription = dict.value(forKey: "Description") as! String
                let Image = NSImage(byReferencing: dict.value(forKey: "Image") as! URL)
                let strReleaseDate = dict.value(forKey: "Release date") as! Int32
                item.itemReleaseDate.intValue = strReleaseDate
                item.Image.image = Image
                item.Description.stringValue = strDescription
                item.Name.stringValue = strName
        }
        while (SearchFld.stringValue != "") {
            
        }
        
        
        
        
        if DM.optionalIndexPath != nil {
            
            
            if indexPath == DM.optionalIndexPath! as IndexPath {
                // set the item.isSelected property to trigger the observer
                item.isSelected = true
            }
        }
        
        return item
    }
    
   
    
    
    
    
    func collectionView(_ collectionView: NSCollectionView,
                        didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        if let path = indexPaths.first {
            print("Selected item: " + String(path.item))
            DM.optionalIndexPath = path
        } else {
            print("selected item was NIL! ")
            
        }
        
    }
    
    // Deselected
    func collectionView(_ collectionView: NSCollectionView,
                        didDeselectItemsAt indexPaths: Set<IndexPath>) {
        
        if let path = indexPaths.first {
            print("Deslelected item: " + String(path.item))
            DM.optionalIndexPath = nil
        } else {
            print("Deselected item was NIL! ")
            
        }
    }
    
    
  
    func reloadItemAtSelectedPath() {
        
        // create a Set of indexPaths
        var pathSet = Set<IndexPath>()
        
        // insert selected indexPath in Set
        pathSet.insert(DM.optionalIndexPath! as IndexPath)
        
        // call collection view method to update/refresh single collection view item
        ColView.reloadItems(at: pathSet)
    }
    
    // Action methods
    
    
    @IBAction func btnDelete(_ sender: AnyObject) {
        
        // Delete a selected contact item
        guard DM.optionalIndexPath != nil else {
            // nothing selected
            return
        }
        
        
        let dict: NSDictionary =
            DM.dataArray[DM.optionalIndexPath!.item] as! NSDictionary
        
        let strName = dict.value(forKey: "Name") as! String
        
        
        
        let alert = NSAlert()
        alert.addButton(withTitle: "Delete")
        alert.addButton(withTitle: "Cancel")
        
        alert.informativeText = "Really delete movie: "  + strName + "?"
        alert.messageText = "Deleting Movie!"
        
        if alert.runModal().rawValue == 1000 {
            
            // remove contact from array, then reload colView
            DM.deleteRecord(DM.optionalIndexPath!.item)
            
            // remove selection
            DM.optionalIndexPath = nil
            
            ColView.reloadData()
        }
    }
    
    
    func editItem(_ sender: AnyObject) {
        performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "showEditMovieView"), sender: self)
    }
    
    
    // segue methods
    override func prepare(for segue: NSStoryboardSegue,
                          sender: Any?) {
        
        if segue.identifier!.rawValue == "showNewMovieView" {
            
            let NVC = segue.destinationController as!
            NewMovieController
            NVC.delegate = self
        }
        
        if segue.identifier!.rawValue == "showEditMoviewView" {
            
            let UVC = segue.destinationController as! EditMovieController
            UVC.delegate = self
        }
    }
    
    
    func shouldPerformSegue(withIdentifier
        identifier: String, sender: Any?) -> Bool {
        
        if identifier == "showAddNewSheetView" {
            return true
            
        } else {
            
            // edit selected
            if DM.optionalIndexPath == nil {
                // debug print
                print(" no item selected ")
                return false
            } else {
                return true
            }
        }
    }
}

