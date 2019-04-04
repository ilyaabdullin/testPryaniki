//
//  PryanikyPictureViewController.swift
//  testPryaniki
//
//  Created by Ilya Abdullin on 04/04/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import UIKit

class PryanikyPictureViewController: UIViewController {
    
    var imageURL: URL?
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            activityIndicator?.stopAnimating()
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            if isValidUrl(url: imageURL!.absoluteString) {
                activityIndicator.startAnimating()
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    let urlContents = try? Data(contentsOf: self!.imageURL!)
                    DispatchQueue.main.async {
                        if let imageData = urlContents, url == self?.imageURL {
                            self?.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }

    private func isValidUrl(url: String) -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: url)
        return result
    }
}
