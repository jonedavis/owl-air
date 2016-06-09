//
//  Runtime.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

//! Returns total memory size in megabytes
unsigned int totalMemoryInMegabytes();

//! Returns used memory size in megabytes
unsigned int usedMemoryInMegabytes();

//! Returns YES if instance method with given selector is required by protocol
BOOL instanceMethodRequiredByProtocol(SEL selector, Protocol *protocol);

//! Returns YES if application extension is running
BOOL isAppExtension();


