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
        return 61.0
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ToDoCell.self), for:indexPath) as! ToDoCell
        
        if let item = interactor?.list?[indexPath.row] {
            cell.configure(isNote: item.isNote ?? true,
                           isCompleted: item.isCompleted ?? false)
            
            cell.setupTexts(title: item.title ?? "", subTitle: item.body ?? "", strikeThrough: item.isCompleted ?? false)
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
        switch editingStyle {
        case .delete:
            if let note = interactor?.list?[indexPath.row] {
                deleteNote(id: note.listId)
                interactor?.list?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let note = interactor?.list?[indexPath.row],
              !(note.isNote ?? false) else {
            return nil
        }
        var markNote: UIContextualAction!
        
        if !(note.isCompleted ?? false) {
            markNote = UIContextualAction(style: .normal, title: NSLocalizedString("done", comment: ""), handler: {
                (action, sourceView, completionHandler) in
                self.markNote(note: note, isCompleted: true)
                 completionHandler(true)
            })
            markNote.backgroundColor = TDColor.logoColor
        } else {
            markNote = UIContextualAction(style: .normal, title: NSLocalizedString("undo", comment: ""), handler: {
                (action, sourceView, completionHandler) in
                self.markNote(note: note, isCompleted: false)
                 completionHandler(true)
            })
            markNote.backgroundColor = TDColor.componentColor
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [markNote])
        return swipeConfiguration
    }
}
