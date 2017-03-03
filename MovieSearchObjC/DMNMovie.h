//
//  DMNMovie.h
//  MovieSearchObjC
//
//  Created by Chance Robertson on 3/3/17.
//  Copyright © 2017 Chance Robertson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMNMovie : NSObject

- (instancetype)initWithTitle:(NSString *)title
                       rating:(double)rating
             movieDescription:(NSString *)movieDescription
                posterURLPath:(NSString *)posterURLPath
NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, readonly) double rating;
@property (nonatomic, copy, readonly) NSString *movieDescription;
@property (nonatomic, copy, readonly) NSString *posterURLPath;

@end

@interface DMNMovie (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString*, id> *)dictionary;

@end
