







def_class("UILingShouCharacterWin",UIWindowBase)









function UILingShouCharacterWin:bindComponents()

self.root=UIObject.get(self,0)
self.attrGrid=UIObject.get(self,1)



end


function UILingShouCharacterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
end

















function UILingShouCharacterWin:onLoaded(...)
self:bindComponents()
end


function UILingShouCharacterWin:__delete()
self:unbindComponents()
local callback=self.callback
if callback then
callback()
end
end


function UILingShouCharacterWin:onHide()

end




function UILingShouCharacterWin:onShow(argtable,afterOnloaded)
self.ls_guid=argtable.ls_guid
self.callback=argtable.callback
self.lsData=lingshouModel:getLingShouData(self.ls_guid)
self:refreshView()
end

function UILingShouCharacterWin:refreshView()
local lsData=self.lsData
local qianli=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)
local effectlist={}
local race=lsData.cfg.race
for i=1,10 do
local lv=i*10
local temp
local temp1=cfgHelper.get(cfg_lingshouqianliconfig_get,lv,'effect')
if i>1 then
local lv2=(i-1)*10
local temp2={}
local temp3=table.deepCopy(temp1)
local temp4=cfgHelper.get(cfg_lingshouqianliconfig_get,lv2,'effect')
for i2,v2 in ipairs(temp3)do
for i3,v3 in ipairs(temp4)do
if v2[1]==v3[1]and v2[2]==v3[2]then
v2[3]=v2[3]-v3[3]
break
end
end
end
for i4,v4 in ipairs(temp3)do
if v4[3]>0 then
table.insert(temp2,v4)
end
end
temp=temp2
else
temp=table.deepCopy(temp1)
end
for i5,v6 in ipairs(temp)do
v6[4]=lv
table.insert(effectlist,v6)
end
end
local num=#effectlist
self.attrGrid:setChildLayoutGroupCreateItems(num)
local gridlist=self.attrGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
local effect=effectlist[i]
local desc=self.getAttrDesc(effect)
local isactive=qianli>=effect[4]
if isactive then
desc=toColorString(FONT_COLOR.eGreenColor,desc)
end
item:SetChildText(0,desc)

local signIcon=isactive==true and'image_tipsty_4'or'image_tipsty_1'
item:SetChildCSImageSprite(1,globalABLookup.global,signIcon)
end
end

function UILingShouCharacterWin.getAttrDesc(v)
local str=lingshouModel.getQianLiEffectDesc(v)
str=FMT.fmt('{0}（潜力值达到{1}）',str,v[4])
return str
end