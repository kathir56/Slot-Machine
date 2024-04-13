//
//  Extensions.swift
//  Slot Machine
//
//  Created by Kathiravan Murali on 12/03/24.
//

import SwiftUI

extension Text
{
    func scoreLabelStyle() -> Text
    {
        self
            .font(.system(size: 12,design: .rounded))
            .fontWeight(.bold)
            .foregroundStyle(.white)
    }
    
    func scoreNumberStyle() -> Text
    {
        self
            .font(.title)
            .fontWeight(.heavy)
            .fontDesign(.rounded)
            .foregroundStyle(.white)
            
    }
}
