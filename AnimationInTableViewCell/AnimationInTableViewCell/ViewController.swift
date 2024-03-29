//
//  ViewController.swift
//  AnimationInTableViewCell
//
//  Created by Mac on 2019/7/17.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    private let cellHeight:CGFloat = 66
    private let colorRatio:CGFloat = 10
    var table:UITableView!
    private var dataSource:Array<String>!
    private let lyric = "when i was young i'd listen to the radio,waiting for my favorite songs,when they played i'd sing along,it make me smile,those were such happy times and not so long ago,how i wondered where they'd gone,but they're back again just like a long lost friend,all the songs i love so well,every shalala every wo'wo,still shines,every shing-a-ling-a-ling"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table = UITableView(frame: self.view.frame)
        self.view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        
        self.dataSource = lyric.split(separator: ",").map(String.init)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        table.reloadData()
        let cells = table.visibleCells
        let tableHeight : CGFloat = table.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            cell.frame.origin.y = tableHeight
            UIView.animate(withDuration: 1.0, delay: 0.04*Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations:{
                cell.frame.origin.y = 0
            }, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "animationInTableViewCell")
        cell.textLabel?.text = self.dataSource[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.cellHeight))
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bgView.frame
        let lowColor:CGColor = UIColor(red: 1.0, green:(CGFloat(indexPath.row * 2) * self.colorRatio)/255.0, blue: (CGFloat(indexPath.row * 2) * self.colorRatio)/255.0, alpha: 1).cgColor
        let upColor:CGColor = UIColor(red: 1.0, green: (CGFloat(indexPath.row * 2) * self.colorRatio + self.colorRatio)/255.0, blue: (CGFloat(indexPath.row * 2) * self.colorRatio + self.colorRatio)/255.0, alpha: 1).cgColor
        gradientLayer.colors = [lowColor,upColor];
        bgView.layer.addSublayer(gradientLayer)
        cell.addSubview(bgView)
        cell.sendSubview(toBack: bgView)
        cell.frame.origin.y = self.cellHeight
        return cell
    }

}

