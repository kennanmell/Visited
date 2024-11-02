//
//  LocationViewController.swift
//  Visited
//
//  Created by Kennan Mell on 4/7/24.
//

import UIKit

class LocationViewController: UITableViewController {
    private let key: String
    private let mapData: MapData
    private var location: Location
    private let settings = Settings.instance
    
    init(key: String, mapData: MapData) {
        self.key = key
        self.mapData = mapData
        self.location = settings.getLocation(for: key)
        super.init(style: .grouped)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = mapData.displayName(for: key)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        settings.setLocation(location, for: key)
    }

    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        default:
            assertionFailure()
            return 0
        }
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = .status
                cell.detailTextLabel?.text = location.visitedStatus.description
                cell.detailTextLabel?.textColor = location.visitedStatus.color
            case 1:
                cell.textLabel?.text = .firstYearVisited
                if let year = location.year {
                    cell.detailTextLabel?.text = String(year)
                } else {
                    cell.detailTextLabel?.text = ""
                }
            default:
                assertionFailure()
            }
            return cell
        case 1:
            // TODO
            return UITableViewCell()
        default:
            assertionFailure()
            return UITableViewCell()
        }
    }

    // MARK: UITableViewDelegate

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let alert = UIAlertController(
                    title: .status,
                    message: nil,
                    preferredStyle: .actionSheet)
                let statuses: [VisitedStatus] = [.none, .visited, .wantToGo]
                for status in statuses {
                    let action = UIAlertAction(title: status.description,
                                               style: .default) { _ in
                        self.location = Location(
                            visitedStatus: status,
                            year: self.location.year,
                            notes: self.location.notes)
                        self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                    action.setValue(status.color, forKey: "titleTextColor")
                    alert.addAction(action)
                }
                alert.addAction(UIAlertAction(title: .cancel, style: .cancel))
                present(alert, animated: true)
            case 1:
                break // TODO
            default:
                assertionFailure()
                break
            }
        case 1:
            break // TODO
        default:
            assertionFailure()
            break
        }
    }
}
