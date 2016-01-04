//
//  ViewController.swift
//  FuncCI
//
//  Created by Chris M on 1/4/16.
//  Copyright © 2016 Christopher Manahan. All rights reserved.
//

import UIKit

typealias CIOption = (name: String, filter: Filter)

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
 
    var pickerSource: [CIOption] = [
        ("Box Blur", FuncCI.boxBlur(5.0)),
        ("Disc Blur", FuncCI.discBlur(5.0)),
        ("Gaussian Blur", FuncCI.gaussianBlur(5.0)),
        ("Motion Blur", FuncCI.motionBlur(5.0)),
        ("Zoom Blur", FuncCI.zoomBlur(5.0)),
        ("Mask", FuncCI.mask(UIImage(named: "tux")!)),
        ("Monochrome", FuncCI.monochrome(UIColor.sepiaColor())),
        ("Vignette", FuncCI.vignette(5.0, intensity: 2.5))
    ]
    
    var selectedSource: [CIOption] = []
    
    func applySelectedFilters() {
        let filter = selectedSource
                        .map { return $0.filter }
                        .reduce(FuncCI.emptyFilter(), combine: >>>)
        
        let img = CIImage(image: UIImage(named: "snoo")!)
        imageView.image = filter(img!).uiImage(img!.extent)
    }
    
    // MARK: - Actions
    @IBAction func ibAdd(sender: AnyObject) {
        let row = pickerView.selectedRowInComponent(0)
        let option = pickerSource[row]
        selectedSource.append(option)
        applySelectedFilters()
        tableView.reloadData()
    }
    
    // MARK: - Table View Datasource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell?.textLabel?.text = selectedSource[indexPath.row].name
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSource.count
    }

    // MARK: Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedSource.removeAtIndex(indexPath.row)
        applySelectedFilters()
        tableView.reloadData()
    }
    
    // MARK: - Picker View Datasource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerSource.count
    }
    
    // MARK: Delegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerSource[row].name
    }
}

