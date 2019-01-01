# devops-pipeline

(c) Adrian Newby, 2019

## Introduction

This repo provides a fairly comprehensive environment, suitable for a developer who wants a local DevOps pipeline in addition to whatever is available centrally (if anything). This provides a number of benefits:

* Instant feedback from local commits
* Lower burden on central resources
* Higher confidence in quality of code pushed to origin

__However:__ That doesn't mean this environment should be used as a substitute for central DevOps services, nor should this be seen as encouragement to delay committing work to origin.  Remember, it's not real until it's been pushed and high quality DevOps relies on each member of the team being able to see and incorporate the work of everybody else.

This project was inspired by the work of [Marcel Birkner](https://blog.codecentric.de/en/author/marcel-birkner/), who authored a great CI Platform in 2015: [Continuous Integration Platform Using Docker Containers: Jenkins, SonarQube, Nexus, GitLab](https://blog.codecentric.de/en/2015/10/continuous-integration-platform-using-docker-container-jenkins-sonarqube-nexus-gitlab/).

Why didn't I just use his work?  Good question.  Basically, I wanted a slightly more bare-bones approach, without the vast array of plugins and starter jobs he included.  I also decided it would be easier to build from the ground up, taking care of version updates as I went, rather then editing his original work, whcih is now several years old.

## Overview

What do you get out of the box?

The project provides the following components, all of which are essential for a modern DevOps pipeline:

* CI/CD Server - [Jenkins](https://jenkins.io/)
* Static Code Analysis - [SonarQube](https://www.sonarqube.org/)
* Automated Testing - [Jasmine](https://jasmine.github.io/), [Protractor](https://www.protractortest.org), JUnit??, NUnit??
* Artifact Repository - [Nexus](https://www.sonatype.com/nexus-repository-oss)
* Orchestrated Container Environment - [Kubernetes](https://kubernetes.io/)

For efficiency, all components are delivered as Docker containers.

## Prerequisites

To get started, you need a couple of things:

* [Docker](https://www.docker.com/get-started) - This entire project is delivered using Docker. If you're not familiar with containers, read [this](https://www.docker.com/resources/what-container) first.
* [Git](https://git-scm.com/) - The environment assumes you are working with a Git repository.  It will probably work with other repos but you will have to configure the hooks yourself.

If your environment is properly-configured, you should see something like this:

```
$ docker --version
Docker version 18.06.1-ce, build e68fc7a

$ git --version
git version 2.19.2
```

## Launching the environment

### Configured services and access points

| *Tool* | *Link* | *Credentials* |
| ------------- | ------------- | ------------- |
| Jenkins | http://localhost:18080/ | no login required |
| SonarQube | http://localhost:19000/ | admin/admin |
| Nexus | http://localhost:18081/ | admin/admin123 |
