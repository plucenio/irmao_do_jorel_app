import 'package:flutter/material.dart';
import 'package:irmao_do_jorel_app/constants.dart';
import 'package:irmao_do_jorel_app/features/api/domain/entities/episode.dart';
import 'package:irmao_do_jorel_app/features/api/domain/entities/link.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class EpisodePage extends StatefulWidget {
  static const String route = "/episodio";
  final Episode episode;
  const EpisodePage({Key key, this.episode}) : super(key: key);

  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();

    if (widget.episode != null) {
      Link link = widget.episode.links
          .where(
              (element) => (element as Link).fonte.toLowerCase() == "youtube")
          .first;
      _controller = YoutubePlayerController(
        initialVideoId: link.url.split("/").last,
        params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          desktopMode: true,
        ),
      );
    }
  }

  @override
  void deactivate() {
    _controller?.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    _controller?.reset();
    return Scaffold(
      appBar: AppBar(
        title: Text(app_name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: widget.episode == null
                ? Container(
                    child: Center(
                      child: Text("O episodio não pôde ser carregado."),
                    ),
                    height: double.infinity,
                    width: double.infinity,
                  )
                : ListView(
                    children: [
                      Center(
                        child: Text(
                          "Temporada ${widget.episode.temporadaId.toString()}" ??
                              "",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Center(
                        child: Text(
                          widget.episode.nome ?? "",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: YoutubePlayerIFrame(
                            controller: _controller,
                            aspectRatio: 16 / 9,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Descrição: ${widget.episode.descricao ?? ""}",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
