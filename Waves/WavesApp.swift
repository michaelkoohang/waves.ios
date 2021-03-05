
import SwiftUI

@main
struct WavesApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let sptManager = SpotifyManager()
    
    var body: some Scene {
        WindowGroup {
            if !UserDefaultsManager.getLoggedIn() {
                MainView(sptManger: sptManager)
                    .onOpenURL { (url) in
                        sptManager.login(url: url)
                        UserDefaultsManager.setLoggedIn(status: true)
                    }
            } else {
                HomeView()
            }
        }
    }
}
