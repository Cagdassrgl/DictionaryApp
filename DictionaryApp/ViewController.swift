//
//  ViewController.swift
//  DictionaryApp
//
//  Created by Çağdaş Sarıgil on 8.06.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kelimeTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var kelimelerListesi = [Kelimeler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        veritabanıKopyala()
        
        kelimeTableView.dataSource = self
        kelimeTableView.delegate = self
                
        searchBar.delegate = self
        
        kelimelerListesi = Kelimelerdao().getKelimeler()
    }
    
    func veritabanıKopyala() {
        
        let bundleYolu = Bundle.main.path(forResource: "sozluk", ofType: ".sqlite")
        
        let hedefYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYolu).appendingPathComponent("sozluk.sqlite")
        
        if !fileManager.fileExists(atPath: kopyalanacakYer.path) {
            do {
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            } catch  {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            
            let index = sender as? Int
            
            let gidilecekVC = segue.destination as! KelimeDetayViewController
            
            gidilecekVC.kelime = kelimelerListesi[index!]
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kelimelerListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kelime = kelimelerListesi[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kelimeHucre", for: indexPath) as! KelimeTableViewCell
        
        cell.ingilizceLabel.text = kelime.ingilizce
        cell.turkceLabel.text = kelime.turkce
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            kelimelerListesi = Kelimelerdao().getKelimeler()
        }else {
            kelimelerListesi = Kelimelerdao().getKelimelerBySearchText(searchText: searchText)
        }
        
        self.kelimeTableView.reloadData()
        
    }
}

