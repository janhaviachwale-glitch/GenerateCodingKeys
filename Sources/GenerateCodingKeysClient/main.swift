import Foundation
import GenerateCodingKeys

@GenerateCodingKeys
struct Article: Codable {
    let articleId: Int
    let articleTitle: String
    let authorName: String
    let publishedDate: String
}

@GenerateCodingKeys
struct Comment: Codable {
    let commentId: Int
    let articleId: Int
    let commenterName: String
    let createdAt: String
}
    
let article = Article(
    articleId: 101,
    articleTitle: "Sample Article",
    authorName: "John Doe",
    publishedDate: "2024-06-01"
)

let comment = Comment(
    commentId: 201,
    articleId: 101,
    commenterName: "Jane Smith",
    createdAt: "2024-06-02"
)

let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

do {
    let articleData = try encoder.encode(article)
    let commentData = try encoder.encode(comment)

    print("Article JSON:")
    print(String(data: articleData, encoding: .utf8)!)
    
    print("\nComment JSON:")
    print(String(data: commentData, encoding: .utf8)!)
} catch {
    print("Encoding error: \(error)")
}
    
