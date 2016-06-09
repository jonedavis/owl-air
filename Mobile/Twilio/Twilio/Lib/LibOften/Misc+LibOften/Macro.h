//
//  Macro.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#define KVO_KEY_OLD @"old"

#define KVO_KEY_NEW @"new"

#define DefineWeakSelf __weak typeof(self) weakSelf = self

#define DoNothing

#define FixNullOrDirtyErrorPointer(error) NSError __autoreleasing *_error; if (!error) error = &_error; *error = nil;

#define AssertObjectNonNullable(object) NSAssert(object, @"Object '%s' must not be nil in %s", #object, __PRETTY_FUNCTION__)

#define AssertBlockNonNullable(block) NSAssert(block, @"Block '%s' must not be NULL in %s", #block, __PRETTY_FUNCTION__)

#define AssertMustOverrideMethod NSAssert(NO, @"Subclasses must override method %s", __PRETTY_FUNCTION__)

#define AssertMustNotReachHere NSAssert(NO, @"Must not reach here in %s", __PRETTY_FUNCTION__)

#define AssertMainThreadOnly NSAssert([NSThread isMainThread], @"%@ should be called only from the main thread", NSStringFromClass(self));

#define LogClassMethod NSLog(@"%@[%@ %@]", self.class == self ? @"+" : @"-", NSStringFromClass(self.class), NSStringFromSelector(_cmd));

#define BeginTimeProfiling NSDate *profilingStartingDate = [NSDate now];

#define EndTimeProfiling NSLog(@"%.0fms", - profilingStartingDate.timeIntervalSinceNow * 1000.0);


