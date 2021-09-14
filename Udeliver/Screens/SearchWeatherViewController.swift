//
//  SearchWeatherViewController.swift
//  Udeliver
//
//  Created by Surgeont on 03.09.2021.
//

import UIKit

class SearchWeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? WeatherTableViewCell {
            
            let city = cities[indexPath.row]
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=6cc646457c330dca6fe9e38c37fabf11"
            let url = URL(string: urlString)
            
            
            var temperatute: Double?
            var humidity: Int?
            
            let task = URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    
                    
                    if let main = json["main"] {
                        temperatute = main["temp"] as? Double
                        humidity = main["humidity"] as? Int
                    }
                    
                    let temp: Int = Int(temperatute!) - 273
                    
                    
                    
                    DispatchQueue.main.async {
                        
                        cell.cityLabel.text = city
                        cell.humidLabel.text = "\(humidity!)%"
                        cell.tempLabel.text = "\(temp)°C"
                        cell.feelingLabel.text = self!.tempFeelings(temperatureF: temp)
                        cell.layer.cornerRadius = 20
                        cell.layer.masksToBounds = true
                        
                    }
                    
                    
                } catch let error {
                    print(error.localizedDescription)
                }
                
            }
            task.resume()
            
            return cell
        }
        return UITableViewCell()
    }
    
    
    var cities: [String] = ["Murmansk", "Sochi", "Moscow", "Khabarovsk", "Novosibirsk", "Kazan", "Vladivostok"]
    

    @IBOutlet weak var searchCityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchWeatherInfo: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weatherFeelingInfoSPB: UILabel!
    @IBOutlet weak var weatherInfoLabelSPB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCityLabel.text = "Введите название города"
        searchWeatherInfo.isHidden = true
        
        
        tableView.dataSource = self
        tableView.delegate = self
        

        searchBar.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getWeatherInfoSPB()
    }
    
    func getWeatherInfoSPB() {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Saint%20Petersburg&appid=6cc646457c330dca6fe9e38c37fabf11"
        let url = URL(string: urlString)
        
        
        var temperatute: Double?
        var humidity: Int?
        
        let task = URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                
                if let main = json["main"] {
                    temperatute = main["temp"] as? Double
                    humidity = main["humidity"] as? Int
                }
                
                let temp: Int = Int(temperatute!) - 273
                
                
                
                DispatchQueue.main.async {
                    
                    self?.weatherInfoLabelSPB.text = "\(temp)°C / \(humidity!)%"
                    self?.weatherFeelingInfoSPB.text = self!.tempFeelings(temperatureF: temp)
                    
                }
                
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
        
    
        
        
    }
    
    func tempFeelings(temperatureF: Int) -> String {
        var feeling: String?
        switch temperatureF {
        case -100 ... -27:
            feeling = "Очень холодно"
        case -26 ... -20:
            feeling = "Ухх, морозец"
        case -19 ... -12:
            feeling = "Нормально для зимы"
        case -11 ... -6:
            feeling = "Запахло весной"
        case -5 ... 0:
            feeling = "Всё таить начнёт"
        case 1 ... 4:
            feeling = "Скользко"
        case 5 ... 7:
            feeling = "Нужна куртка потеплее"
        case 8 ... 11:
            feeling = "Бабьего лета уже не будет"
        case 12 ... 16:
            feeling = "Непонятно как одеваться"
        case 17 ... 21:
            feeling = "Тепло Хорошо"
        case 22 ... 26:
            feeling = "Замечательно"
        case 27 ... 50:
            feeling = "Жарко становится"
        default:
            break
        }
        return feeling!
        
    }
    

}


extension SearchWeatherViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))&appid=6cc646457c330dca6fe9e38c37fabf11"
        let url = URL(string: urlString)
        
        var searchLocationName: String?
        var searchTemperatute: Double?
        var searchHumidity: Int?
        var errorIsOccurred: Bool = false
        
        let task = URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let misstake = json["cod"] {
                    let misstakeCode = misstake as? String
                    if misstakeCode == "404" {
                        errorIsOccurred = true
                    }
                }
                
                if let location = json["name"] {
                    searchLocationName = location as? String
                }
                
                if let main = json["main"] {
                    searchTemperatute = main["temp"] as? Double
                    searchHumidity = main["humidity"] as? Int
                }
                
                
                
                DispatchQueue.main.async {
                    
                    if errorIsOccurred == true {
                        self?.searchCityLabel.text = "City Not Found"
                        self?.searchWeatherInfo.isHidden = true
                    } else {
                        self?.searchCityLabel.text = searchLocationName
                        let temp: Int = Int(searchTemperatute!) - 273
                        self?.searchWeatherInfo.text = "Температура: \(temp)°C, влажность: \(searchHumidity!)%"
                        self?.searchWeatherInfo.isHidden = false
                    }
                    
                }
                
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
        
    }
}
