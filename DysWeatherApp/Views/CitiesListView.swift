//
//  ViewController.swift
//  DysWeatherApp
//
//  Created by dan4 on 09.06.2022.
//

import UIKit
import SnapKit

class CitiesListView: UIViewController {
    
    // MARK: - Parametres
    
    var models = [Cities]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorite cities"
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.addTarget(self, action: #selector(stepToSettings), for: .touchUpInside)
        return button
    }()
    
    private var cityField: UITextField = {
        let field = UITextField()
        field.placeholder = "City name..."
        field.borderStyle = .roundedRect
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.08)
        return field
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addCity), for: .touchUpInside)
        return button
    }()
    
    private var viewModel: WeatherViewModel = WeatherViewModel()
    
    var tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        self.getAllItems()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGroupedBackground
        cityField.delegate = self
        
        addConstraints()
        setupBinding()
        handleSwipeDelete()
    }
    
    // MARK: - For deleting rows when we use PageController
    func handleSwipeDelete() {
        guard let pageController = parent as? UIPageViewController else {
            return
        }
        
        pageController.scrollView?.canCancelContentTouches = false
        tableView.gestureRecognizers?.forEach { recognizer in
            let name = String(describing: type(of: recognizer))
            guard name == "_UISwipeActionPanGestureRecognizer" else {
                return
            }
            pageController.scrollView?
                .panGestureRecognizer
                .require(toFail: recognizer)
        }
    }
    
    // MARK: - Binding
    func setupBinding() {
        
        viewModel.weatherData.bind { [weak self] data in
            guard let data = data, let self = self else { return }
            DispatchQueue.main.async {
                
                self.createItem(name: data.name,
                                  temperature: data.main.temp,
                                  tempMax: data.main.tempMax,
                                  visibility: data.visibility,
                                  feelsLike: data.main.feelsLike,
                                  temMin: data.main.tempMin)
                
                self.tableView.reloadData()
            
            }
        }
    
    }
    
    // MARK: - Add constraints
    func addConstraints() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(130)
            make.left.right.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().inset(0)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(45)
        }
        
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(50)
        }
        
        view.addSubview(cityField)
        cityField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(56.5)
            make.top.equalTo(nameLabel).inset(45)
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel).inset(50)
            make.right.equalToSuperview().inset(22)
        }
        
    }
    
    @objc func addCity() {
        viewModel.weatherByCity(name: cityField.text ?? "")
        cityField.resignFirstResponder()
        cityField.text?.removeAll()
    }
    
    // MARK: - Steps to other view controllers
    @objc private func stepToSettings() {
        let settingsVC = SettingsView()
        settingsVC.modalPresentationStyle = .fullScreen
        present(settingsVC, animated: true)
    }
    
    @objc private func stepToCurLoc() {
        dismiss(animated: true)
    }
    
}
