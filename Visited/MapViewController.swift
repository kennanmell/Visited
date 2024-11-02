//
//  MapViewController.swift
//  Visited
//
//  Created by Kennan Mell on 4/6/24.
//

import UIKit
import FSInteractiveMap

class MapViewController: UIViewController {
    private var map: FSInteractiveMapView = FSInteractiveMapView()
    private let mapType: MapType
    private let mapData: MapData
    private let settings = Settings.instance
    
    init(mapType: MapType) {
        self.mapType = mapType
        self.mapData = MapData(mapType: mapType)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = mapType.displayName
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(self.addTapped))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        map.removeFromSuperview()
        map = FSInteractiveMapView()
        map.frame = CGRect(x: 5,
                           y: 110,
                           width: view.frame.width - 10,
                           height: view.frame.height)

        var mapNumbers = [String: Int]()
        var mapColors = [UIColor]()
        
        var index = 0
        for key in mapData.sortedKeys {
            mapNumbers[key] = index
            index += 1
            mapColors.append(settings.getLocation(for: key).visitedStatus.color)
        }
        
        map.loadMap(mapType.imageName, withData: mapNumbers, colorAxis: mapColors)
        
        map.clickHandler = { [weak self] (identifier: String? , _ layer: CAShapeLayer?) -> Void in
            self?.addTapped()
        }
        
        view.addSubview(map)
    }
    
    @objc
    private func addTapped() {
        let addVC = AddViewController(mapType: mapType)
        navigationController?.pushViewController(addVC, animated: true)
    }
}
