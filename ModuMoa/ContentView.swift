//
//  ContentView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/9/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var draggedOffset = CGSize.zero
    @State private var accumulatedOffset = CGSize.zero
    
    var body: some View {
        HierarchyCardView(me: Member(name: "Me", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date()))
            .offset(draggedOffset)
            .gesture(drag)
        
    }
    
    var drag: some Gesture {
        DragGesture()
          .onChanged { gesture in
            draggedOffset = accumulatedOffset + gesture.translation
          }
          .onEnded { gesture in
            accumulatedOffset = accumulatedOffset + gesture.translation
          }
      }
}

#Preview {
    ContentView()
}
