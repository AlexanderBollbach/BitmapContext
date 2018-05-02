import Foundation

class FakePixel: BitmapPixel {
    
    var color: BitmapColor = BitmapColor.white
    
    func darken(by percent: Double) {
        color.r = pixelComponent(color.r, decrementedBy: percent)
        color.g = pixelComponent(color.g, decrementedBy: percent)
        color.b = pixelComponent(color.b, decrementedBy: percent)
        color.a = pixelComponent(color.a, decrementedBy: percent)
    }
    
    func brighten(by percent: Double) {
        color.r = pixelComponent(color.r, incrementedBy: percent)
        color.g = pixelComponent(color.g, incrementedBy: percent)
        color.b = pixelComponent(color.b, incrementedBy: percent)
        color.a = pixelComponent(color.a, incrementedBy: percent)
    }
}
