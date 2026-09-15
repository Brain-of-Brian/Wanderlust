import SwiftUI

struct UnitedStatesView: View {
    @Binding var CurrentCountryPassport: CountryPassport
    @Binding var CurrentLandmarkLevel: LandmarkLevel
    @State private var ChangeLevel: Int = 0
    @Binding var currentTab: Tabs

    var body: some View {
        VStack {
//            if ChangeLevel == 0 {
//                CurrentLandmarkLevel = .LevelOne
//            }
//            else if ChangeLevel == 1 {
//                CurrentLandmarkLevel = .LevelTwo
//            }
//            else if ChangeLevel == 1 {
//                CurrentLandmarkLevel = .LevelThree
//            }
////            else if ChangeLevel == 1 {
////                CurrentLandmarkLevel = .levelFour
////            }
////            else if ChangeLevel == 1 {
////                CurrentLandmarkLevel = .LevelFive
////            }
//            else {
//                CurrentCountryPassport = .UnitedStates
//            }
            List {
                Button {
                    
                } label: {
                    
                }
                Button {
                    
                } label: {
                    
                }
                Button {
                    
                } label: {
                    
                }
                Button {
                    
                } label: {
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                Button {
//                    currentTab = .Passport
//                } label: {
//                    Image(systemName: "arrow.backward")
//                        .foregroundStyle(.black)
//                }
//            }
//            ToolbarItem(placement: .principal) {
//                Text("Wanderlust")
//                    .font(.title2)
//                    .bold()
//            }
//            ToolbarItem(placement: .topBarTrailing) {
//                HStack {
//                    Button {
//                        
//                    } label: {
//                        Text("Hi")
//                    }
//                }
//            }
//        }
    }
}

#Preview {
    UnitedStatesView(CurrentCountryPassport: .constant(.UnitedStates), CurrentLandmarkLevel: .constant(.LevelOne), currentTab: .constant(.Passport))
}

