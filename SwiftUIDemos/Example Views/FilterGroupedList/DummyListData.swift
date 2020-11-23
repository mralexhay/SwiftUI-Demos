//
//  Countries+PeopleModel.swift
//  SwiftUIDemos
//
//  Created by Alex Hay on 23/11/2020.
//

import Foundation

// MARK: DUMMY DATA
class DummyData {
	static let shared = DummyData()
	var names: [String] = ["Alex","Emma","Simon","Jane","Paul", "John", "Jane", "Mary", "Jack", "Linda"]
	var people: [Person] = []
	private init() {
		people = makePeople(withNames: names)
	}
}

// Generates some randomised dummy data from the array of names when run
extension DummyData {
	func makePeople(withNames names: [String]) -> [Person] {
		return names.map({ Person(name: $0, department: Departments.allCases.randomElement() ?? .design) })
	}
}

// MARK: DUMMY DATA MODEL
struct Person: Identifiable {
	let id: UUID = UUID()
	let name: String
	let department: Departments
}

enum Departments: String, CaseIterable {
	case development = "Development"
	case design = "Design"
	case sales = "Sales"
	case marketing = "Marketing"
}

// Allows the departments enum to be sorted by their raw value
extension Departments: Comparable {	
	static func < (lhs: Departments, rhs: Departments) -> Bool { lhs.rawValue < rhs.rawValue }
}
