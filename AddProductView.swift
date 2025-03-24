//
//  AddProductView.swift
//  Jaskiran_Gill_LabTest02
//
//  Created by Jaskiran Gill on 2025-03-24.
//

import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var productProvider = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Input Product Name ", text: $productName)
                    TextField("Input Product Description", text: $productDescription)
                    TextField("Input Product Price - CAD", text: $productPrice)
                        .keyboardType(.decimalPad)
                    TextField("Input Product Provider", text: $productProvider)
                }

                Section {
                    Button("Save Product") {
                        saveProduct()
                    }
                    .disabled(productName.isEmpty || productDescription.isEmpty || productPrice.isEmpty || productProvider.isEmpty)
                }
            }
            .navigationTitle("Add Product")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveProduct() {
        let context = viewContext

        let newProduct = Product(context: context)
        newProduct.productID = UUID().uuidString
        newProduct.productName = productName
        newProduct.productDescription = productDescription
        newProduct.productProvider = productProvider

        if let price = Double(productPrice) {
            newProduct.productPrice = price
        }

        do {
            try context.save()
            dismiss()
        } catch {
            print("Error: Cannot save product: \(error.localizedDescription)")
        }
    }
    
}
