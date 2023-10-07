#include <Trade/Trade.mqh>

input double ChannelBaseLevel = 1832.58;
input double ChannelSize = 10.90;
input int QttyChannels = 6;

int OnInit(){
   OnTick();
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason){

}

void OnTick()
{

   ObjectsDeleteAll(0);
   //const int j = QttyChannels + 1;
   double priceLevels[7] = {};
   for(int i = - (QttyChannels/2) ; i <= (QttyChannels/2) ; i++)
   {  
      priceLevels[i + 3] = ChannelBaseLevel + (i * ChannelSize);   
   }   
   
   //Drawing horizontal lines to create the main Channels
   for(int i = 0; i < ArraySize(priceLevels); i++)
   {
      // Create a unique name for the horizontal line object
      string lineObjectName = "HorizontalLine_" + DoubleToString(priceLevels[i],4);
   
      // Check if the object already exists and delete it if it does
      if (ObjectCreate(0, lineObjectName, OBJ_HLINE, 0, 0, priceLevels[i])) 
      {
         // Configure the horizontal line object
         ObjectSetInteger(0, lineObjectName, OBJPROP_COLOR, clrPurple); // Line color
         ObjectSetInteger(0, lineObjectName, OBJPROP_STYLE, STYLE_SOLID); // Line style
         ObjectSetInteger(0, lineObjectName, OBJPROP_WIDTH,2);
         ObjectSetInteger(0, lineObjectName, OBJPROP_RAY_RIGHT, true); // Extend to the left
         ObjectSetInteger(0, lineObjectName, OBJPROP_RAY_LEFT, true); // Extend to the right
   
         // Attach the horizontal line object to the chart
         ObjectSetInteger(0, lineObjectName, OBJPROP_SELECTABLE, false);
         ObjectSetInteger(0, lineObjectName, OBJPROP_SELECTED, false);
      } 
   }
   
   //Recalculate the array with price levels to draw 50% channel reference.
   for(int i = 0 ; i <= ArraySize(priceLevels) - 1 ; i++)
   {  
      priceLevels[i] = priceLevels[i] + (ChannelSize/2);   
   }
   // Calculate the starting time of the last day
   datetime lastDayStart = iTime(Symbol(), PERIOD_H1, 36);
   // Calculate the ending time of the next day
   datetime nextDayEnd = TimeCurrent() + PeriodSeconds(PERIOD_H4) + PeriodSeconds(1);   
   //Drawing horizontal lines to create the main Channels
   for(int i = 0; i < int(ArraySize(priceLevels) - 1); i++)
   {
      // Create a unique name for the horizontal line object
      string lineObjectName = "TrendLine_" + DoubleToString(priceLevels[i],4);
   
      // Check if the object already exists and delete it if it does
      if (ObjectCreate(0, lineObjectName, OBJ_TREND, 0, lastDayStart, priceLevels[i], nextDayEnd, priceLevels[i])) 
      {
         // Configure the horizontal line object
         ObjectSetInteger(0, lineObjectName, OBJPROP_COLOR, clrBlue); // Line color
         ObjectSetInteger(0, lineObjectName, OBJPROP_STYLE, STYLE_SOLID); // Line style
         ObjectSetInteger(0, lineObjectName, OBJPROP_WIDTH,1);
         ObjectSetInteger(0, lineObjectName, OBJPROP_RAY_RIGHT, false); // Extend to the left
         ObjectSetInteger(0, lineObjectName, OBJPROP_RAY_LEFT, false); // Extend to the right
   
         // Attach the horizontal line object to the chart
         ObjectSetInteger(0, lineObjectName, OBJPROP_SELECTABLE, false);
         ObjectSetInteger(0, lineObjectName, OBJPROP_SELECTED, false);
      } 
   }
   
  
   
   Comment("\nServer Time:  ", TimeCurrent(),
           "\nChannel Base Level:  ", DoubleToString(ChannelBaseLevel,2),
           "\nChannel Size: ", DoubleToString(ChannelSize * 100 ,2), " pips" );
   
}