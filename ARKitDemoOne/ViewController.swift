//
//  ViewController.swift
//  ARKitDemoOne
//
//  Created by comsubin on 2017/8/4.
//  Copyright © 2017年 comsubin. All rights reserved.
//

import UIKit
import ARKit
import SceneKit


class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置追踪
        let configuration = ARWorldTrackingSessionConfiguration();
        
        //检测水平面
        configuration.planeDetection = .horizontal;
        
        //开始配置运行
        sceneView.session.run(configuration);
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func randomFloat(min:Float,max: Float) -> Float {
        
        return (Float(arc4random()/0xFFFFFFFF))*(max-min)+min
    }
    
    @IBAction func addCube(_ sender: Any) {
        
        //镜头前后的位置
//        let zCoords = randomFloat(min: -1, max: -0.1);
        let zCoords = -0.5;
//        srand48(Int(time(nil)))
//        drand48()
//        let zCoords = drand48()
        
        print(zCoords);
        //单位米 0.1米
        let culbeNode = SCNNode(geometry:SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.1) );
        //获取相机坐标
        let cc = getCamraCoordinaties(sceneViewm: sceneView);
        //出现在3维空间的位置
//        culbeNode.position = SCNVector3(cc.x,cc.y,cc.z);
        
        
        //出现在3维空间的位置
        culbeNode.position = SCNVector3(0,0,zCoords);
        
        //添加到根节点
        sceneView.scene.rootNode.addChildNode(culbeNode);
                //
    }
    
    @IBAction func addCup(_ sender: Any) {
        
        let cupNode = SCNNode();
        
        let cc = getCamraCoordinaties(sceneViewm: sceneView);
        cupNode.position = SCNVector3(cc.x,cc.y,cc.z);
        
        guard let vitualObjectSecne = SCNScene(named:"cup.scn" ,inDirectory:"Models.scnassets/cup")else{
            
            return
        }
        let wrapperNode = SCNNode()
        
        for child in vitualObjectSecne.rootNode.childNodes {
            
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        cupNode.addChildNode(wrapperNode);
        
        sceneView.scene.rootNode.addChildNode(cupNode);
        
    }
    
    struct myCamraCoordinaties {
        
        var x = Float();
        var y = Float();
        var z = Float();
        
    }
    
    func getCamraCoordinaties(sceneViewm: ARSCNView) -> myCamraCoordinaties {
        
        let cameraTransForm = sceneView.session.currentFrame?.camera.transform;
        let cameraCoodrdiantes = MDLTransform(matrix: cameraTransForm!)
        
        var cc  = myCamraCoordinaties()
        
        cc.x = cameraCoodrdiantes.translation.x
        cc.y = cameraCoodrdiantes.translation.y
        cc.z = cameraCoodrdiantes.translation.z
        
        return cc;
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    


}

