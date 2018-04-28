import UIKit

class DemoViewController: UIViewController {
    
    let lv = LiveView(frame: .zero)
    var context: CGContext!
    
    var bitmap: BitmapContext!
    var bitmapTarget: Bitmap!
    
    let w = 10
    let h = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lv)
        view.backgroundColor = .white
        
        
        
        self.context = CGContext(data: nil,
                                 width: w,
                                 height: h,
                                 bitsPerComponent: 8,
                                 bytesPerRow: w * 4,
                                 space: CGColorSpaceCreateDeviceRGB(),
                                 bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { t in
            
//            self.bitmap.setPixels()
//            self.updateSnapshot()
        }
        
        bitmapTarget = CoreGraphicsBitmap(context: context)
        bitmap = BitmapContext.init(bitmapTarget: bitmapTarget)
        
        context.setFillColor(UIColor.black.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 35, height: 35))
//
//        let center = CGPoint(x: w / 2, y: h / 2)
//        context.setFillColor(UIColor.red.cgColor)
//        context.fill(CGRect(x: center.x, y: center.y, width: 1, height: 1))
//
//
        
        
        updateSnapshot()
    }
    
    var tick = 0 {
        didSet {
            if tick > 10 {
                tick = 0
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        tick += 1
        
//        bitmap.logPixels()
        self.bitmap.algo1()
        self.updateSnapshot()
        
//        let center = CGPoint(x: w / 2, y: h / 2)
//        context.setFillColor(UIColor.red.cgColor)
//        context.fill(CGRect(x: center.x, y: center.y, width: 1, height: 1))
        
        if tick % 5 == 0 {
            
            context.setFillColor(UIColor.blue.cgColor)
            context.clear(CGRect(x: 0, y: 0, width: w, height: h))
        
            context.setFillColor(UIColor.white.cgColor)
            context.fill(CGRect(x: w / 2, y: h / 2, width: 1, height: 1))
        }
    }
    
    override func viewDidLayoutSubviews() {
        lv.frame = view.bounds
    }

    
    func updateSnapshot() {
        
        lv.iv.image = UIImage(cgImage: context.makeImage()!)
    }
}










class LiveView: UIView {
    
    let iv = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iv)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        iv.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
}









