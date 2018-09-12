import Foundation

struct Password {
    private struct Constants {
        static let passwordRegEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        static let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
    }
    let passwordString: String
    init?(_ inputString: String) {
        guard Constants.passwordPredicate.evaluate(with: inputString) else {
            return nil
        }
        passwordString = inputString
    }
}

extension Password {
    func asString() -> String {
        return self.passwordString
    }
}

extension String {
    func asPassword() -> Password? {
        return Password(self)
    }
}
