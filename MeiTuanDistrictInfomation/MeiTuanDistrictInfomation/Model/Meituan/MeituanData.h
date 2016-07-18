//
//  MeituanData.h
//
//  Created by 希哥  on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MeituanData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *stid;
@property (nonatomic, strong) NSString *stg;
@property (nonatomic, assign) double total;
@property (nonatomic, strong) NSString *keyword;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
