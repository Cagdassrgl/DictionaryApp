//
//  Kelimeler.swift
//  DictionaryApp
//
//  Created by Çağdaş Sarıgil on 9.06.2023.
//

import Foundation

class Kelimeler {
    var kelime_id: Int?
    var ingilizce: String?
    var turkce: String?
    
    init() {
        
    }
    
    init(kelime_id: Int? = nil, ingilizce: String? = nil, turkce: String? = nil) {
        self.kelime_id = kelime_id
        self.ingilizce = ingilizce
        self.turkce = turkce
    }
}
