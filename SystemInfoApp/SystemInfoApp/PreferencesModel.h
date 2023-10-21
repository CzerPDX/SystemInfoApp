//
//  PreferencesModel.h
//  SystemInfoApp
//
//  Created by Czer on 10/20/23.
//

/*
 This class does not manage its own data inside it, but instead is is the way that NSUserDefaults
 is accessed and manipulated. It is object-oriented in that if the preferences needed to be stored
 differently that could be taken care of here without changing any other classes in the app, but
 it is a little functional because it has none of its own data members to avoid having a copy of
 data that already exists inside of NSUserDefaults (which should be the source of truth).
 */

#import <Foundation/Foundation.h>

@interface PreferencesModel : NSObject

// Window Appearance Preference
+ (NSString *)getWindowAppearancePreferenceName;
+ (void)changeWindowAppearancePreference:(NSString *)newAppearanceName;

// Live Monitoring Refresh Rate Preference
+ (double)getLiveMonitoringRefreshRatePreference;
+ (void)changeLiveMonitoringRefreshRatePreference:(double)newRefreshRatePreference;

@end
