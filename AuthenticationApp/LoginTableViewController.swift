//
//  LoginTableViewController.swift
//  AuthenticationApp
//
//  Created by MD Tanvir Alam on 27/4/21.
//

import UIKit

class LoginTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
