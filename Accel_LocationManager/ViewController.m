//
//  ViewController.m
//  Accel_LocationManager
//
//  Created by Shanmuganathan on 18/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"
#import "AccelerationManager.h"


@interface ViewController ()
/*! Label displays distance travelled in last 3 minutes */
@property (strong, nonatomic) IBOutlet UILabel *totalDistance;

/*! Label to display Maximum X postion Values */
@property (strong, nonatomic) IBOutlet UILabel *maxXValue;
/*! Label to display median of X postion Values */
@property (strong, nonatomic) IBOutlet UILabel *medianXValue;
/*! Label to display mean of X postion Values */
@property (strong, nonatomic) IBOutlet UILabel *meanXValue;
/*! Label to display standard deviation of X postion Values */
@property (strong, nonatomic) IBOutlet UILabel *stdDevXValue;
/*! Label to display Minimum X postion Values */
@property (strong, nonatomic) IBOutlet UILabel *minXValue;
/*! Label to display count of X postion changes */
@property (strong, nonatomic) IBOutlet UILabel *countXValue;
/*! Label to display count of  zero crossings of X postion */
@property (strong, nonatomic) IBOutlet UILabel *zeroCrossingsXValue;

/*! Label to display Maximum Y postion Values */
@property (strong, nonatomic) IBOutlet UILabel *maxYValue;
/*! Label to display median of Y postion Values */
@property (strong, nonatomic) IBOutlet UILabel *medianYValue;
/*! Label to display mean of Y postion Values */
@property (strong, nonatomic) IBOutlet UILabel *meanYValue;
/*! Label to display standard deviation of Y postion Values */
@property (strong, nonatomic) IBOutlet UILabel *stdDevYValue;
/*! Label to display Minimum Y postion Values */
@property (strong, nonatomic) IBOutlet UILabel *minYValue;
/*! Label to display count of Y postion changes */
@property (strong, nonatomic) IBOutlet UILabel *countYValue;
/*! Label to display count of  zero crossings of Y postion */
@property (strong, nonatomic) IBOutlet UILabel *zeroCrossingsYValue;

/*! Label to display Maximum Z postion Values */
@property (strong, nonatomic) IBOutlet UILabel *maxZValue;
/*! Label to display median of Z postion Values */
@property (strong, nonatomic) IBOutlet UILabel *medianZValue;
/*! Label to display mean of Z postion Values */
@property (strong, nonatomic) IBOutlet UILabel *meanZValue;
/*! Label to display standard deviation of Z postion Values */
@property (strong, nonatomic) IBOutlet UILabel *stdDevZValue;
/*! Label to display Minimum Z postion Values */
@property (strong, nonatomic) IBOutlet UILabel *minZValue;
/*! Label to display count of Z postion changes */
@property (strong, nonatomic) IBOutlet UILabel *countZValue;
/*! Label to display count of  zero crossings of Z postion */
@property (strong, nonatomic) IBOutlet UILabel *zeroCrossingsZValue;

@property (strong, nonatomic) IBOutlet UIButton *startStopButton;

/* Location manager instance to start updating location*/
@property (strong, nonatomic) LocationManager *locationManager;

/* accletometer manager instance to start sampling device acceleration*/
@property (strong, nonatomic) AccelerationManager *accelerationManager;

/* Flag indicate whether the sampling is running or not*/
@property (nonatomic, assign) BOOL isSampling;

/* Timer which triggers every one second to update the UI with latest metrics*/
@property (strong, nonatomic) NSTimer *uiTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[LocationManager alloc] init];
    self.accelerationManager = [[AccelerationManager alloc] init];
    
    /* Add observer to observe totel distance travelled by the user in last three minutes*/
    [self.locationManager addObserver:self
                           forKeyPath:@"distanceTravelledInThreeMinutes"
                              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                              context:nil];
}

/* observer method which updates UI with totel distance travelled by the user in last three minutes*/
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    double oldValue = [change[@"old"] doubleValue];
    double newValue = [change[@"new"] doubleValue];
    //Only if it is set to new value then update the UI
    if(oldValue != newValue)
    {
        //Updating label in main thread as the value is observed in background thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([keyPath isEqualToString:@"distanceTravelledInThreeMinutes"])
            {
                self.totalDistance.text = [NSString stringWithFormat:@"%f", newValue];;
            }
        });
    }
}

