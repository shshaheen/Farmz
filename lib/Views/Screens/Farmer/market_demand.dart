import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'secrets.dart';
class MarketDemand extends StatefulWidget {
  const MarketDemand({super.key});

  @override
  State<MarketDemand> createState() => _MarketDemandState();
}

class _MarketDemandState extends State<MarketDemand> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      
      final res = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=Kurnool&APPID=$openWeatherAPIKey"),
      );

      if (res.statusCode != 200) {
        throw ("No city found..!");
      }

      final data = jsonDecode(res.body);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  IconData getWeatherIcon(String data) {
    return data == 'Clouds' || data == 'Rain'
        ? Icons.cloud
        : data == 'Clear'
            ? Icons.sunny
            : Icons.cloud_queue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getCurrentWeather(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator.adaptive());
                }

                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                if (snapshot.hasData) {
                  final data = snapshot.data as Map<String, dynamic>;
                  final currentTemp = (data['list'][0]['main']['temp'] - 273.15)
                      .toStringAsFixed(1);
                  final currentSky = data['list'][0]['weather'][0]['main'];


                  List<String> forecastTime = [];
                  List<String> forecastTemperature = [];
                  List<String> forecastWeather = [];
                  int n = 9;

                  for (int i = 0; i < n; i++) {
                    forecastTime.add(data['list'][i]['dt_txt'].substring(11, 16));
                    forecastTemperature.add(
                      (data['list'][i]['main']['temp'] - 273.15).toStringAsFixed(1),
                    );
                    forecastWeather.add(data['list'][i]['weather'][0]['main']);
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 12),
                                    Text(
                                      '$currentTemp°C',
                                      style: const TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Icon(
                                      getWeatherIcon(currentSky),
                                      size: 55,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      currentSky == 'Clouds'
                                          ? "Cloudy"
                                          : currentSky == 'Rain'
                                              ? "Rainy"
                                              : "Sunny",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                }

                return const Center(child: Text("No data available"));
              },
            ),
          ),

          
        ],
      ),
    );
  }
}
