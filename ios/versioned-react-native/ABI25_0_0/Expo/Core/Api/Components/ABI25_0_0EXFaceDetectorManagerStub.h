//
//  ABI25_0_0EXFaceDetectorManagerStub.h
//  Exponent
//
//  Created by Stanisław Chmiela on 17.11.2017.
//  Copyright © 2017 650 Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "ABI25_0_0EXCamera.h"

@protocol ABI25_0_0EXFaceDetectorDelegate
- (void)onFacesDetected:(NSArray<NSDictionary *> *)faces;
@end

@interface ABI25_0_0EXFaceDetectorManagerStub : NSObject

- (NSDictionary *)constantsToExport;
+ (NSDictionary *)constants;

- (instancetype)initWithSessionQueue:(dispatch_queue_t)sessionQueue delegate:(id <ABI25_0_0EXFaceDetectorDelegate>)delegate;

- (void)setIsEnabled:(id)json;
- (void)setLandmarksDetected:(id)json;
- (void)setClassificationsDetected:(id)json;
- (void)setMode:(id)json;

- (void)maybeStartFaceDetectionOnSession:(AVCaptureSession *)session withPreviewLayer:(AVCaptureVideoPreviewLayer *)previewLayer;
- (void)stopFaceDetection;

@end

