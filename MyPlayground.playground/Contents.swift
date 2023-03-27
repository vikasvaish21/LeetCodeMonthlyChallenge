import UIKit

var greeting = "Hello, playground"


protocol MyProtocol{
    func addition(_ a: Int,_ b: Int)
    
    
    func subtration(_ a: Int,_ b: Int)
}

class Calculation: MyProtocol{
    
    var delegate : MyProtocol?
    func addition(_ a: Int, _ b: Int) {
        a + b
    }
    
    func subtration(_ a: Int, _ b: Int) {
        a - b
    }
}


var cal = Calculation()
cal.addition(5, 2)
cal.subtration(5, 2)


var closure: (_ number1: Int,_ number2: Int) -> Int = {
    (_ number1: Int,_ number2: Int) in return
    number1 + number2
}
closure(3, 7)


enum Planet: Int{
    case earth = 1
    case mars
    case moon
    case jupiter
    
}

//var plane = Planet.earth
//switch plane{
//case .earth:
//    print(<#T##items: Any...##Any#>)
//case .jupiter:
//    print(<#T##items: Any...##Any#>)
//case .mars:
//    print(<#T##items: Any...##Any#>)
//case .moon:
//    print(<#T##items: Any...##Any#>)
//}

//struct Student: Codable{
//    var marks: Int
//}
//

func addition<T: Numeric>(_ a:  T,_ b:  T) -> T{
    return a * b
}
var a = 2
var b = 5
addition(a, b)

enum WeekDays{
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}


enum SocialPlatform : String,CaseIterable{
    case twitter   = "This is my favourite"
    case facebook  = "I never use this"
    case instagram = "Preety picture"
    case linkedIn  = "I need to start posting here."
}

func shareImage(_ platform: SocialPlatform){
    switch platform{
    case .facebook:
        print("This is where the code would go to share the image on facebook")
    case .instagram:
        print("This is where the code would go to share the image on instagram")
    case .twitter:
        print("This is where the code would go to share the image on twitter")
    case .linkedIn:
        print("This is where the code would go to share the image on linkedIn")
    }
}


func getMyOpinion(_ platform: SocialPlatform){
    print(platform.rawValue)
}
var day = WeekDays.friday
day = .wednesday
day = WeekDays.wednesday
shareImage(.facebook)
shareImage(.instagram)
getMyOpinion(.facebook)
print(SocialPlatform.allCases)


enum SocialMediaPlatform{
    case twitter(follower: Int)
    case youtube(subscribers: Int)
    case instagram
    case linkedIn
}

func getSponsorshipEligibility(for platform: SocialMediaPlatform) {
    switch platform{
    case .twitter(let follower) where  follower > 10_000:
        print("Eligible for sponsored tweet.")
    case .youtube(let subscribers) where subscribers > 25_000:
        print("Eligible for sponsored video.")
    case .instagram,.linkedIn,.twitter,.youtube:
        print("Not Eligible for sponsorship.")
    }
}

getSponsorshipEligibility(for: .twitter(follower: 10_000))
    
let status = "shinny"

