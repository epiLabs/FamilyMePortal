// moment.js language configuration
// language : czech (cs)
// author : petrbela : https://github.com/petrbela
!function(){function e(e){function t(e){return e>1&&5>e&&1!==~~(e/10)}function a(e,a,n,_){var s=e+" ";switch(n){case"s":return a||_?"p\xe1r vte\u0159in":"p\xe1r vte\u0159inami";case"m":return a?"minuta":_?"minutu":"minutou";case"mm":return a||_?s+(t(e)?"minuty":"minut"):s+"minutami";break;case"h":return a?"hodina":_?"hodinu":"hodinou";case"hh":return a||_?s+(t(e)?"hodiny":"hodin"):s+"hodinami";break;case"d":return a||_?"den":"dnem";case"dd":return a||_?s+(t(e)?"dny":"dn\xed"):s+"dny";break;case"M":return a||_?"m\u011bs\xedc":"m\u011bs\xedcem";case"MM":return a||_?s+(t(e)?"m\u011bs\xedce":"m\u011bs\xedc\u016f"):s+"m\u011bs\xedci";break;case"y":return a||_?"rok":"rokem";case"yy":return a||_?s+(t(e)?"roky":"let"):s+"lety"}}var n="leden_\xfanor_b\u0159ezen_duben_kv\u011bten_\u010derven_\u010dervenec_srpen_z\xe1\u0159\xed_\u0159\xedjen_listopad_prosinec".split("_"),_="led_\xfano_b\u0159e_dub_kv\u011b_\u010dvn_\u010dvc_srp_z\xe1\u0159_\u0159\xedj_lis_pro".split("_");e.lang("cs",{months:n,monthsShort:_,monthsParse:function(e,t){var a,n=[];for(a=0;12>a;a++)n[a]=new RegExp("^"+e[a]+"$|^"+t[a]+"$","i");return n}(n,_),weekdays:"ned\u011ble_pond\u011bl\xed_\xfater\xfd_st\u0159eda_\u010dtvrtek_p\xe1tek_sobota".split("_"),weekdaysShort:"ne_po_\xfat_st_\u010dt_p\xe1_so".split("_"),weekdaysMin:"ne_po_\xfat_st_\u010dt_p\xe1_so".split("_"),longDateFormat:{LT:"H:mm",L:"DD.MM.YYYY",LL:"D. MMMM YYYY",LLL:"D. MMMM YYYY LT",LLLL:"dddd D. MMMM YYYY LT"},calendar:{sameDay:"[dnes v] LT",nextDay:"[z\xedtra v] LT",nextWeek:function(){switch(this.day()){case 0:return"[v ned\u011bli v] LT";case 1:case 2:return"[v] dddd [v] LT";case 3:return"[ve st\u0159edu v] LT";case 4:return"[ve \u010dtvrtek v] LT";case 5:return"[v p\xe1tek v] LT";case 6:return"[v sobotu v] LT"}},lastDay:"[v\u010dera v] LT",lastWeek:function(){switch(this.day()){case 0:return"[minulou ned\u011bli v] LT";case 1:case 2:return"[minul\xe9] dddd [v] LT";case 3:return"[minulou st\u0159edu v] LT";case 4:case 5:return"[minul\xfd] dddd [v] LT";case 6:return"[minulou sobotu v] LT"}},sameElse:"L"},relativeTime:{future:"za %s",past:"p\u0159ed %s",s:a,m:a,mm:a,h:a,hh:a,d:a,dd:a,M:a,MM:a,y:a,yy:a},ordinal:"%d.",week:{dow:1,doy:4}})}"function"==typeof define&&define.amd&&define(["moment"],e),"undefined"!=typeof window&&window.moment&&e(window.moment)}();