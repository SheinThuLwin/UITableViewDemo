//
//  TabTableViewHeader.swift
//  UITableViewDemo
//
//  Created by ut-i02 on 28/04/2022.
//

import UIKit

protocol TabTableViewHeaderDelegate {
    func tableView(_ tableView: UITableView, didSelectTabIndex tabIndex: Int, at section: Int)
}

class TabTableViewHeader: UITableViewHeaderFooterView {

    static let Identifier = "TabTableViewHeader"
    static let NibName = "TabTableViewHeader"
    static let height: CGFloat = 49
    
    @IBOutlet weak var vwBG: UIView!
    @IBOutlet weak var tabBar: UITabBar!
    
    public var delegate: TabTableViewHeaderDelegate? = nil
    
    private var tabBarItems: [UITabBarItem] = []
    private var selectedIndex: Int = 0
    
    private unowned var tblView: UITableView?
    private var section: Int = 0
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    static func registerForHeaderFooter(at: UITableView){
        let nib = UINib(nibName: NibName, bundle: nil)
        at.register(nib, forHeaderFooterViewReuseIdentifier: Identifier)
    }
    
    static func getReusableHeaderFooterView(_ tblView: UITableView, tabTitles: [String], section: Int, selectedIndex: Int = 0, delegate: TabTableViewHeaderDelegate? = nil) -> TabTableViewHeader {
        
        let cell = tblView.dequeueReusableHeaderFooterView(withIdentifier: Identifier) as! TabTableViewHeader
        
        cell.tblView = tblView
        cell.section = section
        cell.selectedIndex = (selectedIndex < tabTitles.count && selectedIndex >= 0) ? selectedIndex : 0
        cell.delegate = delegate
        
        cell.setupTabBar(tabBar: cell.tabBar, tabTitles: tabTitles)
        cell.setupTabBarItemSelectedStyle(tabBar: cell.tabBar)
        
        return cell
    }
    
    private func setupTabBar(tabBar: UITabBar, tabTitles: [String]){
//        self.viewControllers = getTabViewControllers()
//        selectedIndex = 1
        
        tabBar.clipsToBounds = false
        tabBar.backgroundColor = .white
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
        tabBar.unselectedItemTintColor = .purple
        tabBar.tintColor = .red
        
        
        tabBar.items?.removeAll()
        var items: [UITabBarItem] = []
        var tag = 0
        for tabTitle in tabTitles {
            let item = getTitleOnlyTabBarItem(title: tabTitle, tag: tag)
            items.append(item)
            tag += 1
        }
        tabBar.items = items
        tabBar.selectedItem = items[selectedIndex]
        tabBar.delegate = self
    }
    
    private func getTitleOnlyTabBarItem(title: String, tag: Int) -> UITabBarItem{
        let item = UITabBarItem.init()
        setupTitleOnlyTabBarItem(tabBarItem: item, title: title, tag: tag)
        return item
    }
    
    private func setupTitleOnlyTabBarItem(tabBarItem: UITabBarItem, title: String, tag: Int){
        let txtVOffset: CGFloat = -12
        let systemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]
        
        tabBarItem.title = title
        tabBarItem.image = nil
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: txtVOffset)
        tabBarItem.setTitleTextAttributes(systemFontAttributes, for: .normal)
        tabBarItem.tag = tag
    }
    
    //This func will work correctly if you call from viewDidAppear.
    private func setupTabBarItemSelectedStyle(tabBar: UITabBar){
        let tabCount = CGFloat(tabBar.items?.count ?? 0)
        if tabCount > 0{
            let tabWidth = tabBar.frame.width/tabCount
            let tabHeight = tabBar.frame.height
            let selectionIndicatorImage = UIImage().createSelectionIndicator(color: .red,
                                                                             size: CGSize(width: tabWidth, height: tabHeight),
                                                                             lineHeight: 3.0,
                                                                             bottomSafeArea: 0)

            tabBar.selectionIndicatorImage = selectionIndicatorImage
        }
    }
}

extension TabTableViewHeader: UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("Section - \(section) Selected \(selectedIndex) - select \(item.tag)")
        let newIndex = item.tag
        if selectedIndex != newIndex{
            if let delegate = delegate, let tblView = tblView{
                delegate.tableView(tblView, didSelectTabIndex: newIndex, at: section)
            }
            selectedIndex = newIndex
        }
        
    }
}
