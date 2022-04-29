//
//  ImageCell.swift
//  UITableViewDemo
//
//  Created by ut-i02 on 28/04/2022.
//

import UIKit

class ImageCell: UITableViewCell {
    
    static let Identifier = "ImageCell"
    static let NibName = "ImageCell"
    static let height: CGFloat = 53
    static let imgHSpace: CGFloat = 8
    static let imgVSpace: CGFloat = 8
    
    @IBOutlet weak var vwBase: UIView!
    @IBOutlet weak var imgV: UIImageView!

    static func registerForCell(at: UITableView){
        let cell = UINib(nibName: NibName, bundle: nil)
        at.register(cell, forCellReuseIdentifier: Identifier)
    }
    
    static func getReusableCell(_ tblView: UITableView, indexPath: IndexPath, image: UIImage? = nil) -> ImageCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! ImageCell
        cell.imgV.image = image
        
        print("ImageCell >> \(cell.frame.size.width), \(cell.frame.size.height)")
        
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func getImageviewHeightFor(imgVW: CGFloat, image: UIImage) -> CGFloat{
        let imgW = image.size.width
        let imgH = image.size.height
        let imgVH = (imgVW * imgH)/imgW
        
        return imgVH
    }
    
}
