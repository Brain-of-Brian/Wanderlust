import SwiftUI

struct dashboard: View {
    @Binding var currentTab: Tabs
    var body: some View {
        Text("Dashboard")
        Button {
        currentTab = .Game
        } label: {
            Text("Game")
        }
        Button {
        currentTab = .Passport
        } label: {
            Text("Passport")
        }
        Button {
        currentTab = .Trivia
        } label: {
            Text("triva")
        }
    }
}
#Preview{
    dashboard(currentTab: .constant(.Dashboard))
}
