//
//  ProfileView.swift
//  Legio
//
//  Created by MIkkyMouse on 31/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol ProfileViewProtocol: class {
    
}

class ProfileView: UIViewController {
    
    var cellName = ["Статистика", "Распределение времени", "Интересы", "Log out"]
    
    var presenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    
}

extension ProfileView: ProfileViewProtocol {
    
}

extension ProfileView: UITableViewDelegate, UITableViewDataSource {
    
    
    func configureView() {
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Настройки"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell")
        cell?.textLabel?.text = cellName[indexPath.row]
        cell?.detailTextLabel?.textColor = .gray
        let image = UIImage(named: "profileType")
        let accView = UIImageView(image: image)
        cell?.accessoryView = accView
        cell?.textLabel?.font = UIFont(name: "SF UI Text", size: CGFloat(16))
        if cellName[indexPath.row] == "Log out" {
            cell?.detailTextLabel?.text = ""
            cell?.accessoryView = nil
            cell?.accessoryType = .none
            cell?.textLabel?.textColor = .red
        }
        return cell!
    }
}


// MARK: - Actions
extension ProfileView {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("add")
        case 1:
            presenter.showPreset()
        case 2:
            presenter.showEvent()
        case 3:
            print("add")
        default:
            print("add")
        }
    }
    
}
