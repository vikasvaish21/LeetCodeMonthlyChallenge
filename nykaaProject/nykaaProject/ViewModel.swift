//
//  ViewModel.swift
//  nykaaProject
//
//  Created by Vikas Vaish on 04/10/22.
//

import Foundation

protocol viewControllerProtocol: AnyObject{
    func getResultData(_ data: Welcome?)
}


class ViewModel {
    var service = Service()
    var result : Welcome?
    weak var viewControllerDelegate: viewControllerProtocol?
    
    
    
    func getResultFromGetData(){
        service.getData()
    }
}

extension ViewModel: passDataProtocol{
    func passResult(_ data: Welcome) {
        result = data
        viewControllerDelegate?.getResultData(result)
    }
    
    
}
