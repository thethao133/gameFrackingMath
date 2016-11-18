//
//  gameViewController.swift
//  gameFrackingMath
//
//  Created by Nguyen The Thao on 4/24/16.
//  Copyright © 2016 TheThao. All rights reserved.
//

import UIKit

class gameViewController: UIViewController {
    var timer:NSTimer!
    var so1:Int!
    var so2:Int!
    var dau:Int!
    var diem = 0
    var kihieu:String!
    var nguoiChoiDung:Bool!
    var daClick:Bool = false
    @IBOutlet weak var sldGio: UISlider!
    @IBOutlet weak var lblDiem: UILabel!
    @IBOutlet weak var lblKetQua: UILabel!
    
    @IBOutlet weak var lblBang: UILabel!
    @IBOutlet weak var lblSo2: UILabel!
    @IBOutlet weak var lblDau: UILabel!
    @IBOutlet weak var lblSo1: UILabel!
    @IBOutlet weak var btntrue: UIButton!
    @IBOutlet weak var btnfalse: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sldGio.minimumTrackTintColor = UIColor.yellowColor()
       // sldGio.setMinimumTrackImage(leftTrackImage, forState: .Normal)
        
        sldGio.setThumbImage(UIImage(named: "triangle")!, forState: .Normal)
        sldGio.maximumValue = 5
        sldGio.minimumValue = 0
        sldGio.value = 0
        sldGio.enabled = false
        PhepToanNgauNhien()//gọi phép toán ngẫu nhiên ra
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "Chay", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
  
   func PhepToanNgauNhien()
   {
    
    so1 = Int(arc4random_uniform(20))
    so2 = Int(arc4random_uniform(20))
    lblSo1.text = String(so1)
    lblBang.text = "="
    lblDau.text = "+"
    lblSo2.text = String(so2)
    var ResultCal:Int = so1 + so2
    var ResultRando:Int = Int(arc4random_uniform(2)) + ResultCal
    
    //lblKetQua.text = String(Int(arc4random_uniform(UInt32(so1))) + Int(arc4random_uniform(UInt32(so2/2))))
    lblKetQua.text = String(ResultRando)
   }
    @IBAction func btnTrue(sender: AnyObject) {
        daClick = true
        //btnfalse.enabled = false

        let ketqua:Int = so1 + so2
        if  String(ketqua) == lblKetQua.text {
          nguoiChoiDung = true
        }
        else{
          nguoiChoiDung = false
        }
        
    }

    
    @IBAction func btnFalse(sender: AnyObject) {
        daClick = true
        //btntrue.enabled = false
        let ketqua:Int = so1 + so2
        if  String(ketqua) != lblKetQua.text{
          nguoiChoiDung = true
        }
        else{
            nguoiChoiDung = false
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //đây là hàm reset giá trị
    func reset()
    {
    
        sldGio.value = 0
        PhepToanNgauNhien()
        daClick = false
    }
    
    func Chay()
    {
        sldGio.value += 1
        //người chơi đã click
        if(daClick==true)//nếu đã click thì kiểm tra
        {//đã đúng
            if(nguoiChoiDung != true)//người chơi không đúng
            {
                reset()
                ThongBaoKetQuaThua()
                timer.invalidate()
                
            } else{//người chơi đúng
              
                diem += 1
                lblDiem.text = String(diem)
                timer.invalidate()//ngăt timer
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "Chay", userInfo: nil, repeats: true)
                self.reset()
                
                
            }

        }else//Người chơi chưa lick nhưng hết giờ
        {
            if(sldGio.value == sldGio.maximumValue)//Người chơi chưa lick nhưng hết giờ
            {
                  timer.invalidate()
                      reset()
                       timer.invalidate()
                      ThongBaoKetQuaThua()
            }
        }
     
    
    }
    func ThongBaoKetQuaThua()
    {
        let alert:UIAlertController = UIAlertController(title: "Thông Báo", message: "Bạn Đã Thua \n " + "Điểm : " + lblDiem.text! , preferredStyle: .Alert)
        
        let choilai:UIAlertAction = UIAlertAction(title: "Chơi Lại", style: .Default) { (tengicungduoc) -> Void in
            self.reset()
            self.lblDiem.text = "0"
            self.timer.invalidate()
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "Chay", userInfo: nil, repeats: true)
        }
        
        let cancel:UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { (ten) -> Void in
            self.lblDiem.text = "0"
            let ManHinhDau = self.storyboard?.instantiateViewControllerWithIdentifier("ManHinhChinh") as! ViewController
            self.presentViewController(ManHinhDau, animated: true, completion: nil)
        
        }
        alert.addAction(choilai)
        alert.addAction(cancel)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
