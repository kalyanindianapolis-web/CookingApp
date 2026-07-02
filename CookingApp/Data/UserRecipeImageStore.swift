import UIKit

/// Stores user-picked recipe photos on disk in Documents/RecipeImages, keyed by
/// the recipe's UUID. Keeps large image data out of Core Data while letting any
/// view look up a photo from just a recipe id.
enum UserRecipeImageStore {
    private static var directory: URL {
        let dir = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("RecipeImages", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }

    private static func url(for id: UUID) -> URL {
        directory.appendingPathComponent("\(id.uuidString).jpg")
    }

    static func save(_ data: Data, for id: UUID) {
        try? data.write(to: url(for: id), options: .atomic)
    }

    static func data(for id: UUID) -> Data? {
        try? Data(contentsOf: url(for: id))
    }

    static func image(for id: UUID) -> UIImage? {
        UIImage(contentsOfFile: url(for: id).path)
    }

    static func hasImage(for id: UUID) -> Bool {
        FileManager.default.fileExists(atPath: url(for: id).path)
    }

    static func delete(for id: UUID) {
        try? FileManager.default.removeItem(at: url(for: id))
    }
}
