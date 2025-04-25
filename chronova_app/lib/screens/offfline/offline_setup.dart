import 'package:flutter/material.dart';

class OfflineSetup extends StatefulWidget {
  const OfflineSetup({super.key});

  @override
  State<OfflineSetup> createState() => _OfflineSetupState();
}

class _OfflineSetupState extends State<OfflineSetup> {

  // Init number of bots
  int numberBots = 1;
  int levelBots = 1;
  int gameDifficulty = 1;

  // Increase and Decrease Number of Bots
  void increaseBots (){
    setState(() {
      numberBots = numberBots < 8 ? numberBots+1 : 1;
      
    });
  }
  void decreaseBots (){
    setState(() {
      numberBots = numberBots > 1 ? numberBots-1 : 1;
    });
  }

  // Level of the bots
  void increaseLevel (){
    setState(() {
      levelBots = levelBots <3 ?  levelBots+1 : 1;
    });
  }
  void  decreaseLevel(){
    setState(() {
      levelBots = levelBots > 1 ?  levelBots-1 : 3;
    });
  }

  // Game Difficulty
  void increaseDifficulty (){
    setState(() {
      gameDifficulty = gameDifficulty <3  ? gameDifficulty+1 : 1;
    });
  }
  void decreaseDifficulty () {
    setState(() {
      gameDifficulty = gameDifficulty > 1 ? gameDifficulty-1 : 3;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28264F),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 100,
        backgroundColor: Color(0xFF222142), 
        title: Text("Back to Home",
        style: TextStyle(
          color: Colors.white
        ),),
      ),

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            width: double.infinity,
            child: Column(
              spacing: 30,
              children: [
                Image.asset(
                  width: 150,
                  height: 150,
                  "assets/img/astro_bot.png"),
                Text("Number of Bots", style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),),
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.deepPurpleAccent
                      ),
                      onPressed: decreaseBots, 
                      child: Text("-", style: 
                        TextStyle(fontSize: 18,fontWeight: FontWeight.bold )
                        )),
                    SizedBox(
                      child: Text("$numberBots", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),)),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.deepPurpleAccent
                      ),
                      onPressed: increaseBots, 
                      child: Text("+"))
                    
                  ],
                ),

                Text("Bots Level", style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),),
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.deepPurpleAccent
                      ),
                      onPressed: decreaseLevel, 
                      child: Text("-", style: 
                        TextStyle(fontSize: 18,fontWeight: FontWeight.bold )
                        )),
                    SizedBox(
                      child: Text("$levelBots", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),)),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.deepPurpleAccent
                      ),
                      onPressed: increaseLevel, 
                      child: Text("+"))
                    
                  ],
                ),

                Text("Game difficulty", style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),),
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.deepPurpleAccent
                      ),
                      onPressed: decreaseDifficulty, 
                      child: Text("-", style: 
                        TextStyle(fontSize: 18,fontWeight: FontWeight.bold )
                        )),
                    SizedBox(
                      child: Text("$gameDifficulty", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),)),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.deepPurpleAccent
                      ),
                      onPressed: increaseDifficulty, 
                      child: Text("+"))
                    
                  ],
                ),

                FilledButton.icon(onPressed: () {

                },
                style: FilledButton.styleFrom(
                  
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
                icon:  const Icon(Icons.videogame_asset),
                label: Text("Start Game"))
              ],
            ),
            )
        ],
        
      ),
    );
  }
}