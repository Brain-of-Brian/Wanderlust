//import SwiftUI
////// finder trivia
//struct Trivia: View {
////    @Binding var currentTab: Tabs
////    @Binding var InfoTab: Int
////    @State private var InfoPopup: Bool = false
////    @State private var Offset: CGSize = .zero
////    @State private var CurrentIndex: Int = 0
////    @State private var DroppedAnswers: [Int?] = [nil, nil, nil, nil, nil, nil]
////    
////    let Questions = ["Test 1", "Test 2", "Test 3", "Test 4", "Test 5", "Test 6"]
//    var body: some View {
////        VStack {
////            if CurrentIndex < Questions.count {
////                Circle()
////                    .fill(Color.white)
////                    .frame(width: 200, height: 150)
////                    .border(Color.black, width: 1)
////                    .overlay(
////                        Text(Questions[CurrentIndex])
////                            .font(.headline)
////                            .foregroundStyle(.black)
////                            .multilineTextAlignment(.center)
////                            .padding()
////                    )
////                    .border(Color.black, width: 1)
////                    .offset(Offset)
////                    .gesture(
////                        DragGesture()
////                            .onChanged { gesture in
////                                Offset = gesture.translation
////                            }
////                            .onEnded { gesture in
////                                if gesture.translation.height < -150 {
////                                    if let EmtpySlot = DroppedAnswers.firstIndex(where: {$0 == nil}) {
////                                        withAnimation(.spring()) {
////                                            DroppedAnswers[EmtpySlot] = CurrentIndex
////                                            CurrentIndex += 1
////                                            Offset = .zero
////                                        }
////                                    } else {
////                                        withAnimation(.spring()) {
////                                            Offset = .zero
////                                        }
////                                    }
////                                    
////                                }
////                                else {
////                                    withAnimation(.spring()) {
////                                        Offset = .zero
////                                    }
////                                }
////                            }
////                    )
////            } else {
////                Text("Everything answered")
////                    .font(.title)
////            }
////            HStack {
////                ForEach(0..<Questions.count, id: \.self) { index in
////                    RoundedRectangle(cornerRadius: 5)
////                        .strokeBorder(style: StrokeStyle(lineWidth: 2))
////                        .frame(width: 75, height: 75)
////                        .overlay (
////                            Group {
////                                if let QuestionIndex = DroppedAnswers[index] {
////                                    Text("Question\(QuestionIndex + 1)")
////                                        .font(.caption)
////                                        .bold()
////                                        .foregroundStyle(.black)
////                                } else {
////                                    Text("\(index + 1)")
////                                        .foregroundStyle(.black)
////                                }
////                            }
////                        )
////                }
////            }
////            .padding(.top, 50)
////            
////        }
////        .navigationBarBackButtonHidden(true)
////        .ignoresSafeArea(edges: .top)
////        .navigationBarTitleDisplayMode(.inline)
////        .toolbar{
////            ToolbarItem(placement: .topBarLeading) {
////                Button {
////                    currentTab = .Dashboard
////                } label: {
////                    Image(systemName: "house")
////                        .foregroundStyle(.black)
////                }
////            }
////            ToolbarItem(placement: .principal) {
////                Text("Wanderlust")
////                    .font(.title2)
////                    .bold()
////            }
////            ToolbarItem(placement: .topBarTrailing) {
////                HStack {
////                    Button {
////                        InfoTab = 2
////                        InfoPopup = true
////                    } label: {
////                        Image(systemName: "info.circle")
////                            .foregroundStyle(.black)
////                    }
////                }
////            }
////        }
////        .sheet(isPresented: $InfoPopup) {
////            InfoPopupView(InfoTab: $InfoTab)
////                .presentationDetents([.medium, .large])
////                .presentationDragIndicator(.visible)
////        }
////        .padding(.vertical)
//    }
//}
////
//#Preview {
//    Trivia()
////    Trivia(currentTab: .constant(.Trivia), InfoTab: .constant(2))
//}
