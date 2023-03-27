import UIKit

var greeting = "Hello, playground"

func someFunctionTakesClosures(closure : () -> Void){
    closure()
}


someFunctionTakesClosures(closure: {
    print("Hello")
})
someFunctionTakesClosures(){
    print("This is from another closure")
}


func getData(url: String,completion: (String) -> Void) {
    completion("Something else")
}

//getData(url: "www.google.com") { string in
//    print(string)
//}
getData(url: "www.yahoo.com") { myString in
    print("my name is Vikas")
}

var closure: (_ number1: Int,_ number2: Int) -> Int = {
    (number1, number2) in return
    number1 + number2
}

closure(3, 6)

// MARK: - Lazy

class AnalyticsLogger{
    
    
    func logEnded(){
        
    }
    func logStarted(){
        
    }
}
    


class MyThing {
   lazy var analyticsLogger = AnalyticsLogger()
    
    func userTappedButton() {
        analyticsLogger.logStarted()
    }
}

let thing = MyThing()
thing.analyticsLogger.logEnded()
