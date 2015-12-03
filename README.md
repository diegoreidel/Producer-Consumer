# Producer-Consumer
This is a solution to the producer-consumer problem, using Erlang as the programming language.

In order to compile or run the project you have to download and install Erlang to your computer if you do not have it alread. You can find it at http://www.erlang.org.

Download all files or Fork this repository. Place all files in the same folder.

You should open Erlang Emulator by running "erl" in your Command Line. Compile all 5 files listed bellow:
 - master.erl
 - consumer.erl
 - producer.erl
 - bufferMemory.erl
 - product.erl
 
by executing "c(FileName)." Note that you should not include the extension ".erl" within the parenthesis.

Next, start the program by executing the init function from module master: "master:init()."

This project is based on a sushi-house. The producer is the sushi-men. There is a table, that works like a buffer, and a client, the consumer. When a producer sees that the table is full, he goes take a rest. On the other hand, when a client sees that the table is empty, he complains about it. 

Both client and sushi-men communicate with the table to get and add a sushi. The master process is responsible for spawing all other processes and printing all system messages.
