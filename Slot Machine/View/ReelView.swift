//
//  ReelView.swift
//  Slot Machine
//
//  Created by Kathiravan Murali on 12/03/24.
//

import SwiftUI

struct ReelView: View {
    var body: some View {
        
        Image("gfx-reel")
            .resizable()
            .modifier(ImageModifier())
    }
}

#Preview {
    ReelView()
}
