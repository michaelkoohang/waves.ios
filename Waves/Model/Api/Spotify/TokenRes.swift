
struct TokenRes: Codable {
    var accessToken: String
    var tokenType: String
    var expiresIn: Int
    var scope: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
    }
}
