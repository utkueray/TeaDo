//
//  MainViewControllerExtension.swift
//  TeaDo
//
//  Created by Utku Eray on 13.02.2022.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
        
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ToDoCell.self), for:indexPath) as! ToDoCell
        
        if let item = interactor?.list?[indexPath.row] {
            cell.configure(title: "\(item.listId)", subtitle: item.body)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let note = interactor?.list?[indexPath.row] {
            router?.routeToNote(note: note)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let note = interactor?.list?[indexPath.row] {
                deleteNote(id: note.listId)
                interactor?.list?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}
