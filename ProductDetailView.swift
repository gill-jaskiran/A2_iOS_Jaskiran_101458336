//
//  ProductDetailView.swift
//  Jaskiran_Gill_LabTest02
//
//  Created by Jaskiran Gill on 2025-03-24.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product

    var body: some View {
        Form {
            Section(header: Text("Product Info")) {
                Text("Name: \(product.productName ?? "Unknown")")
                Text("Description: \(product.productDescription ?? "Unknown")")
                Text("Price: $\(product.productPrice, specifier: "%.2f")")
                Text("Provider: \(product.productProvider ?? "Unknown")")
            }
        }
        .navigationTitle(product.productName ?? "Product Details")
    }
}
