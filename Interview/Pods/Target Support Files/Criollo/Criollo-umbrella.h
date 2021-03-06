#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "Criollo.h"
#import "CRTypes.h"
#import "CRApplication.h"
#import "CRRouter.h"
#import "CRServer.h"
#import "CRConnection.h"
#import "CRMessage.h"
#import "CRRequest.h"
#import "CRRequestRange.h"
#import "CRResponse.h"
#import "CRUploadedFile.h"
#import "CRHTTPServer.h"
#import "CRFCGIServer.h"
#import "CRRouteController.h"
#import "CRNib.h"
#import "CRView.h"
#import "CRViewController.h"
#import "CRStaticFileManager.h"
#import "CRStaticDirectoryManager.h"
#import "CRMimeTypeHelper.h"

FOUNDATION_EXPORT double CriolloVersionNumber;
FOUNDATION_EXPORT const unsigned char CriolloVersionString[];

