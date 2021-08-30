//
//  ViewController.swift
//  CoreGraphicsSandbox
//
//  Created by Atin Agnihotri on 28/08/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var drawImageView: UIImageView!
    var currentDrawType = 0 {
        didSet { // Wrapping value from 8
            if currentDrawType > 8 {
                currentDrawType = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRectangle()
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let cgContext = context.cgContext
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)

            cgContext.setFillColor(UIColor.red.cgColor)
            cgContext.setStrokeColor(UIColor.black.cgColor)
            cgContext.setLineWidth(10)

            cgContext.addRect(rectangle)
            cgContext.drawPath(using: .fillStroke)
        }
        
        drawImageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let cgContext = context.cgContext
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 15, dy: 15)

            cgContext.setFillColor(UIColor.red.cgColor)
            cgContext.setStrokeColor(UIColor.black.cgColor)
            cgContext.setLineWidth(10)

            cgContext.addEllipse(in: rectangle)
            cgContext.drawPath(using: .fillStroke)
        }
        
        drawImageView.image = image
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let cgContext = context.cgContext
            
            cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col).isMultiple(of: 2) { // Since checkboards alternate, the col offsets row
                        let rect = CGRect(x: col * 64, y: row * 64, width: 64, height: 64)
                        cgContext.fill(rect)
                    }
                }
            }
        }
        
        drawImageView.image = image
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let cgContext = context.cgContext
            
            cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0..<rotations {
                cgContext.rotate(by: CGFloat(amount))
                
                let square = CGRect(x: -128, y: -128, width: 256, height: 256) // Offsetting things back from center
                cgContext.addRect(square)
            }
            
            // context transformations are cumulative
            
            cgContext.setStrokeColor(UIColor.black.cgColor)
            cgContext.strokePath()
        }
        
        drawImageView.image = image
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let cgContext = context.cgContext
            
            cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0..<256 {
                let point = CGPoint(x: length, y: 50)
                cgContext.rotate(by: .pi/2)
                
                if first {
                    cgContext.move(to: point)
                    first = false
                } else {
                    cgContext.addLine(to: point)
                }
                
                length *= 0.99
            }
            
            cgContext.setStrokeColor(UIColor.black.cgColor)
            cgContext.strokePath()
        }
        
        drawImageView.image = image
    }
    
    func getCenteredTitleString(string: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 36, weight: .bold),
            .paragraphStyle: paragraphStyle
        ]
        return NSAttributedString(string: string, attributes: attrs)
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 100))
            
            
            let string = "The best laid schemes\nof mice an' men\ngang aft agley"
            let attributedString = getCenteredTitleString(string: string)
            
            let stringRect = CGRect(x: 32, y: 32, width: 448, height: 448 )
            attributedString.draw(with: stringRect, options: .usesLineFragmentOrigin, context: nil)
        }
        
        drawImageView.image = image
    }
    
    func drawSmiley() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let cgContext = context.cgContext
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 15, dy: 15)

            // face circle
            cgContext.setFillColor(UIColor.yellow.cgColor)
            cgContext.setStrokeColor(UIColor.black.cgColor)
            cgContext.setLineWidth(10)
            cgContext.addEllipse(in: rectangle)
            
            // draw eyes
            let leftEyeRect = CGRect(x: 128, y: 128, width: 10, height: 10)
            let rightEyeRect = CGRect(x: 384, y: 128, width: 10, height: 10)
            cgContext.addEllipse(in: leftEyeRect)
            cgContext.addEllipse(in: rightEyeRect)
            
            cgContext.drawPath(using: .fillStroke)
            
            // draw smile
            let center = CGPoint(x: rectangle.midX, y: rectangle.midY)
            cgContext.addArc(center: center, radius: 128, startAngle: 0, endAngle: .pi, clockwise: false)
            
            cgContext.drawPath(using: .fillStroke)
        }
        
        drawImageView.image = image
    }
    
    
    func drawStar() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let cgContext = context.cgContext
            
            cgContext.setFillColor(UIColor.yellow.cgColor)
            cgContext.setStrokeColor(UIColor.yellow.cgColor)
            cgContext.setLineWidth(10)
            
            cgContext.translateBy(x: 256, y: 256)
            
            let rect = CGRect(x: -128, y: -128, width: 256, height: 256)//.insetBy(dx: 15, dy: 15)

            
            for _ in 0..<5 {
                cgContext.move(to: CGPoint(x: rect.minX / 2, y: rect.midY / 2))
                cgContext.addLine(to: CGPoint(x: rect.width / 4, y: rect.height / 4))
                cgContext.addLine(to: CGPoint(x: rect.midX / 2, y: rect.minY / 2))
                
                cgContext.rotate(by: (.pi * 2) / 5)

            }
            
            cgContext.drawPath(using: .fillStroke)
            
        }
        
        drawImageView.image = image
    }
    
    func drawTwin() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let cgContext = context.cgContext
            
            cgContext.setLineWidth(2)
            
            let rect = CGRect(x: 0, y: 256, width: 512, height: 128).insetBy(dx: 5, dy: 5)
            
            // T
            cgContext.move(to: CGPoint(x: rect.minX, y: rect.minY))
            cgContext.addLine(to: CGPoint(x: rect.midX / 2, y: rect.minY))
            cgContext.move(to: CGPoint(x: rect.midX / 4, y: rect.minY))
            cgContext.addLine(to: CGPoint(x: rect.midX / 4, y: rect.maxY))
            
            // W
            cgContext.move(to: CGPoint(x: rect.midX / 2 + 10, y: rect.minY))
            cgContext.addLine(to: CGPoint(x: rect.midX / 2 + 10, y: rect.maxY))
            cgContext.addLine(to: CGPoint(x: (rect.midX * 3) / 4  + 10, y: rect.midY))
            cgContext.addLine(to: CGPoint(x: rect.midX + 10, y: rect.maxY))
            cgContext.addLine(to: CGPoint(x: rect.midX + 10, y: rect.minY))
            
            // I
            cgContext.move(to: CGPoint(x: rect.midX + 20, y: rect.minY))
            cgContext.addLine(to: CGPoint(x: rect.midX + 20, y: rect.maxY))
            
            // N
            cgContext.move(to: CGPoint(x: rect.midX + 30 , y: rect.maxY))
            cgContext.addLine(to: CGPoint(x: rect.midX + 30 , y: rect.minY))
            cgContext.addLine(to: CGPoint(x: (rect.width * 3) / 4 , y: rect.maxY))
            cgContext.addLine(to: CGPoint(x: (rect.width * 3) / 4 , y: rect.minY))
            
            
            
            cgContext.strokePath()
        }
        
        
        drawImageView.image = image
    }


    @IBAction func redrawTapped(_ sender: UIButton) {
        currentDrawType += 1
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawSmiley()
        case 7:
            drawStar()
        case 8:
            drawTwin()
        default:
            break
        }
    }
    
}

