//
//  DMNMovieController.h
//  MovieSearchObjC
//
//  Created by Chance Robertson on 3/3/17.
//  Copyright © 2017 Chance Robertson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DMNMovie.h"

@interface DMNMovieController : NSObject

+ (void)fetchMovieWithSearchTerm:(NSString *)searchTerm completion: (void (^)(NSArray<DMNMovie *> *movies))completion;

+ (void)fetchPosterWithURLString:(NSString *)posterURLString completion: (void(^)(UIImage *poster))completion;

@end
