# /r/OttawaSenators Prediction Thread
-------------------------------------
# Introduction

This project is a tool that is meant to communicate with http://www.reddit.com/r/OttawaSenators to aid in automating the prediction threads that occur throughout the season. 

I have taken on the task of running the contest on the subreddit. Each game a post is made by the user OttawaSenatorsBot to gather users answers to 4 questions that are specific to the game. When the game is over the bot collects the answers and stores them in a .log file. The admin can then input the correct answers for the specified game so that the program can modify the score files.

This tool can:

  - Post new Predictions threads
  - Collect answers posted in previous threads
  - Calculate the scores from previous games
  - Display the current scores of users
  - Alert users that their comments were not inputted due to an error in their syntax. 
  
# How to use
  
Note: The program cannot be run by anybody because you need to have the client id and the secret for the reddit access permissions. 

Upon running connect.pl the user will have four options:

  1. To post a new game thread.
  2. To get data from the most recent game thread.
  3. Update the scores for users, based of data previously pulled from the subreddit.
  4. Display the current scores for all users. 

## Posting a new Thread

When this option is selected the program prompts the user to enter information required for the new thread. 
Once all the information is gathered it will push the "post" object to the subreddit. 

## Retrieving data from most recent game thread

This option will prompt the user to enter the name of the file that the scores should be inputted to. It suggestn naming the file after the date of the game in the following format "DDMMYYYY", and it then saves it as a fileName.log file. 

## Updating scores

This option will request the following:

  - The name of the score .log files
  - The name of the .log file that contains users data
  - The answers to the questions for the specified game

Once it confirms that all the files exist then the score .log files will be updated based of the users data matching the correct answer variables. 

## Displaying the Scores

This will prompt the user to choose between seeing the monthly scores or the year, and display the file that is associated with the choice made. 


# Required Software

This program is written using Perl (v5.22.2), and uses the Reddit::Client module which acts a Perl wrapper for the reddit API. 

To run the program you must have access to a reddit development account. 
