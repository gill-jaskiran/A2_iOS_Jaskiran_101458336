//  A2_iOS_Jaskiran_101458336
//  ContentView.swift
//  Jaskiran_Gill_LabTest02
//
//  Created by Jaskiran Gill on 2025-03-23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // Getting Core data from the enviroment
    @Environment(\.managedObjectContext) private var viewContext
    //Fetching all the Core Data
    @FetchRequest(
        // sorting the retrieved data in ascending order
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    // setting a state variable to store the users input in the search field
    @State private var searchField = ""

    var body: some View {
        NavigationView {
            VStack { // displaying the navigation in a v stack
                // if there is no products - a message is displayed
                if products.isEmpty {
                    Text("There are no products currently available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    // Showing the list of products with the search
                    List {
                        ForEach(filteredProducts, id: \.self) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                // display product name else is unknown
                                Text(product.productName ?? "Unknown")
                            }
                        }
                        // when user swipes to left enable delete button
                        .onDelete(perform: deleteProducts)
                    }
                    // placing a seach bar at the top
                    .searchable(text: $searchField)
                }
            }
            .navigationTitle("Products") // the title on the first screen
            // adding add button
            .navigationBarItems(trailing: NavigationLink("Add", destination: AddProductView()))
        }
    }
    
    //filtering products displayedbased on search
    private var filteredProducts: [Product] {
        // If search is empty all products are displayed
        if searchField.isEmpty {
            return Array(products)
        } else {
            return products.filter {
                // checking if the search field contains search text without case sensitivity
                // if product name is nil, false is returned
                let nameMatch = $0.productName?.lowercased().contains(searchField.lowercased()) ?? false
                // Doing the same with the product description so it can be searched by description as well
                let descriptionMatch = $0.productDescription?.lowercased().contains(searchField.lowercased()) ?? false
            }
        }
    }

    
    // creating delete function
    // swiping left to delete
    private func deleteProducts(offsets: IndexSet) {
        withAnimation { // adding animation for swipe
            offsets.map { products[$0] }.forEach(viewContext.delete) // delete product from Core Data
            do {
                try viewContext.save() // save changes
            } catch {
                // error handling
                print("Error when deleting product: \(error.localizedDescription)")
            }
        }
    }
}


