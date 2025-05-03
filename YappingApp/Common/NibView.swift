
import UIKit

/**
 Class for loading view from Nib
 */
open class UIComponentNibView: UIView {

  // MARK: - Initializers

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupNib()
    configureView()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupNib()
    awakeFromNib()
    configureView()
  }

  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setupNib()
  }

  init() {
    super.init(frame: .zero)
    setupNib()
    configureView()
  }
}

// MARK: - Private

private extension UIComponentNibView {

  func setupNib() {
    backgroundColor = .clear
    let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self)))
    let topLevelViews = nib.instantiate(withOwner: self, options: nil)
    let nibView = topLevelViews.first as! UIView
    insertSubview(nibView, at: 0)

    nibView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      nibView.leftAnchor.constraint(equalTo: leftAnchor),
      nibView.rightAnchor.constraint(equalTo: rightAnchor),
      nibView.topAnchor.constraint(equalTo: topAnchor),
      nibView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

public extension UIComponentNibView {
  @objc func configureView() {}
}
