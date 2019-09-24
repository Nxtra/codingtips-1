console.log('function getauthor starts');

const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient({region: 'eu-west-1'});

exports.handler = function(event, context, callback) {
    console.log('Received event:', JSON.stringify(event, null, 2));

    let queryParameters = {
        TableName: 'CodingTips',
        KeyConditionExpression: 'Author = :a',
        ExpressionAttributeValues: {
            ':a': event.pathParameters.author
        }
    };

    docClient.query(queryParameters, function(err,data){
        if(err){
            callback(err, null);
        }else{
            var response = {
                "statusCode": 200,
                "headers": {
                    "Content-Type": "application/json"
                },
                "body": JSON.stringify(data)
            };
            callback(null, response);
        }
    });
};
