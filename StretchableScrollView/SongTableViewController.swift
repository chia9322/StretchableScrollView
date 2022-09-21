//
//  SongTableViewController.swift
//  StretchableScrollView
//
//  Created by Chia on 2022/09/13.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    let imageOriginalHeight: CGFloat = 250
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: imageOriginalHeight, left: 0, bottom: 0, right: 0)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let song = songs[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = song.title
        content.secondaryText = song.artist
        content.textProperties.color = .white
        content.textProperties.font = .boldSystemFont(ofSize: 17)
        content.secondaryTextProperties.color = .lightGray
        content.secondaryTextProperties.font = .boldSystemFont(ofSize: 14)
        content.secondaryTextProperties.numberOfLines = 1
        cell.contentConfiguration = content
        
        let ellipsisImageView = UIImageView(image: UIImage(systemName: "ellipsis"))
        ellipsisImageView.tintColor = .lightGray
        cell.accessoryView = ellipsisImageView
        
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let controller = parent as? ViewController
        let originalOffsetY = -imageOriginalHeight
        let moveDistance = abs(scrollView.contentOffset.y - originalOffsetY)
        if scrollView.contentOffset.y < originalOffsetY {
            controller?.imageViewHeightConstraint.constant = imageOriginalHeight + moveDistance
            tableView.backgroundColor = .clear
        } else {
            controller?.imageViewHeightConstraint.constant = imageOriginalHeight - moveDistance/2
            tableView.backgroundColor = UIColor(white: 0, alpha: moveDistance*1.5/imageOriginalHeight)
        }
    }
    
}
