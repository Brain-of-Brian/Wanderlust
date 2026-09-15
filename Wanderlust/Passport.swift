import SwiftUI

struct Passport: View {
    @Binding var CurrentCountryPassport: CountryPassport
    @Binding var CurrentLandmarkLevel: LandmarkLevel
    @Binding var currentTab: Tabs
    @Binding var InformationTab: Int
    @State private var InfoView: Bool = false
    
    var body: some View {
        VStack {
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
                UnitedStatesView(CurrentCountryPassport: $CurrentCountryPassport, CurrentLandmarkLevel: $CurrentLandmarkLevel, InformationTab: $InformationTab)
            case .Greece:
                Text("Greece Screen")
            case .Italy:
                Text("Italy Screen")
            case .China:
                Text("China Screen")
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
                        InformationTab = 0
                        InfoView = true
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
    Passport( CurrentCountryPassport: .constant(.UnitedStates), CurrentLandmarkLevel: .constant(.LevelOne), currentTab: .constant(.Passport), InformationTab: .constant(1))
}
