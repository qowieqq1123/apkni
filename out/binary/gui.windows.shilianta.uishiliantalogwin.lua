







def_class("UIShiLianTaLogWin",UIWindowBase)









function UIShiLianTaLogWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.packScrollerView=UIObject.get(self,1)
self.noImage=UIObject.get(self,2)
self.layer=UIText.get(self,3)
self.Content=UIObject.get(self,4)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIShiLianTaLogWin")end)



end


function UIShiLianTaLogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.noImage);self.noImage=nil;
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.Content);self.Content=nil;
end



















local cmpIndex=
{
bg1=1,
bg2=2,
bg3=3,
kuang=4,
icon=5,
zmname=6,
name=7,
teamButton=8,
playButton=9,
noneIocn=10,
}


function UIShiLianTaLogWin:onLoaded(...)
self:bindComponents()
end


function UIShiLianTaLogWin:__delete()
self:unbindComponents()
end




function UIShiLianTaLogWin:onShow(argtable,afterOnloaded)
self.selectedLayer=argtable.layer
socketManager:send_13_8(self.selectedLayer)
self.layer:setText(FMT.fmt("{0}层",self.selectedLayer))
end


function UIShiLianTaLogWin:onHide()

end

function UIShiLianTaLogWin:onRefresh(len,recordList)
if len<=0 then
self.noImage:setActive(true)
return
end
table.sort(recordList,function(a,b)
return a.recordType<b.recordType
end)
self.noImage:setActive(false)
self.packScrollerView:setChildScrollViewCreateGrids(#recordList,1)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local data=recordList[i]
local recordType=data.recordType
item:SetChildActive(cmpIndex.bg1,recordType==1)
item:SetChildActive(cmpIndex.bg2,recordType==2)
item:SetChildActive(cmpIndex.bg3,recordType==3 or recordType==4)

playerController:setHeadIcon(item,cmpIndex.icon,{scale=0.6,iconInfo=data.iconInfo})
item:SetChildActive(cmpIndex.noneIocn,false)
if data.name==''then
item:SetChildActive(cmpIndex.icon,false)
item:SetChildActive(cmpIndex.noneIocn,true)
item:SetChildLocalPosY(cmpIndex.name,0)
end

item:SetChildText(cmpIndex.zmname,data.zmName)
item:SetChildText(cmpIndex.name,playerModel:getOtherActorName(data.name))
item:SetChildActive(cmpIndex.teamButton,data.teamFlag==1)
item:SetChildButtonClick(cmpIndex.teamButton,function()

local args={}
args.layer=self.selectedLayer
args.recordType=recordType
args.attachArgs={title='通关阵容'}
args.checkEmpty=true
otherPlayerController:reqOtherZRInfo(data.actorId,otherPlayerInfoType.eShiLianTa2,args)
end)
item:SetChildButtonClick(cmpIndex.playButton,function()
shiLianTaController:openReplay(data.fightLogId,self.selectedLayer)
end)
end
end
end


