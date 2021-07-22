
import SwiftUI

@main
struct WavesApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject var sptManager = SpotifyManager.shared

    var body: some Scene {
        WindowGroup {
            if !sptManager.loggedIn {
                MainView()
                    .onOpenURL { url in
                        SpotifyManager.shared.sessionManager.application(UIApplication.shared, open: url, options: [:])
                    }
            } else {
                HomeView()
            }
        }
        .onChange(of: scenePhase) { phase in
            if UserDefaultsManager.getLoggedIn() {
                if phase == .background {
                    SpotifyManager.shared.appRemote.disconnect()
                }
                if phase == .active {
                    SpotifyManager.shared.appRemote.connect()
                }
            }
        }
    }
}
