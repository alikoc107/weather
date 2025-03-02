//
//  ViewController.swift
//  hava durumu
//
//  Created by Ali Koç on 8.05.2024.
//

// 1.Web adresine gideceğiz
// 2. Datayı al
// 3. Datayı işle

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var fellsLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Wheater API"
    }
    
    @IBAction func getButtonClicked(_ sender: Any) {
        // 1.adım
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=40.979492&lon=29.055140&appid=eabf0df70661fc02b23d34798ba427bd")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil{
                print("error")
            } else{
                //2.adım
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                        
                        DispatchQueue.main.async {
                            if let main = jsonResponse!["main"] as? [String:Any]{
                                if let temp = main["temp"] as? Double{
                                    self.currentTempLabel.text = String(Int(temp-272.15))
        
                                }
                                if let feel = main["feels_like"] as? Double{
                                    self.fellsLabel.text = String(Int(feel-272.15))
                                }
                            }
                            
                            
                            if let wind = jsonResponse!["wind"] as? [String:Any]{
                                if let speed = wind["speed"] as? Double{
                                    self.windSpeedLabel.text = String(Int(speed))
                                }
                            }
                        }
                        
                    } catch{
                        
                    }
                }
            }
            
        }
        task.resume()
    }
    


}

