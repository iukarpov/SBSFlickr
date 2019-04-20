//
//  ViewController.m
//  SBSFlickr
//
//  Created by Igor on 14/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import "SBSFlickrViewController.h"
#import "SBSFlickrCollectionViewCell.h"
#import "SBSNetworkService.h"
#import "SBSFlickrPhotoModel.h"
#import "SBSDetachedImageViewController.h"
#import "SBSDetachedImageViewController.h"
#import "SBSNotification.h"


@interface SBSFlickrViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, SBSNetworkOutputProtocol>

@property (nonatomic, strong) UICollectionView *flickrCollectionView;
@property (nonatomic, copy) NSMutableArray <SBSFlickrPhotoModel *> *modelsArray;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) SBSDetachedImageViewController *detachedImageViewController;
@end


@implementation SBSFlickrViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.networkService = [SBSNetworkService new];
    self.networkService.output = self;
    [self.flickrCollectionView registerClass:[SBSFlickrCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SBSFlickrCollectionViewCell class])];
    self.networkService.flickrViewController = self;
    self.imagesArray = [NSMutableArray new];
    [self setupSearchBar];
    [self setupCollectionView];
    [self.networkService getFlickrPhoto:NO];
}

- (void)setupSearchBar
{
    CGFloat searchBarX = CGRectGetMinX(self.view.frame);
    CGFloat searchBarY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat searchBarWidth = CGRectGetWidth(self.view.frame);
    CGFloat searchBarHeight = 50.0;
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(searchBarX, searchBarY, searchBarWidth, searchBarHeight)];
    [self.searchBar setPlaceholder:@"Start Searching"];
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
}

- (void)setupCollectionView
{
    CGFloat collectionViewX = CGRectGetMinX(self.view.frame);
    CGFloat collectionViewY = CGRectGetMaxY(self.searchBar.frame);
    CGFloat collectionViewWidth = CGRectGetMaxX(self.view.frame);
    CGFloat collectionViewHeight = CGRectGetMaxY(self.view.frame);
    UICollectionViewLayout *collectionViewLayout = [UICollectionViewFlowLayout new];
    self.flickrCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewWidth, collectionViewHeight) collectionViewLayout:collectionViewLayout];
    [self.flickrCollectionView registerClass:[SBSFlickrCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SBSFlickrCollectionViewCell class])];
    self.flickrCollectionView.contentInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    self.flickrCollectionView.delegate = self;
    self.flickrCollectionView.dataSource = self;
    self.flickrCollectionView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.flickrCollectionView];
}

-(void)loadingWithData:(NSData *)data;
{
    [self.imagesArray addObject:[UIImage imageWithData:data]];
    [self.flickrCollectionView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.imagesArray removeAllObjects];
    NSLog(@"%@",searchBar.text );
    [self.networkService startImageLoading:searchBar.text];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SBSFlickrCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SBSFlickrCollectionViewCell class]) forIndexPath:indexPath];
    cell.cellImageView.image = self.imagesArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat padding = 30.0;
    CGFloat flickrCollectionViewSize = CGRectGetWidth(self.flickrCollectionView.frame) - padding;
    return CGSizeMake(flickrCollectionViewSize/2, flickrCollectionViewSize/2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = self.imagesArray[indexPath.item];
    self.detachedImageViewController = [SBSDetachedImageViewController new];
   [self presentViewController:self.detachedImageViewController animated:YES completion:nil];
    self.detachedImageViewController.detachedImage = image;
    self.detachedImageViewController.detachedImageView.image = image;
}
@end
