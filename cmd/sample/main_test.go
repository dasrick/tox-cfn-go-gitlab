package main

import (
	"testing"

	"github.com/aws/aws-lambda-go/events"
	"github.com/stretchr/testify/assert"
	"gopkg.in/dasrick/aws-helper-go.v1"
)

func TestHandleRequest(t *testing.T) {
	event := events.APIGatewayProxyRequest{}
	expectedResponse, _ := awshelper.GetAPIGatewayProxyResponse200("hello world ... " + event.Body)

	response, err := HandleRequest(event)
	assert.IsType(t, nil, err)
	assert.IsType(t, expectedResponse, response)
}
