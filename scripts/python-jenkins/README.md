What it Contains ?
----
----
* docker: python:2.7.14-alpine3.7 docker 
* pip plugins : python-jenkins=0.4.16 and its dependencies

Run it as :
---
docker run --rm -v <workspace>:/python-jenkins --env JENKINSURL=<http://192.168.1.1:8081> --env USERNAME=<user> --env PASSWORD=<password> --env MASTERJOBNAME=<master_job_name> --env MASTERJOBNUMBER=<job_number> --env PARAMSFORPRINT=BUILD_WORKSPACE  cdua/dockers:python-jenkins

*--env PARAMSFORPRINT=<comma separated list of varibales to be printed in html file>*
