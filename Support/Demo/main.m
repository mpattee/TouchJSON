//
//  main.m
//  TouchCode
//
//  Created by Jonathan Wight on 20090528.
//  Copyright 2009 toxicsoftware.com. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

#import "CJSONSerializer.h"
#import "CJSONDeserializer.h"

static void test(void);
static void test_largedata(void);

int main(int argc, char **argv)
	{
	#pragma unused(argc, argv)

	NSAutoreleasePool *theAutoreleasePool = [[NSAutoreleasePool alloc] init];

	test();

	[theAutoreleasePool release];
	//
	return(0);
	}

static void test(void)
	{
	CJSONDeserializer *theDeserializer = [CJSONDeserializer deserializer];
	NSString *jsonString = @"!";
	NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;
	NSNumber *theNumber = [theDeserializer deserializeAsDictionary:jsonData error:&error];

//    CJSONDeserializer *theDeserializer = [CJSONDeserializer deserializer];
//    NSData *theData = [@"14399073641566209" dataUsingEncoding:NSUTF8StringEncoding];
//	NSNumber *theObject = [theDeserializer deserialize:theData error:nil];
//	STAssertEquals([theObject unsignedLongLongValue], 14399073641566209ULL, @"Numbers did not contain expected contents");


	NSLog(@"Result: %@", [theNumber class]);
	NSLog(@"Error: %llu", [theNumber unsignedLongLongValue]); 
	NSLog(@"Error: %g", [theNumber doubleValue]); 
	NSLog(@"Error: %d", [theNumber unsignedLongLongValue] == 14399073641566209ULL); 
	}

static void test_largedata(void)
	{
    NSAutoreleasePool *thePool = [[NSAutoreleasePool alloc] init];
    
    NSMutableArray *theObjects = [NSMutableArray array];
    id theValue = @"I am a value";
    for (int N = 0; N != 10000; ++N)
        {
        NSDictionary *theDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
            theValue, @"key_0",
            theValue, @"key_1",
            theValue, @"key_2",
            theValue, @"key_3",
            theValue, @"key_4",
            theValue, @"key_5",
            theValue, @"key_6",
            theValue, @"key_7",
            NULL];

        [theObjects addObject:theDictionary];
        }
    
    NSData *theData = [[CJSONSerializer serializer] serializeArray:theObjects error:NULL];
    NSLog(@"%ld", theData.length);
    
    [theData retain];
    
    [thePool release];
    
    [theData autorelease];
    
    sleep(2);
    
    NSArray *theArray = [[CJSONDeserializer deserializer] deserialize:theData error:NULL];
    NSLog(@"%ld", [theArray count]);
    
    
    
    }
