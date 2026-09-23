import SwiftUI

struct Passport: View {
    @Binding var CurrentCountryPassport: CountryPassport
    @Binding var CurrentLandmarkLevel: LandmarkLevel
    @Binding var currentTab: Tabs
    @Binding var InformationTab: Int
    @State private var InfoView: Bool = false
    
    var body: some View {
        ZStack {
            HeavyFogBackground()
        NavigationStack {
            switch CurrentCountryPassport {
            case .none:
                VStack {
                    Text("Select a Country")
                        .font(.headline)
                        .padding()
                    
                    ScrollView {
                        ForEach(CountryPassport.allCases) { country in
                            if country != .none {
                                Button {
                                    CurrentCountryPassport = country
                                } label: {
                                    Text(country.rawValue)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 300)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                
            case .UnitedStates:
                UnitedStatesView(CurrentCountryPassport: $CurrentCountryPassport, CurrentLandmarkLevel: $CurrentLandmarkLevel, CurrentTab: $currentTab)
                
            case .Greece:
                Text("greece")
                
                
            case .Italy:
                Text("Italy")
                
                
            case .China:
                Text("china")
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if CurrentCountryPassport == .none {
                        currentTab = .Dashboard
                    }
                    else {
                        CurrentCountryPassport = .none
                    }
                    
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
                        InformationTab = 0
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
    Passport( CurrentCountryPassport: .constant(.UnitedStates), CurrentLandmarkLevel: .constant(.LevelOne), currentTab: .constant(.Passport), InformationTab: .constant(1))
}
