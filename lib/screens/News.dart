import 'package:flutter/material.dart';
import 'package:gexxx_flutter/app_localizations.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/article.dart';
import 'package:gexxx_flutter/screens/articlepage.dart';
import 'package:translator/translator.dart';


class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {

   final translator = GoogleTranslator();
  Widget newbox(Article article) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Articlepage(
                      article: article,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Image.network(
                    article.image,
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      article.title,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Published Date: ${article.publishdate}',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.03),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Article>>(
        stream: DatabaseService().news,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              AppLocalizations.of(context).translate('News'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: articles.length,
                            itemBuilder: (c, i) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: newbox(articles[i]),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(child: Center(child: CircularProgressIndicator())),
            );
          }
        });
  }
}
