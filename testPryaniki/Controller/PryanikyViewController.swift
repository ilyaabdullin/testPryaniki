//
//  ViewController.swift
//  testPryaniki
//
//  Created by Ilya Abdullin on 04/04/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import UIKit

class PryanikyViewController: UIViewController {
    
    let JSONurl = URL.init(string: "https://prnk.blob.core.windows.net/tmp/JSONSample.json")!
    
    var pryanikyData: Pryaniky? {
        didSet {
            getDataActivityIndicator.stopAnimating()
            getDataButton.isEnabled = true
        }
    }

    @IBOutlet weak var getDataActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var getDataButton: UIButton!
    
    @IBOutlet weak var errorLoadJSONDataLabel: UILabel!
    
    @IBAction func getPryanikData(_ sender: UIButton) {
        getDataButton.isEnabled = false
        getDataActivityIndicator.startAnimating()
        errorLoadJSONDataLabel.isHidden = true
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let pryanikyData = try? JSONDecoder().decode(Pryaniky.self, from: Data(contentsOf: self!.JSONurl))
            
            DispatchQueue.main.async {
                if pryanikyData != nil {
                    self?.pryanikyData = pryanikyData
                    self?.performSegue(withIdentifier: "toPryanikyDataTVC", sender: self?.getDataButton)
                }
                else {
                    self?.errorLoadJSONDataLabel.isHidden = false
                    self?.getDataActivityIndicator.stopAnimating()
                    self?.getDataButton.isEnabled = true
                }   
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPryanikyDataTVC" {
            if let pryanikiDataTVC = segue.destination as? PryanikyDataTableViewController {
                pryanikiDataTVC.pryanikyData = pryanikyData
            }
        }
    }    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

