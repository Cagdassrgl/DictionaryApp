//
//  Kelimelerdao.swift
//  DictionaryApp
//
//  Created by Çağdaş Sarıgil on 9.06.2023.
//

import Foundation

class Kelimelerdao {
    
    let db: FMDatabase?
    
    init() {
        
        let hedefYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let veritabaniURL = URL(fileURLWithPath: hedefYolu).appendingPathComponent("sozluk.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func getKelimeler() -> [Kelimeler] {
        
        var liste = [Kelimeler]()
        
        db?.open()

        do {
            let rs =  try db!.executeQuery("SELECT * from kelimeler", values: nil)
            
            while rs.next() {
                let kelime = Kelimeler(
                    kelime_id: Int(rs.string(forColumn: "kelime_id")),
                    ingilizce: rs.string(forColumn: "ingilizce"),
                    turkce: rs.string(forColumn: "turkce")
                )
                
                liste.append(kelime)
            }
        } catch  {
                print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
    
    func getKelimelerBySearchText(searchText: String) -> [Kelimeler] {
        
        var liste = [Kelimeler]()
        
        db?.open()

        do {
            let rs =  try db!.executeQuery("SELECT * from kelimeler WHERE ingilizce LIKE '%\(searchText)%'", values: nil)
            
            while rs.next() {
                let kelime = Kelimeler(
                    kelime_id: Int(rs.string(forColumn: "kelime_id")),
                    ingilizce: rs.string(forColumn: "ingilizce"),
                    turkce: rs.string(forColumn: "turkce")
                )
                
                liste.append(kelime)
            }
        } catch  {
                print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
}
