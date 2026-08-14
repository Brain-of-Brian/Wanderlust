import SwiftUI
import MapKit

struct ContentView: View {
    @State var InfoTab: Int = 0
    @State private var CurrentTab: Tabs = .Game
    @State private var DiscoveredLandmarks: [String] = []
    @State private var CountryFilter: CountryPassport = .UnitedStates
    
    var body: some View {
        NavigationStack {
            Group {
                switch CurrentTab {
                case .Dashboard:
                    Dashboard(currentTab: $CurrentTab)
                case .Game:
                    GuessingGame(currentTab: $CurrentTab, InfoTab: $InfoTab, DiscoveredLandmarks: $DiscoveredLandmarks)
                case .Passport:
                    Passport(currentTab: $CurrentTab, CountryTab: $CountryFilter, InfoTab: $InfoTab)
                case .Trivia:
                    Trivia(currentTab: $CurrentTab, InfoTab: $InfoTab)
                }
            }
        }
        .padding()
    }
}
#Preview {
    ContentView()
}

enum Tabs {
    case Dashboard
    case Game
    case Passport
    case Trivia
}

enum CountryPassport: Hashable {
    case UnitedStates
    case UnitedKingdom
    case France
    case Italy
    case Spain
    case China
}

// NavigationBar
struct InfoPopupView: View {
    @Binding var InfoTab: Int
    var body: some View {
        VStack {
            if InfoTab == 0 {
                Text("How to play")
                    .font(.title)
                    .bold()
                Text("Placeholder")
                Spacer()
            }
            else if InfoTab == 1 {
                Text("What is passport?")
                    .font(.title)
                    .bold()
                Spacer()
            }
            else if InfoTab == 2 {
                Text("hahahahahahha")
                    .font(.title)
                    .bold()
            }
            else {
                Text("No info available")
                    .font(.title)
            }
        }
        .padding(.top, 20)
    }
}
#Preview {
    InfoPopupView(InfoTab: .constant(0))
}
// NavigationBar
struct MapPopupView: View {
    @Binding var DiscoveredLandmarks: [String]
    @Environment(\.dismiss) var Dismiss
    @State private var SelectedLandmark: String? = nil
    
    let landmarkCoordinates: [String: CLLocationCoordinate2D] = [
        "PETRA": CLLocationCoordinate2D(latitude: 30.3285, longitude: 35.4444),
        "LUXOR": CLLocationCoordinate2D(latitude: 25.6872, longitude: 32.6396),
        "TULUM": CLLocationCoordinate2D(latitude: 20.2114, longitude: -87.4654),
        "TOKYO": CLLocationCoordinate2D(latitude: 35.6762, longitude: 139.6503),
        "ALAMO": CLLocationCoordinate2D(latitude: 29.4258, longitude: -98.4861),
        "KYOTO": CLLocationCoordinate2D(latitude: 35.0116, longitude: 135.7681)]
    let LandmarkDescriptions: [String: String] = [
        "PETRA": "A famous archaeological site in Jordan's desert, carved entirely into pink sandstone cliffs.",
        "LUXOR": "A sprawling open-air museum in Egypt, featuring the Karnak Temple and Valley of the Kings.",
        "TULUM": "The site of a pre-Columbian Mayan walled city serving as a major port for Coba.",
        "TOKYO": "Japan's busy capital, mixing ultramodern neon skyscrapers with historic temples.",
        "ALAMO": "A historic Spanish mission and fortress compound in San Antonio, Texas.",
        "KYOTO": "Famous for its numerous classical Buddhist temples, gardens, imperial palaces, and traditional wooden houses."
    ]
    var body: some View {
        ZStack {
            Map(selection: $SelectedLandmark) {
                ForEach(DiscoveredLandmarks, id: \.self) { landmark in
                    if let coordinate = landmarkCoordinates[landmark] {
                        Marker(landmark, coordinate: coordinate)
                            .tag(landmark)
                    }
                }
            }
            .overlay(alignment: .center) {
                if let selected = SelectedLandmark, let description = LandmarkDescriptions[selected] {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .opacity(0.4)
                        VStack(alignment: .leading) {
                            HStack {
                                Text(selected)
                                    .font(.title3)
                                    .bold()
                                Spacer()
                            }
                            Button {
                                SelectedLandmark = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.black)
                            }
                        }
                        Text(description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    } .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                        .padding()
                        .padding()
                        .padding()
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Button {
                        Dismiss()
                    } label: {
                        Text("Close")
                            .bold()
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding(.vertical)
        }
    }
}
#Preview {
    MapPopupView(DiscoveredLandmarks: .constant(["PETRA"]))
}

struct StatsPopupView: View {
    @AppStorage("GamesPlayed") private var GamesPlayed: Int = 0
    @AppStorage("GamesWon") private var GamesWon: Int = 0
    @AppStorage("Streak") private var Streak: Int = 0
    @AppStorage("HighestStreak") private var HighestStreak: Int = 0
    @Environment(\.dismiss) var Dismiss
    var body: some View {
        VStack {
            HStack{
                Text("All-time Stats")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .bold()
                Spacer()
                Button {
                    Dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                        .font(.title3)
                }
            }
            .padding(.horizontal)
            
            HStack {
                Stats(title: "Played", value: "\(GamesPlayed)")
                Stats(title: "Win Rate", value: GamesPlayed > 0 ?"\(Int(Double(GamesWon)/Double(GamesPlayed) * 100))%" : "0%")
                Stats(title: "Streak", value: "\(Streak)")
                Stats(title: "MaxStreak", value: "\(HighestStreak)")
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding(.top, 20)
    }
    struct Stats: View {
        let title: String
        let value: String
        var body: some View {
            VStack {
                Text(value)
                    .font(.title)
                    .foregroundStyle(.black)
                    .bold()
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.black)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.black.opacity(0.1))
            .cornerRadius(5)
        }
    }
}
#Preview {
    StatsPopupView()
}
