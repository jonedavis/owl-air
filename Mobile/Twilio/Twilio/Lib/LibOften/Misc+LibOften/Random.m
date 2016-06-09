//
//  Random.m
//  Marquee
//
//  Created by Alexander Vasenin on 02/09/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "Random.h"

BOOL arc4random_bool() {
    return (BOOL)arc4random_uniform(2);
}

float arc4random_float() {
    return (float)arc4random() / (float)UINT32_MAX;
}

float arc4random_double() {
    return (double)arc4random() / (double)UINT32_MAX;
}


