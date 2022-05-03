/* ==========================================================================
   main.js
   ========================================================================== */ 
var $j = jQuery.noConflict();
 
const callFunc = (value) => {
 $j('#search-contact').attr('value', value)
 fetchContacts(value);
}
 
$j(function () {
 
 var dials = $j(".dials ol li");
 var index;
 var number = '';
 var total;
 
 dials.click(function (e) {
   index = dials.index(this);
   if (index == 9) {
     number = '';
   } else if (index == 10) {
     number += '0';
   } else if (index == 11) {
     total = number;
     total = total.slice(0, -1);
     number = total;
   } else if (index == 14) {
     //add any call action here
   } else {
     number += `${index + 1}`;
   }
   callFunc(number);
 });
 
 $j(document).keyup(function (e) {
   switch (e.which) {
     case 48:
       number += '0';
       break;
     case 49:
       number += '1';
       break;
     case 50:
       number += '2';
       break;
     case 51:
       number += '3';
       break;
     case 52:
       number += '4';
       break;
     case 53:
       number += '5';
       break;
     case 54:
       number += '6';
       break;
     case 55:
       number += '7';
       break;
     case 56:
       number += '8';
       break;
     case 57:
       number += '9';
       break;
     // case 8:
     //   total = number;
     //   total = total.slice(0, -1);
     //   number = total;
     //   break;
     case 27:
       number = '';
       break;
     default: return;
   }
   callFunc(number);
   e.preventDefault();
 });
});