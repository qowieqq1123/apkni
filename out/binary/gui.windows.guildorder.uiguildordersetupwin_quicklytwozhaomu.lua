







def_class("UIGuildOrderSetupWin_quicklyTwoZhaoMu",UIWindowBase)









function UIGuildOrderSetupWin_quicklyTwoZhaoMu:bindComponents()

self.controllBtn=UIButton.get(self,0)
self.controllClose=UIObject.get(self,1)
self.controllOpen=UIObject.get(self,2)
self.guanzhuAll=UIToggleButton.get(self,3)
self.guanzhuGrid=UIObject.get(self,4)
self.guanzhuTips=UIText.get(self,5)
self.jumpAnimation=UIObject.get(self,6)
self.jumpAnimation2=UIObject.get(self,7)
self.jumpAnimation3=UIObject.get(self,8)
self.jumpAnimation4=UIObject.get(self,9)
self.jumpAnimationtz=UIObject.get(self,10)
self.jumpAnimationtz2=UIObject.get(self,11)
self.jumpAnimationtz3=UIObject.get(self,12)
self.jumpAnimationtz4=UIObject.get(self,13)
self.jumpAnimationtz5=UIObject.get(self,14)
self.pinzhiAll=UIToggleButton.get(self,15)
self.root=UIObject.get(self,16)
self.tezhiAll=UIToggleButton.get(self,17)

self.controllBtn:setButtonClick(function()self:onControllBtn()end)



end


function UIGuildOrderSetupWin_quicklyTwoZhaoMu:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.controllBtn);self.controllBtn=nil;
_UIObject_release(self.controllClose);self.controllClose=nil;
_UIObject_release(self.controllOpen);self.controllOpen=nil;
_UIObject_release(self.guanzhuAll);self.guanzhuAll=nil;
_UIObject_release(self.guanzhuGrid);self.guanzhuGrid=nil;
_UIObject_release(self.guanzhuTips);self.guanzhuTips=nil;
_UIObject_release(self.jumpAnimation);self.jumpAnimation=nil;
_UIObject_release(self.jumpAnimation2);self.jumpAnimation2=nil;
_UIObject_release(self.jumpAnimation3);self.jumpAnimation3=nil;
_UIObject_release(self.jumpAnimation4);self.jumpAnimation4=nil;
_UIObject_release(self.jumpAnimationtz);self.jumpAnimationtz=nil;
_UIObject_release(self.jumpAnimationtz2);self.jumpAnimationtz2=nil;
_UIObject_release(self.jumpAnimationtz3);self.jumpAnimationtz3=nil;
_UIObject_release(self.jumpAnimationtz4);self.jumpAnimationtz4=nil;
_UIObject_release(self.jumpAnimationtz5);self.jumpAnimationtz5=nil;
_UIObject_release(self.pinzhiAll);self.pinzhiAll=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tezhiAll);self.tezhiAll=nil;
end

















local _this




function UIGuildOrderSetupWin_quicklyTwoZhaoMu:onLoaded(...)
self:bindComponents()
_this=self
self.jumpAnimationlist={self.jumpAnimation,self.jumpAnimation2,self.jumpAnimation3,self.jumpAnimation4}
self.jumpAnimationtzlist={self.jumpAnimationtz,self.jumpAnimationtz2,self.jumpAnimationtz3,self.jumpAnimationtz4,self.jumpAnimationtz5}
self.pinzhiAll:setToggleChange(function(...)self:onPinZhiAllToggleChanged(...)end)
self.tezhiAll:setToggleChange(function(...)self:onTeZhiAllToggleChanged(...)end)
self.guanzhuAll:setToggleChange(function(...)self:onGuanZhuAllToggleChanged(...)end)
end


function UIGuildOrderSetupWin_quicklyTwoZhaoMu:__delete()
self:unbindComponents()
if self.isChange then
guildOrderModel:changeSetupData(self.orderID)
end
end


function UIGuildOrderSetupWin_quicklyTwoZhaoMu:onHide()

end




function UIGuildOrderSetupWin_quicklyTwoZhaoMu:onShow(argtable,afterOnloaded)
self.orderID=GUILD_ORDER_TYPE.eQuicklyZhaoMu
self.isChange=false
self.lockRefresh=true
self.isgray=false


