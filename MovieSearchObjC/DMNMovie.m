//
//  DMNMovie.m
//  MovieSearchObjC
//
//  Created by Chance Robertson on 3/3/17.
//  Copyright © 2017 Chance Robertson. All rights reserved.
//

#import "DMNMovie.h"

@implementation DMNMovie

- (instancetype)init {
    return [self initWithTitle:@"" rating:0 movieDescription:@"" posterURLPath:@""];
}

- (instancetype)initWithTitle:(NSString *)title rating:(double)rating movieDescription:(NSString *)movieDescription posterURLPath:(NSString *)posterURLPath
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _rating = rating;
        _movieDescription = [movieDescription copy];
        _posterURLPath = posterURLPath;
    }
    return self;
}

@end

@implementation DMNMovie (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary {
    NSString *title = dictionary[@"title"];
    double rating = [dictionary[@"vote_average"] doubleValue];
    NSString *movieDescription = dictionary[@"overview"];
    NSString *posterURLPath = dictionary[@"poster_path"];
    
    if (![title isKindOfClass:[NSString class]] || ![movieDescription isKindOfClass:[NSString class]] || ![posterURLPath isKindOfClass:[NSString class]]) {
        return nil;
    }
    return [self initWithTitle:title rating:rating movieDescription:movieDescription posterURLPath:posterURLPath];
}

@end
