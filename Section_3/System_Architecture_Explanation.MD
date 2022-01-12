# DSAID Data Engineering Technical Test (Section 3)

## Flow of The System Architecture
1. Users will upload the images through the web application in AWS EC2 instance. The images will be stored in the AWS S3 bucket, while other data such as customers details, upload timestamp, version of the images will be stored in the database.
2. The web application with the Kafka stream will pull the images from AWS S3 and output to the company's software engineers. The web application will also remove images from AWS S3 which are more than 7 days old.
3. Qlik Sense Enterprise will be used as the BI tool to pul key statistics including the number and types of images processed and by which customers. This can be viewed by the developers.
