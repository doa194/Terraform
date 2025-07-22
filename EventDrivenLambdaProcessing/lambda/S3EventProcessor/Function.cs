using System;
using System.Threading.Tasks;
using Amazon.Lambda.Core;
using Amazon.Lambda.S3Events;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace S3EventProcessor
{
    public class Function
    {
        // This handler is triggered by S3 'ObjectCreated' events.
        public async Task FunctionHandler(S3Event s3Event, ILambdaContext context)
        {
            foreach (var record in s3Event.Records)
            {
                var s3 = record.S3;
                context.Logger.LogLine($"New S3 object: {s3.Bucket.Name}/{s3.Object.Key}");
            }
            await Task.CompletedTask;
        }
    }
}