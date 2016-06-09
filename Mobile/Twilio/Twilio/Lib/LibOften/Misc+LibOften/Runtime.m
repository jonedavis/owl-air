//
//  Runtime.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "Runtime.h"
#import "../Foundation+LibOften/NSString.h"
#import <objc/runtime.h>
#import <mach/mach.h>

#define BITS_IN_MEGABYTE 20

unsigned int totalMemoryInMegabytes() {
    return (unsigned int)([[NSProcessInfo processInfo] physicalMemory] >> BITS_IN_MEGABYTE);
}

unsigned int usedMemoryInMegabytes() {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kern_return = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kern_return == KERN_SUCCESS) ? (unsigned int)(info.resident_size >> BITS_IN_MEGABYTE) : 0.0;
}

BOOL instanceMethodRequiredByProtocol(SEL selector, Protocol *protocol) {
    unsigned int numberOfMethods;
    struct objc_method_description *method_descriptions = protocol_copyMethodDescriptionList(protocol, YES, YES, &numberOfMethods);
    for (unsigned int i = 0; i < numberOfMethods; i++) {
        SEL methodSelector = method_descriptions[i].name;
        if (sel_isEqual(selector, methodSelector))
            return YES;
    } return NO;
}

BOOL isAppExtension() {
    return [[[NSBundle mainBundle] executablePath] containsStringSafe:@".appex/"];
}


