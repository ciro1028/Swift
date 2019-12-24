//
//  MenuViewController.swift
//  MusicAssistant
//
//  Created by Ciro on 12/15/19.
//  Copyright © 2019 Ciro. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case newSong
    case playlists
    case bugReport
}

@available(iOS 13.0, *)
class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 :
            let toAddSongVC = self.storyboard?.instantiateViewController(withIdentifier: "addSongVC") as! AddSongVC
            self.navigationController?.pushViewController(toAddSongVC, animated: true)
        case 1 :
                let toPlaylistVC = self.storyboard?.instantiateViewController(withIdentifier: "playlistVC") as! PlaylistVC
                self.navigationController?.pushViewController(toPlaylistVC, animated: true)
        case 2 :
                let toBugReportVC = self.storyboard?.instantiateViewController(withIdentifier: "bugReportVC") as! BugReportVCViewController
                self.navigationController?.pushViewController(toBugReportVC, animated: true)
        default :
            print("no value")
        }
        dismiss(animated: true, completion: {
            print("Dismiss Menu")
        })
    }

}
