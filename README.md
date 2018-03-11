# **Liferay CE on Docker**

## What is this?

This docker build is a basic Liferay CE bundle.

Admin info:

 	Username: test
 	Password: test

 	(uses screen name to authenticate - not email)

## Variables

You may overwrite some of the variables with appropriate values in the docker-compose.yml file

* XMX				Maximum Java heap size for the Liferay server [Default: 2048]
* XMS				Minimum Java heap size for the Liferay server [Default: 2048]

Most likely you will want to override the XMS and XMX values if any. By default the system set both to 2048m

## Folder Structure

  - **Project folder Root**
    - **build**
      - **files** _<---  Used to build the Docker image_
	  **README.md** _<---  Readme file_

