//
//  CxenseContent.h
//  CxenseContent
//
//  Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CxenseContentUser.h"
#import "CxenseContentWidget.h"
#import "CxenseContentContext.h"

@interface CxenseContent : NSObject

/**
 *  The default user that is automatically associated with any created widgets
 *
 *  @return CxenseContentUser The default CxenseContentUser
 */
+ (CxenseContentUser *)defaultUser;

/**
 *  Set the default user
 *
 *  @param user The user object you want associated with all new created widgets
 */
+ (void)setDefaultUser:(CxenseContentUser *)user;

/**
 *  Create a context with default user if any is set
 *
 *  @param widgetId The widget id (can be found in the admin interface on http://content.cxense.com)
 *
 *  @return CxenseContentWidget A CxenseContentWidget with a specified widgetId and any default user/contexts set.
 */
+ (CxenseContentWidget *)widgetWithId:(NSString *)widgetId context:(CxenseContentContext *)context;

/**
 *  Create a context with default user (if set) and a provided context
 *
 *  @param widgetId The widget id (can be found in the admin interface on http://content.cxense.com)
 *  @param context  The context that should be used for any recommendations
 *  @param user     The user that should be used for any recommendations
 *
 *  @return CxenseContentWidget A CxenseContentWidget with a specified widgetId, context and user.
 */
+ (CxenseContentWidget *)widgetWithId:(NSString *)widgetId context:(CxenseContentContext *)context user:(CxenseContentUser *)user;

@end
