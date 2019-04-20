//
//  DetachedImageViewController.h
//  SBSFlickr
//
//  Created by Igor on 19/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SBSFilters.h"


NS_ASSUME_NONNULL_BEGIN


@interface SBSDetachedImageViewController : UIViewController
@property (nonatomic, strong) SBSFilters *filter;
@property (nonatomic, strong) UIImage *imageWithFilter;
@property (nonatomic, strong) UIImage *detachedImage;
@property (nonatomic, strong) UIImageView *detachedImageView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *sepiaFilterButton;
@property (nonatomic, strong) UIButton *noirEffectFilterButton;
@property (nonatomic, strong) UIButton *colorInvertFilterButton;
@property (nonatomic, strong) UIButton *removeFilterButton;

@end

NS_ASSUME_NONNULL_END