local setup,cfg=guildOrderModel:getSetupData(self.orderID)
local colorFlaglist=setup.colorFlaglist
self.setcolorflag={0,0,1,1}
if colorFlaglist then
for i,v in ipairs(colorFlaglist)do
self.setcolorflag[i]=v
end
end
local specialityPreviewFlaglist=setup.specialityPreviewFlaglist
self.settezhiflag={1,1,1,1}
if specialityPreviewFlaglist then
for i,v in ipairs(specialityPreviewFlaglist)do
self.settezhiflag[i]=v
end
end

local specialityLoveList=setup.specialityLoveList
self.speLoveflag={}
self.speLoveList={}
self.speLoveList_sort={}
for i,v in ipairs(specialityLoveList)do
local flag=math.floor(v/1000000)
local n=v%1000000
local spetype=math.floor(n/10000)
local speid=n%10000
self.speLoveflag[i]=flag
self.speLoveList[i]={spetype,speid}
local d={i}
self.speLoveList_sort[i]=d
local cfg=TeZhiTuJianModel:getCofig(spetype,speid)
local book_id=cfg.id
local sorts={}
sorts[1]=10-cfg.showType
local state=TeZhiTuJianModel:getTuJianState(book_id)
if state~=TeZhiTuJianModel.TempState.eNotRecv then
sorts[2]=1
else
sorts[2]=0
end
sorts[3]=10000-book_id
d.sorts=sorts
end
if#self.speLoveList_sort>1 then
mathHelper.sortWeightList(self.speLoveList_sort)
end

self:refreshItemControllBtn(self.orderID,true)
self:setcolorButton()
self:refreshPinZhiAllToggleState()
self:settezhiButton()
self:refreshTeZhiAllToggleState()
self:setguanzhuButton()
self:refreshGuanZhuAllToggleState()
self.lockRefresh=false
end



function UIGuildOrderSetupWin_quicklyTwoZhaoMu:onControllBtn(idx)
local orderID=self.orderID
local setup=guildOrderModel:getSetupData(orderID)
setup.isOpen=not setup.isOpen
guildOrderModel:flushSetupData(orderID)
guildOrderModel:changeSetupOpen(orderID,setup.isOpen)
self:refreshItemControllBtn(orderID)
UIManager:invokeUIMethod('UIGuildOrderWin','checkitemorder',orderID)
end


function UIGuildOrderSetupWin_quicklyTwoZhaoMu:refreshItemControllBtn(orderID,isInit)
local isSetupOpen=guildOrderModel:isOrderSetupOpen(orderID)
self.winlua:SetChildActive(self.controllClose:getID(),not isSetupOpen)
self.winlua:SetChildActive(self.controllOpen:getID(),isSetupOpen)
self.isgray=not isSetupOpen
self:setgrayall(self.isgray,isInit)
end


function UIGuildOrderSetupWin_quicklyTwoZhaoMu:setgrayall(flag,isInit)
for i=1,#self.jumpAnimationlist do
local widget=self.jumpAnimationlist[i]:getWidgetBase()
widget:SetChildGray(1,flag)
widget:SetChildGray(2,flag)
end
for i=1,#self.jumpAnimationtzlist do
local widgettwo=self.jumpAnimationtzlist[i]:getWidgetBase()
widgettwo:SetChildGray(1,flag)
widgettwo:SetChildGray(2,flag)
end
if not isInit then
local list=self.guanzhuGrid:getChildLayoutGroupGridList()
local n=list.Count
if n>0 then
for i=0,n-1 do
local widget=list[i]
widget:SetChildGray(1,flag)
end
end
end
end

function UIGuildOrderSetupWin_quicklyTwoZhaoMu:checkGray()
if self.isgray then
UIManager.info('招募法令已关闭，开启法令后可变更选项')
return false
end
return true
end



function UIGuildOrderSetupWin_quicklyTwoZhaoMu:refreshPinZhiAllToggleState()
local isall=true
for idx,v in ipairs(self.setcolorflag)do

if idx~=4 then
if v==0 then
isall=false
end
end
end
self.isPinZhiAllToggle=isall
self.pinzhiAll:setToggle(self.isPinZhiAllToggle)
end

