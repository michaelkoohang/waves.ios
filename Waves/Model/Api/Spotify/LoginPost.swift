
struct LoginPost: Codable {
    var authToken: String
    var refreshToken: String
    var service: String
}
