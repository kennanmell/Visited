//
//  AddViewController.swift
//  Visited
//
//  Created by Kennan Mell on 4/7/24.
//

import UIKit

private class AddTableViewCell: UITableViewCell {}

class AddViewController: UITableViewController {
    private let mapData: MapData
    private let reuseIdentifier = "AddViewController"
    private let settings = Settings.instance

    init(mapType: MapType) {
        self.mapData = MapData(mapType: mapType)
        super.init(style: .grouped)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add"
        tableView.register(AddTableViewCell.self,
                           forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int {
        return mapData.sortedKeys.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = mapData.displayName(
            for: mapData.sortedKeys[indexPath.row])
        return cell
    }

    // MARK: UITableViewDelegate
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath)
    {
        let locationVC = LocationViewController(
            key: mapData.sortedKeys[indexPath.row], mapData: mapData)
        navigationController?.pushViewController(locationVC, animated: true)
    }
}
