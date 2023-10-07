#include <Trade/Trade.mqh>

input int CloseTimeHour = 16;
input int CloseTimeMin = 00;

input double TargetProfit = 250;
input double StopLoss = -150;  

int OnInit(){
   OnTick();
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason){

}

void OnTick()
{

   MqlDateTime structTime;
   TimeCurrent(structTime);
   
   structTime.hour = CloseTimeHour;
   structTime.min = CloseTimeMin;
   
   datetime timeClose = StructToTime(structTime);

   
   double profit = AccountInfoDouble(ACCOUNT_EQUITY) - AccountInfoDouble(ACCOUNT_BALANCE);
   
   bool isCloseTime = TimeCurrent() > timeClose;
   bool isProfit = profit > TargetProfit;
   bool isLoss = profit < StopLoss;
   
   if(isCloseTime || isProfit || isLoss)
   {
      CTrade trade;
      for(int i = PositionsTotal()-1; i >= 0; i--)
      {
         ulong posTicket = PositionGetTicket(i);
         if(PositionSelectByTicket(posTicket))
         {
            if(trade.PositionClose(posTicket))
            {
               if(isCloseTime){
                  Print(__FUNCTION__," > Pos #",posTicket," was closed due exceed close time.");
               }
               else if(isProfit) {
                  Print(__FUNCTION__," > Pos #",posTicket," was closed due reach target.");        
               }
               else if(isLoss) {
                  Print(__FUNCTION__," > Pos #",posTicket," was closed due reach StopLoss.");        
               }
            }
         }
      }
   }
   
   double distanceToTarget = TargetProfit - profit;
   double distanceToLimitLoss = StopLoss - profit;
   
   Comment("\nServer Time:  ", TimeCurrent(),
           "\nCountDown CloseTime:  ", timeClose - TimeCurrent(),
           "\nProfit: ",DoubleToString(profit,2), 
           "\n(Distance to Target: ", DoubleToString(distanceToTarget,2)," / ",DoubleToString(TargetProfit,2),
           ") \n(LimitLoss: ", DoubleToString(distanceToLimitLoss,2)," / ",DoubleToString(StopLoss,2),") ");
   
}