- (void)updateUI:(id)sender
{
    //Calculate metrics with all latest data
    [self.accelerationManager calculateAccelerationMetrics];
    AccelerationMetrics *xMetrics = self.accelerationManager.xAccelerationMetrics;
    AccelerationMetrics *yMetrics = self.accelerationManager.yAccelerationMetrics;
    AccelerationMetrics *zMetrics = self.accelerationManager.zAccelerationMetrics;
    
    if(xMetrics || yMetrics || zMetrics)
    {
       self.minXValue.text = [NSString stringWithFormat:@"%.3f", xMetrics.min];
       self.maxXValue.text = [NSString stringWithFormat:@"%.3f", xMetrics.max];
       self.countXValue.text = [NSString stringWithFormat:@"%ld", (long)xMetrics.count];
       self.medianXValue.text = [NSString stringWithFormat:@"%.3f", xMetrics.median];
       self.meanXValue.text = [NSString stringWithFormat:@"%.3f", xMetrics.mean];
       self.zeroCrossingsXValue.text = [NSString stringWithFormat:@"%ld", (long)xMetrics.zeroCrossingsCount];
       self.stdDevXValue.text = [NSString stringWithFormat:@"%.3f", xMetrics.standardDeviation];

       self.minYValue.text = [NSString stringWithFormat:@"%.3f", yMetrics.min];
       self.maxYValue.text = [NSString stringWithFormat:@"%.3f", yMetrics.max];
       self.countYValue.text = [NSString stringWithFormat:@"%ld", (long)yMetrics.count];
       self.medianYValue.text = [NSString stringWithFormat:@"%.3f", yMetrics.median];
       self.meanYValue.text = [NSString stringWithFormat:@"%.3f", yMetrics.mean];
       self.zeroCrossingsYValue.text = [NSString stringWithFormat:@"%ld", (long)yMetrics.zeroCrossingsCount];
       self.stdDevYValue.text = [NSString stringWithFormat:@"%.3f", yMetrics.standardDeviation];

       self.minZValue.text = [NSString stringWithFormat:@"%.3f", zMetrics.min];
       self.maxZValue.text = [NSString stringWithFormat:@"%.3f", zMetrics.max];
       self.countZValue.text = [NSString stringWithFormat:@"%ld", (long)zMetrics.count];
       self.medianZValue.text = [NSString stringWithFormat:@"%.3f", zMetrics.median];
       self.meanZValue.text = [NSString stringWithFormat:@"%.3f", zMetrics.mean];
       self.zeroCrossingsZValue.text = [NSString stringWithFormat:@"%ld", (long)zMetrics.zeroCrossingsCount];
       self.stdDevZValue.text = [NSString stringWithFormat:@"%.3f", zMetrics.standardDeviation];
    }
}

- (IBAction)start:(UIButton *)sender {
    if(self.isSampling)
    {
        [self.locationManager stopLocationUpdates];
        [self.accelerationManager stopAccelerationUpdates];
        self.isSampling = NO;
        [sender setTitle:@"START" forState:UIControlStateNormal];
        [self.uiTimer invalidate];
        self.uiTimer = nil;
    }
    else
    {
        [sender setTitle:@"STOP" forState:UIControlStateNormal];
        self.isSampling = YES;
        [self.locationManager startLocationUpdates];
        [self.accelerationManager startAccelerationUpdates];
        self.uiTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(updateUI:)
                                                      userInfo:nil
                                                       repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.uiTimer
                                  forMode:NSRunLoopCommonModes];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.locationManager stopLocationUpdates];
    [self.accelerationManager stopAccelerationUpdates];
    [super viewWillDisappear:animated];
    
}

/* When memory becomes low, reset all stored data and restart lcoation and accelerometer updates*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.isSampling) {
        [self.startStopButton setTitle:@"START" forState:UIControlStateNormal];
        [self.uiTimer invalidate];
        self.uiTimer = nil;
        [self.locationManager stopLocationUpdates];
        [self.accelerationManager stopAccelerationUpdates];
        UIAlertController *lowMemoryAlert = [UIAlertController alertControllerWithTitle:@"Memory Warning"
                                                                                message:@"Device memory is low. Data collection stopped. All data are cleared. Restart it by clicking Start button. "
                                                                         preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:lowMemoryAlert animated:YES completion:nil];
    }
}

@end
