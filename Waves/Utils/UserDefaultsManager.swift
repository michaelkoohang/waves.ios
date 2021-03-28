
import Foundation

struct UserDefaultsManager {    
    static private let defaults = UserDefaults.standard
    static private let LOGIN_KEY = "logged_in"
    static private let USERNAME_KEY = "username"
    static private let JWT_KEY = "jwt_token"
    
    static func setLoggedIn(status: Bool) {
        defaults.setValue(status, forKey: LOGIN_KEY)
    }
    
    static func getLoggedIn() -> Bool {
        return defaults.bool(forKey: LOGIN_KEY)
    }
    
    static func setUsername(username: String) {
        defaults.setValue(username, forKey: USERNAME_KEY)
    }
    
    static func getUsername() -> String {
        return defaults.string(forKey: USERNAME_KEY) ?? ""
    }
    
    static func setJwtToken(token: String) {
        defaults.setValue(token, forKey: JWT_KEY)
    }
    
    static func getJwtToken() -> String {
        return defaults.string(forKey: JWT_KEY) ?? ""
    }
    
    static func resetUserDefaults() {
        defaults.removeObject(forKey: LOGIN_KEY)
        defaults.removeObject(forKey: USERNAME_KEY)
        defaults.removeObject(forKey: JWT_KEY)
    }
}
