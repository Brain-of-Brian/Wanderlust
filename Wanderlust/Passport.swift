////import SwiftUI
////
////struct PassportOld: View {
////    
//////    @State private var InfoPopup: Bool = false
//////    
//////    @Binding var currentTabs: Tabs
//////    @Binding var currentCountryPassport: CountryPassport
//////    @Binding var currentLandmarkLevel: LandmarkLevel
//////    
//////    @State var UnlockedLevels: LandmarkLevel = .LevelOne
//////    
//////    let Countries: [CountryPassport] = [.UnitedStates,.UnitedKingdom,.China,.France,.Italy,.Spain]
//////    
//////    @Binding var InformationTab: Int
////    
////    var body: some View {
////        VStack {
////            
////        }
////        .navigationBarBackButtonHidden(true)
////        .ignoresSafeArea(edges: .top)
////        .navigationBarTitleDisplayMode(.inline)
////        .toolbar {
////            
////            ToolbarItem(placement: .topBarLeading) {
////                
////                Button {
////                    
//////                    currentTabs = .Dashboard
////                    
////                } label: {
////                    
////                    Image(systemName: "house")
////                        .foregroundStyle(.black)
////                }
////            }
////            
////            ToolbarItem(placement: .principal) {
////                
////                Text("Wanderlust")
////                    .font(.title2)
////                    .bold()
////            }
////            
////            ToolbarItem(placement: .topBarTrailing) {
////                
////                Button {
////                    
//////                    InformationTab = 1
//////                    InfoPopup = true
////                    
////                } label: {
////                    
////                    Image(systemName: "info.circle")
////                        .foregroundStyle(.black)
////                }
////            }
////        }
//////        .sheet(isPresented: $InfoPopup) {
//////            
//////            InfoPopupView(InformationTab: $InformationTab)
//////                .presentationDetents([.medium, .large])
//////                .presentationDragIndicator(.visible)
//////        }
////        .padding(.vertical)
////    }
////}
////
////#Preview {
////    PassportOld()
////}
////
////
////
//////struct Passport: View {
//////    @Binding var currentTabs: Tabs
//////    @Binding var currentCountryPassport: CountryPassport
//////    @Binding var currentLandmarkLevel: LandmarkLevel
//////    @binding var InformationTab: Int
//////    
//////    var body: some View {
//////        VStack {
//////            
//////        }
//////    }
//////}
//////
//////#Preview {
//////    Passport()
//////}
////
////
////
////
////
////
////
//////temp placement
//struct InfoPopupView: View {
//    @Binding var InformationTab: Int
//    var body: some View {
//        
//        VStack {
//            // Primary Tab Views
//            if InformationTab == 0 { // Guessing game
//                Text("How to play").font(.title).bold()
//                Text("Placeholder")
//            }
//            else if InformationTab == 1 { // Passport tab
//                Text("What is passport?").font(.title).bold()
//            }
//            else if InformationTab == 2 { // Trivia
//                Text("hahahahahahha").font(.title).bold()
//            }
//// Divider ----------------------------------------------------------
//            // Passport Struct: Country Views
//            else if InformationTab == 3 {
//                Text("USA").font(.title).bold()
//            }
//            else if InformationTab == 4 {
//                Text("UK").font(.title).bold()
//            }
//            else if InformationTab == 5 {
//                Text("France").font(.title).bold()
//            }
//            else if InformationTab == 6 {
//                Text("Spain").font(.title).bold()
//            }
//            else if InformationTab == 7 {
//                Text("Italy").font(.title).bold()
//            }
//            else if InformationTab == 8 {
//                Text("China").font(.title).bold()
//            }
//// Divider ----------------------------------------------------------
//            else {
//                Text("No info available").font(.title)
//            }
//        }
//        .padding(.top, 20)
//        
//    }
//}
//
//#Preview {
//    InfoPopupView(InformationTab: .constant(0))
//}
//
