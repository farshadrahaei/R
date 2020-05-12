# R
Introduction

Stock trader's goal is to increase the profit and avoid loos on their stock trading, making decision on when to buy and sell are very important as sometime a minute difference on a trade could cause less gain or even more loss of money. 
Using stock data in the past and compare it with current market, they can make a better decision on their trades to potentially gain more and loos less. 

Successful traders tend to buy stocks at the bottom price to get the most profit after the price recovered to the high, using Average price traders can have better insight to understand if the price is close to bottom or not.

I used Yahoo Finance stock's data to illustrate stock information and create different graphs, to query live data from Yahoo on Shiny application "quantmod" package required to be installed. 
This dataset provide the full historical daily price and volume data for all US-based stocks and ETFs trading on the NYSE, NASDAQ, and NYSE MKT. 
The actual data included Date, Open, High, Low, Close, Volume and adjusted values for selected stock. 

Stock Trading Helper Application:
My application provide advisory information about stocks on specific period, those information included:
- Graphs that shows historical data about the price of each stock.
 - Actual Historical traded data on "Open price" , "Highest price" , "Lowest price", "Close price", "Volume", "Adjusted".
 - Graph Volume of traded stock.
 
 To run this R Shiny application you need to install bellow packages:
library(shiny)
library(quantmod)
library(xts)
library(zoo)
library(TTR)
library(shinyjs)


