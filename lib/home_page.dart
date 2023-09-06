import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacex/bloc/spacex_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'bloc/spacex_event.dart';
import 'bloc/spacex_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State {
  late SpacexBloc _spacexBloc;
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _spacexBloc = BlocProvider.of<SpacexBloc>(context);
    _spacexBloc.add(SpacexTestEvent());
  }

  Future<void> onRefresh() async => _spacexBloc.add(SpacexLatestLaunchEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      RefreshIndicator(onRefresh: () async => onRefresh(), child:
        CustomScrollView( slivers: <Widget>[
          SliverAppBar(pinned: true, expandedHeight: 280.0, flexibleSpace:
            FlexibleSpaceBar(centerTitle: true, background:
              Image.asset('assets/images/spacex.jpg', height: 200,), title:
              Text('- Latest Launch -', style: Theme.of(context).textTheme.titleMedium,),),),
          SliverList(delegate:
            SliverChildBuilderDelegate(childCount: 1, (BuildContext context, int index) {
              return Container(alignment: Alignment.center, child:
                BlocBuilder<SpacexBloc, SpacexState>(bloc: _spacexBloc, builder: (context, state) {
                  switch(state){
                    case SpacexLoadingState():
                     return const Padding(padding: EdgeInsets.all(20), child:
                      CircularProgressIndicator());
                    case SpacexSuccessState():
                      return latestLaunchCard();
                    case SpacexFailureState():
                      return Text(state.errorMessage);
                  }
                },
              ),
            );
          },
        ),
      )
    ])));
  }

  Widget latestLaunchCard() {
    final spacexModel = (_spacexBloc.state as SpacexSuccessState).spacexModel;
    final sizeX = MediaQuery.of(context).size.width;
    final crewName = spacexModel.name ?? '';
    final youtubeID = spacexModel.links?.youtubeId ?? '';
    final details = spacexModel.details ?? 'No Details Available';
    final thumbnail = spacexModel.links?.patch?.smallThumb ?? '';
    final mediumTextStyle = Theme.of(context).textTheme.titleMedium;
    final largeTextStyle = Theme.of(context).textTheme.titleLarge;
    final dateUnix = spacexModel.dateUnix;
    final date = dateUnix != null ? DateFormat("yyyy-MM-dd")
        .format(DateTime.fromMillisecondsSinceEpoch(dateUnix * 1000))
        .toString() : '';

    return SizedBox(width: sizeX, child:
    Column(children: [
      SizedBox(width: sizeX*0.8, child:
        Card(elevation: 8, child:
          Padding(padding: EdgeInsets.all(sizeX*0.05), child:
            Column(children: [
              if(date.isNotEmpty) Text(date, style: mediumTextStyle),
              SizedBox(height: sizeX*0.02,),
              if(thumbnail.isNotEmpty) Image.network(thumbnail, width: sizeX*0.5, fit: BoxFit.fitWidth,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center( child:
                        LinearProgressIndicator (
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                  },),
                SizedBox(height: sizeX*0.02,),
                if(crewName.isNotEmpty) Text(crewName, style: mediumTextStyle),
                if(details.isNotEmpty) Text(details),
              ],)
            )
          ),
        ),
      if(youtubeID.isNotEmpty) Column(
        children: [
          SizedBox(height: sizeX*0.05,),
          Text('Video', style: largeTextStyle,),
          SizedBox(height: sizeX*0.05,),
          if(youtubeID.isNotEmpty) youtubePlayer(youtubeID),
          SizedBox(height: sizeX*0.05,),
         ],)
      ],)
    );
  }

  Widget youtubePlayer(String youtubeID){
    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: youtubeID,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          loop: false,
          forceHD: false,
        )
    );

    return YoutubePlayer(
      controller: _youtubePlayerController!,
      liveUIColor: Colors.deepPurpleAccent,
    );
  }

  @override
  void dispose() {
    _youtubePlayerController?.dispose();
    super.dispose();
  }
}