function UIGuildOrderSetupWin_quicklyTwoZhaoMu:onPinZhiAllToggleChanged(name,isToggle,data)
if self.lockRefresh then return end
if not self:checkGray()then
self.lockRefresh=true
self.pinzhiAll:setToggle(self.isPinZhiAllToggle)
self.lockRefresh=false
return
end
if isToggle==self.isPinZhiAllToggle then return end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
local colorFlaglist=setup.colorFlaglist
local n=isToggle==true and 1 or 0
for idx,_ in ipairs(self.setcolorflag)do

if idx~=4 then
self.setcolorflag[idx]=n
colorFlaglist[idx]=n
end
end
guildOrderModel:flushSetupData(self.orderID)
self.isPinZhiAllToggle=isToggle
self:setcolorButton()
end


function UIGuildOrderSetupWin_quicklyTwoZhaoMu:setcolorButton()
for i=1,#self.jumpAnimationlist do
local widget=self.jumpAnimationlist[i]:getWidgetBase()

widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onChangeColorClick(widget,i)
end)

self:colorchoose(widget,self.setcolorflag[i])
end
end
function UIGuildOrderSetupWin_quicklyTwoZhaoMu:colorchoose(widget,flag)
local ischoose=flag==1 and true or false
widget:SetChildActive(0,not ischoose)
widget:SetChildActive(1,ischoose)
end


function UIGuildOrderSetupWin_quicklyTwoZhaoMu:onChangeColorClick(widget,index)
if self.lockRefresh then return end
if not self:checkGray()then return end

local setup,cfg=guildOrderModel:getSetupData(self.orderID)
if index==1 or index==2 then
self:refreshColorClick(widget,index)

elseif index==3 then

if self.setcolorflag[index]==1 then
local show_data=
{
title='提示',





okcallback=function()
if _this==nil then return end
_this:refreshColorClick(widget,index)
end
}
UIManager:showWindow('UIDialougeZhaoMutips',show_data)
elseif self.setcolorflag[index]==0 then
self:refreshColorClick(widget,index)
end

elseif index==4 then
if self.setcolorflag[index]==1 then
UIManager.info('逆天品质的弟子极其稀有，无法自动拒招')
elseif self.setcolorflag[index]==0 then
self:refreshColorClick(widget,index)
end
end
end

function UIGuildOrderSetupWin_quicklyTwoZhaoMu:refreshColorClick(widget,index)
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
self.setcolorflag[index]=self.setcolorflag[index]==1 and 0 or 1
setup.colorFlaglist[index]=self.setcolorflag[index]

self:colorchoose(widget,self.setcolorflag[index])
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
self:refreshPinZhiAllToggleState()
end



function UIGuildOrderSetupWin_quicklyTwoZhaoMu:refreshTeZhiAllToggleState()
local isall=true
for _,v in ipairs(self.settezhiflag)do
if v==0 then
isall=false
end
end
self.isTeZhiAllToggle=isall
self.tezhiAll:setToggle(self.isTeZhiAllToggle)
end

function UIGuildOrderSetupWin_quicklyTwoZhaoMu:onTeZhiAllToggleChanged(name,isToggle,data)
if self.lockRefresh then return end
if not self:checkGray()then
self.lockRefresh=true
self.tezhiAll:setToggle(self.isTeZhiAllToggle)
self.lockRefresh=false
return
end
if isToggle==self.isTeZhiAllToggle then return end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
local specialityPreviewFlaglist=setup.specialityPreviewFlaglist
local n=isToggle==true and 1 or 0
for i,_ in ipairs(self.settezhiflag)do
self.settezhiflag[i]=n
specialityPreviewFlaglist[i]=n
end
guildOrderModel:flushSetupData(self.orderID)
self.isTeZhiAllToggle=isToggle
self:settezhiButton()
end


function UIGuildOrderSetupWin_quicklyTwoZhaoMu:settezhiButton()
for i=1,#self.jumpAnimationtzlist do
local widget=self.jumpAnimationtzlist[i]:getWidgetBase()

widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onChangetezhiClick(widget,i)
end)

