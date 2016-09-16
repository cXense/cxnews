//
// Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CxenseDMPExternalProfile;

/**
* CxenseDMPExternalData represent external data associated with a user.
*/
@interface CxenseDMPExternalData : NSObject

/**
* The identifier of the user.
*/
@property(nonatomic, copy) NSString *dataId;

/**
* The customer identifier type (customer prefix) under which the user identifier is stored.
*/
@property(nonatomic, copy) NSString *dataType;

/**
* Array of CxenseDMPExternalProfile objects, representing the stored key-values for the user.
*/
@property(nonatomic, strong) NSArray<CxenseDMPExternalProfile *> *profiles;

/**
* Creates and returns an CxenseDMPExternalData object with the specified dataId, type and profiles.
*
* @return CxenseDMPExternalData object with specified parameters.
*/
+ (CxenseDMPExternalData *)externalDataWithId:(NSString *)dataId
                                         type:(NSString *)type
                                     profiles:(NSArray<CxenseDMPExternalProfile *> *)profiles;

@end