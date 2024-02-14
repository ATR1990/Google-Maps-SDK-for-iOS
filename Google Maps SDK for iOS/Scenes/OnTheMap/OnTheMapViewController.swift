//
//  OnTheMapViewController.swift
//  optima
//
//  Created by Тауекел on 06.02.2024.
//

import UIKit

final class OnTheMapViewController: UIViewController {
    private var mapViewController: UIViewController!
    private var listViewController: UIViewController!

    // MARK: - UI
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Карта", "Список"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.addTarget(
            self,
            action: #selector(segmentAction),
            for: .valueChanged
        )
        return control
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
        setupChildViewControllers()
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = UIColor(
            red: 0.97, green: 0.96, blue: 0.98, alpha: 1
        )
        view.addSubview(segmentedControl)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    private func setupChildViewControllers() {
        mapViewController = MapViewController()
        listViewController = ListViewController()

        addChild(mapViewController)
        addChild(listViewController)

        view.addSubview(mapViewController.view)
        view.addSubview(listViewController.view)

        mapViewController.view.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
        }

        listViewController.view.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
        }

        listViewController.view.isHidden = true
    }

    // MARK: - Navigation bar
    private func setupNavigationBar() {
        self.navigationItem.title = "На карте"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: AppFont.semibold.s18()
        ]

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "previous_page"),
            style: .done,
            target: self,
            action: #selector(barButtonTapped)
        )
        navigationController?.navigationBar.tintColor = .gray
    }

    // MARK: - Actions
    @objc func barButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func segmentAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapViewController.view.isHidden = false
            listViewController.view.isHidden = true
        case 1:
            mapViewController.view.isHidden = true
            listViewController.view.isHidden = false
        default:
            break
        }
    }
}
