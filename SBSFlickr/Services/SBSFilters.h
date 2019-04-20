//
//  SBSFilters.h
//  SBSFlickr
//
//  Created by Igor on 20/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface SBSFilters : NSObject

- (UIImage *)addSepiaFilter:(UIImage *)image;
- (UIImage *) addNoirFilter:(UIImage *)imag;
- (UIImage *) addColorInvertFilter:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
