import 'package:chronova_app/models/events_params.dart';
import 'package:flutter/material.dart';

class EventsPack {

  final List<EventsParams> _cardPack = [
    // event 01
    EventsParams(
      date: 1965, 
      title: "Discovery of Jupiter", 
      era: "Moyen Age", 
      image: "chronova_app/assets/img/default_card.png"),
    
     EventsParams(
      date: 1945, 
    title: "Discovery of Saturn", 
      era: "Moyen Age", 
      image: "chronova_app/assets/img/default_card.png"),

     EventsParams(
      date: 1992, 
      title: "Publication of Relativity", 
      era: "Modern Age", 
      image: "chronova_app/assets/img/default_card.png"),

    
     EventsParams(
      date: 2022, 
      title: "Launching of JWST", 
      era: "Revolution", 
      image: "chronova_app/assets/img/default_card.png"),

  ];
}