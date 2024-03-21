import 'package:flutter/material.dart';
import 'package:news_bloc_app/pages/single_page.dart';
import 'package:news_bloc_app/widgets/data.dart';

class CustomCard extends StatelessWidget {
  final Data data;

  const CustomCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SinglePage(
                  data: data,
                )),
      ),
      child: Card(
        child: SizedBox(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                  ),
                  height: 100,
                  width: 100,
                  child: Image.network(
                    data.urlToImage ??
                        'https://www.tea-tron.com/antorodriguez/blog/wp-content/uploads/2016/04/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.only(right: 10, top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.title ?? 'No title',
                          style: const TextStyle(fontSize: 17),
                          maxLines: 3,
                        ),
                        Text(
                          "Author: ${data.author ?? 'No author'}",
                          style: const TextStyle(fontSize: 17),
                          maxLines: 1,
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
