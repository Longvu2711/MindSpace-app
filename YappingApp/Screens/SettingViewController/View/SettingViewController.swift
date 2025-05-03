
import UIKit

class SettingViewController: BaseViewController {
  
  @IBOutlet weak var settingView: UIView!
  @IBOutlet weak var introductionView: UIView!
  
  @IBOutlet weak var settingTitle: UILabel!
  @IBOutlet weak var settingTable: UITableView!
  
  @IBOutlet weak var introductionTitle: UILabel!
  @IBOutlet weak var termOfUseView: UIView!
  @IBOutlet weak var privacyPolicyView: UIView!
  @IBOutlet weak var rateAppView: UIView!
  @IBOutlet weak var contactUsView: UIView!
  
  @IBOutlet weak var termOfUseLabel: UILabel!
  @IBOutlet weak var privacyPolicyLabel: UILabel!
  @IBOutlet weak var rateAppLabel: UILabel!
  @IBOutlet weak var contactLabel: UILabel!
  
  private var viewModel = SettingsViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    settingTitle.text = "account_setting".localized()
    settingTitle.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    introductionTitle.text = "introduction".localized()
    introductionTitle.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    termOfUseLabel.text = "term_of_use".localized()
    termOfUseLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    privacyPolicyLabel.text = "privacy_policy".localized()
    privacyPolicyLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    rateAppLabel.text = "rate_app".localized()
    rateAppLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    contactLabel.text = "contact_us".localized()
    contactLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    setupNavigation()
    setupTableView()
  }
  
  private func setupTableView() {
    settingTable.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
    settingTable.delegate = self
    settingTable.dataSource = self
  }
  
  private func setupNavigation() {
    let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20, weight: .semibold) ]
    navigationController?.navigationBar.titleTextAttributes = attributes
    navigationItem.title = "setting".localized()
    let backButton = UIBarButtonItem(image: UIImage(resource: .icQrBack),
                                     style: .plain,
                                     target: self,
                                     action: #selector(backTapped))
    backButton.tintColor = .black
    navigationItem.leftBarButtonItem = backButton
  }
  
  @objc private func backTapped() {
    navigationController?.popViewController(animated: true)
  }
  
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.settings.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingCell else {
      return UITableViewCell()
    }
    let setting = viewModel.settings[indexPath.row]
    cell.configureCell(with: setting)
    cell.separatorInset = UIEdgeInsets.zero
    if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
      cell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
      cell.layoutMargins = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let setting = viewModel.settings[indexPath.row]
    print("click \(setting.title)")
  }
}
