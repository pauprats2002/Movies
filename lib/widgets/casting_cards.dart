// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
final int idMovie;
const CastingCards(this.idMovie);

  @override
  Widget build(BuildContext context) {
    final Movie selectedCast = ModalRoute.of(context)?.settings.arguments as Movie;
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    
    return FutureBuilder(
      future: moviesProvider.getMovieCast(idMovie),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        if(!snapshot.hasData){
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final casting = snapshot.data!;

        return Container(
              margin: EdgeInsets.only(bottom: 30),
              width: double.infinity,
              height: 180,
              // color: Colors.red,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) => _CastCard(selectedCast: casting[index],)
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
final Cast selectedCast;
  const _CastCard({Key? key, required this.selectedCast}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 10),
      width: 110,
      height: 100,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(selectedCast.fullPosterPath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            selectedCast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}