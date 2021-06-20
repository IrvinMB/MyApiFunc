import Foundation
extension Dictionary {
    func parameterToString() -> String? {
        return map {key, value in
            let key = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let value = "\(value.self)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return "\(key)=\(value)"
        }.joined(separator: "&")
    }
}
