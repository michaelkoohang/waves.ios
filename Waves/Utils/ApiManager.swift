
struct ApiManager {
    
    // Login to the Waves API
    static func login(loginData: LoginPost, completion: @escaping (Result<LoginRes, ApiError>) -> ()) {
        guard let url = URL(string: "\(Constants.API_URL)/api/login") else {
            return
        }
        
        let jsonData = try! JSONEncoder().encode(loginData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(LoginRes.self, from: data) {
                    completion(.success(decodedResponse))
                    return
                }
                completion(.failure(.ServerError))
                return
            }
            completion(.failure(.ConnectionError))
            return
        }.resume()
    }
    
    // Get friends for the user
    static func getFriends(completion: @escaping (Result<[Friend], ApiError>) -> ()) {
        guard let url = URL(string: "\(Constants.API_URL)/api/friends") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(UserDefaultsManager.getUsername(), forHTTPHeaderField: "Username")
        request.setValue("Bearer \(UserDefaultsManager.getJwtToken())", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Friend].self, from: data) {
                    completion(.success(decodedResponse))
                    return
                }
                completion(.failure(.ServerError))
                return
            }
            completion(.failure(.ConnectionError))
            return
        }.resume()
    }
    
    // Get radar for a particular user
    static func getRadar(username: String, completion: @escaping (Result<[Song], ApiError>) -> ()) {
        guard let url = URL(string: "\(Constants.API_URL)/api/radar") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(username, forHTTPHeaderField: "Username")
        request.setValue("Bearer \(UserDefaultsManager.getJwtToken())", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Song].self, from: data) {
                    completion(.success(decodedResponse))
                    return
                }
                completion(.failure(.ServerError))
                return
            }
            completion(.failure(.ConnectionError))
            return
        }.resume()
    }
}
