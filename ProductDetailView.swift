//  A2_iOS_Jaskiran_101458336
//  ProductDetailView.swift
//  Jaskiran_Gill_LabTest02
//
//  Created by Jaskiran Gill on 2025-03-24.
//

import SwiftUI

// Displaying product detals
struct ProductDetailView: View {
    var product: Product

    var body: some View {
        // Creating a from for product details
        Form {
            Section(header: Text("Product Info")) {
                Text("Name: \(product.productName ?? "Unknown")")
                Text("Description: \(product.productDescription ?? "Unknown")")
                Text("Price: $\(product.productPrice, specifier: "%.2f")")
                Text("Provider: \(product.productProvider ?? "Unknown")")
            }
        }
        // adding navigation title for product details
        .navigationTitle(product.productName ?? "Product Details")
    }
}
