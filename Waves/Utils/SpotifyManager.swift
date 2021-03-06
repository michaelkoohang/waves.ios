
import Foundation
import SwiftUI

class SpotifyManager: NSObject, ObservableObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate, SPTSessionManagerDelegate {
    let ApiURL = Constants.API_URL
    let SpotifyClientID = "a9a2854c43bc43ddb98f2bedf627bc50"
    let SpotifyRedirectURL = URL(string: "waves://spotify-login-callback")!
    var accessToken = UserDefaultsManager.getAccessToken() {
        didSet {
            UserDefaultsManager.setAccessToken(token: accessToken)
        }
    }
    var refreshToken = UserDefaultsManager.getRefreshToken() {
        didSet {
            UserDefaultsManager.setRefreshToken(token: refreshToken)
        }
    }
    var playURI = "spotify:track:7p5bQJB4XsZJEEn6Tb7EaL"
    
    static let shared = SpotifyManager()
    override private init() {}

    @Published var loggedIn = UserDefaultsManager.getLoggedIn()
    
    lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: SpotifyClientID, redirectURL: SpotifyRedirectURL)
        configuration.tokenSwapURL = URL(string: "\(ApiURL)/api/token")
        configuration.tokenRefreshURL = URL(string: "\(ApiURL)/api/refresh_token")
        return configuration
    }()
    
    lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
        return manager
    }()
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()
    
    func loginWithScopes() {
        let scope: SPTScope = [.appRemoteControl, .userReadPrivate, .userTopRead, .userReadRecentlyPlayed]
        sessionManager.initiateSession(with: scope, options: .clientOnly)
    }
    
    // MARK: - Session Manager Delegate Methods
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        
    }

    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("RENEW")
    }

    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        appRemote.connectionParameters.accessToken = session.accessToken
        self.refreshToken = session.refreshToken
        self.accessToken = session.accessToken
        self.appRemote.connect()

        let loginPost = LoginPost(authToken: session.accessToken, refreshToken: session.refreshToken, service: "spotify")
        ApiManager.login(loginData: loginPost) { [self] res in
            switch res {
            case .success(let data):
                UserDefaultsManager.setUsername(username: data.username)
                UserDefaultsManager.setJwtToken(token: data.token)
                UserDefaultsManager.setLoggedIn(status: true)
                DispatchQueue.main.async {
                    self.loggedIn = true
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("connected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        reconnect()
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("player state changed")
    }
    
    func play(uri: String) {
        appRemote.playerAPI?.play(uri, callback: defaultCallback)
    }
    
    func pause() {
        appRemote.playerAPI?.pause(defaultCallback)
    }
    
    func resume() {
        appRemote.playerAPI?.resume(defaultCallback)
    }
    
    var defaultCallback: SPTAppRemoteCallback {
        get {
            return {[weak self] _, error in
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    private func reconnect() {
        ApiManager.refreshToken(refreshToken: UserDefaultsManager.getRefreshToken()) { res in
            switch res {
            case .success(let data):
                self.accessToken = data.accessToken
                self.appRemote.authorizeAndPlayURI(self.playURI)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
