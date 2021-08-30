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
        
    }

    @IBAction func redrawTapped(_ sender: UIButton) {
        currentDrawType += 1
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        default:
            break
        }
    }
    
}

