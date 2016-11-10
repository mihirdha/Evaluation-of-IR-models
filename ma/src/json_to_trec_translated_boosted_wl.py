# -*- coding: utf-8 -*-
"""
Created on Tue Oct 27 17:47:48 2015

@author: ruhansa
"""
import json
# if you are using python 3, you should 
import urllib
import urllib2

#Additional code for taking queries from the query file
with open('queries_translated_wl.txt','r') as file_q:
	for line in file_q:
		query = line.split(' ', 2)
		print query[0]
		print query[1]
		query_t = query[2]
		query_tq = query_t.split('\t', 2)

		if query[1] in ['lang:en']:
			qt = 'text_en:"'+query_tq[0]+'"^5'+' OR '+'text_de:'+query_tq[1]+' OR '+'text_ru:'+query_tq[2]
		elif query[1] in ['lang:de']:
			qt = 'text_en:'+query_tq[0]+' OR '+'text_de:"'+query_tq[1]+'"^5'+' OR '+'text_ru:'+query_tq[2]
		elif query[1] in ['lang:ru']:
			qt = 'text_en:'+query_tq[0]+' OR '+'text_de:'+query_tq[1]+' OR '+'text_ru:"'+query_tq[2]+'"^5'
		print qt

		query_args = {'q':qt}
		encoded_args = urllib.urlencode(query_args)
		print encoded_args

		# change the url according to your own koding username and query
		inurl = 'http://mihirdha.koding.io:8983/solr/projectB/select?'+encoded_args+'&fl=id%2Cscore&wt=json&indent=true&rows=1000'
		outfn = 'res/1_translated_boosted_wl.txt'
		#print inurl

		# change query id and IRModel name accordingly
		qid = query[0]
		IRModel='default'
		outf = open(outfn, 'a+')
		data = urllib2.urlopen(inurl)
		# if you're using python 3, you should use
		# data = urllib.request.urlopen(inurl)
		#print data

		docs = json.load(data)['response']['docs']
		# the ranking should start from 1 and increase
		rank = 1
		for doc in docs:
		    outf.write(qid + ' ' + 'Q0' + ' ' + str(doc['id']) + ' ' + str(rank) + ' ' + str(doc['score']) + ' ' + IRModel + '\n')
		    rank += 1
		outf.close()
