import SwiftUI

struct Dashboard: View {
    @Binding var CurrentTab: Tabs
    @State private var ShowStats: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.035, green: 0.04, blue: 0.037)
                        .ignoresSafeArea()

                    RadialGradient(
                        colors: [
                            Color(red: 0.12, green: 0.16, blue: 0.12).opacity(0.35),
                            Color.clear
                        ],
                        center: .topLeading,
                        startRadius: 50,
                        endRadius: 500
                    )
                    .ignoresSafeArea()
                VStack {
                    
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        ShowStats = true
                    } label: {
                        Image(systemName: "chart.bar.fill")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .sheet(isPresented: $ShowStats) {
            StatsView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    Dashboard(CurrentTab: .constant(.Dashboard))
}
