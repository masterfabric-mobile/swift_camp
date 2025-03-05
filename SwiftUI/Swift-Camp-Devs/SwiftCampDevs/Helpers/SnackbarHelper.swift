import UIKit

// MARK: - SnackbarHelperProtocol
protocol SnackbarHelperProtocol {
    func showSnackbar(
        in viewController: UIViewController,
        type: SnackbarHelper.SnackbarType,
        title: String,
        description: String?,
        duration: TimeInterval
    )
}

// MARK: - SnackbarHelper
final class SnackbarHelper: SnackbarHelperProtocol {
    
    // MARK: - Singleton Instance
    static let shared = SnackbarHelper()
    
    // MARK: - Initializer (Private for Singleton)
    private init() {}
    
    // MARK: - Public Method to Show Snackbar
    func showSnackbar(
        in viewController: UIViewController,
        type: SnackbarType,
        title: String,
        description: String? = nil,
        duration: TimeInterval = 3.0
    ) {
        let snackbarView = createSnackbarView(
            title: title,
            description: description,
            backgroundColor: type.backgroundColor,
            textColor: type.textColor,
            icon: type.icon
        )
        showSnackbarView(snackbarView, in: viewController, duration: duration)
    }
    
    // MARK: - Private Method to Create Snackbar View
    private func createSnackbarView(
        title: String,
        description: String?,
        backgroundColor: UIColor,
        textColor: UIColor,
        icon: UIImage?
    ) -> UIView {
        let snackbarView = UIView()
        snackbarView.backgroundColor = backgroundColor
        snackbarView.layer.cornerRadius = 12
        snackbarView.clipsToBounds = true
        snackbarView.translatesAutoresizingMaskIntoConstraints = false

        // Icon
        let iconImageView = UIImageView(image: icon)
        iconImageView.tintColor = textColor
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = textColor
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        snackbarView.addSubview(iconImageView)
        snackbarView.addSubview(titleLabel)

        var constraints: [NSLayoutConstraint] = [
            iconImageView.leadingAnchor.constraint(equalTo: snackbarView.leadingAnchor, constant: 8),
            iconImageView.centerYAnchor.constraint(equalTo: snackbarView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: snackbarView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: snackbarView.topAnchor, constant: 8)
        ]

        // Eğer description nil değilse, descriptionLabel'ı ekleyelim
        if let description = description, !description.isEmpty {
            let descriptionLabel = UILabel()
            descriptionLabel.text = description
            descriptionLabel.font = UIFont.systemFont(ofSize: 14)
            descriptionLabel.textColor = textColor
            descriptionLabel.numberOfLines = 0
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

            snackbarView.addSubview(descriptionLabel)

            constraints.append(contentsOf: [
                descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                descriptionLabel.bottomAnchor.constraint(equalTo: snackbarView.bottomAnchor, constant: -8)
            ])
        } else {
            constraints.append(titleLabel.bottomAnchor.constraint(equalTo: snackbarView.bottomAnchor, constant: -8))
        }

        NSLayoutConstraint.activate(constraints)
        
        return snackbarView
    }
    
    // MARK: - Private Method to Show Snackbar View
    
    private func showSnackbarView(_ snackbarView: UIView, in viewController: UIViewController, duration: TimeInterval) {
        snackbarView.tag = 999
        viewController.view.addSubview(snackbarView)
        
        NSLayoutConstraint.activate([
            snackbarView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 16),
            snackbarView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -16),
            snackbarView.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        viewController.view.layoutIfNeeded()
        
        snackbarView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            snackbarView.alpha = 1
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                UIView.animate(withDuration: 0.3, animations: {
                    snackbarView.alpha = 0
                }, completion: { _ in
                    snackbarView.removeFromSuperview()
                })
            }
        })
    }
    
    // MARK: - SnackbarType Enum
    enum SnackbarType {
        case success
        case error
        case warning
        case info
        case custom(backgroundColor: UIColor, textColor: UIColor, icon: UIImage?)
        
        var backgroundColor: UIColor {
            switch self {
            case .success: return UIColor(red: 0.0, green: 0.4, blue: 0.0, alpha: 1.0) // Dark green
            case .error: return UIColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0) // Dark red
            case .warning: return UIColor(red: 0.6, green: 0.3, blue: 0.0, alpha: 1.0) // Dark orange
            case .info: return UIColor(red: 0.0, green: 0.2, blue: 0.4, alpha: 1.0) // Dark blue
            case .custom(let backgroundColor, _, _): return backgroundColor
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .custom(_, let textColor, _): return textColor
            default: return .white
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .success: return UIImage(systemName: "checkmark.circle")
            case .error: return UIImage(systemName: "xmark.octagon")
            case .warning: return UIImage(systemName: "exclamationmark.triangle")
            case .info: return UIImage(systemName: "info.circle")
            case .custom(_, _, let icon): return icon
            }
        }
    }
}
