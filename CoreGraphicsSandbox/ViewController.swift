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
        didSet { // Wrapping value from 5
            if currentDrawType > 5 {
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
        default:
            break
        }
    }
    
}

