
import SwiftUI
import CoreData

struct MainView: View {
    var sptManger: SpotifyManager

    var body: some View {
        VStack {
            Spacer()
            Image("Hand")
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
            Text("Waves")
                .font(Font.custom("SF Pro", size: 50))
            Text("Music Sharing Done Right")
            Spacer()
            WavesButton(text: "Login To Spotify", color: Color.green) {
                sptManger.connect()
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(sptManger: SpotifyManager())
    }
}
