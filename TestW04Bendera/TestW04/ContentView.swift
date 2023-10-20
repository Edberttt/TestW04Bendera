////
////  ContentView.swift
////  TestW04
////
////  Created by Christian on 06/10/23.
////
//

import SwiftUI

struct ContentView: View {
    @State private var nyawa = 10
    @State private var currentCountryIndex: Int
    @State private var displayedCountries: Set<Int> = []
    
    @State private var benar = 0
    @State private var salah = 0
    @State private var showAlert = false
    
    var asean = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    
    init() {
        _currentCountryIndex = State(initialValue: Int.random(in: 0...9))
    }
    
    var body: some View {
        
        ZStack {
            Color.mint
                .ignoresSafeArea()
            VStack {
                Text("Pilih Bendera dari Negara : ")
                    .foregroundStyle(.black)
                Text("\(asean[currentCountryIndex])")
                    .foregroundStyle(.black)
                    .padding(.bottom, 40)
                
                HStack {
                    Spacer()
                    VStack {
                        
                        ForEach(0..<5) { number in
                            Button {
                                checkAnswer(number)
                            } label: {
                                Image(asean[number])
                                    .resizable()
                                    .frame(width: 105, height: 65)
                                    .padding(.bottom, 10)
                                //                            .opacity(displayedCountries.contains(number) ? 0.5 : 1.0) // Menyembunyikan bendera yang sudah benar
                            }
                        }
                    }
//                    .background(Color.mint)
                    .ignoresSafeArea()
                    
                    Spacer()
                    VStack {
                        ForEach(5..<10) { number in
                            let isHidden = displayedCountries.contains(number)
                            Button {
                                checkAnswer(number)
                            } label: {
                                Image(asean[number])
                                    .resizable()
                                    .frame(width: 105, height: 65)
                                    .padding(.bottom, 10)
                                //                            .opacity(displayedCountries.contains(number) ? 0.5 : 1.0) // Menyembunyikan bendera yang sudah benar
                                    .animation(.default, value: isHidden)
                            }
                        }
                    }
//                    .background(Color.mint)
//                    .background(Color.black)
                    .ignoresSafeArea()
                    Spacer()
                }
                
                .background(Color.mint)
                .ignoresSafeArea()
                
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Game Selesai"),
                        message: Text("Jawaban Benar: \(benar)\nJawaban Salah: \(salah)"),
                        primaryButton: .default(
                            Text("Mulai Ulang"),
                            action: {
                                restartGame()
                            }
                        ),
                        secondaryButton: .cancel(){
                            exit(0)
                        }
                    )
                    
                }
//                Spacer()
            }
//            Spacer()
        }
//        Spacer()
    }
    
    
    
    
    func checkAnswer(_ number: Int) {
        if number == currentCountryIndex {
            benar += 1
            nyawa -= 1
            displayedCountries.insert(number) // Menambahkan bendera yang benar ke dalam Set
        } else {
            salah += 1
            nyawa -= 1
        }
        if nyawa == 0 || benar + salah == 10 {
            showAlert = true
        }
        nextRound()
    }
    
        func nextRound() {
            currentCountryIndex = Int.random(in: 0...9)
            if displayedCountries.count == 10 {
                displayedCountries = [currentCountryIndex]
            } else {
                while displayedCountries.contains(currentCountryIndex) {
                    currentCountryIndex = Int.random(in: 0...9)
                }
            }
        }
//    func nextRound() {
//        repeat {
//            currentCountryIndex = Int.random(in: 0...9)
//        } while displayedCountries.contains(currentCountryIndex)
//        
//        displayedCountries.insert(currentCountryIndex)
//        
//        if displayedCountries.count == 10 {
//            displayedCountries = Set<Int>()
//        }
//    }
    
    
    func restartGame() {
        benar = 0
        salah = 0
        nyawa = 10
        displayedCountries.removeAll()
        showAlert = false
        nextRound()
    }
}


#Preview {
    ContentView()
}
