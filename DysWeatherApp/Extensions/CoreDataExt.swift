//
//  CoreDataExt.swift
//  DysWeatherApp
//
//  Created by dan4 on 12.06.2022.
//

import UIKit

extension CurrentLocationWeather {
    
    func getAllItems() {
        do {
            models = try context.fetch(Cities.fetchRequest())
            DispatchQueue.main.async {
//                self.tableView.reloadData()
            }
        }
        catch {
            // error
        }
    }
    
    func createItem(name: String, temperature: Double, tempMax: Double, visibility: Int, feelsLike: Double, temMin: Double ) {
        let newItem = Cities(context: context)
        
        newItem.name = name
        newItem.temperature = temperature
        newItem.visibility = Int16(visibility)
        newItem.feelsLike = feelsLike
        newItem.tempMin = temMin
        newItem.tempMax = tempMax

        getAllItems()
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func deleteItem(item: Cities) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
}


// MARK: - CoreData functions
extension CitiesListView {
    
    func getAllItems() {
        do {
            models = try context.fetch(Cities.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            // error
        }
    }
    
    func createItem(name: String, temperature: Double, tempMax: Double, visibility: Int, feelsLike: Double, temMin: Double ) {
        let newItem = Cities(context: context)
        
        newItem.name = name
        newItem.temperature = temperature
        newItem.visibility = Int16(visibility)
        newItem.feelsLike = feelsLike
        newItem.tempMin = temMin
        newItem.tempMax = tempMax

        getAllItems()
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func deleteItem(item: Cities) {
        context.delete(item)
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
}
