//
//  SettingsView.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//

import UIKit
import SnapKit

class SettingsView: UIViewController {
    
    // MARK: - Parametres
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(button.tintColor, for: .normal)
        button.addTarget(self, action: #selector(stepToCitiesList), for: .touchUpInside)
        return button
    }()
    
    private lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Color theme"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var themeSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(self, action: #selector(setOn), for: .allTouchEvents)
        return switcher
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var locationSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(self, action: #selector(setOn), for: .allTouchEvents)
        return switcher
    }()
    
    private var switcher = 1
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        addConstraints()
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(45)
            make.left.equalToSuperview().inset(20)
        }
    
        view.addSubview(themeLabel)
        themeLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton).inset(40)
            make.left.equalToSuperview().inset(20)
        }
        
        view.addSubview(themeSwitch)
        themeSwitch.snp.makeConstraints { make in
            make.top.equalTo(backButton).inset(35)
            make.right.equalToSuperview().inset(20)
        }
        
        view.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(themeLabel).inset(40)
            make.left.equalToSuperview().inset(20)
        }
        
        view.addSubview(locationSwitch)
        locationSwitch.snp.makeConstraints { make in
            make.top.equalTo(themeSwitch).inset(40)
            make.right.equalToSuperview().inset(20)
        }
        
    }
    
    // MARK: - Steps to other view controllers
    @objc private func stepToCitiesList() {
        dismiss(animated: true)
    }
    
    @objc func setOn(_ sender: UISwitch) {
        if sender.isOn {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
    }
    
}
