import CollectionKitty
import Foundation

struct ChurchPack: Pack {
	let id: UUID
	let title: String
	let subtitle: String
	let description: String
	let entries: [ChurchEntry]
}
