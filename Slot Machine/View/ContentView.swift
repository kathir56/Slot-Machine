//
//  ContentView.swift
//  Slot Machine
//
//  Created by Kathiravan Murali on 04/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var highScore : Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var betAmount : Int = 10
    @State private var coins : Int = 100
    @State private var showingInfoView : Bool = false
    @State private var betCoin : Bool = false
    @State private var showingModel : Bool = false
    @State private var imageAnimation : Bool = false
    var images = ["gfx-bell","gfx-cherry","gfx-coin","gfx-grape","gfx-seven","gfx-strawberry"]
    
    @State private var reels : Array = [0,1,2]
    
    //spin reels
    
    func spinReels()
    {
        reels = reels.map({ _ in
            Int.random(in: 0...images.count-1)
        })
    }
    
    //check winning
    func checkWinning()
    {
        if reels[0] == reels[1] && reels[1] == reels[2]
        {
            coins += betAmount * 10
            
            if coins > highScore
            {
                UserDefaults.standard.set(highScore, forKey: "HighScore")
                highScore = coins
            }
        }
        else
        {
            //checkLosing()
        }
    }
    
    func checkLosing()
    {
        if coins <= 0
        {
            showingModel = true
        }
        else
        {
            coins -= betAmount
            
        }
    }
    
    func reset()
    {
        coins = 100
        UserDefaults.standard.set(0, forKey: "HighScore")
        highScore = 0
        betCoin = false
    }
    
    
    
    var body: some View {
        
        ZStack
        {
            // MARK: - Background
            LinearGradient(colors: [.colorPink,.colorPurple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            
            VStack(alignment:.center,spacing: 5)
            {
                // MARK: - Header
                
                LogoView()
                
                Spacer()
                
                    
        
                // MARK: - Score
                
                HStack {
                    HStack
                    {
                        Text("your\ncoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                         
                            
                        
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .layoutPriority(1)
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack
                    {
                        Text("\(highScore)")
                            .scoreNumberStyle()
                            .layoutPriority(1)
                        
                        Text("high\nscore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)

                    }
                    .modifier(ScoreContainerModifier())
                }
                
                
                Spacer()
                
                // MARK: - Slot Machine
                
                VStack(alignment:.center,spacing: 0)
                {
                    // MARK: - Reel_1
                    ZStack
                    {
                        ReelView()
                        Image(images[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(imageAnimation ? 1 : 0)
                            .offset( y: imageAnimation ? 0 : -30)
                            .animation(.easeIn(duration: Double.random(in: 0.7...0.9)))
                    }
                    
                    // MARK: - Reel_2
                    HStack(alignment:.center,spacing: 0)
                    {
                        ZStack
                        {
                            ReelView()
                            Image(images[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(imageAnimation ? 1 : 0)
                                .offset( y: imageAnimation ? 0 : -30)
                                .animation(.easeIn(duration: Double.random(in: 0.9...1.1)))
                        }
                        
                        Spacer()
                        
                        // MARK: - Spin Button
                        
                        ZStack
                        {
                            ReelView()
                            Image(images[reels[2]])
                                .resizable()
                                //.animation(.interpolatingSpring(.bouncy))
                                .modifier(ImageModifier())
                                .opacity(imageAnimation ? 1 : 0)
                                .offset( y: imageAnimation ? 0 : -30)
                                .animation(.easeIn(duration: Double.random(in: 1.1...1.3)))
                        }
                        
                    }
                    .frame(maxWidth: 500)
                    
                    Button(action: {
                        
                        withAnimation {
                            imageAnimation = false
                        }
                
                        spinReels()
                        
                        withAnimation {
                            imageAnimation = true
                        }
                        checkWinning()
                        checkLosing()
                    }, label: {
                        
                        Image(.gfxSpin)
                            .resizable()
                            .modifier(ImageModifier())
                        
                    })
                    
                }
                .layoutPriority(2)
                
                Spacer()
            
                // MARK: - Footer
                
                HStack(alignment: .center, spacing: 10, content: {
                    
                    // MARK: - Bet 1
                    
                    Button(action: {
                        betCoin = true
                        betAmount = 20
                    }, label: {
                        
                        Text("20")
                            .foregroundStyle(betCoin ? .yellow : .white)
                            .modifier(BetNumberModifier())
                        
                            
                    })
                    .modifier(BetCapsuleModifier())
                    
                    Image(.gfxCasinoChips)
                        .resizable()
                        .opacity(betCoin ? 1.0 : 0.0)
                        .modifier(CasinoChipModifier())
                    
                    Spacer()
                    
                    
                    Image(.gfxCasinoChips)
                        .resizable()
                        .opacity(betCoin ? 0.0 : 1.0)
                        .modifier(CasinoChipModifier())
                    
                    Button(action: {
                        betCoin = false
                        betAmount = 10
                    }, label: {
                        
                        Text("10")
                            .foregroundStyle(betCoin ? .white : .yellow)
                            .modifier(BetNumberModifier())
                        
                            
                    })
                    .modifier(BetCapsuleModifier())
                    
                    
                    
                    
                    
                    
                })// Hstack
                
                
            }
            .padding()
            .overlay(alignment: .topLeading) {
                Button(action: {
                    self.reset()
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                
                .modifier(ButtonModifier())
                .padding(.horizontal)
            }
        
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    print("info button")
                    showingInfoView = true
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier())
                .padding(.horizontal)
            }
            .frame(maxWidth: 720)
            .blur(radius: $showingModel.wrappedValue ? 5 : 0)
            .onAppear(perform: {
                withAnimation {
                    imageAnimation = true
                }
            })
            
            // MARK: - Pop UP
            
            if $showingModel.wrappedValue
            {
                ZStack
                {
                    Color(.colorTransparentBlack)
                        .ignoresSafeArea(.all)
                    
                    VStack(spacing: 0, content: {
                        Text("Game Over".uppercased())
                            .font(.title)
                            .fontWeight(.heavy)
                            .fontDesign(.rounded)
                            .padding()
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .background(Color(.colorPink))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        
                        VStack(alignment: .center,spacing: 16, content: {
                            
                            Image(.gfxSevenReel)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 72)
                            
                            Text("Bad Luck! You lost all the coins. \nLet's play again!")
                                .font(.body)
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
                                .lineLimit(2)
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.center)
                                .layoutPriority(1)
                            
                            Button(action: {
                                showingModel = false
                                coins = 100
                            }, label: {
                                Text("New Game")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.colorPink)
                                    .padding(.vertical,8)
                                    .padding(.horizontal,12)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .stroke(lineWidth: 1.75)
                                            .foregroundStyle(.colorPink)
                                    )
                            })
                        })
                        
                        Spacer()
                        
                    })
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 300, minHeight: 260, idealHeight: 280, maxHeight: 300, alignment: .center)
                    .background(
                        Color.white
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            
            
        }
        .sheet(isPresented: $showingInfoView, content: {
            InfoView()
        })
        
    }
}

#Preview {
    ContentView()
}
