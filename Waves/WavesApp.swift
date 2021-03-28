
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
    }
}
