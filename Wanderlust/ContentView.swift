import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            GuessingGame()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct GuessingGame: View {
    @State private var secretWord: String = "PETRA" // test landmark
    @State private var guess: [String] = Array(repeating: "", count: 6)
    @State private var GameWon: Bool = false
    @State private var GameOver: Bool = false
    @State private var CurrentGuess: String = ""
    @State private var CurrentAttempt: Int = 0
    
    let CorrectLetter: Color = Color(red: 0.1, green: 0.35, blue: 0.2)
    let MisplacedLetter: Color = Color(red: 0.6, green: 0.5, blue: 0.1)
    let WrongLetter: Color = Color(red: 0.35, green: 0.25, blue: 0.15)
    let EmptyLetter = Color.gray
    var body: some View {
        VStack {
            Text("Guess the landmark")
                .font(.title)
            VStack {
                ForEach(0..<6, id: \.self){ Row in
                    HStack {
                        ForEach(0..<5, id: \.self){ Column in
                            let letter = GetLetterColor(for: Row, and: Column)
                            let BackgroundColor = GetTileColor(for: Row, at: Column)
                            
                            Text(letter)
                                .frame(width: 50, height: 60)
                                .background(BackgroundColor)
                                .foregroundStyle(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
            
            if !GameOver {
                VStack {
                    Text("Type your 5 letter landmark: ")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                    HStack {
                        TextField("Enter Guess", text: $CurrentGuess)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.characters)
                            .onChange(of: CurrentGuess) { _, NewValue in
                                if NewValue.count > 5 {
                                    CurrentGuess = String(NewValue.prefix(5))
                                }
                                
                            }
                        Button{
                            SubmitGuess()
                        } label: {
                            Text("Submit")
                        }
                        .disabled(CurrentGuess.count != 5)

                    }
                }
            }
        }
    }
    func GetLetterColor(for row: Int, and column: Int) -> String {
        let word = (row == CurrentAttempt) ? CurrentGuess : guess[row]
        let index = word.index(word.startIndex, offsetBy: column, limitedBy: word.endIndex)
        if let index = index, column < word.count {
            return String(word[index])
        }
        return ""
    }
    func GetTileColor(for row: Int, at column: Int) -> Color {
        if row >= CurrentAttempt && (row != CurrentAttempt || CurrentGuess.count <= column) {
            return EmptyLetter
        }
        let word = (row == CurrentAttempt) ? CurrentGuess : guess[row]
        guard column < word.count else {
            return EmptyLetter
        }
        
        let index = word.index(word.startIndex, offsetBy: column)
        let letter = String(word[index])
        let SecretArray = Array(secretWord)
        let GuessArray = Array(word)
        
        if SecretArray[column] == GuessArray[column] {
            return CorrectLetter
        }
        
        if SecretArray.contains(Character(letter)) {
            return MisplacedLetter
        }
        return WrongLetter
    }
    func SubmitGuess() {
        guard CurrentGuess.count == 5 else {
            return
        }
        
        guess[CurrentAttempt] = CurrentGuess.uppercased()
        
        if CurrentGuess.uppercased() == secretWord {
            GameOver = true
            GameWon = true
        }
        else if CurrentAttempt == 5 {
            GameOver = true
            
        }
        else {
            CurrentAttempt += 1
            CurrentGuess = ""
        }
    }
    
}

#Preview {
    GuessingGame()
}
