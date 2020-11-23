//
//  GroupedListView.swift
//  SwiftUIDemos
//
//  Created by Alex Hay on 23/11/2020.
//
// Filterable groupd list with disclosure groups

import SwiftUI

// MARK: GROUPED LIST
struct GroupedListView: View {
	
	@Environment(\.colorScheme) var colorScheme // Check whether the environment is .light or .dark
	@State private var pickerChoice: PickerChoice = .allStaff
	@State private var searchQuery: String = ""
	
	var body: some View {
		List {
			Section {
				// Choose between "Staff" or "Departments" list views
				Picker("", selection: $pickerChoice) {
					ForEach(PickerChoice.allCases, id: \.self) { value in
						Text(value.rawValue)
					}
				}
				// Hides the grouped list background
				.listRowBackground(colorScheme == .light ? Color(.systemGray6) : Color(.systemBackground))
				.pickerStyle(SegmentedPickerStyle())
			}
			Section {
				SearchBarView(searchQuery: $searchQuery)
				.listRowBackground(colorScheme == .light ? Color(.systemGray6) : Color(.systemBackground))
			}
			Section {
				switch pickerChoice {
					case .allStaff:
						PeopleListView(people: filterPeople(), showDepartmentName: true)
					case .byDepartment:
						DepartmentListView(searchQuery: $searchQuery)
				}
			}
		}
		.listStyle(InsetGroupedListStyle())
		.navigationTitle(Text("Personnel"))

	}
		
	enum PickerChoice: String, CaseIterable {
		case allStaff = "Staff"
		case byDepartment = "Departments"
	}
	
	/// Gets all dummy people and filters them down to those with names or departments containing the search query
	func filterPeople() -> [Person] {
		let allPeople = DummyData.shared.people
		if searchQuery == "" {
			return allPeople
		} else {
			let lowercaseQuery = searchQuery.lowercased()
			let filteredPeople = allPeople.filter({
				$0.name.lowercased().contains(lowercaseQuery) || $0.department.rawValue.lowercased().contains(lowercaseQuery)
			})
			return filteredPeople.sorted(by: {$0.name < $1.name})
		}
	}
}

// MARK: PREVIEWS
struct GroupedListView_Previews: PreviewProvider {
	static var previews: some View {
		GroupedListView()
	}
}
