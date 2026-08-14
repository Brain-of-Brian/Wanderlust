import SwiftUI

// finder dashboard
struct Dashboard: View {
    @Binding var currentTab: Tabs
    @State var StatsView: Bool = false
    var body: some View {
        VStack {
            Button {
                currentTab = .Game
            } label: {
                Text("Guessing game") // temp
                    .frame(width: 300, height: 200)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
            HStack {
                Button {
                    currentTab = .Passport
                } label: {
                    Text("Passport") // temp
                        .frame(width: 150, height: 200)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                Button {
                    currentTab = .Trivia
                } label: {
                    Text("Trivia") // temp
                        .frame(width: 150, height: 200)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                } label: {
                    Image(systemName: "globe.fill")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Wanderlust")
                    .font(.title2)
                    .bold()
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button {
                        StatsView.toggle()
                    } label: {
                        Image(systemName: "chart.bar.fill")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .sheet(isPresented: $StatsView) {
            StatsPopupView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    Dashboard(currentTab: .constant(.Dashboard))
}
