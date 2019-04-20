//
//  SBSNetworkOutputProtocol.h
//  SBSFlickr
//
//  Created by Igor on 19/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


@protocol SBSNetworkOutputProtocol

- (void)loadingWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
