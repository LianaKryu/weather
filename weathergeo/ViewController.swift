//
//  ViewController.swift
//  weathergeo
//
//  Created by LianaKryu on 24.11.2020.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UISearchBarDelegate {
    
    struct City {
        var name: String
        var temp: String
        var icon: String
        var time: String
        var lat: String
        var lon: String
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tmeLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        getCityDetail(name: "Москва")
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let name = searchBar.text {
            getCityDetail(name: name)
        }
    }
    
    func getCityDetail(name: String) -> (Double, Double) {
        var lat = 0.0
        var lon = 0.0
        let token = "bb6d29b11d044d2ba7881210201811"
        let url = "http://api.weatherapi.com/v1/current.json?key=\(token)&q=\(name)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(url as! URLConvertible, method: .get).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.nameLabel.text = name
                self.tempLabel.text = json["current"]["temp_c"].stringValue
                let iconString = "https:\(json["current"]["condition"]["icon"].stringValue)"
                self.iconImage.image = UIImage(data: try! Data(contentsOf: URL(string: iconString)!))
                self.tmeLabel.text = json["location"]["localtime"].stringValue
                self.latLabel.text = json["location"]["lat"].stringValue
                self.lonLabel.text = json["location"]["lon"].stringValue
                lat = json["location"]["lat"].doubleValue
                lon = json["location"]["lon"].doubleValue
                print("lat: \(lat), lon: \(lon)")
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        print("lat: \(lat), lon: \(lon)")
        return (lat, lon)
        }

    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //      if segue.identifier == "showmap" {
  //          let vc = segue.destination as! MapViewController
   //         vc.lat = latLabel.text
            
            
 //       }
  //  }
}


