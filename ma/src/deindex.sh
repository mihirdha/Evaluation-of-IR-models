curl 'http://localhost:8983/solr/projectB/update?commit=true' --data '<delete><query>*:*</query></delete>' -H 'Content-type:text/xml; charset=utf-8'
