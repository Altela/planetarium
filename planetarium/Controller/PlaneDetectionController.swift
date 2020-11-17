//
//  PlaneDetectionController.swift
//  planetarium
//
//  Created by Altela Pramardhika on 21/07/20.
//  Copyright © 2020 projectflakes. All rights reserved.
//
import ARKit
import SceneKit
import UIKit
import Foundation

class PlaneDetectionController: UIViewController, ARSCNViewDelegate {
    
    // Koneksi Scene PlaneDetectionController Ke ViewController
    @IBOutlet var scenePlaneDetection: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Munculkan FeaturePoint Di Kamera
        self.scenePlaneDetection.debugOptions = [ARSCNDebugOptions.showFeaturePoints]

        scenePlaneDetection.delegate = self
    }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

    // Atur Session Configuration Dengan ARWorldTrackingConfiguration Agar Objek Statis
            let configuration = ARWorldTrackingConfiguration()
            
    // Setup Agar Session Menggunakan Plane Detection Horizontal Surface
            configuration.planeDetection = .horizontal

    // Jalankan Session
            scenePlaneDetection.session.run(configuration)
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

    // Pause Session
            scenePlaneDetection.session.pause()
        }
        
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {

            print("plane detected")

            let planeAnchor = anchor as! ARPlaneAnchor

            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))

            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "textures.scnassets/grid.png")
            plane.materials = [gridMaterial]

            let planeNode = SCNNode()

            planeNode.geometry = plane
            planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)

            node.addChildNode(planeNode)

        } else {
            return
        }

        }
    }
