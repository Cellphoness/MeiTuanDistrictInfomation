//
//  MeituanServerInfo.h
//
//  Created by 希哥  on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MeituanServerInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *traceId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
