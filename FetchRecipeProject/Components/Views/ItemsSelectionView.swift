//
//  ItemsSelectionView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/16/25.
//

import SwiftUI

struct ItemsSelectionView<Item: Hashable & CustomStringConvertible>: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Binding var selectedItem: Item?
    let items: [Item]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    itemButtonView(for: nil)

                    ForEach(items, id: \.self) { item in
                        itemButtonView(for: item)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .onChange(of: selectedItem) { newID in
                if let newID {
                    withAnimation(.easeInOut) {
                        proxy.scrollTo(newID.description, anchor: .center)
                    }
                } else {
                    withAnimation(.easeInOut) {
                        proxy.scrollTo("All", anchor: .center)
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    proxy.scrollTo(selectedItem?.description ?? "All", anchor: .center)
                }
            }
        }
    }
    
    private func itemButtonView(for item: Item?) -> some View {
        Button {
            selectedItem = item
        } label: {
            itemButton(for: item)
                .id(item?.description ?? "All")
        }
        .buttonStyle(PressableButtonStyle())
    }
    
    private func itemButton(for item: Item?) -> some View {
        let isSelected = selectedItem == item
        let selectedBackgroundColor = colorScheme == .dark ? Color.gray : Color.black
        let selectedTextColor = colorScheme == .dark ? Color.black : Color.white
        let defaultBackgroundColor = Color.clear
        let defaultTextColor = Color.primary
        let borderColor = Color.primary
        
        return Text(item?.description ?? "All")
            .foregroundStyle(isSelected ? selectedTextColor : defaultTextColor)
            .font(.callout)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(isSelected ? selectedBackgroundColor : defaultBackgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: 1.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    ItemsSelectionView(selectedItem: .constant(nil), items: Recipe.mocks.map { $0.cuisine })
}
