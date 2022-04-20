//
//  CPPTest.hpp
//  LGSwift
//
//  Created by vampire on 2020/9/27.
//  Copyright © 2020 LGEDU. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

struct lg_heapObject{
    void *metadata;
    uint32_t refCount;
};

struct lg_swift_class_t{
    void *isa;
    void *superClass;
    void *cache_t[2];
    void *data;
    uint32_t flags;  //4
    uint32_t instanceAddressOffset; //4
    uint32_t instanceSize;//4
    uint16_t instanceAlignMask; //2
    uint16_t reserved; //2

    uint32_t classSize; //4
    uint32_t classAddressOffset; //4
    void *description;
};

