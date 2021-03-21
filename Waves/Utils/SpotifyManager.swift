
import Foundation
import SwiftUI

class SpotifyManager: NSObject, ObservableObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate, SPTSessionManagerDelegate {
    let ApiURL = "https://016e7c736b18.ngrok.io"
    let SpotifyClientID = "a9a2854c43bc43ddb98f2bedf627bc50"
    let SpotifyRedirectURL = URL(string: "waves://spotify-login-callback")!
    var accessToken = ""
    var playURI = ""
    
    lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: SpotifyClientID, redirectURL: SpotifyRedirectURL)
        configuration.playURI = ""
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
        let scope: SPTScope = [.appRemoteControl, .userTopRead, .userReadRecentlyPlayed]
        sessionManager.initiateSession(with: scope, options: .clientOnly)
    }
    
    // MARK: - Session Manager Delegate Methods
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("FAIL")
    }

    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("RENEW")
    }

    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        appRemote.connectionParameters.accessToken = session.accessToken
        appRemote.connect()
        UserDefaultsManager.setLoggedIn(status: true)
    }

    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
      print("connected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
      print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
      print("failed")
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
      print("player state changed")
    }
    
}
