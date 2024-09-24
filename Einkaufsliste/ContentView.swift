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
    
    @State private var einkaufsliste = ["Äpfel", "Bananen", "Zitronen", "Mehl", "Spülmittel"]
    
    @State private var neuerArtikel = ""

    var body: some View {
        NavigationView {
            List(einkaufsliste, id: \.self) {
                artikel in Text(artikel)
            }
            .navigationTitle("Einkaufsliste")
        }
        HStack {
            TextField("Neuer Artikel", text:$neuerArtikel)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Ok", action: {
                if !neuerArtikel.isEmpty {
                    einkaufsliste.append(neuerArtikel)
                }
            })
        }
        .padding(.horizontal)
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
