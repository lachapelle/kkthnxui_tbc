﻿local K, C, L, _ = select(2, ...):unpack()
if C["chat"].enable ~= true or C["chat"].spam ~= true then return end

K.ChatSpamList = {
	"$%d+.+%d+g", 
	"%.c0m%f[%A]",
	"%S+#%d+",
	"%W+mmo4store[%.,]c[0o]m%W+",
	"%[dirge%]",
	"%d%s?eur%f[%A]",
	"%d%s?usd%f[%A]",
	"%d+%-%d+.*d[ou][ub]ble.*%d+%-%d+.*tripp?le",
	"%d+%.?%d*[\226\130\172%$\194\163]+[/\98=]%d+%.?%d*[kg]",
	"%d+%.?%d*[kg][/\98=]%d+%.?%d*eur",
	"%d+%.?%d*[kg][/\98=][\226\130\172%$\194\163]+%d+",
	"%d+.*lfggameteam",
	"%d+e.?u.?r.+%d+g", 
	"%d+g.+$%d+", 
	"%d+g.+%d+e.?u.?r", 
	"%d+g.+\194\163%d+",
	"%d+g.+\226\130\172%d+", 
	"%d+g.+e.?u.?r%d+", 
	"%d/%d cm gold",
	"%f[%a]arena",
	"%f[%a]cap%f[%A]",
	"%f[%a]carry%f[%A]",
	"%f[%a]cr%f[%A]",
	"%f[%a]ebay",
	"%f[%d][235]s%f[%A]",
	"[%.,]c[o0@]m",
	"[%.,]cqm",
	"[%.,]c{circle}m",
	"[%.,]c{rt2}m",
	"[%.,]net",
	"[235]v[235]",
	"[\226\130\172%$\194\163]+%d+%.?%d+[/\98=]%d+%.?%d*[kg]",
	"\194\163%d+.+%d+g", 
	"\226\130\172%d+.+%d+g", 
	"^%W+%d+.*bargeld.*rabatt.*gold%W+$",
	"^%W+diymm[0o]game[%.,]c[0o]m%W+$",
	"^%W+gg4g[%.,][ce][ou]m?%W+$",
	"^%W+m+oggg[%.,][cd][oe]m?%W+$",
	"^%W+mm[0o]%[?yy[%.,]c[0o]m%W+$",
	"^%W+mmoggg%d+.*aktion%W+$",
	"^%W+safer.*loyal.*customers%W+$",
	"^%W+w*[%.,]?gold4guild[%.,]c[o0]m%W+$",
	"^%W+w*[%.,]?wowseller[%.,]c[o0]m%W+$",
	"^www[%.,]ignmax[%.,]com$",
	"a?m[eu]rican?",
	"account",
	"account",
	"account.?share","accshare",
	"an[au][ls]e?r?%f[%L]",
	"anal",
	"argument",
	"aussie",
	"australi",
	"bacon",
	"berechtigt",
	"bewbs",
	"bitch",
	"blizz",
	"boobs",
	"boost",
	"bother.*%d%d%d+g.*server.*quick.*gold",
	"brbgame.*need.*gold.*only.*fast.*deliver",
	"buy.*wow.*curr?ency.*deliver",
	"casino.*%d+.*double.*%d+.*tripp?le",
	"casino.*%d+x2.*%d+x3",
	"casino.*whisper.*info",
	"christian",
	"chuck ?norris",
	"claim",
	"company.*le?ve?l.*char.*%d%d.*free",
	"congratulations",
	"conqu?e?s?t? cap",
	"conqu?e?s?t? points",
	"cs[:;]go%f[%A]",
	"d[ou][ub]ble.*%d+%-%d+.*%d+%-%d+.*tripp?le",
	"d[ou][ub]ble.*%d+%-%d+.*tripp?le.*%d+%-%d+",
	"deaktiviert",
	"delivery",
	"diablo",
	"elite gear",
	"erhalten",
	"euro.*gold.*safer.*trade",
	"excuse.*do.*need.*buy.*wow.*gold",
	"for %ds",
	"free",
	"free.*powerleveling.*level.*%d+.*interested",
	"friend.*price.*%d+k.*gold",
	"friend.*website.*gg4g",
	"friend.*website.*gold4guild",
	"friend.*website.*wowseller",
	"g0ld",
	"game ?time",
	"games.*sale.*thankyou.*buy.*account",
	"gift",
	"girl",
	"hello.*%d%d+k.*stock.*buy.*now",
	"hey.*interest.*some.*fast.*%d+kg.*left",
	"hi.*%d%d+k.*stock.*interest",
	"hi.*you.*need.*gold.*we.*promotion",
	"hippogryph hatchling",
	"interest.*%d+kg.*price.*delive",
	"kiss",
	"know.*need.*buy.*gold.*delivery",
	"konto",
	"kostenlos",
	"launch",
	"lf %ds",
	"log[io]n",
	"low mmr",
	"luckyplayer",
	"mad ?bro",
	"may.*ask.*whether.*interest.*ing.*boe.*stuff.*rocket",
	"may.*know.*have.*account.*don.*use",
	"mmoarm2teeth.*wanna.*gear.*season.*wowgold",
	"mmoggg.*rabat.*artikel",
	"mottled drake",
	"mount",
	"mudda",
	"muslim",
	"name change",
	"nigg[ae]r?",
	"nstig.*produkte.*freien.*preisfall",
	"obama",
	"only%d+%.?%d*eur?o?s?[fp][oe]r%d+%.?%d*[kg]",
	"only[\226\130\172%$\194\163]+%d+[%.%-]?%d*[fp][oe]r%d+%.?%d*[kg]",
	"only[\226\130\172%$\194\163]+%d+[%.%-]?%d*{%S-}%d+%.?%d*[kg]",
	"partner",
	"paypal",
	"pkpkg.*gear.*pet",
	"pleasevisit",
	"points cap",
	"price.*%d%d+g.*sale.*gold",
	"price.*slash.*mmoggg",
	"professional",
	"promotion.*serve.*%d+k",
	"punktecap",
	"pussy",
	"pvp ?mate",
	"qq",
	"qq%d+",
	"qualifiziert",
	"ranking",
	"rating",
	"rbg",
	"realm",
	"receive",
	"rocket chicken",
	"s%A*k%A*y%A*p%Ae",
	"s.?k.?p.?y.?e?", 
	"s.?k.?y.?p.?e?", 
	"sale.*promotion.*mmoggg",
	"season",
	"self ?play",
	"sell.*safe.*fast.*site.*gold2wow",
	"server",
	"server.*purchase.*gold.*deliv",
	"sexy",
	"share",
	"shut ?up",
	"skillcopper.*wow.*mount.*gold",
	"so?r?ry.*bother.*still.*%d+k.*left.*buy.*gold",
	"so?r?ry.*need.*cheap.*gold.*%d+",
	"so?rr?y.*interest.*cheap.*gold",
	"so?rr?y.*you.*tellyou.*%d+k.*wow.*gold",
	"sorr?y.*bother.*another.*wow.*account.*use",
	"stock.*gold.*wonder.*buy.*so?rr?y",
	"surprise",
	"suspe[cn][td]ed",
	"system",
	"tits",
	"transfer",
	"twitch%.tv",
	"warcraft",
	"we.*%d%d%d+g.*stock.*price",
	"we.*%d+k.*gold.*buy",
	"we.*%d+k.*stock.*gold",
	"we.*%d+k.*stock.*interest",
	"we.*%d+k.*stock.*realm",
	"webcam",
	"weekly cap",
	"wins? mount",
	"wondering.*you.*need.*buy.*g.*so?r?ry",
	"wow gold",
	"wts.*boeitems.*sale.*ignah",
	"wts.+guild",
	"www[%.,]",
	"www[%.,]pvpbank[%.,]c.*%d+",
	"xbox",
	"y?o?ur? m[ao]mm?a",
	"y?o?ur? m[ou]th[ae]r",
	"youtu%.?be",
	"youtube",
	"{.*}.*mm4ss.*{.*}",
	"{square}","{star}","{triangle}","{circle}","{skull}","{diamond}",
	"¥",
	"å","à","á","ä","â","ã",
	"è","é","ë","ê",
	"ì","í","ï","î",
	"ò","ó","ö","ô","õ",
	"ù","ú","ü","û",
}