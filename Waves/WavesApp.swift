
import SwiftUI

@main
struct WavesApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let sptManager = SpotifyManager()

    var body: some Scene {
        WindowGroup {
            if !UserDefaultsManager.getLoggedIn() {
                MainView(sptManager: sptManager)
                    .onOpenURL { url in
                        sptManager.sessionManager.application(UIApplication.shared, open: url, options: [:])
                    }
            } else {
                HomeView()
            }
        }
    }
}
