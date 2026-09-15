import SwiftUI

struct Dashboard: View {
    @Binding var CurrentTab: Tabs
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(maxWidth: .infinity, maxHeight: 400)
                    .ignoresSafeArea(edges: .top)
                    .padding(.horizontal, 5)
            }
            Button {
                CurrentTab = .Game
            } label: {
                Text("Game")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding(.horizontal, 10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 1))
            }
            Button {
                CurrentTab = .Passport
            } label: {
                Text("Passport")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding(.horizontal, 10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 1))
            }
            Button {
                CurrentTab = .Trivia
            } label: {
                Text("Trivia")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding(.horizontal, 10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 1))
            }
        }
    }
}

#Preview {
    Dashboard(CurrentTab: .constant(.Dashboard))
}
