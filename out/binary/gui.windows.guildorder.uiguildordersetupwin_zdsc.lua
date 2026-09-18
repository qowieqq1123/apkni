







def_class("UIGuildOrderSetupWin_ZDSC",UIWindowBase)









function UIGuildOrderSetupWin_ZDSC:bindComponents()

self.centerpanel=UIObject.get(self,0)
self.controllBtn=UIButton.get(self,1)
self.controllClose=UIObject.get(self,2)
self.controllOpen=UIObject.get(self,3)
self.jumpAnimationtz=UIObject.get(self,4)
self.jumpAnimationtz2=UIObject.get(self,5)
self.jumpAnimationtz3=UIObject.get(self,6)
self.jumpAnimationtz4=UIObject.get(self,7)
self.jumpAnimationtz5=UIObject.get(self,8)
self.root=UIObject.get(self,9)
self.allbtn=UIObject.get(self,10)
self.jumpAnimationtz6=UIObject.get(self,11)
self.tipsbtn=UIButton.get(self,12)

self.controllBtn:setButtonClick(function()self:onControllBtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)



end


function UIGuildOrderSetupWin_ZDSC:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerpanel);self.centerpanel=nil;
_UIObject_release(self.controllBtn);self.controllBtn=nil;
_UIObject_release(self.controllClose);self.controllClose=nil;
_UIObject_release(self.controllOpen);self.controllOpen=nil;
_UIObject_release(self.jumpAnimationtz);self.jumpAnimationtz=nil;
_UIObject_release(self.jumpAnimationtz2);self.jumpAnimationtz2=nil;
_UIObject_release(self.jumpAnimationtz3);self.jumpAnimationtz3=nil;
_UIObject_release(self.jumpAnimationtz4);self.jumpAnimationtz4=nil;
_UIObject_release(self.jumpAnimationtz5);self.jumpAnimationtz5=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.allbtn);self.allbtn=nil;
_UIObject_release(self.jumpAnimationtz6);self.jumpAnimationtz6=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
end

















local _this
local buildidlist=
{
2,3,4,7,8,9
}
local itemidx=
{
item=0,
checkm=1,
icon=2,
btn=3,
name=4,
reddot=5
}



function UIGuildOrderSetupWin_ZDSC:onLoaded(...)
self:bindComponents()
_this=self
self.tzlist={self.jumpAnimationtz,self.jumpAnimationtz2,self.jumpAnimationtz3,self.jumpAnimationtz4,self.jumpAnimationtz5,self.jumpAnimationtz6}
end


function UIGuildOrderSetupWin_ZDSC:__delete()
self:unbindComponents()
if self.isChange then
guildOrderModel:changeSetupData(self.orderID)
end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)

guildOrderModel:clearAutoShengChanReddot()

if setup.isOpen then
guildOrderController:handleAutoShengChan()
end
_this=nil
end




function UIGuildOrderSetupWin_ZDSC:onShow(argtable,afterOnloaded)
self.orderID=GUILD_ORDER_TYPE.eAutoShengChan
self.cfg=cfg_monijybuildconfig()
self.isChange=false
self.allchoose=false

local setup,cfg=guildOrderModel:getSetupData(self.orderID)

self.buildscFlaglist=setup.scFlaglist
local reddot,reddottype=guildOrderModel:checkAutoShengChanReddot()
self.buildred=reddot
self.builistred=reddottype
self:setbuild()
self:initBuildState()
self:setchooseButton()


local allbtnwidget=_this.allbtn:getWidgetBase()
allbtnwidget:SetChildActive(1,self.allchoose)
allbtnwidget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onChangeallClick(allbtnwidget)
end)
end


function UIGuildOrderSetupWin_ZDSC:onHide()

end


function UIGuildOrderSetupWin_ZDSC:onControllBtn()
end


function UIGuildOrderSetupWin_ZDSC:onTipsbtn()


local tabledesc=cfgHelper.get2(cfg_guildorderconfig_get,self.orderID,'tipsdesc')
local str=tabledesc[1]
self:showWindow('UICommonHelpF',{content=str,posx=154,posy=190})
end


function UIGuildOrderSetupWin_ZDSC:setbuild()
local list={}
for k,v in ipairs(buildidlist)do
local buildNum=zongmenModel:getBuildingCount(v,mapIdType.zhufeng)
if buildNum and buildNum>0 then
local temp=
{
buildtype=v,
idx=k
}
list[#list+1]=temp
end
end
self.buildlist=list

end


function UIGuildOrderSetupWin_ZDSC:initBuildState()
for i=1,#_this.tzlist do
local widget=_this.tzlist[i]:getWidgetBase()
local builddata=self.buildlist[i]
if builddata then
widget:SetChildActive(itemidx.item,true)
local buildid=builddata.buildtype
local idx=builddata.idx
local cfg=cfg_monijybuildconfig_get(buildid)
local name=cfg.name
widget:SetChildText(itemidx.name,name)
widget:SetChildIcon(itemidx.icon,cfg.icon,true)
if self.buildred and self.builistred[buildid]then
widget:SetChildActive(itemidx.reddot,true)
else
widget:SetChildActive(itemidx.reddot,false)
end


local ischoose=self.buildscFlaglist[idx]==1
widget:SetChildActive(itemidx.checkm,ischoose)
else
widget:SetChildActive(itemidx.item,false)
end
end
end

function UIGuildOrderSetupWin_ZDSC:setchooseButton()
for i=1,#_this.tzlist do
local builddata=_this.buildlist[i]
if builddata then
local widget=_this.tzlist[i]:getWidgetBase()
widget:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
_this:onChangebuildClick(widget,i)
end)


end
end
end
function UIGuildOrderSetupWin_ZDSC:buildchoose(widget,flag)
widget:SetChildActive(itemidx.checkm,flag)
end


function UIGuildOrderSetupWin_ZDSC:onChangebuildClick(widget,index)
local setup,cfg=guildOrderModel:getSetupData(_this.orderID)
local builddata=self.buildlist[index]

local idx=builddata.idx
_this.buildscFlaglist[idx]=_this.buildscFlaglist[idx]==1 and 0 or 1
setup.scFlaglist[idx]=_this.buildscFlaglist[idx]

local ischoose=_this.buildscFlaglist[idx]==1
self:buildchoose(widget,ischoose)
guildOrderModel:flushSetupData(_this.orderID)
self.isChange=true
end

function UIGuildOrderSetupWin_ZDSC:onChangeallClick(allbtnwidget)
_this.allchoose=not _this.allchoose
local setup,cfg=guildOrderModel:getSetupData(_this.orderID)
for i=1,#_this.tzlist do
local widget=_this.tzlist[i]:getWidgetBase()
local builddata=self.buildlist[i]
if builddata then
if _this.allchoose then
_this.buildscFlaglist[i]=1
else
_this.buildscFlaglist[i]=0
end
setup.scFlaglist[i]=_this.buildscFlaglist[i]

local ischoose=_this.buildscFlaglist[i]==1
widget:SetChildActive(itemidx.checkm,ischoose)
end
end
allbtnwidget:SetChildActive(1,self.allchoose)
guildOrderModel:flushSetupData(_this.orderID)
self.isChange=true
end
