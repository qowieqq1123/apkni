







def_class("UIXianZhanTalkWin",UIWindowBase)









function UIXianZhanTalkWin:bindComponents()

self.mask=UIObject.get(self,0)
self.btnListPanel=UIObject.get(self,1)
self.root=UIObject.get(self,2)



end


function UIXianZhanTalkWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.btnListPanel);self.btnListPanel=nil;
_UIObject_release(self.root);self.root=nil;
end

















local _this=nil

local TalkType=
{
simple=1,
}

local btnFunctions={
[1]={
refresh=function(win,item,index)
win:refreshTalkBtn(item,index)
end,
onclick=function(win,index)
win:onTalkBtn(index)
end
},
[2]={
refresh=function(win,item,index)
win:refreshTalkBtn(item,index)
end,
onclick=function(win,index)
win:onTalkBtn(index)
end
},
[3]={
refresh=function(win,item,index)
win:refreshTalkBtn(item,index)
end,
onclick=function(win,index)
win:onTalkBtn(index)
end
},
[4]={
refresh=function(win,item,index)
win:refreshBackBtn(item,index)
end,
onclick=function(win,index)
win:onBackBtn()
end
},
}


function UIXianZhanTalkWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianZhanTalkWin:__delete()
_this=nil
self:stopTimerByName('speakCallDelayTimer')
self:unbindComponents()
end




function UIXianZhanTalkWin:onShow(argtable,afterOnloaded)
local change=self.roomId~=argtable
self.roomId=argtable
self.data=xianzhanModel:getRoomDataByRoomId(self.roomId)
self.fkConfig=cfgHelper.get1(cfg_xianzhanfangkeconfig_get,self.data.customerId)
if change then
local speakList=self:getTalkContent()
self.speakList=speakList
end

local grid=self.btnListPanel:getChildCommonLayoutGroupWidgetList()
local count=grid.Count
for i=1,count do
local item=grid[i-1]
local check=btnFunctions[i]
check.refresh(self,item,i)
item:SetChildButtonClick(0,function()
check.onclick(self,i)
end)
end

self:doOpenAnim()
end

function UIXianZhanTalkWin:doOpenAnim()
local win=UIManager:findActiveWindow('UIXianZhanInteractWin')
if win then
win:activeRightPanel(false)
end
self.root:setChildCanvasGroupAlpha(1)
local delay=0
local grid=self.btnListPanel:getChildCommonLayoutGroupWidgetList()
local count=grid.Count
for i=1,count do
local item=grid[i-1]
local isactive=item:GetChildActiveSelf(-1)
if isactive then
item:SetChildLocalPosX(1,400)
if delay>0 then
self:delayDo(delay,function()
item:SetChildDOLocalMoveX(1,0,0.15,nil)
end)
else
item:SetChildDOLocalMoveX(1,0,0.15,nil)
end
delay=delay+0.1
end
end
end

function UIXianZhanTalkWin:doCloseAnim(func)
self.root:setChildCanvasGroupAlpha(1)
self.root:setChildCanvasGroupDOFade(0,0.2,function()
if _this==nil then return end
if func~=nil then
func()
end
end)
end


function UIXianZhanTalkWin:onHide()

end

function UIXianZhanTalkWin:refreshBackBtn(item,index)
item:SetChildText(2,'返 回')
end

function UIXianZhanTalkWin:refreshTalkBtn(item,index)
local hgd=self.data.haoGanDu
local lv=npcModel.getHaoGanDuLevel(hgd)
local data=self.speakList[index]
local titlestr=data[2]
local need=data[1]
local isfix=lv>=need
item:SetChildActive(3,not isfix)
if not isfix then
titlestr=FMT.fmt('<color=#E33021>{0}</color>',titlestr)
local name=npcModel.getHaoGanDuName(need)
local hgdstr=FMT.fmt('<color=#E33021>(关系达到{0})</color>',name)
item:SetChildText(3,hgdstr)
end
item:SetChildText(2,titlestr)
end

function UIXianZhanTalkWin:getTalkContent()
local simpleTalk=xianzhanModel:getTalkContent(self.data.customerId)
local temp={}
local weights={}
for i,v in ipairs(simpleTalk)do
table.insert(weights,v[4])
table.insert(temp,v)
end
local speakList={}
local sum=0
while sum<3 do
local index=mathHelper.weightRandom(weights,true)
table.insert(speakList,temp[index])
table.remove(weights,index)
table.remove(temp,index)
sum=sum+1
end
table.sort(speakList,function(a,b)
return a[1]<b[1]
end)
return speakList
end

function UIXianZhanTalkWin:checkTalkCond(typo,index)
local hgd=self.data.haoGanDu
local lv=npcModel.getHaoGanDuLevel(hgd)
local need
self.talkType=typo
if typo==TalkType.simple then
local speak=self.speakList[index]
need=speak[1]
end
if lv<need then
local name=npcModel.getHaoGanDuNameEx(need)
UIManager.error(FMT.fmt('关系达到{0}解锁',name))
return false
end
return true
end


function UIXianZhanTalkWin:startTalk(typo,index)
local speakList
self.talkType=typo
if typo==TalkType.simple then
local speak=self.speakList[index]
speakList=speak[3]
end
self.root:setActive(false)
self.mask:setActive(true)
local func=function(...)
if _this==nil then return end
_this.istalking=false
_this:stopTimerByName('speakCallDelayTimer')
_this:delaySpeakCallback(typo)
end
local func2=function()
if _this==nil then return end
_this.istalking=false
_this:stopTimerByName('speakCallDelayTimer')
_this.mask:setActive(false)
_this:speakCallback(typo)
end
self.istalking=true
xianzhanController:interactStartTalk(speakList,func,func2)

if typo==TalkType.simple then
local dailyTaskNum=self.data.dayTalkNum
if dailyTaskNum<1 then
xianzhanController:req_customer_talk(self.roomId)
end
end
end

function UIXianZhanTalkWin:delaySpeakCallback(typo)
self.speakCallDelayTimer=self:delayDo(3,function(...)
self:stopTimerByName('speakCallDelayTimer')
self.mask:setActive(false)
self:speakCallback(typo)
end)
end

function UIXianZhanTalkWin:speakCallback(typo)
if typo==TalkType.simple then
self.root:setActive(true)
xianzhanController:resetInreractSpeak()
end
end



function UIXianZhanTalkWin:onTalkBtn(index)
if not self:checkTalkCond(TalkType.simple,index)then
return
end
self:startTalk(TalkType.simple,index)
end

function UIXianZhanTalkWin:onBackBtn()
local func=function()
local win=UIManager:findActiveWindow('UIXianZhanInteractWin')
if win then
win:activeRightPanel(true)
end
xianzhanController:closeInteractAttachWin(XianZhanInteractType.eTalk)
end
self:doCloseAnim(func)
end

function UIXianZhanTalkWin:onClickMask()
if self.istalking then
local isfinish=UIManager:invokeUIMethod('UIXianZhanInteractWin','checkFinishTalk')
if not isfinish then
UIManager:invokeUIMethod('UIXianZhanInteractWin','quicklyPlay')
if not self.istalking then
self:onClickMask()
end
else
self.istalking=nil
end
elseif self.speakCallDelayTimer~=nil then
self:stopTimerByName('speakCallDelayTimer')

self.mask:setActive(false)
self:speakCallback(self.talkType)
else
self.mask:setActive(false)
self:speakCallback(self.talkType)
end
end