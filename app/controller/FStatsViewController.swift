//
//  FStatsViewController.swift
//  follower
//
//  Created by Luke Wakeford on 28/08/2020.
//

import UIKit

class FStatsViewController:UIViewController {
    
    let stack = UIStackView()
    let distanceLabel = FLabel(.stat)
    let durationLabel = FLabel(.stat)
    let averageSpeed = FLabel(.stat)
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.backgroundColor = UIColor(named: "accent")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stats"
        
        self.stack.axis = .vertical
        self.stack.distribution = .fill
        self.stack.translatesAutoresizingMaskIntoConstraints = false
        self.stack.spacing = 10
        self.view.addSubview(self.stack)
    
        NSLayoutConstraint.activate([
            self.stack.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: 20
            ),
            self.stack.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: 20
            ),
            self.stack.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            self.stack.bottomAnchor.constraint(
                lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
        
        drawStack()
        updateStats()
        
    }
    
    func drawStack() {
        let distanceTitle = FLabel(.title)
        distanceTitle.text = "Total distance"
        self.stack.addArrangedSubview(distanceTitle)
    
        self.stack.addArrangedSubview(distanceLabel)
        
        let durationTitle = FLabel(.title)
        durationTitle.text = "Duration"
        self.stack.addArrangedSubview(durationTitle)

        self.stack.addArrangedSubview(durationLabel)
        
        let averageSpeedTitle = FLabel(.title)
        averageSpeedTitle.text = "Average speed"
        self.stack.addArrangedSubview(averageSpeedTitle)
        
        self.stack.addArrangedSubview(averageSpeed)
        
        NSLayoutConstraint.activate([
            distanceTitle.heightAnchor.constraint(equalToConstant: 20),
            durationTitle.heightAnchor.constraint(equalToConstant: 20),
            averageSpeedTitle.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func updateStats() {
        let locations = FLocationManager.shared.locations
        distanceLabel.text = FStatsHelper.getTotalDistance(forLocations: locations)
        durationLabel.text = FStatsHelper.getDuration(forLocations: locations)
        averageSpeed.text = FStatsHelper.getAverageSpeed(forLocations: locations)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { timer in
            self.updateStats()
        })
    }

    
}
