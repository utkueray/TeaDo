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
        return isSearch == true ? filteredTableData?.count ?? 0 : interactor?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ToDoCell.self), for:indexPath) as! ToDoCell
        
        if (isSearch) {
            if let item = filteredTableData?[indexPath.row] {
                cell.configure(isNote: item.isNote ?? true,
                               isCompleted: item.isCompleted ?? false)
                
                cell.setupTexts(title: item.title ?? "", subTitle: item.body ?? "", strikeThrough: item.isCompleted ?? false)
            }
        } else {
            if let item = interactor?.list?[indexPath.row] {
                cell.configure(isNote: item.isNote ?? true,
                               isCompleted: item.isCompleted ?? false)
                
                cell.setupTexts(title: item.title ?? "", subTitle: item.body ?? "", strikeThrough: item.isCompleted ?? false)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 64))
        
        let searchBar = UISearchBar(frame: headerView.frame)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = NSLocalizedString("search", comment: "")
        searchBar.backgroundImage = UIImage(color: TDColor.backgroundColor)
        searchBar.backgroundColor = TDColor.backgroundColor
        searchBar.tintColor = TDColor.componentColor
        searchBar.searchTextField.textColor = TDColor.titleColor
        searchBar.searchTextField.leftView?.tintColor = TDColor.componentColor
        searchBar.searchTextField.clearButtonMode = .whileEditing
        searchBar.isTranslucent = false
        searchBar.sizeToFit()

        searchBar.delegate = self
        headerView.addSubview(searchBar)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isSearch {
            if let note = filteredTableData?[indexPath.row] {
                router?.routeToNote(note: note)
            }
        } else {
            if let note = interactor?.list?[indexPath.row] {
                router?.routeToNote(note: note)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if isSearch {
                if let note = filteredTableData?[indexPath.row] {
                    filteredTableData?.remove(at: indexPath.row)
                    deleteNote(id: note.listId)
                }
            } else {
                if let note = interactor?.list?[indexPath.row] {
                    interactor?.list?.remove(at: indexPath.row)
                    deleteNote(id: note.listId)
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)

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

//MARK: UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let tableView = contentView?.tableView {
            self.searchText = searchText

            if searchText.count == 0 {
                isSearch = false
                tableView.reloadData()
            } else {
                isSearch = true
                filteredTableData = interactor?.list?.filter {
                    $0.title?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                }
                
                tableView.reloadData()
            }
        }
    }
}
