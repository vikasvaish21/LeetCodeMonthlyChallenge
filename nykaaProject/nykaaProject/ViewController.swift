//
//  ViewController.swift
//  nykaaProject
//
//  Created by Vikas Vaish on 04/10/22.
//

import UIKit

class ViewController: UIViewController {
    var viewModel = ViewModel()
    var tableView = UITableView()
    var dataResponse : Welcome?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.getResultFromGetData()
        tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
        // Do any additional setup after loading the view.
    }

}

extension ViewController: viewControllerProtocol {
    
    func getResultData(_ data: Welcome?) {
        dataResponse = data
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataResponse?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: , for: indexPath)
    }
    
    
}
