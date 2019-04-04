//
//  PryanikySimpleTextViewController.swift
//  testPryaniki
//
//  Created by Ilya Abdullin on 04/04/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import UIKit

class PryanikySimpleTextViewController: UIViewController {
    
    var textViewText: String?
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        textView.text = textViewText
    }
}
