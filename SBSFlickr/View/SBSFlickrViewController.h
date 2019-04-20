//
//  ViewController.h
//  SBSFlickr
//
//  Created by Igor on 14/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import <UIKit/UIKit.h>
@class SBSNetworkService;

@interface SBSFlickrViewController : UIViewController

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) SBSNetworkService *networkService;
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;

@end

