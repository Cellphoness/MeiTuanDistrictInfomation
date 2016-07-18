//
//  MeituanBaseClass.h
//
//  Created by 希哥  on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MeituanServerInfo;

@interface MeituanBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *stid;
@property (nonatomic, strong) MeituanServerInfo *serverInfo;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *sugGid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
