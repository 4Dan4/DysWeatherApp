//
//  UIPageViewControllerExt.swift
//  DysWeatherApp
//
//  Created by dan4 on 12.06.2022.
//

import UIKit

// MARK: - Extension for UIPageController
extension UIPageViewController {

    var scrollView: UIScrollView? {
        return view.subviews.first { $0 is UIScrollView } as? UIScrollView
    }

}
