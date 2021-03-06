//
//  ViewController.swift
//  SearchBar
//
//  Created by Oscar Rodriguez Garrucho on 27/11/20.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    private let barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1.0)

    private let searchBar = UISearchBar()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Selectors

    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white

        configureNavigationBar(withTitle: "Search Bar",
                               prefersLargeTitles: true,
                               barTintColor: barTintColor)

        showSearchBarButton(shouldShow: true)

        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.placeholder = "Search for an item 🎃"
        definesPresentationContext = false

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .darkGray
            textField.backgroundColor = .white
        }
    }

    private func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                                action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }

    private func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil

    }
}

// MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("DEBUG: Search bar did begin editing...")
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("DEBUG: Search bar did end editing...")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("DEBUG: Search text is: \(searchText)")
    }
}

extension UIViewController {

    func configureNavigationBar(withTitle title: String,
                                prefersLargeTitles: Bool,
                                barTintColor: UIColor = .systemPurple) {

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = barTintColor

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true

        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
}
