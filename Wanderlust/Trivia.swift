import SwiftUI

struct Trivia: View {
    @Binding var currentTab: Tabs
    @Binding var InformationTab: Int
    @State private var InfoView: Bool = false
    var body: some View {
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
                        InformationTab = 5
                        InfoView.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .foregroundStyle(.black)
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

#Preview {
    Trivia(currentTab: .constant(.Trivia), InformationTab: .constant(3))
}
