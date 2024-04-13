//
//  LaunchScreen.swift
//  Slot Machine
//
//  Created by Kathiravan Murali on 09/03/24.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack(alignment: .center) {
            Image("gfx-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            Image("gfx-slot-machine")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
        }
    }
}

#Preview {
    LaunchScreen()
}
