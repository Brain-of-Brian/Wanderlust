import SwiftUI

struct UnitedStatesView: View {
    @Binding var CurrentCountryPassport: CountryPassport
    @Binding var CurrentLandmarkLevel: LandmarkLevel
    @Binding var CurrentTab: Tabs
    
    @State private var AnswerText: String = ""
    @State private var Correct: Bool = false
    
    var CorrectAnswer: String {
        switch CurrentLandmarkLevel {
        case .LevelOne:
            return "STATUE OF LIBERTY"
        case .LevelTwo:
            return "GRAND CANYON"
        case .LevelThree:
            return "YELLOWSTONE"
        }
    }
    
    var body: some View {
        VStack {
            Text("United States - Level \(CurrentLandmarkLevel.rawValue)")
                .font(.title)
                .padding()
            
            TextField("Enter Answer", text: $AnswerText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button {
                Submit()
            } label: {
                Text("Submit")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .alert("Incorrect Answer", isPresented: $InvalidAnswer) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Try again!")
                .font(.caption)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Wanderlust")
                    .font(.title2)
                    .bold()
            }
        }
    }
    
    func Submit() {
        let UppercasedAnswer = AnswerText.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if UppercasedAnswer == CorrectAnswer {
            Correct = true
            
            if CurrentLandmarkLevel == .LevelOne {
                CurrentLandmarkLevel = .LevelTwo
            }
            else if CurrentLandmarkLevel == .LevelTwo {
                CurrentLandmarkLevel = .LevelThree
            }
            else if CurrentLandmarkLevel == .LevelThree {
                CurrentCountryPassport = .none
                CurrentLandmarkLevel = .LevelOne
            }
            
            AnswerText = ""
        }
        else {
            Correct = false
            InvalidAnswer = true
        }
    }
}

#Preview {
    UnitedStatesView(CurrentCountryPassport: .constant(.UnitedStates), CurrentLandmarkLevel: .constant(.LevelOne), CurrentTab: .constant(.Passport))
}
