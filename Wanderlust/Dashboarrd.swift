import SwiftUI
import MapKit

struct Dashboard: View {
    @Binding var CurrentTab: Tabs
    @State private var ShowStats: Bool = false
    
    @State private var Position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 20, longitude: 0),
            span: MKCoordinateSpan(
                latitudeDelta: 140,
                longitudeDelta: 140
            )
        )
    )
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.035, green: 0.04, blue: 0.037)
                        .ignoresSafeArea()

                    RadialGradient(
                        colors: [
                            Color(red: 0.12, green: 0.16, blue: 0.12).opacity(0.35),
                            Color.clear
                        ],
                        center: .topLeading,
                        startRadius: 50,
                        endRadius: 500
                    )
                    .ignoresSafeArea()
                VStack {
                    
                    TravelMapView()
                        .frame(height: 300)
                        .cornerRadius(20)
                        .padding(1)
                    Button {
                        CurrentTab = .Game
                    } label: {
                        Text("Game")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .padding(.horizontal, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black, lineWidth: 1))
                    }
                    Button {
                        CurrentTab = .Passport
                    } label: {
                        Text("Passport")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .padding(.horizontal, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black, lineWidth: 1))
                    }
                    Button {
                        CurrentTab = .Trivia
                    } label: {
                        Text("Trivia")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .padding(.horizontal, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black, lineWidth: 1))
                    }
                }
            }
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        ShowStats = true
                    } label: {
                        Image(systemName: "chart.bar.fill")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .sheet(isPresented: $ShowStats) {
            StatsView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    Dashboard(CurrentTab: .constant(.Dashboard))
}

struct TravelMapView: View {
    @AppStorage("VisitedLandmarks") private var VisitedLandmarks: String = ""

    @State private var Position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 20, longitude: 0),
            span: MKCoordinateSpan(
                latitudeDelta: 140,
                longitudeDelta: 140
            )
        )
    )

    var body: some View {
        Map(position: $Position) {
            ForEach(Landmarks, id: \.Name) { Landmark in
                if VisitedLandmarks.components(separatedBy: "|").contains(Landmark.Name) {
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
    }
}
