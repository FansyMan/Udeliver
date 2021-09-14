import UIKit

func someFunc() {

    DispatchQueue.main.sync {

        print("hello")

    }

}

 
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:

[UIApplication.LaunchOptionsKey: Any]?) -> Bool {

   someFunc()

    return true

  }