self:tezhichoose(widget,self.settezhiflag[i])
end
end
function UIGuildOrderSetupWin_quicklyTwoZhaoMu:tezhichoose(widget,flag)
local ischoose=flag==1 and true or false
widget:SetChildActive(0,not ischoose)
widget:SetChildActive(1,ischoose)
end


function UIGuildOrderSetupWin_quicklyTwoZhaoMu:onChangetezhiClick(widget,index)
if self.lockRefresh then return end
if not self:checkGray()then return end
self.settezhiflag[index]=self.settezhiflag[index]==1 and 0 or 1
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
setup.specialityPreviewFlaglist[index]=self.settezhiflag[index]

self:tezhichoose(widget,self.settezhiflag[index])
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
self:refreshTeZhiAllToggleState()
end



function UIGuildOrderSetupWin_quicklyTwoZhaoMu:refreshGuanZhuAllToggleState()
local isall=true
for _,v in ipairs(self.speLoveflag)do
if v==0 then
isall=false
end
end
self.isGuanZhuAllToggle=isall
self.guanzhuAll:setToggle(self.isGuanZhuAllToggle)
end

function UIGuildOrderSetupWin_quicklyTwoZhaoMu:onGuanZhuAllToggleChanged(name,isToggle,data)
if self.lockRefresh then return end
if not self:checkGray()then
self.lockRefresh=true
self.guanzhuAll:setToggle(self.isGuanZhuAllToggle)
self.lockRefresh=false
return
end
if isToggle==self.isGuanZhuAllToggle then return end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
local specialityLoveList=setup.specialityLoveList
local n=isToggle==true and 1 or 0
for i,_ in ipairs(self.speLoveflag)do
local idx=self.speLoveList_sort[i][1]
self.speLoveflag[idx]=n
local v=self.speLoveList[idx]
specialityLoveList[idx]=n*1000000+v[1]*10000+v[2]
end
guildOrderModel:flushSetupData(self.orderID)
self.isGuanZhuAllToggle=isToggle
self:setguanzhuButton()
end


function UIGuildOrderSetupWin_quicklyTwoZhaoMu:setguanzhuButton()
local n=#self.speLoveList_sort
local has=n>0
self.guanzhuAll:setActive(has)
self.guanzhuGrid:setActive(has)
self.guanzhuTips:setActive(not has)
if has then
local config2=TeZhiTuJianModel:getConfigLoolup2()
self.guanzhuGrid:setChildLayoutGroupCreateItems(n,function(index)
local widget=self.guanzhuGrid:getChildLayoutGroupGridItem(index-1)
local idx=self.speLoveList_sort[index][1]
local spe=self.speLoveList[idx]
local spetype=spe[1]
local speid=spe[2]
local cfg=config2[spetype][speid]
UIDiscipleModel.refreshSpecialityItem(widget,cfg,nil)

widget:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onChangeguanzhuClick(widget,index)
end)
widget:SetChildLongTouch(5,index,1,function(...)
if _this==nil then return end
_this:onDescSlotClick(index,spetype,speid)
end)

widget:SetChildGray(1,self.isgray)

self:guanzhuchoose(widget,self.speLoveflag[idx])
end)
end
end

function UIGuildOrderSetupWin_quicklyTwoZhaoMu:onDescSlotClick(idx,spetype,speid)
local cfg=TeZhiTuJianModel:getTeZhiCfg(spetype,speid)

local item=self.guanzhuGrid:getChildLayoutGroupGridItem(idx-1)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',config=cfg})
end

function UIGuildOrderSetupWin_quicklyTwoZhaoMu:guanzhuchoose(widget,flag)
local ischoose=flag==1 and true or false
widget:SetChildActive(3,not ischoose)
widget:SetChildActive(4,ischoose)
end


function UIGuildOrderSetupWin_quicklyTwoZhaoMu:onChangeguanzhuClick(widget,index)
if self.lockRefresh then return end
if not self:checkGray()then return end
local idx=self.speLoveList_sort[index][1]
local flag=self.speLoveflag[idx]==1 and 0 or 1
self.speLoveflag[idx]=flag
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
local v=self.speLoveList[idx]
setup.specialityLoveList[idx]=flag*1000000+v[1]*10000+v[2]

self:guanzhuchoose(widget,self.speLoveflag[idx])
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
self:refreshGuanZhuAllToggleState()
end
