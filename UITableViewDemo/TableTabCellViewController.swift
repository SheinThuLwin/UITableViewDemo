//
//  TableTabCellViewController.swift
//  UITableViewDemo
//
//  Created by ut-i02 on 28/04/2022.
//

import UIKit

class TableTabCellViewController: UIViewController {
    
    @IBOutlet weak var tbl: UITableView!
    
    enum Section:Int{
        case imgSection = 0
        case textSection
            
        static var count:NSInteger = 2
    }
    
    private var selectedSectionTabIndices: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView(tbl: tbl)
        
        for _ in 0...Section.count{
            selectedSectionTabIndices.append(0)
        }
    }

    private func setupTableView(tbl: UITableView){
        SingleLblCell.registerForCell(at: tbl)
        SingleLblSingleBtnCell.registerForCell(at: tbl)
        ImageCell.registerForCell(at: tbl)
        TabTableViewHeader.registerForHeaderFooter(at: tbl)
        
        tbl.dataSource = self
        tbl.delegate = self
        
        // The below line is to eliminate the empty cells
//        tbl.tableFooterView = UIView()
    }

}

extension TableTabCellViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Dequeue with the reuse identifier
        let tabIndex = selectedSectionTabIndices[section]
        if section == Section.imgSection.rawValue{
            let header = TabTableViewHeader.getReusableHeaderFooterView(tableView, tabTitles: ["Baby", "Man", "Women"], section: section, selectedIndex: tabIndex, delegate: self)
            return header
        }else{
            let header = TabTableViewHeader.getReusableHeaderFooterView(tableView, tabTitles: ["Cell Auto Height", "Cell Fix Height"], section: section, selectedIndex: tabIndex, delegate: self)
            return header
        }
        
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0{
//            return "AutomaticDimension Cells"
//        }else{
//            return "Custom Height Cells"
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Section.imgSection.rawValue{
            return 1
        }else{
            return 5
        }
    }
    
    //Can remove this function if all cells are automaticDimension.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == Section.imgSection.rawValue{
            let tabIndex = selectedSectionTabIndices[indexPath.section]
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let hSpace: CGFloat = 20 + ImageCell.imgHSpace
            let imgVW = screenWidth - (hSpace * 2)
            
            if let img = getImageByTab(tabIndex: tabIndex){
                let imgVH = ImageCell.getImageviewHeightFor(imgVW: imgVW, image: img)
                return imgVH + ImageCell.imgVSpace
            }
            
            return 0
        }else {
            let tabIndex = selectedSectionTabIndices[indexPath.section]
            if tabIndex == 0{
                return UITableView.automaticDimension
            }else{
                return 150
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Section.imgSection.rawValue{
            return self.tableView(tableView, imageCellForRowAt: indexPath)
        }else{
            return self.tableView(tableView, textCellForRowAt: indexPath)
        }
    }
    
    private func tableView(_ tableView: UITableView, imageCellForRowAt indexPath: IndexPath) -> ImageCell {
        let cell = ImageCell.getReusableCell(tbl, indexPath: indexPath)
        let tabIndex = selectedSectionTabIndices[indexPath.section]
        let img = getImageByTab(tabIndex: tabIndex)
        
        cell.imgV.image = img
        
        return cell
    }
    
    private func getImageByTab(tabIndex: Int) -> UIImage?{
        switch tabIndex {
        case 0:
            return UIImage(named: "baby.jpg")
        case 1:
            return UIImage(named: "man.jpg")
        case 2:
            return UIImage(named: "woman.jpg")
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, textCellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var txt = ""
        let tabIndex = selectedSectionTabIndices[indexPath.section]
        let bgColor = tabIndex == 0 ? UIColor.lightGray : UIColor.yellow
        switch indexPath.row{
        case 1:
            txt = "Although knowing the above code is definitely useful, if you're using storyboards you will find it easier to create prototype cells and give them a reuse identifier directly inside Interface Builder."
            let cell = SingleLblCell.getReusableCell(tbl, indexPath: indexPath, text: txt)
            cell.vwBase.backgroundColor = bgColor
            return cell
        case 2:
            txt = "All you have to do is passing callback closure, and we are done, closure will do the future work for us since we already set it up in second view controller."
            let cell = SingleLblSingleBtnCell.getReusableCell(tbl, indexPath: indexPath, text: txt, btnTitle: "Go", btnTap: { print("Tap button at \(indexPath.row)") })
            cell.vwBase.backgroundColor = bgColor
            return cell
        case 3:
            txt = "We must figure out how to use callback"
            let cell =  SingleLblSingleBtnCell.getReusableCell(tbl, indexPath: indexPath, text: txt, btnTitle: "Tap Me", btnTap: { print("Tap button at \(indexPath.row)") })
            cell.vwBase.backgroundColor = bgColor
            return cell
        case 4:
            txt = "<p>No. 123, 45th Street, 6 Ward, 78 Township, Yangon.</p>\n<p>အမှတ် (၁၂၃)၊ ၄၅လမ်း၊ ၆ ရပ်ကွက်၊ ၇၈ မြို့နယ်၊ ရန်ကုန်။</p>\n<p>Tel: <a href=\"tel:0987654321\">09-87654321</a>, <a href=\"tel:09987654322\">09-987654322</a></p>"
            let cell = SingleLblSingleBtnCell.getReusableCell(tbl, indexPath: indexPath, text: txt, isAttributed: true, btnTitle: "Map", btnTap: { print("Tap button at \(indexPath.row)") })
            cell.vwBase.backgroundColor = bgColor
            return cell
        default:
            txt = "Apple"
            let cell =  SingleLblCell.getReusableCell(tbl, indexPath: indexPath, text: txt)
            cell.vwBase.backgroundColor = bgColor
            return cell
        }


    }
    
    
}

extension TableTabCellViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select row at index \(indexPath.row)")
    }
}

extension TableTabCellViewController: TabTableViewHeaderDelegate{
    func tableView(_ tableView: UITableView, didSelectTabIndex tabIndex: Int, at section: Int) {
        print("Tabselect >> sectoin-\(section) tabIndex-\(tabIndex)")
        selectedSectionTabIndices[section] = tabIndex
        
        tableView.reloadSections(IndexSet(integersIn: section...section), with: .none)
    }
    
    
}
