import UIKit

class LocatonManager{
    static let shared = LocatonManager()
    
    private init(){}
    
    var locationGranted : Bool?
    
    
    func requestForLocation(){
        print("Location granted")
    }
}

LocatonManager.shared.requestForLocation()
print(LocatonManager.shared.locationGranted ?? false)
