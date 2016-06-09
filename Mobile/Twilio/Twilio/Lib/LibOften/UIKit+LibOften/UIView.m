//
//  UIView.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIView.h"
#import "../Foundation+LibOften/NSObject.h"
#import "../Misc+LibOften/GCD.h"
#import "UIColor.h"
#import <objc/runtime.h>

@implementation UIView (LibOften)

- (BOOL)isVisible {
    return !self.isHidden;
}

- (void)setVisible:(BOOL)visible {
    self.hidden = !visible;
}

- (UILayoutPriority)contentCompressionResistancePriority {
    UILayoutPriority horizontal = [self contentCompressionResistancePriorityForAxis:UILayoutConstraintAxisHorizontal];
    UILayoutPriority vertical = [self contentCompressionResistancePriorityForAxis:UILayoutConstraintAxisVertical];
    return (horizontal + vertical) * 0.5;
}

- (void)setContentCompressionResistancePriority:(UILayoutPriority)contentCompressionResistancePriority {
    [self setContentCompressionResistancePriority:contentCompressionResistancePriority forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentCompressionResistancePriority:contentCompressionResistancePriority forAxis:UILayoutConstraintAxisVertical];
}

- (void)bringSubviewToFront:(UIView *)subview withSuperviews:(NSInteger)number {
    for (NSInteger i = 0; i <= number; i++) {
        [subview.superview bringSubviewToFront:subview];
        subview = subview.superview;
    }
}

- (NSLayoutConstraint *)addConstraintWithItem1:(UIView *)view1 item2:(UIView *)view2 att1:(NSLayoutAttribute)att1 att2:(NSLayoutAttribute)att2 mult:(CGFloat)mul const:(CGFloat)con {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view1 attribute:att1 relatedBy:RE toItem:view2 attribute:att2 multiplier:mul constant:con];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addConstraintWith:(UIView *)view att1:(NSLayoutAttribute)att1 att2:(NSLayoutAttribute)att2 mult:(CGFloat)mul const:(CGFloat)con {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:att1 relatedBy:RE toItem:view attribute:att2 multiplier:mul constant:con];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addConstraintSameCenterXFor:(UIView *)view1 and:(UIView *)view2 {
    return [self addConstraintWithItem1:view1 item2:view2 att1:CX att2:CX mult:1.0 const:0.0];
}

- (NSLayoutConstraint *)addConstraintSameCenterYFor:(UIView *)view1 and:(UIView *)view2 {
    return [self addConstraintWithItem1:view1 item2:view2 att1:CY att2:CY mult:1.0 const:0.0];
}

- (void)addConstraintSameCenterXYFor:(UIView *)view1 and:(UIView *)view2 {
    [self addConstraintSameCenterXFor:view1 and:view2];
    [self addConstraintSameCenterYFor:view1 and:view2];
}

- (void)addVisualConstraints:(NSArray *)constraints forSubviews:(NSDictionary *)subviews {
    [self addVisualConstraints:constraints withMetrics:nil forSubviews:subviews];
}

- (void)addVisualConstraints:(NSArray *)constraints withMetrics:(NSDictionary *)metrics forSubviews:(NSDictionary *)subviews {
    // Disable autoresizing masks translation for all subviews
    for (UIView *subview in [subviews allValues])
        if ([subview respondsToSelector:@selector(setTranslatesAutoresizingMaskIntoConstraints:)])
            [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    // Apply all constraints
    for (NSString *constraint in constraints)
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constraint options:0 metrics:metrics views:subviews]];
}

- (NSLayoutConstraint *)findConstraintWithFirstItem:(id)item1 firstAttribute:(NSLayoutAttribute)att1 secondItem:(id)item2 secondAttribute:(NSLayoutAttribute)att2 {
    for (NSLayoutConstraint *constraint in self.constraints)
        if ((constraint.firstItem == item1 && constraint.firstAttribute == att1 && constraint.secondItem == item2 && constraint.secondAttribute == att2) || (constraint.firstItem == item2 && constraint.firstAttribute == att2 && constraint.secondItem == item1 && constraint.secondAttribute == att1)) // Commutation
            return constraint; // Return constraint
    return nil; // If nothing found
}

- (void)addConstraintToFillSuperview {
    NSAssert(self.superview, @"%@ must have a superview for %s", self, __PRETTY_FUNCTION__);
    [self.superview addVisualConstraints:@[@"H:|[self]|", @"V:|[self]|"] forSubviews:@{@"self":self}];
}

