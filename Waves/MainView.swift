
import SwiftUI
import CoreData

struct MainView: View {
    var sptManger: SpotifyManager

    var body: some View {
        Button(action: {
            sptManger.connect()
        }) {
            Text("Login to Spotify")
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
