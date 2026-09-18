







def_class("UIWanBaoXunBaoDui_EmployeeUpWin",UIWindowBase)









function UIWanBaoXunBaoDui_EmployeeUpWin:bindComponents()

self.root=UIObject.get(self,0)
self.spineeffect=UIObject.get(self,1)
self.uiroot=UIObject.get(self,2)
self.titlebg=UIObject.get(self,3)
self.title=UIText.get(self,4)
self.layoutGroup=UIObject.get(self,5)
self.clostBtn=UIButton.get(self,6)
self.timerInfo=UIText.get(self,7)

self.clostBtn:setButtonClick(function()self:onClostBtn()end)



end


function UIWanBaoXunBaoDui_EmployeeUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spineeffect);self.spineeffect=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.titlebg);self.titlebg=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.layoutGroup);self.layoutGroup=nil;
_UIObject_release(self.clostBtn);self.clostBtn=nil;
_UIObject_release(self.timerInfo);self.timerInfo=nil;
end
















local CmpItemIndex={
quality=0,
catinfo=1,
headimg=2,
name=3,
levelinfo=4,
up=5,
attrlayoutgroup=6,
levelup=7,
layout=8,
addtili=9,
tilitemp=10,
scrollview=11,
}




function UIWanBaoXunBaoDui_EmployeeUpWin:onLoaded(...)
self:bindComponents()
end


function UIWanBaoXunBaoDui_EmployeeUpWin:__delete()
self:unbindComponents()

if self.timerID then
self:stopTimerByID(self.timerID)
self.timerID=nil
end
end




function UIWanBaoXunBaoDui_EmployeeUpWin:onShow(argtable,afterOnloaded)
local compareList=argtable

local propNamelist=wanBaoXunBaoDuiModel:getPropNameList()


AudioManager.playAudio(630)

self.layoutGroup:setChildLayoutGroupCreateItems(#compareList,function(index)
local data=compareList[index]
local item=self.layoutGroup:getChildLayoutGroupGridItem(index-1)

item:SetChildActive(-1,data~=nil)

if data~=nil then
local oldCatData=data.oldCatData
local newCatData=data.newCatData


local modelid,components=wanbaoXunBaoDuiHelper:getCatModelCaptureImageParam(oldCatData)
item:SetChildModelCaptureImage(CmpItemIndex.headimg,modelid,components,2,eAnimationID.idle,0,0,Vector2(0,50),1,false)


local bgiconname=FMT.fmt('frame_dzpz_{0}',oldCatData.color+1)
item:SetChildCSImageSprite(CmpItemIndex.quality,globalABLookup.diciplecolorframe,bgiconname)


local name=cfgHelper.get1(cfg_catnameconfig_get,oldCatData.name_id).name
item:SetChildText(CmpItemIndex.name,name)

item:SetChildText(CmpItemIndex.levelinfo,FMT.fmt('等级：{0}',newCatData.lv))
item:SetChildActive(CmpItemIndex.levelup,newCatData.lv>oldCatData.lv)

local attrlist={}
local tempAttrList={}
local oldLevelCfg=cfgHelper.get1(cfg_catlvconfig_get,oldCatData.lv)
local newLevelCfg=cfgHelper.get1(cfg_catlvconfig_get,newCatData.lv)


local addTili=newLevelCfg.upTili-oldLevelCfg.upTili
local oldProp=oldCatData.propList
local newProp=newCatData.propList

for index=1,5 do
local dvalue=newProp[index]-(oldProp[index]or 0)
if dvalue>0 then
tempAttrList[index]=dvalue
end
end



for k,v in pairs(tempAttrList)do
local temp={type=k,value=v}
table.insert(attrlist,temp)
end

table.sort(attrlist,function(a,b)
return a.type<b.type
end)

item:SetChildActive(CmpItemIndex.tilitemp,addTili>0)
if addTili>0 then
item:SetChildText(CmpItemIndex.addtili,FMT.fmt('+{0}',addTili))
end

item:SetChildLayoutGroupCreateItems(CmpItemIndex.attrlayoutgroup,#attrlist,function(index)
local data=attrlist[index]
local ritem=item:GetChildLayoutGroupGridItem(CmpItemIndex.attrlayoutgroup,index-1)
local name=propNamelist[data.type]or data.type

ritem:SetChildText(0,name)
ritem:SetChildText(1,FMT.fmt('+{0}',data.value))
end)

item:SetChildScrollRectEnable(CmpItemIndex.scrollview,#attrlist>3)
item:ForceLayoutRect(CmpItemIndex.layout)
end
end)


local time=10
local func=function()
time=time-1
self.timerInfo:setText(FMT.fmt('退出({0})',time))
if time==0 then
if self.timerID then
self:stopTimerByID(self.timerID)
self.timerID=nil
end
self:onClostBtn()
end
end
self.timerID=self:setTimer(1,time,func)
end


function UIWanBaoXunBaoDui_EmployeeUpWin:onHide()

end





function UIWanBaoXunBaoDui_EmployeeUpWin:onClostBtn()
self:closeSelf()
wanBaoXunBaoDuiModel:showAdventureFinishSettlementWin()
end

