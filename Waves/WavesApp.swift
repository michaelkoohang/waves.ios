
import SwiftUI

@main
struct WavesApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let sptManager = SpotifyManager()
    
    var body: some Scene {
        WindowGroup {
//            MainView(sptManger: sptManager)
//                .onOpenURL { (url) in
//                    sptManager.login(url: url)
//                }
            HomeView()
        }
    }
}
