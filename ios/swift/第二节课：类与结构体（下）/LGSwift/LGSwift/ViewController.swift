//
//  ViewController.swift
//  LGSwift
//
//  Created by vampire on 2020/1/6.
//  Copyright © 2020 LGEDU. All rights reserved.
//

import UIKit

class LGTeacher{ //继承关系吗？没有
    //消息调度的机制 
    @objc dynamic func teach(){
        print("teach")
    }
    
    func teach1(){
        print("teach1")
    }
    
    func teach2(){
        print("teach2")
    }
}



class LGPartTeacher: LGTeacher{
    @objc dynamic func teach4(){
        print("teach3")
    }
}



class ViewController: UIViewController{

    override func viewDidLoad() {
        
        //0x10000B85C : LGTeacher Descriptor在MachO的内存地址
        //0xb85c :LGTeacher Descriptor在MachO 偏移量
        //0x0000000100044000 : 程序运行的基地址
        //0xB890在二进制偏移量
       // 0x10004F890 --- 函数 teach 在运行内存当中的地址
        //struct TargetMethodDescriptor {
          /// Flags describing the method.
//          MethodDescriptorFlags Flags; // 4

          /// The method implementation.  //Offset
//          TargetRelativeDirectPointer<Runtime, void> Impl; // offset

          // TODO: add method types or anything else needed for reflection.
//        };
        //0x10004BAB4 == teach函数地址 == 0x000000010004bab4
        
        let t = LGTeacher()
        
        //函数表的调度， Method-swizzling , Runtime的API
        t.teach()
        
        //metadata + offset
    }
}










