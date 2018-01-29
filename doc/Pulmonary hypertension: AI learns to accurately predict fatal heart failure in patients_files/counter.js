var sys_callback = function(json){
	console.log('stats counted');
};

var news_counter=function(ibt)
{
	var c_what=ibt.what||'';
	var a_id=ibt.a_id||0;
	var r_id=ibt.r_id||0;
	var c_id=ibt.c_id||0;
	var c_url=ibt.c_url||'';
	var a_editor=ibt.a_editor||1;
	var c_country=ibt.c_country||'';
	var referrer=ibt.referer||'';
	var device=ibt.device||'';
	if(c_what)
	{
		if(!referrer||referrer=="0")	referrer=document.referrer;
		if(location.href!=referrer)	setCookie('orir',document.referrer,1/50);
		if(!referrer&&getCookie('orir'))referrer=getCookie('orir');

		if(!referrer && location.search && getUrlParameters && typeof(getUrlParameters) == "function"){	
			var args =	getUrlParameters(location.search.substr(1));
			if(args.utm_source=='yahoo' && (args.utm_medium=='referral' || args.utm_medium=='yahoo_news') || args.yptr=='yahoo') referrer = 'http://www.yahoo.com';
		}
		var sys_script = document.createElement('script');
		sys_script.setAttribute('src', 'https://stats.ibtimes.co.uk/counter/article?ack=sys_callback&c_what='+c_what+"&a_id="+a_id+"&r_id="+r_id+"&c_id="+c_id+"&c_url="+c_url+"&referer="+encodeURIComponent(referrer)+"&device="+device+"&a_editor="+a_editor+"&c_country="+c_country+"&xz=4");
		sys_script.setAttribute('async', true);
		document.body.appendChild(sys_script);
	}
};
if(typeof ibt_cter !='undefined' && top==window && location.href.indexOf('.ibtimes.co.uk')>-1) news_counter(ibt_cter);

