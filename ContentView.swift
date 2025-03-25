//
//  ContentView.swift
//  Jaskiran_Gill_LabTest02
//
//  Created by Jaskiran Gill on 2025-03-23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    @State private var searchField = ""

    var body: some View {
        NavigationView {
            VStack {
                if products.isEmpty {
                    Text("There are no products currently available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(filteredProducts, id: \.self) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                Text(product.productName ?? "Unknown")
                            }
                        }
                        .onDelete(perform: deleteProducts)
                    }
                    .searchable(text: $searchField)
                }
            }
            .navigationTitle("Products")
            .navigationBarItems(trailing: NavigationLink("Add", destination: AddProductView()))
        }
    }

    private var filteredProducts: [Product] {
        if searchField.isEmpty {
            return Array(products)
        } else {
            return products.filter {
                $0.productName?.lowercased().contains(searchField.lowercased()) ?? false ||
                $0.productDescription?.lowercased().contains(searchField.lowercased()) ?? false
            }
        }
    }

    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print("Error when deleting product: \(error.localizedDescription)")
            }
        }
    }
}


