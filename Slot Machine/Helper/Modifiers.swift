//
//  Modifiers.swift
//  Slot Machine
//
//  Created by Kathiravan Murali on 11/03/24.
//

import SwiftUI

struct ShadowModifier : ViewModifier
{
    func body(content: Content) -> some View {
        content
            .shadow(color: .colorTransparentBlack,radius: 0,x: 0,y: 5)

    }
}


struct ButtonModifier : ViewModifier
{
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(.white)
        
    }
}

struct ScoreContainerModifier  : ViewModifier
{
    func body(content: Content) -> some View {
        content
            .padding(.horizontal,16)
            .padding(.vertical,5)
            .frame(minWidth: 128)
            .background(
                Capsule()
                    .foregroundStyle(.colorTransparentBlack)
            )
    }
}


struct ImageModifier : ViewModifier
{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 140, idealWidth: 200, maxWidth: 220, minHeight: 130, idealHeight: 190, maxHeight: 200, alignment: .center)
            .modifier(ShadowModifier())
    }
}

struct BetNumberModifier : ViewModifier
{
    func body(content: Content) -> some View {
        content
            .fontWeight(.heavy)
            .foregroundStyle(.white)
            .font(.system(.title,design: .rounded))
            .padding(.vertical,8)
            .frame(width: 90)
            .shadow(color: .colorTransparentBlack, radius: 0, x: 0, y: 3)
    }
}

struct BetCapsuleModifier : ViewModifier
{
    func body(content: Content) -> some View {
        content
            .background(
                Capsule()
                    .fill(LinearGradient(colors: [.colorPink,.colorPurple], startPoint: .top, endPoint: .bottom))
                
            )
            .padding(3)
            .background(
                Capsule()
                    .fill(LinearGradient(colors: [.colorPink,.colorPurple], startPoint: .bottom, endPoint: .top))
                
            )
    }
}

struct CasinoChipModifier : ViewModifier
{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(height: 64)
            .animation(.default)
            .modifier(ShadowModifier())
    }
}
