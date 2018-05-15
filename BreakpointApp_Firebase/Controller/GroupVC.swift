//
//  GroupVC.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/10/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit

class GroupVC: UIViewController {

    @IBOutlet weak var tableGroup: UITableView!
    var arrGroups = [Group]();
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableGroup.delegate = self;
        self.tableGroup.dataSource = self;
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        DataService.instant.getAllGroups { (groups) in
            self.arrGroups = groups;
            self.tableGroup.reloadData();
        }
    }
}

extension GroupVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGroups.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupReuseCell", for: indexPath) as! GroupCell;
        
        let item = self.arrGroups[indexPath.row];
        cell.configureCell(withTitle: item.groupTitle, andDescription: item.groupDesc, memberCount: item.groupMember.count);
        return cell;
    }
    
    
}