- (NSLayoutConstraint *)addConstraintForAspectRatio:(CGFloat)aspectRatio {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:AW relatedBy:RE toItem:self attribute:AH multiplier:aspectRatio constant:0.0];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addConstraintForWidth:(CGFloat)width {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:AW relatedBy:RE toItem:nil attribute:NA multiplier:0.0 constant:width];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addConstraintForHeight:(CGFloat)height {
    NSLayoutConstraint * constraint = [self constraintForAttribute:NSLayoutAttributeHeight];
    if(constraint) {
        [constraint setConstant:height];
    } else {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:AH relatedBy:RE toItem:nil attribute:NA multiplier:0.0 constant:height];
        [self addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint*) constraintForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && firstItem = %@", attribute, self];
    NSArray *fillteredArray = [[self.superview constraints] filteredArrayUsingPredicate:predicate];
    if (fillteredArray.count == 0) {
        return nil;
    } else {
        return fillteredArray.firstObject;
    }
}

- (void)addConstraintForSize:(CGSize)size {
    [self addConstraintForWidth:size.width];
    [self addConstraintForHeight:size.height];
}

- (void)removeAllConstraints {
    [self removeConstraints:self.constraints];
}

- (void)addSubviews:(NSArray *)subviews {
    for (UIView *view in subviews) {
        [UIView assertSameKindOfClass:view];
        [self addSubview:view];
    }
}

- (CGRect)convertFrameToView:(UIView *)view {
    return [self convertRect:self.bounds toView:view];
}

+ (CGRect)boundsForContent:(CGSize)contentSize aspectFilledInView:(CGSize)viewSize {
    CGFloat viewAspectRatio = viewSize.height / viewSize.width;
    CGFloat contentAspectRatio = contentSize.height / contentSize.width;
    CGFloat scaleFactor = (viewAspectRatio > contentAspectRatio) ? viewSize.height / contentSize.height : viewSize.width / contentSize.width;
    CGSize size = CGSizeMake(contentSize.width * scaleFactor, contentSize.height * scaleFactor);
    CGPoint offset = CGPointMake(0.5 * (viewSize.width - size.width), 0.5 * (viewSize.height - size.height));
    CGRect result = CGRectMake(offset.x, offset.y, size.width, size.height);
    return result;
}

- (NSArray *)findAllSubviewsOfClass:(Class)class {
    NSMutableArray *result = [NSMutableArray new];
    for (UIView *subview in self.subviews)
        if ([subview isKindOfClass:class]) {
            [result addObject:subview];
        } else {
            [result addObjectsFromArray:[subview findAllSubviewsOfClass:class]];
        }
    return result;
}

- (void)bringToFront {
    NSAssert(self.superview, @"Superview required for %s", __PRETTY_FUNCTION__);
    [self.superview bringSubviewToFront:self];
}

- (void)sendToBack {
    NSAssert(self.superview, @"Superview required for %s", __PRETTY_FUNCTION__);
    [self.superview sendSubviewToBack:self];
}

static char tap_gesture_recognizer_key;

- (void)setupTapGestureRecognizer {
    UITapGestureRecognizer *recognizer = objc_getAssociatedObject(self, &tap_gesture_recognizer_key);
    if (!recognizer) {
        recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUpInside)];
        objc_setAssociatedObject(self, &tap_gesture_recognizer_key, recognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addGestureRecognizer:recognizer];
        self.userInteractionEnabled = YES;
    };
}

static char action_block_key;

- (void(^)())actionBlock {
    return objc_getAssociatedObject(self, &action_block_key);
}

- (void)setActionBlock:(void(^)())actionBlock {
    objc_setAssociatedObject(self, &action_block_key, actionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (actionBlock)
        [self setupTapGestureRecognizer];
}

- (void)touchUpInside {
    if (self.actionBlock)
        self.actionBlock();
}

- (void)increaseFrameHeightBy:(CGFloat)delta {
    CGRect frame = self.frame;
    frame.size.height += delta;
    self.frame = frame;
}

- (void)animateWithDuration:(NSTimeInterval)duration constraintsAnimations:(void(^)())animations completion:(void(^)(BOOL))completion {
    [self.superview layoutIfNeeded];
    [UIView animateWithDuration:duration animations:^{
        ExecuteNullableBlockSafely(animations);
        [self.superview layoutIfNeeded];
    } completion:completion];
}

- (void)animateWithDuration:(NSTimeInterval)duration constraintsAnimations:(void (^)())animations {
    [self animateWithDuration:duration constraintsAnimations:animations completion:NULL];
}

- (void)setRandomBackgroundColor {
    self.backgroundColor = [UIColor randomColorWithAlpha:0.5];
}

- (void)setRandomBackgroundColorForAllSubviews {
    for (UIView *subview in self.subviews)
        [subview setRandomBackgroundColor];
}

- (void)logAllSuperviews {
    UIView *view = self;
    do {
        NSLog(@"%@", view);
        view = view.superview;
    } while (view);
}

@end


