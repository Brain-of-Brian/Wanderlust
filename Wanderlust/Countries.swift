import SwiftUI

struct UnitedStatesView: View {
    @Binding var CurrentCountryPassport: CountryPassport
    @Binding var CurrentLandmarkLevel: LandmarkLevel
    var body: some View {
        VStack {
            Text("HII")
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if CurrentCountryPassport == .UnitedStates {
                        CurrentCountryPassport = .none
                    }
                    else {
                        CurrentCountryPassport = .none
                    }

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
                        
                    }
                }
            }
        }
    }
}

#Preview {
    UnitedStatesView(CurrentCountryPassport: .constant(.UnitedStates), CurrentLandmarkLevel: .constant(.LevelOne))
}

