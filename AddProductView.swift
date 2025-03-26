//  A2_iOS_Jaskiran_101458336
//  AddProductView.swift
//  Jaskiran_Gill_LabTest02
//
//  Created by Jaskiran Gill on 2025-03-24.
//

import SwiftUI
import CoreData

struct AddProductView: View {
    // Getting core Data context
    @Environment(\.managedObjectContext) private var viewContext
    // dimissing view after saving
    @Environment(\.dismiss) private var dismiss
    
    // Adding @State variables to store user inputs
    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var productProvider = ""

    var body: some View {
        NavigationView {
            // implementing the form UI
            Form {
                Section(header: Text("Product Details")) {
                    // Displaying all the input fields
                    TextField("Product Name ", text: $productName)
                    TextField("Product Description", text: $productDescription)
                    TextField("Product Price - CAD", text: $productPrice)
                        .keyboardType(.decimalPad)
                    TextField("Product Provider", text: $productProvider)
                }

                Section {
                    // Adding button to save product
                    Button("Save Product") {
                        saveProduct()
                    }
                    // button disabled if imput fields are empty - prevents gaps in data storage
                    .disabled(productName.isEmpty || productDescription.isEmpty || productPrice.isEmpty || productProvider.isEmpty)
                }
            }
            // adding title to add product section
            .navigationTitle("Add Product")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // adding cancel button and dismiss without saving if pressed
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // Adding function to save the product to the core data
    private func saveProduct() {
        let context = viewContext
        // creating new data object
        let newProduct = Product(context: context)
        newProduct.productID = UUID().uuidString
        newProduct.productName = productName
        newProduct.productDescription = productDescription
        newProduct.productProvider = productProvider
        // converting the price into a double
        if let price = Double(productPrice) {
            newProduct.productPrice = price
        }
        do {
            try context.save() // saving data to the core data & dismissing view
            dismiss()
        } catch {
            // Error handling if it fails to save product
            print("Error: Cannot save product: \(error.localizedDescription)")
        }
    }
    
}
