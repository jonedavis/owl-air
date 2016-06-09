//
//  UICollectionView.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UICollectionView (LibOften)

//! Scrolls to the first item
- (void)scrollToTopAnimated:(BOOL)animated;

//! Reloads visible items
- (void)reloadVisibleItems;

@end


