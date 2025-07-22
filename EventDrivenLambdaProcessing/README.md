# Event-Driven Lambda Processing with Terraform (AWS S3 → Lambda in C#)

This project demonstrates how to use **Terraform** to provision an event-driven AWS architecture, where a Lambda function (written in C#) is triggered whenever a file is uploaded to an S3 bucket. The Lambda function can be easily extended (e.g., for image resizing or processing), but is kept simple here for demonstration.

---

## Features

- **S3 Bucket**: For file uploads (event source).
- **Lambda Function (C#)**: Triggered by S3 `put` events. Sample handler just logs the event.
- **IAM Role**: Least-privilege access for Lambda.
- **Terraform Modules**: Clean, modular structure for easy reuse/expansion.