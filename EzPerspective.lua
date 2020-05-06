script_name="EzPerspective"
script_description="Bad coded script for lazyfucks"
script_author="shikawa"
script_version="1.0"
script_namespace="EzPerspective"


function EzPerspective(subs,sel)
    rine=subs[sel[1]]
	clip=rine.text:match("%\\clip%(m %d* %d* l %d* %d* %d* %d* %d* %d*%)")
	runPersp1=io.popen('python %appdata%\\Aegisub\\automation\\autoload\\perspective.py "' .. clip .. '" >perspective.txt & type perspective.txt')
	cmdLua=runPersp1:read('*a')
	reportdialog={{x=0,y=1,width=30,height=10,class="textbox",name="Persp",value=cmdLua}}
	local file = io.open("perspective.txt", "r")
	local tablePersp = {}
	for Line in file:lines() do
		table.insert(tablePersp, Line)
	end
	if tablePersp[10] ~= nil then
	pressd,rez=aegisub.dialog.display(reportdialog,{"Pick first", "Pick second", "Pick third", "Close"},{close='Close'})
	if pressd=="Pick first" then 
	text=rine.text
	:gsub("%\\clip%(m %d* %d* l %d* %d* %d* %d* %d* %d*%)",tablePersp[4])
		rine.text=text
		subs[sel[1]]=rine
		end
	if pressd=="Pick second" then 
	text=rine.text
	:gsub("%\\clip%(m %d* %d* l %d* %d* %d* %d* %d* %d*%)",tablePersp[8])
		rine.text=text
		subs[sel[1]]=rine
		end	
	if pressd=="Pick third" then 
	text=rine.text
	:gsub("%\\clip%(m %d* %d* l %d* %d* %d* %d* %d* %d*%)",tablePersp[10])
		rine.text=text
		subs[sel[1]]=rine
		end		
	if pres=="Cancel" then aegisub.cancel() end	
	else pressd,rez=aegisub.dialog.display(reportdialog,{"Pick first", "Pick second", "Close"},{close='Close'})
	if pressd=="Pick first" then 
	text=rine.text
	:gsub("%\\clip%(m %d* %d* l %d* %d* %d* %d* %d* %d*%)",tablePersp[4])
		rine.text=text
		subs[sel[1]]=rine
		end
	if pressd=="Pick second" then 
	text=rine.text
	:gsub("%\\clip%(m %d* %d* l %d* %d* %d* %d* %d* %d*%)",tablePersp[8])
		rine.text=text
		subs[sel[1]]=rine
		end	
	if pres=="Cancel" then aegisub.cancel() end	
	end
	end
aegisub.register_macro(script_name, script_description, EzPerspective)