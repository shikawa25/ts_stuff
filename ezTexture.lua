script_name="ezTexture"
script_description="Fake textures with splatter.ttf"
script_author="shikawa"
script_version="1.0"
script_namespace="ezTexture"

re=require'aegisub.re'


GUI={

	{x=0,y=0,class="label",label="Font size:"},
	{x=0,y=1,class="label",label="Loops:"},
	{x=2,y=0,class="label",label="Blur:"},
	{x=2,y=1,class="label",label="Colors:"},
	{x=1,y=0,width=1,class="floatedit",name="fontsize",value=500},
	{x=1,y=1,width=1,class="floatedit",name="loops",value=10},
	{x=3,y=0,width=1,class="floatedit",name="blur",value=1.0},
	{x=3,y=1,class="dropdown",name="colors",items={"1","2","3","4","5","6"},value="1"},
	{x=4,y=0,class="color",name="cl1"},
	{x=5,y=0,class="color",name="cl2"},
	{x=6,y=0,class="color",name="cl3"},
	{x=4,y=1,class="color",name="cl4"},
	{x=5,y=1,class="color",name="cl5"},
	{x=6,y=1,class="color",name="cl6"},
}

function getStuff(subs,sel)
	for z=#sel,1,-1 do
		i=sel[z]
		rine=subs[i]
	rawLine = rine.raw
	config = res["fontsize"]..','..res["loops"]..','..res["blur"]..','..res["colors"]..','..res.cl1:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&")..','..res.cl2:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&")..','..res.cl3:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&")..','..res.cl4:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&")..','..res.cl5:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&")..','..res.cl6:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&")
	file = io.open("C:\\windows\\temp\\decadaocu.bat", "w")
	putaria = 'python %appdata%\\Aegisub\\automation\\autoload\\ezTexture.py "'..rawLine..'" "'..config..'"'
	file:write(putaria)
	file:close()
	runTexture=os.execute("C:\\windows\\temp\\decadaocu.bat")
	end
	end

	

function ezTexture(subs,sel)
P,res=aegisub.dialog.display(GUI,{'Run', 'Close'},{ok='Run',cancel='Close'})
if P=='Run' then getStuff(subs,sel) end
end

aegisub.register_macro(script_name,script_description,ezTexture)