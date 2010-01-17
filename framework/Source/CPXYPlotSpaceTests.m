
#import "CPXYPlotSpaceTests.h"
#import "CPXYGraph.h"
#import "CPXYPlotSpace.h"
#import "CPExceptions.h"
#import "CPPlotRange.h"
#import "CPUtilities.h"


@implementation CPXYPlotSpaceTests

@synthesize graph;

-(void)setUp 
{
    self.graph = [[(CPXYGraph *)[CPXYGraph alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 50.0)] autorelease];
}

-(void)tearDown
{
	self.graph = nil;
}

-(void)testViewPointForPlotPoint
{
	CPXYPlotSpace *plotSpace = (CPXYPlotSpace *)self.graph.defaultPlotSpace;
	
    plotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromDouble(0.0) 
                                                        length:CPDecimalFromDouble(10.0)];
    plotSpace.yRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromDouble(0.0) 
                                                        length:CPDecimalFromDouble(10.0)];
    
    NSDecimal plotPoint[2];
	plotPoint[CPCoordinateX] = CPDecimalFromDouble(5.0);
	plotPoint[CPCoordinateY] = CPDecimalFromDouble(5.0);
    
    CGPoint viewPoint = [plotSpace plotAreaViewPointForPlotPoint:plotPoint];
    
    STAssertEqualsWithAccuracy(viewPoint.x, (CGFloat)50.0, (CGFloat)0.01, @"");
    STAssertEqualsWithAccuracy(viewPoint.y, (CGFloat)25.0, (CGFloat)0.01, @"");
    
    plotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromDouble(0.0) 
                                                        length:CPDecimalFromDouble(10.0)];
    plotSpace.yRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromDouble(0.0) 
                                                        length:CPDecimalFromDouble(5.0)];
    
    viewPoint = [plotSpace plotAreaViewPointForPlotPoint:plotPoint];
    
    STAssertEqualsWithAccuracy(viewPoint.x, (CGFloat)50.0, (CGFloat)0.01, @"");
    STAssertEqualsWithAccuracy(viewPoint.y, (CGFloat)50.0, (CGFloat)0.01, @"");
}

-(void)testPlotPointForViewPoint 
{
	CPXYPlotSpace *plotSpace = (CPXYPlotSpace *)self.graph.defaultPlotSpace;

    plotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromDouble(0.0) 
                                                        length:CPDecimalFromDouble(10.0)];
    plotSpace.yRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromDouble(0.0) 
                                                        length:CPDecimalFromDouble(10.0)];
        
    NSDecimal plotPoint[2];
    CGPoint viewPoint = CGPointMake(50.0, 25.0);
    
	[plotSpace plotPoint:plotPoint forPlotAreaViewPoint:viewPoint];
	
	STAssertTrue(CPDecimalEquals(plotPoint[CPCoordinateX], CPDecimalFromDouble(5.0)), @"");
	STAssertTrue(CPDecimalEquals(plotPoint[CPCoordinateY], CPDecimalFromDouble(5.0)), @"");
}

@end
