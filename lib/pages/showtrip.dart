import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/model/response/trip_get_res.dart';
import 'package:flutter_application_1/pages/Profile.dart';
import 'package:flutter_application_1/pages/detail.dart';
import 'package:http/http.dart' as http;

class ShowTripPage extends StatefulWidget {
  int cid = 0;
  ShowTripPage({super.key, required this.cid});

  @override
  State<ShowTripPage> createState() => _ShowTripPageState();
}

class _ShowTripPageState extends State<ShowTripPage> {
  var url = '';
  late Future<void> loadData;
  List<TripGetResponse> tripGetResponses = [];
  List<TripGetResponse> AlltripGetResponses = [];

  //only one excution
  //Cannot run asyn funtion
  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('ไปเที่ยวกันมั้ย'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              log(value);
              if (value == 'logout') {
                Navigator.of(context).popUntil((route) => route.isFirst);
              } else if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(idx: widget.cid),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(child: Text('ข้อมูลส่วนตัว'), value: 'profile'),
              PopupMenuItem(child: Text('ออกจากระบบ'), value: 'logout'),
            ],
          ),
        ],
      ),
      body:
          // Load Data
          FutureBuilder(
            future: loadData,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                // Waiting
                return Center(child: CircularProgressIndicator());
              }
              //Done
              return Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 8,
                      children: [
                        FilledButton(
                          onPressed: () {
                            setState(() {
                              getTrips();
                            });
                          },
                          child: Text('ทั้งหมด'),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetResponse> asiaTrips = [];
                            tripGetResponses = AlltripGetResponses;
                            for (var trip in tripGetResponses) {
                              if (trip.destinationZone == 'เอเชีย') {
                                asiaTrips.add(trip);
                              }
                            }
                            setState(() {
                              //all trip will be replaced
                              tripGetResponses = asiaTrips;
                            });
                          },
                          child: Text('เอเชีย'),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetResponse> euroTrips = [];
                            tripGetResponses = AlltripGetResponses;
                            for (var trip in tripGetResponses) {
                              if (trip.destinationZone == 'ยุโรป') {
                                euroTrips.add(trip);
                              }
                            }
                            setState(() {
                              //all trip will be replaced
                              tripGetResponses = euroTrips;
                            });
                          },
                          child: Text('ยูโรป'),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetResponse> thaiTrips = [];
                            tripGetResponses = AlltripGetResponses;
                            for (var trip in tripGetResponses) {
                              if (trip.destinationZone == 'ประเทศไทย') {
                                thaiTrips.add(trip);
                              }
                            }
                            setState(() {
                              //all trip will be replaced
                              tripGetResponses = thaiTrips;
                            });
                          },
                          child: Text('ประเทศไทย'),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetResponse> southeastAsiaTrips = [];
                            tripGetResponses = AlltripGetResponses;
                            for (var trip in tripGetResponses) {
                              if (trip.destinationZone ==
                                  'เอเชียตะวันออกเฉียงใต้') {
                                southeastAsiaTrips.add(trip);
                              }
                            }
                            setState(() {
                              //all trip will be replaced
                              tripGetResponses = southeastAsiaTrips;
                            });
                          },
                          child: Text('เอเชียตะวันออกเฉียงใต้'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: tripGetResponses
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Image.network(
                                            e.coverimage,
                                            width: 200,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                        "ไม่มีรูป",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.lightBlue,
                                                        ),
                                                      ),
                                                    ),
                                          ),
                                          // Image.asset(e.coverimage, width: 200),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(e.country),
                                                Text(
                                                  "ระยะเวลา ${e.duration.toString()} วัน",
                                                ),
                                                Text(
                                                  "ราคา ${e.price.toString()} บาท",
                                                ),
                                                FilledButton(
                                                  onPressed: () =>
                                                      gttoTrip(e.idx),
                                                  child: Text(
                                                    'รายละเอียดเพิ่มเติม',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }

  Future<void> getTrips() async {
    tripGetResponses = AlltripGetResponses;
  }

  Future<void> loadDataAsync() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var res = await http.get(Uri.parse('$url/trips'));
    AlltripGetResponses = tripGetResponseFromJson(res.body);
    tripGetResponses = AlltripGetResponses;
    log(tripGetResponses.length.toString());
  }

  gttoTrip(int idx) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TripPage(idx: idx)),
    );
  }
}
