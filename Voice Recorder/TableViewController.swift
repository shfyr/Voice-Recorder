//
//  TableViewController.swift
//  Voice Recorder
//
//  Created by Elizaveta Prokudina on 23.01.2020.
//  Copyright © 2020 Elizaveta Prokudina. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var recordings = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listRecordings()
        print(recordings)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Record", for: indexPath) as? TableViewCell {
            cell.recordLabel.text = recordings[indexPath.row].lastPathComponent
            return cell
        }
        return UITableViewCell()
    }
    
    //MARK: - Functions
    func listRecordings() {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil,
                                                                   options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            self.recordings = urls.filter({ (name: URL) -> Bool in
                return name.pathExtension == "m4a"
            })
        } catch {
            print(error.localizedDescription)
            print("something went wrong listing recordings")
        }
    }
}


class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var recordLabel: UILabel!
    
}

