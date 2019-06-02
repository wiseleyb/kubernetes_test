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

## Setting up Kubernetes

* Based on following [this guide](https://github.com/rotati/rails-docker-kubernetes-ECS-example)
* `brew install kops`
* In AWS create a IAM user `kubernetes-test-user` with admin access, make sure to check the `Programmatic Access` checkbox
* Record the `Access key id` and the `Secret access key`
* back in terminal `aws configure` with keys from above
* in AWS in Route 52 - register a domain. We registerested `zkubernetes.net` for this test.

## Create cluster

* You need to use full region names... if you're on `us-east-1` run this to find the full name `aws ec2 describe-availability-zones --region us-east-1` (which should include `us-east-1a`)
* Now you can finally create the cluster:

```
kops create cluster \
--name=zkubernetes.net \
--state=s3://zkubernetes-state \
--zones=us-east-1a \
--node-count=2 \
--node-size=t2.micro \
--master-size=t2.micro \
--dns-zone=zkubernetes.net
```

Make a note of suggestions after running

Suggestions:

* list clusters with: `kops get cluster`
* edit this cluster with: `kops edit cluster zkubernetes.net`
* edit your node instance group: `kops edit ig --name=zkubernetes.net nodes`
* edit your master instance group: `kops edit ig --name=zkubernetes.net master-us-east-1a`

## Apply the cluster

```
kops update cluster zkubernetes.net \
--state=s3://zkubernetes-state \
--yes
```

Make a note of the suggestions again

Suggestions:

* validate cluster: `kops validate cluster`
* list nodes: `kubectl get nodes --show-labels`
* ssh to the master: `ssh -i ~/.ssh/id_rsa admin@api.zkubernetes.net`
* the admin user is specific to Debian. If not using Debian please use the appropriate user based on your OS.
* read about installing addons at: `https://github.com/kubernetes/kops/blob/master/docs/addons.md`

## Edit config

If you're brave enough to edit the config:

```
kops edit cluster \
--name=zkubernetes.net \
--state=s3://zkubernetes-state
```

## Validate cluster

To see if things are set up properly...

```
kops validate cluster --state=s3://zkubernetes-state
```

If things are setup properly this will give you useful feedback.

## Delete cluster

If you want to roll this all back...

```
kops delete cluster \
--name=zkubernetes.net \
--state=s3://zkubernetes-state
```

