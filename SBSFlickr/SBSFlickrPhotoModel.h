//
//  SBSFlickrPhotoModel.h
//  SBSFlickr
//
//  Created by Igor on 19/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface SBSFlickrPhotoModel : NSObject

@property (nonatomic, strong) NSString *photoURL;
@property (nonatomic, strong) UIImage *image;
@end

NS_ASSUME_NONNULL_END
