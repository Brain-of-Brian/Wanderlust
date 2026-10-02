import SwiftUI
import MapKit

struct Headerfile: View {
    @State private var InformationTab: Int = 0
    @State private var ChangeLevel: Int = 0
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
                    Trivia(currentTab: $CurrentTab, InformationTab: $InformationTab)
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

struct Landmark {
    let Name: String
    let Latitude: Double
    let Longitude: Double
}

let Landmarks: [Landmark] = [
    Landmark(Name: "PETRA", Latitude: 30.3285, Longitude: 35.4444),
    Landmark(Name: "LUXOR", Latitude: 25.6872, Longitude: 32.6396),
    Landmark(Name: "TULUM", Latitude: 20.2114, Longitude: -87.4654),
    Landmark(Name: "TOKYO", Latitude: 35.6762, Longitude: 139.6503),
    Landmark(Name: "ALAMO", Latitude: 29.4259, Longitude: -98.4861)

]

struct MapView: View {
    @Binding var DiscoveredLandmarks: [String]
    @State private var Position: MapCameraPosition = .automatic
    var body: some View {
        Map(position: $Position) {
            ForEach(Landmarks, id: \.Name) { Landmark in
                if DiscoveredLandmarks.contains(Landmark.Name) {
                    Marker(
                        Landmark.Name,
                        coordinate: CLLocationCoordinate2D(
                            latitude: Landmark.Latitude,
                            longitude: Landmark.Longitude
                        )
                    )

                }

            }

        }
        .navigationTitle("Map")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StatsView: View {

    @AppStorage("GamesPlayed") var GamesPlayed: Int = 0
    @AppStorage("GamesWon") var GamesWon: Int = 0
    @AppStorage("CurrentStreak") var CurrentStreak: Int = 0
    @AppStorage("HighestStreak") var HighestStreak: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Overall Stats")
                .font(.largeTitle)
                .bold()
                .background(ignoresSafeAreaEdges: .top)
            Divider()
            Text("Games Played: \(GamesPlayed)")
            Text("Games Won: \(GamesWon)")
            Text("Current Streak: \(CurrentStreak)")
            Text("Highest Streak: \(HighestStreak)")
            Divider()
        }
        .padding()
    }
}
