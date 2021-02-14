
import Foundation

class SpotifyManager: NSObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    
    let SpotifyClientID = "a9a2854c43bc43ddb98f2bedf627bc50"
    let SpotifyRedirectURL = URL(string: "waves://spotify-login-callback")!
    var accessToken = ""
    var playURI = ""

    lazy var configuration = SPTConfiguration(
      clientID: SpotifyClientID,
      redirectURL: SpotifyRedirectURL
    )
    
    lazy var appRemote: SPTAppRemote = {
      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
      appRemote.connectionParameters.accessToken = self.accessToken
      appRemote.delegate = self
      return appRemote
    }()
    
    func login(url: URL) {
        let parameters = appRemote.authorizationParameters(from: url);

        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = access_token
            self.accessToken = access_token
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            // Show the error
        }
    }
    
    func connect() {
        self.appRemote.authorizeAndPlayURI(self.playURI)
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
