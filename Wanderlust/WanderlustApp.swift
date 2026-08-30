import SwiftUI

@main
struct WanderlustApp: App {
    var body: some Scene {
        WindowGroup {
            dashboard(currentTab: .constant(.Dashboard))
        }
    }
}
