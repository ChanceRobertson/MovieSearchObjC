//
//  DMNMovieController.m
//  MovieSearchObjC
//
//  Created by Chance Robertson on 3/3/17.
//  Copyright © 2017 Chance Robertson. All rights reserved.
//

#import "DMNMovieController.h"

static NSString *const baseURLString = @"https://api.themoviedb.org/3/search/movie";
static NSString *const apiKeyString = @"79e77df6ddd71c9cc245f34dfb6220e8";

@implementation DMNMovieController

+ (void)fetchMovieWithSearchTerm:(NSString *)searchTerm completion: (void (^)(NSArray<DMNMovie *> *movies))completion
{
    // Make the URL
    
    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKeyString];
    NSURLQueryItem *searchTermKeyItem = [NSURLQueryItem queryItemWithName:@"query" value:searchTerm];
    
    NSArray *queryItems = @[apiKeyItem, searchTermKeyItem];
    
    urlComponents.queryItems = queryItems;
    
    NSURL *moviePhotoEndpoint = urlComponents.URL;
    
    // NSURLSession - Used for making a URL request.
    
    [[[NSURLSession sharedSession] dataTaskWithURL:moviePhotoEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { NSLog(@"Error: %@", error); completion(nil); }
        
        if (!data) { NSLog(@"Error: No data returned from data task"); completion(nil); }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSArray *moviesDictionary = jsonDictionary[@"results"];
        
        NSMutableArray *moviesArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *movie in moviesDictionary) {
            DMNMovie *newMovie = [[DMNMovie alloc] initWithDictionary:movie];
            [moviesArray addObject:newMovie];
        }
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error: Could not parse JSON correctly; json is not of type NSDictionary");
            completion(nil);
        }
        
        NSString *errorString = jsonDictionary[@"error"];
        
        if (errorString) {
            NSLog(@"%@", errorString);
            completion(nil);
        } else {
            
            NSString *posterURLString = jsonDictionary[@"url"];
            
            [self fetchPosterWithURLString:posterURLString completion:^(UIImage *poster) {
                completion(@[poster]);
            }];
        }
    }] resume];
}

+ (void)fetchPosterWithURLString:(NSString *)posterURLString completion: (void(^)(UIImage *poster))completion
{
    
    NSURL *posterURL = [NSURL URLWithString:posterURLString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:posterURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error); completion(nil);
        }
        if (!data) {
            NSLog(@"Error: No data returned from data task"); completion(nil);
        }
        
        UIImage *poster = [[UIImage alloc] initWithData:data];
        
        completion(poster);
        
    }] resume];
}

@end
