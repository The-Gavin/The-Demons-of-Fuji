### 2024-11-5 - 2.5hr: Class Work
* Found out issue with uppercut not sending enemy up. Comparing to old code, the buttons call straight to the action function with their string in the old version, whereas in the new code the buttons will allow select to be pressed, and pressing select calls the action function with default values.
* To put it succinctly: Calling action after pressing select puts defult values through, but we need action to run after pressing select to unleash the attack.
* Discovered new problem. Nothing stops player from pressing select multiple times, which will continue to do damage without restriction. Silver lining is giving me a new idea for an attack.
* Fixed directional issues.
* Partially fixed death issues. Killing one enemy now removes it from the array and pulls all other indexes back, however killing all enemies will cause the game to crash since I haven't created a win state.
* Fixed issue of player being able to select multiple times


### 2024-10-29 - 2.5hr: Class Work
* Successfully implemented the order of operations for selecting moves. The player chooses an attack, then targets an enemy, and then damages the enemy they targetted.
* After implementing the previous successful change, a new problem arose in that the L Arm (or uppercut) button no longer sends the enemy up, and now sends the enemy chosen down. Caused by function having a default value set to down and being called before the buttons are pressed.

### 2024-10-13 - 3hr: More Pre-Playtest Work
* Tried again to implement project mechanic. Struggling to make it so that the Head button functions the same way as the L Arm button.
* Breakthrough made with chatGPT, I attempted to simulate overloaded methods in gdScript because I noticed that my _action method was causing the enemy to move regardless of the button used.
* Progress made due to method overloading solution, but now the problem is that I cannot choose the second enemy, the action goes through as soon as I press a button, making it so that only the first enemy is affected.


### 2024-10-12 - 3hr: Pre-Playtest Work
* Made attacking "turn based" by waiting until every enemy has been selected to initiate the attack
* Updated targeting reticle
* Finished tutorial "https://youtu.be/HEexLmt7enc?si=C21M7QN-WMbyYR4h", have fully implemented the basics of turn based combat, enemies are not currently able to act
* Tried to implement enemy death, but using queue_free() made the code crash because the focus function would try to look for an index that wasn't there anymore. Left in for now
* Tried to implement project mechanic with the assistance of chatGPT, but could not get the Head button to function as intended


### 2024-10-8 - 4hr: In-Class Work + After class work
* Uploaded cardinal movement playtest to itch
* Watched this video for help creating the battle scene: https://youtu.be/HEexLmt7enc?si=C21M7QN-WMbyYR4h
* Added enemy sprite
* Added healthbars to player and enemy
* Created scene for group of enemy scenes
* Downloaded "SunnyLand Forest of Illusion" asset pack from itch: https://ansimuz.itch.io/sunnyland-forest-of-illusion
* Added player, enemy group, and background to main scene
* Attempted to implement enemy focusing with arrow sprites
* Finished implementing enemy focusing and attacking enemies


### 2024-10-1 - 3.5hr: Pre-Class/In-Class Work
* Updated itch.io page to be public
* Uploaded proposal PDF to github
* Downloaded "RPG Fantasy Battlers" asset pack from itch.io
* Saved an example of a state machine to a text file for testing purposes later
* Followed this tutorial to get cardinal movement in the game: https://youtu.be/Ig5jpqesS_g?si=HATr8xyRuZL263kA
* Finished Implementing cardinal movement


### 2024-09-24 - 3hr: In-class work of creating Github repository
* Item 1 - Created SSH key and added it to Github
* Item 2 - Created Trello board
* Item 3 - Created itch.io account
* Item 4 - Exported project as html and uploaded to itch.io