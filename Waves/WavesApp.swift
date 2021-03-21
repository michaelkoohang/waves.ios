
import SwiftUI

@main
struct WavesApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject var sptManager = SpotifyManager()
    @State var loggedIn = false

    var body: some Scene {
        WindowGroup {
            if loggedIn {
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
