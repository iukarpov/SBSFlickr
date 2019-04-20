//
//  SBSFlickrCollectionViewCell.m
//  SBSFlickr
//
//  Created by Igor on 15/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import "SBSFlickrCollectionViewCell.h"


@implementation SBSFlickrCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
       [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _cellImageView = [UIImageView new];
    [self.contentView addSubview:_cellImageView];
}

- (void)layoutSubviews
{
    CGFloat flickrImageViewX = CGRectGetMinX(self.contentView.frame);
    CGFloat flickrImageViewY = CGRectGetMinY(self.contentView.frame);
    CGFloat flickrImageViewWidth = CGRectGetMaxX(self.contentView.frame);
    CGFloat flickrImageViewHeight = CGRectGetMaxY(self.contentView.frame);
    CGFloat activityIndicatorViewX = CGRectGetMidX(self.contentView.frame) - 20;
    CGFloat activityIndicatorViewY = CGRectGetMidY(self.contentView.frame) - 20;
    CGFloat activityIndicatorViewWidth = 40;
    CGFloat activityIndicatorViewHeight = 40;
    [super layoutSubviews];
    self.cellImageView.frame = CGRectMake(flickrImageViewX, flickrImageViewY, flickrImageViewWidth, flickrImageViewHeight);
    self.activityIndicatorView.frame = CGRectMake(activityIndicatorViewX, activityIndicatorViewY, activityIndicatorViewWidth, activityIndicatorViewHeight);
}
@end
