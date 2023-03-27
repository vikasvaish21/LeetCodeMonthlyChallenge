//
//  Service.swift
//  nykaaProject
//
//  Created by Vikas Vaish on 04/10/22.
//

import Foundation

protocol passDataProtocol:AnyObject{
    func passResult(_ data: Welcome)
}


class Service{
    var endPoint = "https://gist.githubusercontent.com/sanjeevkumargautam-nykaa/a2ab56f3a0973bd415a41b10906a0683/raw/15136211cf4e810abaa19dc0ec77641cd518cc26/products.json"
    weak var delegate : passDataProtocol?
    func getData(){
        guard let urlRequest = URL(string: endPoint) else { return  }
        var task = URLSession.shared.dataTask(with: urlRequest) {[weak self] data, dataResponse, error in
            if data != nil && error == nil{
                do {
                    let result = try JSONDecoder().decode(Welcome.self, from: data!)
                    if result != nil{
                        self?.delegate?.passResult(result)
                    }
                } catch{
                    print(error.localizedDescription.description)
                }
            }
        }
        task.resume()
    }
}
