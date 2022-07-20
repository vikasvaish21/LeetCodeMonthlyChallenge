import UIKit

var greeting = "Hello, playground"

protocol Mammal{
    func eat()
    func sleep()
}

protocol Humans: Mammal{
    func goToWork()
    func buyAHouse()
}

protocol Animal: Mammal{
    func Hunt()
}

class Person:Humans{
    
    func goToWork() {
        debugPrint("Person goes to work")
    }
    
    func buyAHouse() {
        debugPrint("person buy a House")
    }
    
    func eat() {
        debugPrint("Person eat food")
    }
    
    func sleep() {
        debugPrint("Person sleeps")
    }
    
}

class Lion: Animal{
    func Hunt() {
        <#code#>
    }
    
    
    func eat() {
        <#code#>
    }
    
    func sleep() {
        <#code#>
    }
    
    
}
