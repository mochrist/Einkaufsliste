//
//  ContentView.swift
//  Einkaufsliste
//
//  Created by Moritz Christ on 24.09.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var einkaufsliste = ["Äpfel", "Bananen", "Zitronen", "Mehl", "Spülmittel"]

    var body: some View {
        NavigationView {
            List(einkaufsliste, id: \.self) {
                artikel in Text(artikel)
            }
            .navigationTitle("Einkaufsliste")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
