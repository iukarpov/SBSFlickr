//
//  SBSNetworkService.m
//  SBSFlickr
//
//  Created by Igor on 19/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import "SBSNetworkService.h"
#import "SBSFlickrConstants.h"


@implementation SBSNetworkService

-(void)startImageLoading:(NSString*)keyString
{
    [self getFlickrPhotoWithKeyString:keyString isSearch:YES];
    
}

- (NSString *)urlForKeyString:(NSString *)keyString
{
    return [NSString stringWithFormat:@"%@?method=%@&api_key=%@&text=%@&per_page=25&format=%@", FlickrRestAPIBaseUrl, FlickrTextSearchAPI, FlickrAPIKey, keyString, FlickrRestAPIFormat];
}

- (NSString *)urlForPictureWithFarm:(NSString *)farmID andWithServer:(NSString *)serverId andWithPicture:(NSString *)pictureId andWithSecret:(NSString *)secret
{
    return [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", farmID, serverId, pictureId, secret];
}

-(void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData *dataWithImage = [NSData dataWithContentsOfURL:location];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.output loadingWithData:dataWithImage];
    });
}

-(void)downloadTaskWithURL: (NSString *)stringURL {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:stringURL]];
    [downloadTask resume];
}

-(void)getFlickrPhoto:(BOOL)isSearch
{
    NSString *urlString = nil;
    if (isSearch)
    {
        urlString = [self urlForKeyString:self.keyString];
    }
    else
    {
        urlString = [NSString stringWithFormat:@"%@?method=%@&api_key=%@&extras=url_h,date_taken&format=%@", FlickrRestAPIBaseUrl, FlickrInterestingSearchAPI, FlickrAPIKey, FlickrRestAPIFormat];
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-ww-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:10];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [SBSNetworkService setNetworkActivityIndicatorVisible:NO];
        NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSMutableArray<SBSFlickrPhotoModel *> *tempArray = [NSMutableArray new];
        for (id photo in temp[@"photos"][@"photo"]) {
            
            NSString *url = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", photo[@"farm"], photo[@"server"], photo[@"id"], photo[@"secret"]];
            [self downloadTaskWithURL:url];
            
            SBSFlickrPhotoModel *model = [SBSFlickrPhotoModel new];
            model.photoURL = url;
            [tempArray addObject:model];
            
        }
        self.flickrPhotosArray = tempArray;
    }];
    
    [sessionDataTask resume];

}

- (void)getFlickrPhotoWithKeyString:(NSString *)keyString isSearch:(BOOL)isSearch
{
    self.keyString = keyString;
    [self getFlickrPhoto:YES];
}

+ (void)setNetworkActivityIndicatorVisible:(BOOL)setVisible {
    static NSUInteger NetworkIndicatorCount = 0;
    
    if (setVisible) {
        NetworkIndicatorCount++;
    } else {
        NetworkIndicatorCount--;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:(NetworkIndicatorCount > 0)];
    });
}
@end


