import SwiftUI

struct Trivia: View {
    @Binding var currentTab: Tabs
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
                        
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    Trivia(currentTab: .constant(.Trivia))
}
