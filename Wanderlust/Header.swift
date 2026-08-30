import SwiftUI

struct Headerfile: View {
    @State private var InformationTab: Int = 0
    @State private var CurrentTab: Tabs = .Game
    @State private var CurrentLandmarkLevel: LandmarkLevel = .LevelOne
    @State private var CurrentCountryPassport: CountryPassport = .UnitedStates
    var body: some View {
        switch CurrentTab {
            case .Dashboard:
                Text("Dashboard")
            case .Game:
                Game(currentTab: $CurrentTab, InformationTab: $InformationTab)
            case .Passport:
                Text("Passport")
            case .Trivia:
                Text("Trivia")
        }
        switch CurrentCountryPassport {
        case .UnitedStates:
            Text("United States")
        case .UnitedKingdom:
            Text("United Kingdom")
        case .France:
            Text("France")
        case .Italy:
            Text("Italy")
        case .Spain:
            Text("Spain")
        case .China:
            Text("China")
        case .none:
            Text("None")
        }
        switch CurrentLandmarkLevel {
        case .LevelOne:
            Text("Level One")
        case .LevelTwo:
            Text("Level Two")
        case .LevelThree:
            Text("Level Three")
        }
    }
}

#Preview {
    Headerfile()
}
enum Tabs {
    case Dashboard
    case Game
    case Passport
    case Trivia
}

enum CountryPassport: String {
    case none
    case UnitedStates = "United States"
    case UnitedKingdom = "United Kingdom"
    case France = "France"
    case Italy = "Italy"
    case Spain = "Spain"
    case China = "China"
}

enum LandmarkLevel: Int {
    case LevelOne = 1
    case LevelTwo = 2
    case LevelThree = 3
}

//temporarily writing the new structs here in order to easily manage the screen changes

struct Game: View {
    @State private var SecretWord: String = ""
    @Binding var currentTab: Tabs
    @Binding var InformationTab: Int
    
    @State private var map: Bool = false
    @State private var info: Bool = false
    @State private var InvalidLandmark: Bool = false
    
    @State private var GameWon: Bool = false
    @State private var GameOver: Bool = false
    
    @State private var CurrentGuess: String = ""
    @State private var Guess: [String] = Array(repeating: "", count: 6)
    @State private var CurrentAttempt: Int = 0
    @State private var UsedLetters: [String: Color] = [:]

    let AvaliableLandmarks: [String] = ["PETRA", "LUXOR", "TULUM", "TOKYO", "ALAMO"]
    @State private var Discoverries: [String] = []
    let today = Date()

    let CorrectLetter: Color = Color(red: 0.1, green: 0.35, blue: 0.2)
    let MisplacedLetter: Color = Color(red: 0.6, green: 0.5, blue: 0.1)
    let WrongLetter: Color = Color(red: 0.35, green: 0.25, blue: 0.15)
    let EmptyLetter = Color.clear
    let Gray = Color.gray.opacity(0.5)
    
    let KeyboardRows = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["ENTER", "Z", "X", "C", "V", "B", "N", "M", "⌫"]]
    
    var body: some View {
        VStack {
            ForEach(0..<6, id: \.self) {
                row in
                HStack {
                    ForEach(0..<5, id: \.self) {Column in
                    Text(Column < CurrentGuess.count ? String(Array(CurrentGuess)[Column]): "")
                        .frame(width: 50, height: 60)
                        .border(.black)
                    }
                }
            }
            Spacer()
            ForEach(KeyboardRows, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { letter in
                        Button {
                            Input(letter)
                        } label: {
                            Text(letter)
                        }
                    }
                }
                
            }
        }
        .alert(isPresented: $InvalidLandmark) {
            Alert(
                title: Text("Invalid Landmark"),
                message: Text("If this is a specific landmark you want to add to the game, please submit a suggestion in the feedback form.")
                    .font(.caption),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            SecretWord = DailyLandmark().capitalized
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
                        Image(systemName: "globe.fill")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
    func DailyLandmark() -> String {
        let calendar = Calendar.current
        let Day = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 1
        
        return AvaliableLandmarks[Day % AvaliableLandmarks.count]
    }
    func Submit() {
        guard CurrentGuess.count == 5 else {
            return
        }
        guard AvaliableLandmarks.contains(CurrentGuess) else {
            InvalidLandmark = true
            return
        }
        if !Discoverries.contains(CurrentGuess) {
            Discoverries.append(CurrentGuess)
        }
    }
    func Input(_ letters: String) {
        if letters == "ENTER" {
        }
        else if letters == "⌫" {
            if CurrentGuess.isEmpty {
                CurrentGuess.removeLast()
            }
        }
        else if CurrentGuess.count < 5 {
            CurrentGuess.append(letters.uppercased())
        }
    }
}
//Guess.append(letter)
#Preview {
    Game(currentTab: .constant(.Game), InformationTab: .constant(0))
}

struct Passport: View {
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
                        Image(systemName: "globe.fill")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    Passport(currentTab: .constant(.Passport))
}

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
                        Image(systemName: "globe.fill")
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

struct InfoScreen: View {
    @Binding var InformationTab: Int
    var body: some View {
        VStack {
            // Main Information Tabs
            if InformationTab == 0 {
                
            }
            else if InformationTab == 1 {
                
            }
            else if InformationTab == 2 {
                
            }
            else if InformationTab == 3 {
                
            }
            //other tabs
            else if InformationTab == 4 {
                
            }
            else if InformationTab == 5 {
                
            }
            else if InformationTab == 5 {
                
            }
            else if InformationTab == 5 {
                
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
