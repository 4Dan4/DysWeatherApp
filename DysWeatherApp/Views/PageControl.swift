//
//  PageControl.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//

import UIKit

class PageControl: UIPageViewController {
    
    // MARK: - Parametres
    var pages: [UIViewController] = [CurrentLocationWeather()]
    
    // MARK: - Iinits
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
            super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        dataSource = self
        delegate = nil
        pages.append(CitiesListView())
        
        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
    
    }
    
}
