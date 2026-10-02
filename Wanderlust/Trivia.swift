import SwiftUI

struct Trivia: View {
    @Binding var currentTab: Tabs
    @Binding var InformationTab: Int
    @State private var InfoView: Bool = false
    var body: some View {
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
            
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    currentTab = .Dashboard
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundStyle(.white)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Wanderlust")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                    
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button {
                        InformationTab = 5
                        InfoView.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .sheet(isPresented: $InfoView) {
            InfoScreen(InformationTab: $InformationTab)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        
    }
}
}

#Preview {
    Trivia(currentTab: .constant(.Trivia), InformationTab: .constant(3))
}
