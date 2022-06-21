//
//  TableViewExt.swift
//  DysWeatherApp
//
//  Created by dan4 on 12.06.2022.
//

import UIKit
// MARK: - UITableViewDelegate, UITableViewDataSource
extension CitiesListView: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = models[indexPath.row]
        cell.textLabel?.text = city.name! + " \(city.tempMax)K"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = models[indexPath.row]
        
        let controller = WeatherDetailView()
        controller.city = item
        present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = models[indexPath.row]
        
        if editingStyle == .delete {
            
            self.deleteItem(item: item)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
}
