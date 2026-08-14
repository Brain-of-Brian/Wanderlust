import SwiftUI

// finder passport
struct Passport: View {
    @State private var InfoPopup: Bool = false
    @Binding var currentTab: Tabs
    @Binding var CountryTab: CountryPassport
    
    @State private var Countries: [String] = ["USA", "United Kingdom", "France", "Spain", "Italy", "China"] //,"India", "Japan", "Australia", "Canada"]
    @State private var SearchCountry: String = ""
    @Binding var InfoTab : Int
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(CountryFilterList, id: \.self) { Country in
                    NavigationLink(value: CountryEnum(Country)) {
                        VStack {
                            HStack {
                                Image(systemName: "globe.fill")
                                Text(Country)
                                    .bold()
                                Spacer()
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, minHeight: 225)
                        .background(Color.white)
                        .overlay{
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                        }
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
            }
        }
        .searchable(text: $SearchCountry, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search countries")
        .navigationDestination(for: CountryPassport.self) { SelectedEnum in
            CountryTabView(CountryTab: Binding(
                get: { SelectedEnum },
                set: { CountryTab = $0 }
            ), currentTab: $currentTab, InfoTab: $InfoTab)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    currentTab = .Dashboard
                } label: {
                    Image(systemName: "house")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Wanderlust")
                    .font(.title2)
                    .bold()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    InfoTab = 1
                    InfoPopup = true
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.black)
                }
            }
        }
        .sheet(isPresented: $InfoPopup) {
            InfoPopupView(InfoTab: $InfoTab)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .padding(.vertical)
    }
    
    func CountryEnum(_ name: String) -> CountryPassport {
        switch name {
        case "USA": return .UnitedStates
        case "United Kingdom": return .UnitedKingdom
        case "France": return .France
        case "Spain": return .Spain
        case "Italy": return .Italy
        case "China": return .China
        default: return .UnitedStates
        }
    }
    
    var CountryFilterList: [String] {
        if SearchCountry.isEmpty {
            return Countries
        } else {
            return Countries.filter { $0.localizedCaseInsensitiveContains(SearchCountry) }
        }
    }
}

#Preview {
    Passport(currentTab: .constant(.Passport), CountryTab: .constant(.UnitedStates), InfoTab: .constant(1))
}

struct CountryTabView: View {
    @Binding var CountryTab: CountryPassport
    @Binding var currentTab: Tabs
    @Binding var InfoTab: Int
    
    var body: some View {
        Group {
            switch CountryTab {
            case .UnitedStates:
                UnitedStates(currentTab: $currentTab, CountryTab: $CountryTab, InfoTab: $InfoTab)
            case .UnitedKingdom:
                UnitedKingdom(currentTab: $currentTab, CountryTab: $CountryTab, InfoTab: $InfoTab)
            case .France:
                France(currentTab: $currentTab, CountryTab: $CountryTab, InfoTab: $InfoTab)
            case .Italy:
                Italy(currentTab: $currentTab, CountryTab: $CountryTab, InfoTab: $InfoTab)
            case .Spain:
                Spain(currentTab: $currentTab, CountryTab: $CountryTab, InfoTab: $InfoTab)
            case .China:
                Spain(currentTab: $currentTab, CountryTab: $CountryTab, InfoTab: $InfoTab)
            }
        }
        .padding(.top, 20)
    }
}

struct UnitedStates: View {
    @State private var InfoPopup: Bool = false
    @Binding var currentTab: Tabs
    @Binding var CountryTab: CountryPassport
    @Binding var InfoTab: Int
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("United States Detail View") // temp
                .font(.title)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("United States")
                    .font(.title2)
                    .bold()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    InfoTab = 1
                    InfoPopup = true
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.vertical)
        .sheet(isPresented: $InfoPopup) {
            InfoPopupView(InfoTab: $InfoTab)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    UnitedStates(currentTab: .constant(.Passport), CountryTab: .constant(.UnitedStates), InfoTab: .constant(0))
}



struct UnitedKingdom: View {
    @State private var InfoPopup: Bool = false
    @Binding var currentTab: Tabs
    @Binding var CountryTab: CountryPassport
    @Binding var InfoTab: Int
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("United Kingdom Detail View") // temp
                .font(.title)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("United Kingdom")
                    .font(.title2)
                    .bold()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    InfoTab = 1
                    InfoPopup = true
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.vertical)
        .sheet(isPresented: $InfoPopup) {
            InfoPopupView(InfoTab: $InfoTab)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    UnitedKingdom(currentTab: .constant(.Passport), CountryTab: .constant(.UnitedKingdom), InfoTab: .constant(0))
}



struct France: View {
    @State private var InfoPopup: Bool = false
    @Binding var currentTab: Tabs
    @Binding var CountryTab: CountryPassport
    @Binding var InfoTab: Int
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("France Detail View") //temp
                .font(.title)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("France")
                    .font(.title2)
                    .bold()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    InfoTab = 1
                    InfoPopup = true
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.vertical)
        .sheet(isPresented: $InfoPopup) {
            InfoPopupView(InfoTab: $InfoTab)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    France(currentTab: .constant(.Passport), CountryTab: .constant(.France), InfoTab: .constant(0))
}


struct Spain: View {
    @State private var InfoPopup: Bool = false
    @Binding var currentTab: Tabs
    @Binding var CountryTab: CountryPassport
    @Binding var InfoTab: Int
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Spain Detail View") //temp
                .font(.title)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Spain")
                    .font(.title2)
                    .bold()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    InfoTab = 1
                    InfoPopup = true
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.vertical)
        .sheet(isPresented: $InfoPopup) {
            InfoPopupView(InfoTab: $InfoTab)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    Spain(currentTab: .constant(.Passport), CountryTab: .constant(.Spain), InfoTab: .constant(0))
}



struct Italy: View {
    @State private var InfoPopup: Bool = false
    @Binding var currentTab: Tabs
    @Binding var CountryTab: CountryPassport
    @Binding var InfoTab: Int
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Italy Detail View") //temp
                .font(.title)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Italy")
                    .font(.title2)
                    .bold()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    InfoTab = 1
                    InfoPopup = true
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.vertical)
        .sheet(isPresented: $InfoPopup) {
            InfoPopupView(InfoTab: $InfoTab)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    Italy(currentTab: .constant(.Passport), CountryTab: .constant(.Italy), InfoTab: .constant(0))
}


struct China: View {
    @State private var InfoPopup: Bool = false
    @Binding var currentTab: Tabs
    @Binding var CountryTab: CountryPassport
    @Binding var InfoTab: Int
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("China Detail View") //temp
                .font(.title)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("China")
                    .font(.title2)
                    .bold()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    InfoTab = 1
                    InfoPopup = true
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.vertical)
        .sheet(isPresented: $InfoPopup) {
            InfoPopupView(InfoTab: $InfoTab)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    China(currentTab: .constant(.Passport), CountryTab: .constant(.Italy), InfoTab: .constant(0))
}

