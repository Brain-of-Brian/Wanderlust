import SwiftUI

// finder passport

struct Passport: View {

    @State private var InfoPopup: Bool = false

    @Binding var currentTab: Tabs

    @State private var Countries: [String] = ["USA", "United Kingdom", "France", "Spain", "Italy", "China"] //,"India", "Japan", "Australia", "Canada"]

    @Binding var InfoTab: Int

    var body: some View {

        ScrollView {

            LazyVStack {

                ForEach(Countries, id: \.self) { Country in

                    NavigationLink(value: Country) {

                        VStack {

                            HStack {

                                Image(systemName: "globe.fill")

                                Text(Country)
                                    .bold()

                                Spacer()
                            }
                            .padding(.horizontal)

                            Spacer()
                        }
                        .frame(maxWidth: .infinity, minHeight: 225)
                        .background(Color.white)
                        .overlay {

                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                        }
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(placement: .topBarLeading) {

                Button {

                    currentTab = .Dashboard

                } label: {

                    Image(systemName: "house")
                        .foregroundStyle(.black)
                }
            }

            ToolbarItem(placement: .principal) {

                Text("Wanderlust")
                    .font(.title2)
                    .bold()
            }

            ToolbarItem(placement: .topBarTrailing) {

                Button {

                    InfoTab = 1
                    InfoPopup = true

                } label: {

                    Image(systemName: "info.circle")
                        .foregroundStyle(.black)
                }
            }
        }
        .sheet(isPresented: $InfoPopup) {

            InfoPopupView(InfoTab: $InfoTab)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .padding(.vertical)
    }
}

#Preview {
    Passport(
        currentTab: .constant(.Passport),
        InfoTab: .constant(1)
    )
}
