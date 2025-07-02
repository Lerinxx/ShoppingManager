import UIKit

enum ErrorPresenter {
    static func present(_ error: Error, in viewController: UIViewController) {
        let message = (error as? LocalizedError)?.errorDescription
        
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }
}
