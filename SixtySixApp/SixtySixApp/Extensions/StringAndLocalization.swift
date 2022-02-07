import Foundation

extension String{
    func localized() -> String{
        return NSLocalizedString(
            self,
            tableName: "Localization",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
