//
//  DataModel.swift
//  Catalog
//
//  Created by Uzver on 02/05/2018.
//  Copyright © 2018 Artem Linetskyi. All rights reserved.
//

import Cocoa

class DataModel {
    
    static let sharedInstance = DataModel()
    fileprivate var DataChanged = false
    fileprivate var strPath: String = ""
    var dataArray:NSMutableArray = []
    var optionalIndexPath: IndexPath? = nil
    var SortAsc:Bool = true
    
    fileprivate init(){
        let strApp = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")
        strPath = NSHomeDirectory() + "/" + (strApp as! String) + "-Datafile.xml"
        if FileManager.default.fileExists(atPath: strPath)
        {
            dataArray = NSMutableArray(contentsOfFile: strPath)!
        }
        
    }
    func addNewRecord (name: String, director: String, description: String, imageurl: URL?,releaseDate:Int32) {
        let dict = ["Name": name, "Director": director, "Description": description,"Image": imageurl!,"Release date":releaseDate] as [String : Any]
        dataArray.add(dict)
        DataChanged = true
    }
    func deleteRecord (_ row: Int){
        dataArray.removeObject(at: row)
        DataChanged = true;
    }
    func updateRecord(_ row: Int, withData data: AnyObject) {
        dataArray[row] = data
        DataChanged = true;
    }
    func saveArray(){
        if(DataChanged){
            dataArray.write(toFile: strPath, atomically: false)
            DataChanged = false;
        }
    }
   
    
    
    
}
