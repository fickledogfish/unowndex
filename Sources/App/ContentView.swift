import SwiftUI
import UIComponents

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()

            RemoteImageView(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/495.gif")!)
                .frame(width: 50, height: 50, alignment: .center)

            RemoteImageView(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/4.png")!)
                .frame(width: 50, height: 50, alignment: .center)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro Max")
    }
}
#endif
