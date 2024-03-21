import 'package:flutter/material.dart';
import 'package:news_bloc_app/widgets/data.dart';
import 'package:url_launcher/url_launcher.dart';

class SinglePage extends StatefulWidget {
  final Data data;
  const SinglePage({Key? key, required this.data}) : super(key: key);

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.data.author ?? "no author",
          maxLines: 1,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  widget.data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.data.urlToImage ??
                            'https://www.tea-tron.com/antorodriguez/blog/wp-content/uploads/2016/04/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png',
                        width: 300,
                      ),
                    )),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text(
                        widget.data.content,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _launchURL(widget.data.url!);
                            },
                            child: const Text('Open Link'),
                          ),
                          Text(widget.data.publishedAt),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    try {
      await launch(url);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Could not launch $url'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }
}
