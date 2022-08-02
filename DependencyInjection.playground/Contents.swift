import UIKit

protocol Engine {
     func startEngine()
     func stopEngine()
 }
 
 class TrainEngine: Engine {
     func startEngine() {
         print("Engine started")
     }
     
     func stopEngine() {
         print("Engine stopped")
     }
 }
 
 protocol TrainCar {
 var numberOfSeats: Int { get }
 func attachCar(attach: Bool)
}
class RestaurantCar: TrainCar {
    var numberOfSeats: Int {
        get {
            return 30
        }
    }
    func attachCar(attach: Bool) {
        print("Attach car")
    }
}

class PassengerCar: TrainCar {
    var numberOfSeats: Int {
        get {
            return 50
        }
    }
    func attachCar(attach: Bool) {
        print("Attach car")
    }
}
    
class Train {
    let engine: Engine?
    var mainCar: TrainCar?
//MARK: constructor Injection
    init(engine: Engine){
        self.engine = engine
    }
}



let train = Train(engine: TrainEngine())
// MARK: Property Injection
train.mainCar = PassengerCar()
