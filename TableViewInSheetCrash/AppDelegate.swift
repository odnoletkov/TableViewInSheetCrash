import UIKit

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let controller = UIViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = controller
        window!.makeKeyAndVisible()

        let tableViewController = TableViewController(style: .insetGrouped)
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems((0..<20).map { String ($0 )})
        tableViewController.dataSource.applySnapshotUsingReloadData(snapshot)
        let navigationController = UINavigationController(rootViewController: tableViewController)
        navigationController.sheetPresentationController?.detents = [.medium(), .large()]
        controller.present(navigationController, animated: true)

        return true
    }
}

class TableViewController: UITableViewController {
    lazy var dataSource = UITableViewDiffableDataSource<Int, String>(tableView: tableView) { tableView, indexPath, itemIdentifier in
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
