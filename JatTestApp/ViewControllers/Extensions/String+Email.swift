import Foundation

struct Email {
    private struct Constants {
        static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    }
    
    let emailString: String
    init?(_ inputString: String) {
        let trimString = inputString.trimmingCharacters(in: .whitespacesAndNewlines)
        guard Constants.emailPredicate.evaluate(with: trimString) else {
            return nil
        }
        emailString = trimString
    }
}

extension Email {
    func asString() -> String {
        return self.emailString
    }
}

extension String {
    func asEmail() -> Email? {
        return Email(self)
    }
}

