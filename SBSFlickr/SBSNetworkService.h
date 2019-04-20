//
//  SBSNetworkService.h
//  SBSFlickr
//
//  Created by Igor on 19/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SBSNetworkOutputProtocol.h"
#import "SBSFlickrViewController.h"
#import "SBSFlickrPhotoModel.h"


NS_ASSUME_NONNULL_BEGIN


@interface SBSNetworkService : NSObject <NSURLSessionDownloadDelegate>
@property (nonatomic, weak) id<SBSNetworkOutputProtocol> output;
@property (nonatomic, strong) SBSFlickrViewController *flickrViewController;
@property (nonatomic, strong) SBSFlickrPhotoModel *model;
@property (nonatomic, copy) NSString *keyString;
@property (nonatomic, strong) NSMutableArray<SBSFlickrPhotoModel *> *flickrPhotosArray;

-(void)startImageLoading:(NSString*)keyString;
-(void)getFlickrPhoto:(BOOL)isSearch;
- (void)getFlickrPhotoWithKeyString:(NSString *)keyString isSearch:(BOOL)isSearch;
@end

NS_ASSUME_NONNULL_END
