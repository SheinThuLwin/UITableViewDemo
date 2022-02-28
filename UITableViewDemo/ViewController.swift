//
//  ViewController.swift
//  UITableViewDemo
//
//  Created by ut-i02 on 22/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView(tbl: tbl)
    }

    private func setupTableView(tbl: UITableView){
        SingleLblCell.registerForCell(at: tbl)
        SingleLblSingleBtnCell.registerForCell(at: tbl)
        tbl.dataSource = self
        tbl.delegate = self
    }

}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "AutomaticDimension Cells"
        }else{
            return "Custom Height Cells"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 5
        }else{
            return 5
        }
    }
    
    //Can remove this function if all cells are automaticDimension.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return UITableView.automaticDimension
        }else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var txt = ""
        let bgColor = indexPath.section == 0 ? UIColor.lightGray : UIColor.yellow
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

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select row at index \(indexPath.row)")
    }
}

