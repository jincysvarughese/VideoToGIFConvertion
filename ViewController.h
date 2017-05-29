//
//  ViewController.h
//  SampleVedioToGif
//
//  Created by Jincy Saramma Varughese on 20/02/17.
//  Copyright © 2017 Jincy Saramma Varughese. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIWebView *webView;



- (IBAction)buttonAction:(id)sender;

@end

