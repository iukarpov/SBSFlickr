//
//  DetachedImageViewController.m
//  SBSFlickr
//
//  Created by Igor on 19/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import "SBSDetachedImageViewController.h"


@implementation SBSDetachedImageViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _detachedImageView = [UIImageView new];
        _detachedImage = [UIImage new];
        _filter = [SBSFilters new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDetachedImageView];
    [self setupCloseButton];
    [self setupFilterButtons];
}

- (void)setupDetachedImageView
{
    CGFloat detachedImageViewX = CGRectGetMinX(self.view.frame);
    CGFloat detachedImageViewY = CGRectGetMidY(self.view.frame) - CGRectGetWidth(self.view.frame)/1.5;
    CGFloat detachedImageViewWidth = CGRectGetWidth(self.view.frame);
    CGFloat detachedImageViewHeight = CGRectGetWidth(self.view.frame);
    self.detachedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(detachedImageViewX, detachedImageViewY, detachedImageViewWidth, detachedImageViewHeight)];
    self.detachedImageView.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.detachedImageView];
}
- (void)setupCloseButton
{
    CGFloat closeButtonX = CGRectGetMaxX(self.view.frame) - 50;
    CGFloat closeButtonY = CGRectGetMinY(self.view.frame) + 20;
    CGFloat closeButtonWidth = 40.0;
    CGFloat closeButtonHeight = 40.0;
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton addTarget:self action:@selector(closeDetachedViewController)
               forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    self.closeButton.frame = CGRectMake(closeButtonX, closeButtonY, closeButtonWidth, closeButtonHeight);
    [self.view addSubview:self.closeButton];
}

- (void)setupFilterButtons
{
    CGFloat sepiaFilterButtonX = CGRectGetMinX(self.view.frame) + 20;
    CGFloat sepiaFilterButtonY = CGRectGetMaxY(self.view.frame) - 170;
    CGFloat sepiaFilterButtonWidth = (CGRectGetWidth(self.view.frame) - 30);
    CGFloat sepiaFilterButtonHeight = 30.0;
    self.sepiaFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sepiaFilterButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.sepiaFilterButton.layer.cornerRadius = 15;
    self.sepiaFilterButton.frame = CGRectMake(sepiaFilterButtonX, sepiaFilterButtonY, sepiaFilterButtonWidth, sepiaFilterButtonHeight);
    [self.sepiaFilterButton setTitle:@"CISepiaTone" forState:UIControlStateNormal];
    [self.sepiaFilterButton addTarget:self action:@selector(applySepiaFilter)
                     forControlEvents:UIControlEventTouchUpInside];
    self.sepiaFilterButton.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.sepiaFilterButton];
    
    CGFloat noirEffectFilterButtonX = CGRectGetMinX(self.view.frame) + 20;
    CGFloat noirEffectFilterButtonY = CGRectGetMaxY(self.view.frame) - 130;
    CGFloat noirEffectFilterButtonWidth = (CGRectGetWidth(self.view.frame) - 30);
    CGFloat noirEffectFilterButtonHeight = 30.0;
    self.noirEffectFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.noirEffectFilterButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.noirEffectFilterButton.layer.cornerRadius = 15;
    self.noirEffectFilterButton.frame = CGRectMake(noirEffectFilterButtonX, noirEffectFilterButtonY, noirEffectFilterButtonWidth, noirEffectFilterButtonHeight);
    [self.noirEffectFilterButton setTitle:@"CIPhotoEffectNoir" forState:UIControlStateNormal];
    [self.noirEffectFilterButton addTarget:self action:@selector(applyNoirFilter)
                          forControlEvents:UIControlEventTouchUpInside];
    self.noirEffectFilterButton.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.noirEffectFilterButton];
    
    CGFloat colorInvertFilterButtonX = CGRectGetMinX(self.view.frame) + 20;
    CGFloat colorInvertFilterButtonY = CGRectGetMaxY(self.view.frame) - 90;
    CGFloat colorInvertFilterButtonWidth = (CGRectGetWidth(self.view.frame) - 30);
    CGFloat colorInvertFilterButtonHeight = 30.0;
    self.colorInvertFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.colorInvertFilterButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.colorInvertFilterButton.layer.cornerRadius = 15;
    self.colorInvertFilterButton.frame = CGRectMake(colorInvertFilterButtonX, colorInvertFilterButtonY, colorInvertFilterButtonWidth, colorInvertFilterButtonHeight);
    [self.colorInvertFilterButton setTitle:@"CIColorInvert" forState:UIControlStateNormal];
    [self.colorInvertFilterButton addTarget:self action:@selector(applyColorInvertFilter)
                           forControlEvents:UIControlEventTouchUpInside];
    self.colorInvertFilterButton.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.colorInvertFilterButton];
    
    CGFloat removeFilterButtonX = CGRectGetMinX(self.view.frame) + 20;
    CGFloat removeFilterButtonY = CGRectGetMaxY(self.view.frame) - 50;
    CGFloat removeFilterButtonWidth = (CGRectGetWidth(self.view.frame) - 30);
    CGFloat removeFilterButtonHeight = 30.0;
    self.removeFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.removeFilterButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.removeFilterButton.layer.cornerRadius = 15;
    self.removeFilterButton.frame = CGRectMake(removeFilterButtonX, removeFilterButtonY, removeFilterButtonWidth, removeFilterButtonHeight);
    [self.removeFilterButton setTitle:@"Remove Filter" forState:UIControlStateNormal];
    [self.removeFilterButton addTarget:self action:@selector(removeFilter)
                      forControlEvents:UIControlEventTouchUpInside];
    self.removeFilterButton.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.removeFilterButton];
}

- (void)closeDetachedViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)applySepiaFilter
{
    UIImage *filteredImage = [self.filter addSepiaFilter:self.detachedImage];
    self.detachedImageView.image = filteredImage;
}

- (void)applyNoirFilter
{
    UIImage *filteredImage = [self.filter addNoirFilter:self.detachedImage];
    self.detachedImageView.image = filteredImage;
}

- (void)applyColorInvertFilter
{
    UIImage *filteredImage = [self.filter addColorInvertFilter:self.detachedImage];
    self.detachedImageView.image = filteredImage;
}

- (void)removeFilter
{
    self.detachedImageView.image = self.detachedImage;
}
@end
