//
//  UICollectionView.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UICollectionView.h"

@implementation UICollectionView (LibOften)

- (void)scrollToTopAnimated:(BOOL)animated {
    NSIndexPath *firstItem = [NSIndexPath indexPathForItem:0 inSection:0];
    [self scrollToItemAtIndexPath:firstItem atScrollPosition:UICollectionViewScrollPositionTop animated:animated];
}

- (void)reloadVisibleItems {
    [self reloadItemsAtIndexPaths:[self indexPathsForVisibleItems]];
}

@end


