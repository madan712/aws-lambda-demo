package com.javaxp.lambda.demo;

import java.io.IOException;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;

/**
 * A simple test harness for locally invoking your Lambda function handler.
 */
public class LambdaFunctionHandlerTest {

	private static final String GREETING = "Good night %s!";
	private static final String NAME = "Madan";

	private static APIGatewayProxyRequestEvent event;

	@BeforeClass
	public static void createInput() throws IOException {
		event = new APIGatewayProxyRequestEvent();
		event.setBody(NAME);
	}

	private Context createContext() {
		TestContext ctx = new TestContext();
		ctx.setFunctionName("test_function");
		return ctx;
	}

	@Test
	public void testLambdaFunctionHandler() {
		LambdaFunctionHandler handler = new LambdaFunctionHandler();
		Context ctx = createContext();
		APIGatewayProxyResponseEvent output = handler.handleRequest(event, ctx);
		Assert.assertEquals(String.format(GREETING, NAME), output.getBody());
	}
}
