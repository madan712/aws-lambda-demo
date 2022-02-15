package com.javaxp.lambda.demo;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;

import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import com.datadoghq.datadog_lambda_java.DDLambda;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class LambdaFunctionHandler
		implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {

	private static final String GREETING = "Good eveing %s!";

	private static final Gson gson = new GsonBuilder().setPrettyPrinting().create();

	@Override
	public APIGatewayProxyResponseEvent handleRequest(APIGatewayProxyRequestEvent event, Context context) {
		
		DDLambda ddl = new DDLambda(event, context);
		
		LambdaLogger logger = context.getLogger();
		logger.log("event : " + gson.toJson(event));
		
		ddl.finish();
		return new APIGatewayProxyResponseEvent().withStatusCode(200)
				.withBody(String.format(GREETING, event.getBody()));
	}
}
