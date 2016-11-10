curl 'http://localhost:8983/solr/projectB/update/json?commit=true' --data-binary @$(echo ~/solr/solr-5.3.0/projectB/train.json) -H 'Content-type:application'
