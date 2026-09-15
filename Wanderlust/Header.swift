import SwiftUI

struct Headerfile: View {
    @State private var InformationTab: Int = 0
    @State private var CurrentTab: Tabs = .Game
    @State private var CurrentLandmarkLevel: LandmarkLevel = .LevelOne
    @State private var CurrentCountryPassport: CountryPassport = .none
    @State private var DiscoverdLandmarks: [String] = []
    var body: some View {
        NavigationStack {
            Group {
                switch CurrentTab {
                case .Dashboard:
                    Dashboard(CurrentTab: $CurrentTab)
                case .Game:
                    Game(currentTab: $CurrentTab, InformationTab: $InformationTab, DiscoveredLandmarks: $DiscoverdLandmarks)
                case .Passport:
                    Passport( CurrentCountryPassport: $CurrentCountryPassport, CurrentLandmarkLevel:$CurrentLandmarkLevel, currentTab: $CurrentTab, InformationTab: $InformationTab)
                case .Trivia:
                    Trivia(currentTab: $CurrentTab)
                }
            }
        }
    }
}
enum Tabs {
    case Dashboard
    case Game
    case Passport
    case Trivia
}

enum CountryPassport: String, CaseIterable, Identifiable {
    case none
    case UnitedStates = "United States"
    case Greece = "Greece"
    case Italy = "Italy"
    case China = "China"
    var id: String { rawValue }
}

enum LandmarkLevel: Int {
    case LevelOne = 1
    case LevelTwo = 2
    case LevelThree = 3
}

//temporarily writing the new structs here in order to easily manage the screen changes

struct InfoScreen: View {
    @Binding var InformationTab: Int
    var body: some View {
        VStack {
            // Main Information Tabs
            if InformationTab == 0 {
                Text("Apple")
            }
            else if InformationTab == 1 {
                Text("Orange")
            }
            else if InformationTab == 2 {
                Text("Lemon")
            }
            else if InformationTab == 3 {
            }
            //other tabs
            else if InformationTab == 4 {
                
            }
            else if InformationTab == 5 {
                
            }
            else if InformationTab == 6 {
                
            }
            else if InformationTab == 7 {
                
            }
            else {
                Text("No information available")
            }
        }
    }
}
#Preview {
    InfoScreen(InformationTab: .constant(0))
}
