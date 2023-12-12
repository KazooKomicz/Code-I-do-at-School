########
# Student name: Alyssa Ballestro
# Course: COSC 3603 Section 01 – Networks
# Assignment: Programming Assignment 1
# Filename: web_server.py
#
# Purpose: To make a simple web server.
#
# Input: None
#
# Output: web server
#
# Assumptions:
#
# Limitations:
#
# Development Computer: Legion 7
# Operating System: Windows 11
# Compiler: Python 3
# Integrated Development Environment (IDE): Spyder
# Operational Status:
#######

#import socket module
from socket import *
import sys  # In order to terminate the program

serverSocket = socket(AF_INET, SOCK_STREAM)

serverPort = 12000  # Set the port number for your server
serverSocket.bind(('localhost', serverPort))
serverSocket.listen(1)  # Listen for incoming connections

while True:
    # Establish the connection
    print('Ready to serve...')
    connectionSocket, addr = serverSocket.accept()  # Accept incoming connection
    try:
        message = connectionSocket.recv(2048).decode()  # Receive message from client
        filename = message.split()[1]
        f = open(HelloWorld.html)

        outputdata = f.read()
        # Send one HTTP header line into socket
        connectionSocket.send("HTTP/1.1 200 OK\r\n\r\n".encode())

        # Send the content of the requested file to the client
        for i in range(0, len(outputdata)):
            connectionSocket.send(outputdata[i].encode())
        connectionSocket.send("\r\n".encode())
        print("Success")

        connectionSocket.close()
    except IOError:
        # Send response message for file not found
        connectionSocket.send("HTTP/1.1 404 Not Found\r\n\r\n".encode())
        print("Fail")
        # Close client socket
        connectionSocket.close()

serverSocket.close()
sys.exit()  # Terminate the program after sending the corresponding data

