// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'notif',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello , Mina',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'you have a new reminder !',
                style: TextStyle(color: Colors.grey.shade500),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(35)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(
                              Icons.text_format,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Title',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'tesk 3',
                          style: TextStyle(
                              color: Colors.deepOrange.shade300, fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(
                              Icons.description,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Description',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'sdfsdfsdfsfssafasdfasdfsadfasdhh adafsdfasdfsadgag aggasdgdfgdfg adfasdgasdga asdgsag a asgdasdg',
                          style: TextStyle(
                              color: Colors.deepOrange.shade300, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 20),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Date',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          '10-7-2022',
                          style:
                              TextStyle(color: Colors.deepOrange, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
