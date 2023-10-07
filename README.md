# MQL5-Algo-Trading-Scripts

## TradeLevels (Channels) Script

After long time observing the markets I realized that the price moves inside channels.

Using MetaTrader5 I draw and update manually the main channels and the 50% channel mark.

Now i have written this script, it requires the base price and channel size (this comes from my analysis).

And it Draws 6 channels and their intermediate 50% lines.

This is how the lines looks like. It is simple and very useful for my trading.

![image](https://github.com/giovanekochhann/MQL5-Algo-Trading-Scripts/assets/112240542/20784550-93b1-406c-8b3a-cb3f491eb3b7)



![image](https://github.com/giovanekochhann/MQL5-Algo-Trading-Scripts/assets/112240542/bee94203-9f72-4f92-8f0f-eac967be25b4)

Code appling knowdge learned:
- How to find information needed in reference MQL5 documentation.
- How to draw objects in the chart
- How to get chart reference (price x time) in order to draw the objects.

## Close Trades at Condition

Discipline in trading is something fundamental for success.
When trading you can set price to automatically close position if market reaches that value.
If you have lack of discipline some things might happen:
- You move your stop loss because you do not accept the loss and try to give the market more space and return, and you end losing more than planned.
- You move your take profit motivated by greed, you want more and despite the fact that market have reached the initial take profit level, you have modified and ended returning all back.
- You know the best moment to trade but urge to trade at any time, even though there is no liquidity in your favor.
- You have the need to do something. So you trade, 20 trades in a day, this is overtrading, spread and comission end with the profits.
In order to save my trading from this lack of discipline, i have coded this script. It lock my trades to my planning, it runs in a virtual machine where i have access just for 1 hour at night, if i need to change any parameter, i am able to do it just at night, out for the market hours.

![image](https://github.com/giovanekochhann/MQL5-Algo-Trading-Scripts/assets/112240542/1b8021e3-65e5-4892-a039-cc9a70d75f36)

This is how the chart look like, i have used the function Comment() to show target and stop levels and maximum time which trades becomes blocked.
