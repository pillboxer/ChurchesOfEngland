import SwiftUI
import CollectionKitty

@main
struct ChurchesOfEnglandApp: App {
	@JSON(name: "LondonPack") var londonPack: ChurchPack
    var body: some Scene {
        WindowGroup {
            PacksView(packs: [londonPack])
        }
    }
}

#Preview {
	Text("H")
}
