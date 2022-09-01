//
//  ListMusclesTableVC.swift
//  Training Diary
//
//  Created by user on 29.08.2022.
//

import UIKit

class MusclesViewController: UIViewController {
    private var viewModel: MusclesViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MusclesViewModel()
    }
}
    // MARK: - Table view data source

extension MusclesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForListMusclesTableView.muscleCell.rawValue) as? MusclesTableViewCell
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        return tableViewCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.didSelectRow(forIndexPath: indexPath)
        self.performSegue(withIdentifier: "ToExercisesList", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else { return }
        if identifier == "ToExercisesList" {
            if let evc = segue.destination as? ExercisesViewController {
                evc.viewModel = viewModel.viewModelForSelectedRow() as? ExercisesViewModel
            }
        }
    }
}
