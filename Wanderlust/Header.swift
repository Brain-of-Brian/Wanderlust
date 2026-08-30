import SwiftUI

struct Headerfile: View {
    @State private var InformationTab: Int = 0
    @State private var CurrentTab: Tabs = .Game
    @State private var CurrentLandmarkLevel: LandmarkLevel = .LevelOne
    @State private var CurrentCountryPassport: CountryPassport = .UnitedStates
    var body: some View {
        NavigationStack {
            Group {
                switch CurrentTab {
                case .Dashboard:
                    Text("Dashboard")
                case .Game:
                    Game(currentTab: $CurrentTab, InformationTab: $InformationTab)
                case .Passport:
                    Passport( CurrentCountryPassport: $CurrentCountryPassport, currentTab: $CurrentTab, InformationTab: $InformationTab)
                case .Trivia:
                    Text("Trivia")
                }
                switch CurrentCountryPassport {
                case .UnitedStates:
                    Text("United States")
                case .Greece:
                    Text("France")
                case .Italy:
                    Text("Italy")
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

struct Game: View {
    @State private var SecretWord: String = ""
    @Binding var currentTab: Tabs
    @Binding var InformationTab: Int
    @State private var InfoView: Bool = false
    
    @State private var map: Bool = false
    @State private var info: Bool = false
    @State private var InvalidLandmark: Bool = false
    
    @State private var GameWon: Bool = false
    @State private var GameOver: Bool = false
    
    @AppStorage("HighestStreak") var HighestStreak: Int = 0
    @AppStorage("CurrentStreak") var CurrentStreak: Int = 0
    @AppStorage("GamesWon") var GamesWon: Int = 0
    @AppStorage("GamesPlayed") var GamesPlayed: Int = 0
    @AppStorage("LastPlayed") private var LastPlayed: String = ""
    
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
                        let letter: String = {
                            if row < CurrentAttempt {
                                let word = Guess[row]
                                return Column < word.count ? String(Array(word)[Column]) : ""
                            }
                            else if row == CurrentAttempt {
                                return Column < CurrentGuess.count ? String(Array(CurrentGuess)[Column]) : ""
                            }
                            return ""
                        }()
                        Text(letter)
                            .font(.title)
                            .bold()
                            .frame(width:50, height:60)
                            .background(row < CurrentAttempt ? LetterColor(guess: Guess[row], index: Column) : EmptyLetter)
                            .border(Color.black)
                    }
                }
            }
            ForEach(KeyboardRows, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { letter in
                        Button {
                            Input(letter)
                        } label: {
                            Text(letter)
                                .font(.system(size: letter.count > 1 ? 12 : 18, weight: .bold))
                                .frame(width: letter.count > 1 ? 55 : 32, height: 50)
                                .background(UsedLetters[letter] ?? Gray)
                                .foregroundStyle(.white)
                                .cornerRadius(6)
                        }
                        .disabled(GameWon || GameOver)
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
        .alert(isPresented: $GameWon) {
            Alert(
                title: Text("Congratulations! You guessed the landmark correctly"),
                message: Text("You can view your stats in the dashboard.")
                    .font(.caption),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $GameOver) {
            Alert(
                title: Text("Try again tomorrow! the correct landmark was \"\(SecretWord)\"."),
                message: Text("You can view your stats in the dashboard.")
                    .font(.caption),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear{
            DailyReset()
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
                        InformationTab = 0
                        InfoView = true
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .sheet(isPresented: $InfoView) {
            InfoScreen(InformationTab: $InformationTab)
                .presentationDetents([.medium,.large])
                .presentationDragIndicator(.visible)
        }
    }
    func DailyLandmark() -> String {
        let calendar = Calendar.current
        let Day = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 1
        
        return AvaliableLandmarks[abs(Day % AvaliableLandmarks.count)]
    }
    func Submit() {
        let UppercasedGuess = CurrentGuess.uppercased()
        guard CurrentGuess.count == 5 else {
            return
        }
        guard AvaliableLandmarks.contains(UppercasedGuess) else {
            InvalidLandmark = true
            return
        }
        Guess[CurrentAttempt] = UppercasedGuess
        UpdatedColors(for: UppercasedGuess)
        if UppercasedGuess == SecretWord.uppercased() {
            GamesPlayed += 1
            GamesWon += 1
            CurrentStreak += 1
            CurrentGuess = ""
            if CurrentStreak > HighestStreak {
                HighestStreak = CurrentStreak
            }
            GameWon = true
            LastPlayed = Today()
            if !Discoverries.contains(UppercasedGuess) {
                Discoverries.append(UppercasedGuess)
            }
        } else if CurrentAttempt == 5 {
            GameOver = true
            GamesPlayed += 1
            CurrentStreak = 0
            LastPlayed = Today()
            CurrentGuess = ""
        }
        else {
            CurrentAttempt += 1
            CurrentGuess = ""
        }
        
    }
    func Input(_ letters: String) {
        if letters == "ENTER" {
            Submit()
        }
        else if letters == "⌫" {
            if !CurrentGuess.isEmpty {
                CurrentGuess.removeLast()
            }
        }
        else if CurrentGuess.count < 5 {
            CurrentGuess.append(letters.uppercased())
        }
    }
    func LetterColor(guess: String, index: Int) -> Color {
        let Guessed = Array(guess)
        let SecretWord = Array(SecretWord.uppercased())
        guard index < Guessed.count, index < SecretWord.count else {
            return EmptyLetter
        }
        let letter = Guessed[index]
        if letter == SecretWord[index] {
            return CorrectLetter
        }
        else if SecretWord.contains(letter) {
            return MisplacedLetter
        }
        else {
            return WrongLetter
        }
    }
    func UpdatedColors(for guess: String) {
        let Guessed = Array(guess)
        for (i, char) in Guessed.enumerated() {
            let letter = String(char)
            let color = LetterColor(guess: guess, index: i)
            if UsedLetters[letter] != CorrectLetter {
                UsedLetters[letter] = color
            }
        }
        
    }
    func Reset() {
        SecretWord = DailyLandmark().uppercased()
        CurrentGuess = ""
        Guess = Array(repeating: "", count: 6)
        CurrentAttempt = 0
        UsedLetters = [:]
        GameWon = false
        GameOver = false
    }
    func Today() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: today)
    }
    func DailyReset() {
        let CurrentDay = Today()
        if LastPlayed == CurrentDay {
            SecretWord = DailyLandmark().uppercased()
            GameOver = true
        } else {
            Reset()
        }
    }
}
//Guess.append(letter)
#Preview {
    Game(currentTab: .constant(.Game), InformationTab: .constant(0))
}

struct Passport: View {
    @Binding var CurrentCountryPassport: CountryPassport
    @Binding var currentTab: Tabs
    @Binding var InformationTab: Int
    @State private var InfoView: Bool = false
    
    var body: some View {
        VStack {
            ForEach(CountryPassport.allCases) { country in
                Button {
                    CurrentCountryPassport = country
                    InformationTab = 1
                    InfoView.toggle()
                } label: {
                    VStack {
                        HStack {
                            Text(country.rawValue)
                            Spacer()
                        }
                        .padding()
                        Spacer()
                    } .padding()
                }
            }
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
    Passport( CurrentCountryPassport: .constant(.UnitedStates), currentTab: .constant(.Passport), InformationTab: .constant(1))
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
                        Image(systemName: "info.circle.fill")
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
