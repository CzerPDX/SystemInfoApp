//
//  PreferencesModel.m
//  SystemInfoApp
//
//  Created by Czer on 10/20/23.
//

#import "PreferencesModel.h"

@interface PreferencesModel ()

@end


@implementation PreferencesModel

// Window Appearance Preference
+ (NSString *)getWindowAppearancePreferenceName {
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"WindowAppearancePreference"];
}

+ (void)changeWindowAppearancePreference:(NSString *)newAppearanceName {
  // Get the current user defaults
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

  // Set the window appearance preference to the incoming newAppearanceName
  [defaults setObject:newAppearanceName forKey:@"WindowAppearancePreference"];
  
  // Synchronize the defaults to disk
  [defaults synchronize];
}


// Live Monitoring Refresh Rate Preference
+ (double)getRefreshRatePreference {
  return [[NSUserDefaults standardUserDefaults] doubleForKey:@"RefreshRatePreference"];
}

+ (void)changeRefreshRatePreference:(NSString *)newRefreshRate {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  // Set the refresh appearance preference to the incoming newRefreshRatePreference
  [defaults setDouble:newRefreshRate.doubleValue forKey:@"RefreshRatePreference"];
  
  // Synchronize the defaults to disk
  [defaults synchronize];
}

@end
