//
//  MasterViewController.swift
//  MesActivite
//
//  Created by m2sar on 01/12/2017.
//  Copyright © 2017 UPMC. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController,UISplitViewControllerDelegate{
    
    var svc: UISplitViewController?
    var termType = terminalType.undefined
    var monDetail: DetailViewController?
    
    var compteur = 0
    var contenu = [[UneCellule]]()
    
    private var currentSection : Int = 0
    private var currentRow : Int = 0
    
    let celluleVacDefault = UneCellule(l: "S'occuper des vacances", p: 4)
    let cellulePersoDefault = UneCellule(l: "Faire les courses", p: 2)
    let celluleUrgentDefault = UneCellule(l: "Me faire un cadeau", p: 3)
    let tabCelluleAujourdhuiDefault = [ UneCellule(l: "Boire mon café", p: 0),
                                        UneCellule(l:"Faire ma sieste", p: 1)
    ]
    
    
    var mobile = false
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(style : UITableViewStyle){
        super.init(style: style)
        
        self.tableView.sectionFooterHeight = 0.0
        self.tableView.separatorColor = UIColor.clear
        
        for i in 0 ... 3{
            var dansSection = [UneCellule]()
            switch i {
            case 0:
                dansSection += [celluleVacDefault]
            case 1:
                dansSection += [cellulePersoDefault]
            case 2:
                dansSection += [celluleUrgentDefault]
            case 3:
                dansSection += tabCelluleAujourdhuiDefault
            default:
                ()
            }
            contenu += [dansSection]
        }
        
        self.tableView.sectionFooterHeight = 80
        self.tableView.sectionIndexBackgroundColor = UIColor.white
        self.tableView.separatorColor = UIColor.red
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.title = "List de taches"
        
        //les boutons de modification
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,target: self,action: #selector(ajouteCellule))
        
        self.tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func changeTextCellue(string:String){
        let tmp = contenu[currentSection][currentRow]
        tmp.updateTitle(prio: string)
        self.contenu[currentSection].remove(at: currentRow)
        self.contenu[currentSection].insert(tmp, at: currentRow)
        
        self.tableView.reloadData()
    }
    
    func changePrioCellule(selected : Int){
        let tmp = contenu[currentSection][currentRow]
        tmp.updatePrio(prio: selected)
        print("Prio\(selected)")
        
        self.contenu[currentSection].remove(at: currentRow)
        self.contenu[currentSection].insert(tmp, at: currentRow)
        
        self.tableView.reloadData()
    }
    
    func changeImageCellule(selected : UIImage){
        let tmp = contenu[currentSection][currentRow]
        tmp.updateImage(d: selected)
        
        self.contenu[currentSection].remove(at: currentRow)
        self.contenu[currentSection].insert(tmp, at: currentRow)
        
        self.tableView.reloadData()
    }
    
    func ajouteCellule() {
        self.contenu[1].insert(UneCellule(l:"Nouvelle tache",p: 0), at: contenu[1].count)
        
        compteur += 1
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contenu.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (contenu[section] as AnyObject).count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width,height: 80.0))
        hv.addSubview(UIImageView(image: UIImage(named: "bg-header")))
        let l = UILabel(frame: CGRect(x: 20.0, y: 30.0, width: UIScreen.main.bounds.size.width,height: 25.0))
        l.textColor = UIColor.white
        l.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        switch section {
        case 0:
            l.text = "Vacances"
        case 1:
            l.text = "Personnel"
        case 2:
            l.text = "Urgent"
        default:
            l.text = "Aujourd'hui"
        }

        hv.addSubview(l)
        return hv
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                var cell = tableView.dequeueReusableCell(withIdentifier: "ppm")
        if cell === nil {
            cell = UITableViewCell(style:. subtitle,reuseIdentifier: "ppm")
        }
        
        let cont = contenu[indexPath.section][indexPath.row]
        cell!.textLabel?.text = cont.label
        cell!.detailTextLabel?.text = cont.detail
        cell!.imageView?.image = cont.prioImage.image
        cell!.backgroundView = UIImageView(image: UIImage(named: "bg-tableview-cell"))
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       return true
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.contenu[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }else if editingStyle == .insert{
            
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let detail = DetailViewController(s: self.contenu[indexPath.section][indexPath.row].priorite)
        
        
        //monDetail?.updateView(cel: contenu[indexPath.section][indexPath.row])
        currentSection = indexPath.section
        currentRow = indexPath.row
        
        //        //detail.showDetailViewController(monDetail!.navigationController!, sender: self)
        currentSection = indexPath.section
        currentRow = indexPath.row
        let cont = contenu[indexPath.section][indexPath.row]
        monDetail?.updateView(cel: cont)
        
        if(mobile){
            self.navigationController?.pushViewController(monDetail!, animated: true)

        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = contenu[sourceIndexPath.section][sourceIndexPath.row]
        contenu[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        contenu[destinationIndexPath.section].insert(movedObject, at: destinationIndexPath.row)
        
        currentRow = destinationIndexPath.row
        currentSection = destinationIndexPath.section
        
        
        
        self.tableView.reloadData()
        
    }
    
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewControllerDisplayMode) {
        let access = monDetail?.navigationController?.topViewController?.navigationItem
        if displayMode == .primaryHidden{
            access?.setLeftBarButton(svc.displayModeButtonItem, animated: true)
        }else{
            access?.setLeftBarButton(nil, animated: true)
        }
    }
    
    func targetDisplayModeForAction(in svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        switch termType{
        case .iphone35,.iphone40,.iphone47:
            ()
        default:
            let a = monDetail?.navigationController?.topViewController?.navigationItem
            a?.setLeftBarButton(svc.displayModeButtonItem, animated: true)
        }
        
        return .allVisible
    }
 
}
