//
//  UIView.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UIView (LibOften)

//! Returns bounds for content constrained by view with aspect fill content mode
+ (CGRect)boundsForContent:(CGSize)contentSize aspectFilledInView:(CGSize)viewSize;

/// Action block for tap
@property void(^actionBlock)();

/// Shortcut for "not hidden"
@property (getter=isVisible) BOOL visible;

/// Shortcut for contentCompressionResistancePriority for both axis
@property UILayoutPriority contentCompressionResistancePriority;

//! Brings to front subview and it's given number of descendands
- (void)bringSubviewToFront:(UIView *)subview withSuperviews:(NSInteger)number;

//! Shortcut for [self addConstraint:[NSLayoutContraint ...]]
- (NSLayoutConstraint *)addConstraintWithItem1:(UIView *)view1 item2:(UIView *)item2 att1:(NSLayoutAttribute)att1 att2:(NSLayoutAttribute)att2 mult:(CGFloat)mul const:(CGFloat)con;

//! Shortcut for [self addConstraint:[NSLayoutContraint ...]]
- (NSLayoutConstraint *)addConstraintWith:(UIView *)view att1:(NSLayoutAttribute)att1 att2:(NSLayoutAttribute)att2 mult:(CGFloat)mul const:(CGFloat)con;

//! Shortcut for [self addConstraint:[NSLayoutContraint ...]]
- (NSLayoutConstraint *)addConstraintSameCenterXFor:(UIView *)view1 and:(UIView *)view2;

//! Shortcut for [self addConstraint:[NSLayoutContraint ...]]
- (NSLayoutConstraint *)addConstraintSameCenterYFor:(UIView *)view1 and:(UIView *)view2;

//! Shortcut for [self addConstraint:[NSLayoutContraint ...]]
- (void)addConstraintSameCenterXYFor:(UIView *)view1 and:(UIView *)view2;

//! Applies array of VFL-constraints with subviews dictionary to the receiver
- (void)addVisualConstraints:(NSArray *)constraints forSubviews:(NSDictionary *)subviews;

//! Applies array of VFL-constraints with subviews and metrics dictionaries to the receiver
- (void)addVisualConstraints:(NSArray *)constraints withMetrics:(NSDictionary *)metrics forSubviews:(NSDictionary *)subviews;

//! Finds constraint with given views and attributes
- (NSLayoutConstraint *)findConstraintWithFirstItem:(id)item1 firstAttribute:(NSLayoutAttribute)att1 secondItem:(id)item2 secondAttribute:(NSLayoutAttribute)att2;

- (void)addConstraintToFillSuperview;

- (NSLayoutConstraint *)addConstraintForAspectRatio:(CGFloat)aspectRatio;

- (NSLayoutConstraint *)addConstraintForWidth:(CGFloat)width;

- (NSLayoutConstraint *)addConstraintForHeight:(CGFloat)height;

- (void)addConstraintForSize:(CGSize)size;

- (void)removeAllConstraints;

//! Adds multiple views as subviews
- (void)addSubviews:(NSArray *)subviews;

//! Converts view frame to coordinate system of another view
- (CGRect)convertFrameToView:(UIView *)view;

//! Returns array of all subviews (recursively) of specified class
- (NSArray *)findAllSubviewsOfClass:(Class)class;

//! Shortcut for bringSubviewToFront:
- (void)bringToFront;

//! Shortcut for sendSubviewToBack:
- (void)sendToBack;

//! Sets action block for tap
- (void)setActionBlock:(void(^)())actionBlock;

// Increases frame height by given number
- (void)increaseFrameHeightBy:(CGFloat)delta;

- (void)animateWithDuration:(NSTimeInterval)duration constraintsAnimations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

- (void)animateWithDuration:(NSTimeInterval)duration constraintsAnimations:(void(^)())animations;

- (void)setRandomBackgroundColor;

- (void)setRandomBackgroundColorForAllSubviews;

- (void)logAllSuperviews;

@end

#define CX NSLayoutAttributeCenterX
#define CY NSLayoutAttributeCenterY
#define AW NSLayoutAttributeWidth
#define AH NSLayoutAttributeHeight
#define AT NSLayoutAttributeTop
#define AB NSLayoutAttributeBottom
#define AL NSLayoutAttributeLeft
#define AR NSLayoutAttributeRight
#define NA NSLayoutAttributeNotAnAttribute
#define RE NSLayoutRelationEqual
#define RG NSLayoutRelationGreaterThanOrEqual
#define RL NSLayoutRelationLessThanOrEqual


