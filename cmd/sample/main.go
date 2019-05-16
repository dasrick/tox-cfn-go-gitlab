package main

import (
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"gopkg.in/dasrick/aws-helper-go.v1"
)

// HandleRequest - this is the sample method which will be call by lambda
func HandleRequest(event events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return awshelper.GetAPIGatewayProxyResponse200("hello world ... " + event.Body)
}

func main() {
	lambda.Start(HandleRequest)
}
