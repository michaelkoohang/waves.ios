
import Foundation

struct UserDefaultsManager {
    static private let defaults = UserDefaults.standard
    static private let LOGIN_KEY = "logged_in"
    
    static func setLoggedIn(status: Bool) {
        defaults.setValue(status, forKey: LOGIN_KEY)
    }
    
    static func getLoggedIn() -> Bool {
        return defaults.bool(forKey: LOGIN_KEY)
    }
}
