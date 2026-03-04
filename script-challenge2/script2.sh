#!/bin/bash
> The aim of this task is to write a simple script that can provide the result in a prometheus ready metric format. Using any scripting language (Bash, Python, etc...) make a basic script which can monitor the number of restarts experienced by any docker container of your choosing. The script should log when a restart has been found and also to a text file in a prometheus ready metric format for collection via Node Exporter textfile collector. You should consider the types of labels that way be useful when intending to query this data at a later date, i.e alert rules, dashboard visualisations. Once you are happy with your script, please share this with us via a public github repo. 

docker events | 
