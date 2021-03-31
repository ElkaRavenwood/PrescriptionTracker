const toReadableDate = (sqlDateIn) => {
    let date = parseToDateInfo(sqlDateIn);
    return date.hh+":"+date.mm+", "+date.MMM+" "+date.dd+", "+date.yyyy;
 }
 
 const parseToDateInfo = (sqlDateIn) => {
     let pt = sqlDateIn.split("T")[0];
     let tt = sqlDateIn.split("T")[1].split(".000Z")[0];
     let date = new Date(pt+" "+tt);
     console.log(date);
 
     let dateDix = {};
 
     dateDix.h = ""+date.getHours();
     dateDix.hh = (date.getHours() < 10) ? "0"+date.getHours() : ""+date.getHours();
     dateDix.m = ""+date.getMinutes();
     dateDix.mm = (date.getMinutes() < 10) ? "0"+date.getMinutes() : ""+date.getMinutes();
     dateDix.s = ""+date.getSeconds();
     dateDix.ss = (date.getSeconds() < 10) ? "0"+date.getSeconds() : ""+date.getSeconds();
     dateDix.d = ""+date.getDate();
     dateDix.dd = (date.getDate() < 10) ? "0"+date.getDate() : ""+date.getDate();
 
     
     let monthStr = "";
     let longMonthStr = "";
     switch(date.getMonth()+1){
         case 1:
             monthStr = "Jan";
             longMonthStr = "January";
         break;
 
         case 2:
             monthStr = "Feb";
             longMonthStr = "February";
         break;
 
         case 3:
             longMonthStr = monthStr = "March";
         break;
 
         case 4:
             monthStr = "Apr";
             longMonthStr = "April";
         break;
 
         case 5:
             longMonthStr = monthStr = "May";
 
         break;
 
         case 6:
             monthStr = "Jun";
             longMonthStr = "June";
         break;
 
         case 7:
             monthStr = "Jul";
             longMonthStr = "";
         break;
 
         case 8:
             monthStr = "August";
             longMonthStr = "August";
         break;
 
         case 9:
             monthStr = "Sep";
             longMonthStr = "September";
         break;
 
         case 10:
             monthStr = "Oct";
             longMonthStr = "October";
         break;
 
         case 11:
             monthStr = "Nov";
             longMonthStr = "November";
         break;
 
         case 12:
             monthStr = "Dec";
             longMonthStr = "December";
         break;
     }
 
     dateDix.M = ""+(date.getMonth()+1);
     dateDix.MM = (date.getMonth()+1 < 10) ? "0"+date.getMonth()+1 : ""+date.getMonth()+1;
     dateDix.MMM = monthStr;
     dateDix.MMMM = longMonthStr;
     dateDix.yy = ""+date.getYear();
     dateDix.yyyy = ""+date.getFullYear();
 
     return dateDix;
  }

  module.exports = {
      toReadableDate,
      parseToDateInfo
  }