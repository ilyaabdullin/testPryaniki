//
//  TableViewController.swift
//  testPryaniki
//
//  Created by Ilya Abdullin on 04/04/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import UIKit

class PryanikyDataTableViewController: UITableViewController {

    var pryanikyData: Pryaniky?

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pryanikyData?.view.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pryanikyDataReusableCell", for: indexPath)
        let pryanikyViewName = pryanikyData!.view[indexPath.row]
        let pryanikyDataCurItem = pryanikyData?.getData(by: pryanikyViewName)
        
        cell.textLabel?.text = pryanikyDataCurItem?.data.text ?? pryanikyDataCurItem?.getSelectedVariant()?.text ?? ""
        cell.detailTextLabel?.text = pryanikyViewName

        return cell
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let pryanikyViewName = pryanikyData!.view[indexPath.row]
        let pryanikyDataCurItem = pryanikyData?.getData(by: pryanikyViewName)
        
        switch pryanikyDataCurItem?.name {
        case "picture":
            performSegue(withIdentifier: "toPictureView", sender: indexPath)
        case "selector":
            performSegue(withIdentifier: "toSelectorView", sender: indexPath)
        default:  //hz
            performSegue(withIdentifier: "toSimpleLabelView", sender: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath {
            let pryanikyViewName = pryanikyData!.view[indexPath.row]
            let pryanikyDataCurItem = pryanikyData?.getData(by: pryanikyViewName)
            
            switch segue.identifier {
            case "toSimpleLabelView":
                if let simpleTextVC = segue.destination as? PryanikySimpleTextViewController  {
                    simpleTextVC.textViewText = pryanikyDataCurItem?.data.text
                }
            case "toPictureView":
                if let simpleTextVC = segue.destination as? PryanikyPictureViewController  {
                    simpleTextVC.imageURL = URL(string: (pryanikyDataCurItem?.data.url)!)
                }
            case "toSelectorView":
                if let simpleTextVC = segue.destination as? PryanikySelectorViewController  {
                    simpleTextVC.selectorData = pryanikyDataCurItem
                }
            default:
                break
            }
        }
    }
}
