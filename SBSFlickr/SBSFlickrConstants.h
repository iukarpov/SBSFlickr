//
//  FlickrAPIKey.m
//  SBSFlickr
//
//  Created by Igor on 15/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import <Foundation/Foundation.h>


static NSString *const FlickrAPIKey = @"0844803c38b554d2e6c82a3462f7d41a";
static NSString *const FlickrRestAPIBaseUrl = @"https://api.flickr.com/services/rest";
static NSString *const FlickrTextSearchAPI = @"flickr.photos.search";
static NSString *const FlickrInterestingSearchAPI = @"flickr.interestingness.getList";
static NSString *const FlickrRestAPIFormat = @"json&nojsoncallback=1";
static NSString *const Interesting =  @"https://api.flickr.com/services/rest?method=flickr.interestingness.getList&api_key=0844803c38b554d2e6c82a3462f7d41a&extras=url_h,date_taken&format=json&nojsoncallback=1";
