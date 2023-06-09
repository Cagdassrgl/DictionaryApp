//
//  KelimeDetayViewController.swift
//  DictionaryApp
//
//  Created by Çağdaş Sarıgil on 9.06.2023.
//

import UIKit

class KelimeDetayViewController: UIViewController {

    @IBOutlet weak var turkceLabel: UILabel!
    
    @IBOutlet weak var ingilizceLabel: UILabel!
    
    var kelime: Kelimeler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let k = kelime {
            
            ingilizceLabel.text = k.ingilizce
            turkceLabel.text = k.turkce
        }

    }
    
}
