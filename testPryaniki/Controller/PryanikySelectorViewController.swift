//
//  PryanikySelectorViewController.swift
//  testPryaniki
//
//  Created by Ilya Abdullin on 04/04/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import UIKit

class PryanikySelectorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var selectorData: PryanikyData?
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.dataSource = self
        picker.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        picker.selectRow(selectorData?.getIndexForSelectedVariant() ?? 0, inComponent: 0, animated: true)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectorData?.getVariantValues()?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectorData?.getVariantValues()?[row] ?? ""
    }
}
