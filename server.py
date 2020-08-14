# using flask_restful
import firebase_admin
from firebase_admin import credentials, firestore
from flask import Flask, jsonify, request
from flask_restful import Resource, Api
from bs4 import BeautifulSoup
from urllib.request import Request, urlopen
import re
import requests
import json
from newspaper import Article
import nltk
nltk.download('punkt')


cred = credentials.Certificate("./gexxx-7087a-firebase-adminsdk-d316e-d8152055de.json")
firebase_admin.initialize_app(cred)
db = firestore.client()


def getschema(articles):
  url = "http://agricoop.gov.in/programmes-schemes-listing"
  page_request = requests.get(url)
  data = page_request.content
  soup = BeautifulSoup(data,'html.parser')
  for divtag in soup.findAll('div',{'class':'item-list divide-into-2-col'}):
    for litag in divtag.findAll('li'):
      schematitle = litag('a')[0].text
      print(schematitle)
      suburl = 'http://agricoop.gov.in'+litag('a')[0]['href']
      sub_page_request = requests.get(suburl)
      sub_data=sub_page_request.content
      sub_soup = BeautifulSoup(sub_data,'html.parser')
    
      for sub_div_tag in sub_soup.findAll('div',{'class':'view-content'}):
        for tbodytag in sub_div_tag.findAll('tbody'):
          for trtag in tbodytag.findAll('tr'):
            title =trtag('td',{'class':'views-field views-field-title'})[0].text
            atag = trtag('td',{'class':'views-field views-field-field-attached'})[0]('a')
            if (len(atag)!=0):
              downloadlink = atag[0]['href']
            
            j = {'title':title,'downloadlink':downloadlink,'category':schematitle}
            articles+=[json.dumps(j)]
            try:
                doc_ref = db.collection('policies').document(downloadlink.replace("/", "")).create(j)
            except:
                print("exception\n")
            
      

def getpestssolution():
  url = "https://www.dhanuka.com/crops/soybean"
  page_request = requests.get(url)
  data = page_request.content
  soup = BeautifulSoup(data,'html.parser')
  for divtag in soup.findAll('div',{'class':'CROP_sec2Table'}):
    for divtag2 in divtag.findAll('div',{'class':'CROP_sec2ProductListMain'}):
      for divtag3 in divtag2.findAll('div',{'class':'CROP_sec2ProductList cropAccordian_Parent activeMe3'}):
        print(divtag3('div',{'class':'CROP_sec2TableLTBody'})[0]('h4'))


def gethindu(articles):
    for page in range(6):
        url = "https://www.thehindu.com/business/agri-business/?page=" + \
            str(page+1)
        page_request = requests.get(url)
        data = page_request.content
        soup = BeautifulSoup(data, 'html.parser')

        counter = 0
        for divtag in soup.findAll('div', {'class': 'main'}):
            for storydiv in divtag.findAll('div', {'class': 'story-card'}):
                url = storydiv('a')[0]['href']
                date = storydiv('h3')[0].prettify().rsplit('>')[1].rsplit('>')[
                    0].replace('\r', '').replace('\n', '').rsplit('title=')[1]
                a = Article(url)
                a.download()
                a.parse()
                a.nlp()
                # print(date)
                # print(a.title)
                j = {'articlelink': url, 'publishdate': date,
                     'title': a.title, 'summary': a.summary, 'img': a.top_img, 'keywords': a.keywords}
                articles += [json.dumps(j)]
                try:
                    doc_ref = db.collection('news').document(url.replace("/", "")).create(j)
                except:
                    print("exception 1\n")


def gettimesofindia(articles):
    for page in range(2):
        page = page+1
        url = "https://timesofindia.indiatimes.com/topic/Agriculture/news/" + \
            str(page)
        page_request = requests.get(url)
        data = page_request.content
        soup = BeautifulSoup(data, 'html.parser')

        counter = 0
        for divtag in soup.findAll('div', {'id': 'c_topic_list1_1'}):
            for div2tag in divtag.findAll('div', {'class': 'tab_content'}):
                for ultag in div2tag.findAll('ul'):
                    if (counter <= 30):
                        for litag in ultag.findAll('li'):
                            counter = counter+1
                            url = 'https://timesofindia.indiatimes.com' + \
                                litag.find('a')['href']
                            a = Article(url)
                            a.download()
                            a.parse()
                            a.nlp()
                            print(a.keywords)
                            j = {'articlelink': url, 'publishdate': litag.find(
                                'span', {'class': 'meta'}).text, 'title': a.title, 'summary': a.summary, 'img': a.top_img, 'keywords': a.keywords}
                            articles += [json.dumps(j)]
                            try:
                                doc_ref = db.collection('news').document(url.replace("/", "")).create(j)
                            except:
                                print("exceptioon 2\n")

                    #ar1 += json.dumps(a)
                    # print(litag.find('span',{'class':'meta'}).text)
                    # 11articles+= ['https://timesofindia.indiatimes.com'+litag.find('a')['href']]


# creating the flask app
app = Flask(__name__)
# creating an API object
api = Api(app)



# making a class for a particular resource
# the get, post methods correspond to get and post requests
# they are automatically mapped by flask_restful.
# other methods include put, delete, etc.


class Hello(Resource):

    # corresponds to the GET request.
    # this function is called whenever there
    # is a GET request for this resource
    def get(self):

      articles = []
      #getschema(articles)
      gettimesofindia(articles)
      gethindu(articles)
      getschema(articles)
      print(articles)
      return jsonify(articles)

    # Corresponds to POST request
    # def post(self):

    #     data = request.get_json()	 # status code
    #     return jsonify({'data': data}), 201


# another resource to calculate the square of a number
class Square(Resource):

    def get(self, num):

        return jsonify({'square': num**2})


# adding the defined resources along with their corresponding urls
api.add_resource(Hello, '/')
api.add_resource(Square, '/square/<int:num>')


# driver function
if __name__ == '__main__':

    app.run(debug=True)