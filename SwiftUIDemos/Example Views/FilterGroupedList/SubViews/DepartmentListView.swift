//
//  DepartmentListView.swift
//  SwiftUIDemos
//
//  Created by Alex Hay on 23/11/2020.
//

import SwiftUI

// MARK: DEPARTMENT LIST
struct DepartmentListView: View {
	
	@Binding var searchQuery: String
	
	var body: some View {
		ForEach(Departments.allCases.sorted(), id: \.self) { department in
			if let people = getPeople(fromDepartment: department), !people.isEmpty {
				DisclosureGroup(
					content: {
						PeopleListView(people: people, showDepartmentName: false)
					},
					label: {
						HStack {
							Text(department.rawValue)
							Spacer()
							Text("\(people.count)")
								.foregroundColor(.secondary)
						}
					}
				)
			}
		}
	}
	
	/// Gets all dummy people from the given department and filters them down to those with names containing the search query
	func getPeople(fromDepartment department: Departments) -> [Person] {
		let people: [Person] = DummyData.shared.people
		var results = [Person]()
		if searchQuery == "" {
			results = people.filter({ $0.department == department })
		} else {
			let lowercaseQuery = searchQuery.lowercased()
			results = people.filter({ $0.department == department && $0.name.lowercased().contains(lowercaseQuery) })
		}
		return results.sorted(by: {$0.name < $1.name})
	}
}

struct DepartmentListView_Previews: PreviewProvider {
    static var previews: some View {
		List {
			DepartmentListView(searchQuery: .constant(""))
			.padding()
		}
		.listStyle(InsetGroupedListStyle())
    }
}
