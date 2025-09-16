//
//  SearchResultsViewController.swift
//  DVTWeatherApp
//
//  Created by Nick on 16/09/2025.
//


import UIKit
import DVTWeatherAppDomain

class SearchResultsViewController: UITableViewController {
    var placeSuggestions: [PlacesData] = []
    var onSelect: ((PlacesData) -> Void)?

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeSuggestions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ??
                   UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let place = placeSuggestions[indexPath.row]
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = [place.state, place.country].filter { !$0.isEmpty }.joined(separator: ", ")
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = placeSuggestions[indexPath.row]
        onSelect?(place)
    }
}
