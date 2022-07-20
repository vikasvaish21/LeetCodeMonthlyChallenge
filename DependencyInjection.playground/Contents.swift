import UIKit
import Foundation

var greeting = "Hello, playground"

protocol Driving {
    func startDriving()
    func isDriving() ->  Bool
    func stopDriving()
}

class BMW : Driving {
    func startDriving() {
        
    }
    
    func isDriving() ->  Bool{
        return true
    }
    
    func stopDriving() {
        
    }
    
    
}

class Honda : Driving {
    func startDriving() {
        
    }
    
    func isDriving() ->  Bool{
        return true
    }
    
    func stopDriving() {
        
    }
    
    
}


class SelectedCar{
    
    let car: Driving
    
    init (car : Driving) {
        self.car = car
    }
    
}

var selection = SelectedCar(car: BMW())
var selection2 = SelectedCar(car: Honda())
