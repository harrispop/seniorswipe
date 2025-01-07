import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import '../models/item.dart';
import 'item_card.dart';
import 'owner_info_dialog.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'dart:async'; // Import the Timer class

class SwipeCard extends StatefulWidget {
  final List<Item> items;

  SwipeCard({required this.items});

  @override
  SwipeCardState createState() => SwipeCardState();
}

class SwipeCardState extends State<SwipeCard> {
  late TCardController _controller;
  late ConfettiController _confettiController;
  bool isMatched = false;
  int currentIndex = 0;
  bool canSwipe = true; // Cooldown flag

  final List<String> names = [
    'Alice Johnson', 'Bob Smith', 'Charlie Brown', 'David Williams', 'Eva Davis',
    'Frank Miller', 'Grace Wilson', 'Henry Moore', 'Isla Taylor', 'Jack Anderson',
    'Kara Thomas', 'Liam Harris', 'Mia Martin', 'Noah Thompson', 'Olivia White'
  ];

  @override
  void initState() {
    super.initState();
    _controller = TCardController();
    _confettiController = ConfettiController(duration: Duration(seconds: 1));
    shuffleItems();
  }

  void shuffleItems() {
    setState(() {
      widget.items.shuffle();
    });
  }

  void handleSwipe(int index, SwipDirection direction) {
    setState(() {
      currentIndex = index;
    });

    // Only match if swiped right
    if (direction == SwipDirection.Right) {
      // 20% chance to match
      if (Random().nextDouble() < 0.2) {
        setState(() {
          isMatched = true;
        });
        _confettiController.play();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Matched with ${widget.items[index].name}!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() {
          isMatched = false;
        });
      }
    }
  }

  void showOwnerInfoDialog(Item item) {
    showDialog(
      context: context,
      builder: (context) {
        return OwnerInfoDialog(
          ownerName: item.owner,
          listingsCount: Random().nextInt(50) + 1,
          ratingsCount: item.ratings,
          avgRating: item.avgRating, // Show avgRating here
          onSendMessage: () {
            Navigator.of(context).pop();
            // Handle message sending
          },
        );
      },
    );
  }

  void swipeRight() {
    if (canSwipe) {
      _controller.forward(direction: SwipDirection.Right);
      startCooldown();
    }
  }

  void swipeLeft() {
    if (canSwipe) {
      _controller.forward(direction: SwipDirection.Left);
      startCooldown();
    }
  }

  void startCooldown() {
    setState(() {
      canSwipe = false;
    });
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        canSwipe = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: TCard(
            controller: _controller,
            size: Size(350, 600),
            cards: widget.items.map((item) {
              return ItemCard(
                item: item,
                onTap: () => showOwnerInfoDialog(item),
              );
            }).toList(),
            onForward: (index, info) {
              handleSwipe(index, info.direction);
              if (index == widget.items.length - 1) {
                shuffleItems();
                _controller.reset();
              }
            },
            onBack: (index, info) {
              setState(() {
                currentIndex = index;
              });
            },
            onEnd: () {
              // Handle end of card stack if needed
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 100, // Increase the number of particles
          ),
        ),
        Positioned(
          bottom: 50,
          left: 50,
          child: FloatingActionButton(
            onPressed: swipeLeft,
            child: Icon(Icons.close, color: Colors.red),
            backgroundColor: Colors.white,
            shape: CircleBorder(side: BorderSide(color: Colors.red)),
          ),
        ),
        Positioned(
          bottom: 50,
          right: 50,
          child: FloatingActionButton(
            onPressed: swipeRight,
            child: Icon(Icons.favorite, color: Colors.green),
            backgroundColor: Colors.white,
            shape: CircleBorder(side: BorderSide(color: Colors.green)),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
}