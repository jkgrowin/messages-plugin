#import <Foundation/Foundation.h>

@interface VettedAliasDictionary : NSObject

@property NSDictionary *dictionary;
-(instancetype)initWithDictionary: (NSDictionary *)dict;
-(BOOL)isEqual:(VettedAliasDictionary *)object;
-(NSUInteger)hash;
-(NSString *)description;

@end
