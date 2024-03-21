import 'package:flutter/material.dart';
import 'package:news_bloc_app/widgets/data.dart';

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
          widget.data.author ?? "no avtor",
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
                Image.network(
                  widget.data.urlToImage ??
                      'https://www.tea-tron.com/antorodriguez/blog/wp-content/uploads/2016/04/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png',
                  width: 300,
                ),
                const SizedBox(height: 10),
                Card(
                  child: Column(children: [
                    Text(
                      widget.data.content,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // _launchURL('https://www.example.com');
                      },
                      child: Text(widget.data.url!),
                    ),
                    const SizedBox(height: 10),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// void _launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
