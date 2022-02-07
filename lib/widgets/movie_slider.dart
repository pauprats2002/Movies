// ignore_for_file: prefer_const_constructors, unnecessary_this, unused_local_variable

import 'package:flutter/material.dart';
import 'package:practica_final_2/models/movie.dart';

class MovieSlider extends StatelessWidget {
  final List<Movie> populars;

  const MovieSlider({Key? key, required this.populars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (this.populars.isEmpty) {
      return Container(
        width: double.infinity,
        height: 260,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populars',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 5,
          ),
          
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: populars.length,
                itemBuilder: (BuildContext context, int index){
                final popular = populars[index];
                return _MoviePoster(populars: popular);
                }
          ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie populars;

  const _MoviePoster({Key? key, required this.populars}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: populars),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(populars.fullPosterPath),
                width: 130,
                height: size.height * 0.22,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            populars.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
