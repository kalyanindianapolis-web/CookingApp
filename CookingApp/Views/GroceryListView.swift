import SwiftUI

struct GroceryListView: View {
    @EnvironmentObject var groceryStore: GroceryStore
    @State private var showAddSheet = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                if groceryStore.items.isEmpty {
                    emptyState
                } else {
                    groceryList
                }
                addButton
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }

    private var groceryList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                if !groceryStore.uncheckedItems.isEmpty {
                    sectionHeader("To Buy (\(groceryStore.uncheckedItems.count))")
                    itemsSection(groceryStore.uncheckedItems)
                }
                if !groceryStore.checkedItems.isEmpty {
                    sectionHeader("In Cart (\(groceryStore.checkedItems.count))")
                    itemsSection(groceryStore.checkedItems, dimmed: true)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 0) {
            header.padding(.horizontal, 20).padding(.top, 0).frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            VStack(spacing: 12) {
                Image(systemName: "cart")
                    .font(.system(size: 48, weight: .light))
                    .foregroundStyle(.tertiary)
                Text("Your grocery list is empty")
                    .font(.system(size: 17, weight: .medium))
                Text("Tap + to add your first item")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Shopping")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.top, 12)
            Text("Grocery List")
                .font(.system(size: 32, weight: .bold))
                .tracking(-0.5)
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title.uppercased())
            .font(.system(size: 13, weight: .semibold))
            .tracking(0.8)
            .foregroundStyle(.secondary)
            .padding(.top, 4)
    }

    private func itemsSection(_ list: [GroceryItem], dimmed: Bool = false) -> some View {
        VStack(spacing: 0) {
            ForEach(Array(list.enumerated()), id: \.element.id) { index, item in
                itemRow(item, dimmed: dimmed)
                if index < list.count - 1 {
                    Divider().padding(.leading, 14)
                }
            }
        }
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func itemRow(_ item: GroceryItem, dimmed: Bool) -> some View {
        HStack(spacing: 12) {
            Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 22))
                .foregroundStyle(item.isChecked ? Color.green : Color(uiColor: .systemGray3))

            VStack(alignment: .leading, spacing: 2) {
                Text(item.name)
                    .font(.system(size: 15, weight: .medium))
                    .strikethrough(item.isChecked)
                    .foregroundStyle(dimmed ? .secondary : .primary)
                if !item.quantity.isEmpty {
                    Text(item.quantity)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
        .onTapGesture { groceryStore.toggle(item) }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                groceryStore.delete(at: IndexSet([0]), from: [item])
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }

    private var addButton: some View {
        Button { showAddSheet = true } label: {
            Image(systemName: "plus")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Color.primary)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.2), radius: 8, y: 4)
        }
        .padding(.trailing, 20)
        .padding(.bottom, 24)
        .sheet(isPresented: $showAddSheet) {
            AddGroceryItemSheet()
                .environmentObject(groceryStore)
        }
    }
}

// MARK: - Add Sheet

struct AddGroceryItemSheet: View {
    @EnvironmentObject var groceryStore: GroceryStore
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var quantity = ""
    @FocusState private var nameFocused: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Item name (e.g. Tomatoes)", text: $name)
                        .focused($nameFocused)
                    TextField("Quantity (e.g. 500g, 2 cans)", text: $quantity)
                }
            }
            .navigationTitle("New Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let trimmed = name.trimmingCharacters(in: .whitespaces)
                        guard !trimmed.isEmpty else { return }
                        groceryStore.add(name: trimmed, quantity: quantity.trimmingCharacters(in: .whitespaces))
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onAppear { nameFocused = true }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    GroceryListView().environmentObject(GroceryStore())
}
