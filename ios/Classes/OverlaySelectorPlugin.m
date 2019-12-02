#import "OverlaySelectorPlugin.h"
#import <overlay_selector/overlay_selector-Swift.h>

@implementation OverlaySelectorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOverlaySelectorPlugin registerWithRegistrar:registrar];
}
@end
