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
        }
    }
    
}
