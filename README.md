# Kubernetes Test

## Database

We created a free-tier db on AWS using postgres. Credentials are in config/database.yml

## Docker

To get docker working locally on a Mac 

* get docker desktop [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
* `docker build . -t kubernetes-test-container`
* `docker run -it -p 3000:3000 --rm kubernetes-test-container`
* go to [http://localhost:3000](http://localhost:3000)
* go to [http://localhost:3000/users](http://localhost:3000/users)
* both should be working

