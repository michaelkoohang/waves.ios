
import SwiftUI

@main
struct WavesApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject var sptManager = SpotifyManager()

    var body: some Scene {
        WindowGroup {
            if !sptManager.loggedIn {
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
