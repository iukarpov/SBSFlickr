//
//  SBSFlickrCollectionViewCell.h
//  SBSFlickr
//
//  Created by Igor on 15/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface SBSFlickrCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *cellImageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@end

NS_ASSUME_NONNULL_END
