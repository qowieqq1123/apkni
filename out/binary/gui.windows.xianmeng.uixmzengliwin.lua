







def_class("UIXMZengLiWin",UIWindowBase)









function UIXMZengLiWin:bindComponents()

self.allReciveBtn=UIButton.get(self,0)
self.batchToggle=UIToggleButton.get(self,1)
self.boxRoot=UIObject.get(self,2)
self.Content=UIObject.get(self,3)
self.jumpBtn=UIButton.get(self,4)
self.jumpTitle=UIText.get(self,5)
self.noTaskSign=UIObject.get(self,6)
self.rankFirstList=UIObject.get(self,7)
self.receiveNum=UIText.get(self,8)
self.root=UIObject.get(self,9)

self.allReciveBtn:setButtonClick(function()self:onAllReciveBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UIXMZengLiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.allReciveBtn);self.allReciveBtn=nil;
_UIObject_release(self.batchToggle);self.batchToggle=nil;
_UIObject_release(self.boxRoot);self.boxRoot=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.jumpTitle);self.jumpTitle=nil;
_UIObject_release(self.noTaskSign);self.noTaskSign=nil;
_UIObject_release(self.rankFirstList);self.rankFirstList=nil;
_UIObject_release(self.receiveNum);self.receiveNum=nil;
_UIObject_release(self.root);self.root=nil;
end

















local this
local _format=string.format
local _floor=math.floor


function UIXMZengLiWin:onLoaded(...)

self:bindComponents()
this=self
self.config=cfg_guildboxbaseconfig_get(1)
local flag=xianMengBaoXiangModel:getNMFlag()
self.isBatchToggle=true and flag==0 or false
self.batchToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self:freshToggle()
end


function UIXMZengLiWin:__delete()
self:unbindComponents()
self:clearGiftTimer()
end




function UIXMZengLiWin:onShow(argtable,afterOnloaded)
if argtable then
self.tabIndex=argtable.tabIndex
else
self.tabIndex=1
end

self.isGray=false
self:refreshWin()
end


function UIXMZengLiWin:onHide()
self:clearGiftTimer()
end

function UIXMZengLiWin:getSortDatas()
local list=xianMengBaoXiangModel:getBoxList(self.tabIndex)

table.sort(list,function(a,b)
return a.rwFlag<b.rwFlag
end)
return list
end

function UIXMZengLiWin:refreshWin()
self.isGray=false
self:clearGiftTimer()

self.boxList=self:getSortDatas()

self:refreshTitle()
self:refreshScrollview()
self:refreshReciveNum()

self.batchToggle:setActive(self.tabIndex==1)
self.boxRoot:setActive(self.tabIndex==2)
self.winlua:SetChildButtonEnable(self.allReciveBtn:getID(),true,not self.isGray)
end

function UIXMZengLiWin:refreshReciveNum()
if self.tabIndex==1 then return end
local cur=xianMengBaoXiangModel:getReceiveNum()
local max=self.config.dayMax
local str=string.format('%s/%s',cur,max)
self.receiveNum:setText(str)
end

function UIXMZengLiWin:refreshTitle()
local text
local index=self.tabIndex
local textCfg=self.config.topTitle

local str={'购买含有仙盟宝箱的礼包可提供一份盟友赠礼','击败仙域魔物可获得仙盟宝箱'}

if textCfg then
text=textCfg[index]
else
text=str[index]
end

self.jumpTitle:setText(text)
end

function UIXMZengLiWin:refreshScrollview()
if self.boxList and next(self.boxList)then
this.rankFirstList:setActive(true)
self.noTaskSign:setActive(false)

local len=#self.boxList
this.rankFirstList:setChildScrollViewCreateGrids(len,1)
self:refreshItem()
else
self.noTaskSign:setActive(true)
this.rankFirstList:setActive(false)
end
end

function UIXMZengLiWin:refreshItem()
local grids=this.rankFirstList:getChildScrollViewItemWidgets()
local count=grids.Count
local max=self.config.dayMax or 10
local currVal=xianMengBaoXiangModel:getReceiveNum()or 0
local isMax=currVal>=max and true or false

for i=1,count do
local desc
local actorName
local item=grids[i-1]
local data=self.boxList[i]

local guid=data.guid
local rwFlag=data.rwFlag
local itemid=data.itemId

local name=itemsModel.getName(itemid)
if xianMengBaoXiangModel:getItemTag(itemid)==self.tabIndex then
local conf={itemid=itemid,showCountBG=false,showStage=true,itemcount=data.itemNum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


local hideName=self.config.hideName
if data.name==''then
actorName=hideName
else
actorName=data.name
end

if self.tabIndex==1 then
local actName=self.config.actTitle[itemid]
desc=string.format('%s购买了%s中的礼包',actorName,actName)
else
local resName=self.config.resName[itemid]
desc=string.format('由%s带领集结队伍征讨<color=#CA631D>[%s]</color>获得',actorName,resName)
end

if rwFlag==0 then
local tag=xianMengBaoXiangModel:getItemTag(itemid)
if tag==1 then
self.isGray=true
elseif tag==2 and not isMax then
self.isGray=true
end
end

local func
if not isMax or xianMengBaoXiangModel:getItemTag(itemid)==1 then
func=function()socketManager:send_20_144(1,{guid})end
else
func=function()UIManager.error('今日领取仙盟宝箱已达上限')end
end

item:SetChildText(0,name)
item:SetChildActive(1,rwFlag==0)
item:SetChildButtonClick(1,func)
item:SetChildActive(2,rwFlag==0)
item:SetChildActive(3,rwFlag==1)
item:SetChildText(4,desc)
item:SetChildPropData(6,prop)
item:SetBaseItemClickEvent(6,function()
tipsManager.showTips({itemid=itemid})
end)

local flag,leftTime=xianMengBaoXiangModel:getEndLeftTime(data.expireTime)
if leftTime>0 then
item:SetChildText(5,FMT.fmt("{0}",self:format_time_stamp(leftTime,true)))
else
item:SetChildText(5,"礼包已过期")
end

self:setGiftTimer(i,data.expireTime)
end
end
end

function UIXMZengLiWin:setGiftTimer(index,expireTime)
if not self.timerList then self.timerList={}end

self.timerList[index]=self:setTimer(1,-1,function()
local flag,leftTime=xianMengBaoXiangModel:getEndLeftTime(expireTime)
if leftTime>0 then
local grids=this.rankFirstList:getChildScrollViewItemWidgets()
local item=grids[index-1]
item:SetChildText(5,FMT.fmt("{0}",self:format_time_stamp(leftTime,true)))
else
if self.timerList[index]then
self:stopTimerByID(self.timerList[index])
self.timerList[index]=nil
end
socketManager:send_20_143()
end
end)
end

function UIXMZengLiWin:clearGiftTimer()
if self.timerList and next(self.timerList)then
for k,v in pairs(self.timerList)do
if v then
self:stopTimerByID(v)
end
end
end
end

function UIXMZengLiWin:format_time_stamp(inteval,isShort)
if inteval<0 then
inteval=0
end
local HH=_floor(inteval/3600)
local mm=_floor((inteval-HH*3600)/60)
local SS=(inteval-HH*3600-mm*60)%60
if(HH==0)then
HH='00'
end
if(string.len(HH)==1 and HH~=0)then
HH='0'..HH
end
if(mm==0)then
mm='00'
end
if(string.len(mm)==1 and mm~=0)then
mm='0'..mm
end
if(SS==0)then
SS='00'
end
if(string.len(SS)==1 and SS~=0)then
SS='0'..SS
end

if(isShort and HH=='00')then
return _format('%s:%s',mm,SS)
end

return _format('%s:%s:%s',HH,mm,SS)
end




function UIXMZengLiWin:onJumpBtn()
local index=self.tabIndex
local jumpCfg=self.config.jumpId[index]

if jumpCfg then
local jumpType=jumpCfg.type
if jumpType==1 then
local jumpId=jumpCfg.id
local args=jumpCfg.args
jumpManager:jump({id=jumpId,args=args})
elseif jumpType==2 then
local itemId=jumpCfg.itemId
gainControl:showGainWin(itemId)
end
else
UIManager.error('没有配置可用的跳转id')
end
end


function UIXMZengLiWin:onAllReciveBtn()









local max=self.config.dayMax or 10
local currVal=xianMengBaoXiangModel:getReceiveNum()or 0
local boxList=xianMengBaoXiangModel:getBoxList(0)

if boxList and next(boxList)then
local list={}

for k,v in ipairs(boxList)do
local tag=xianMengBaoXiangModel:getItemTag(v.itemId)
if v.rwFlag==0 then
if tag==1 then
table.insert(list,v.guid)
elseif tag==2 and currVal<max then
currVal=currVal+v.itemNum
table.insert(list,v.guid)
end
end
end

if list and next(list)then
local len=#list
socketManager:send_20_144(len,list)
return
end
end

UIManager.error('暂无可领取的仙盟赠礼')
end

function UIXMZengLiWin:onTipsBtn()
local d={}
d.title='规则说明'
d.mode=3
d.name=self.config.helpStr
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIXMZengLiWin:onToggleChanged(name,isToggle,data)
if self.isBatchToggle==isToggle then return end
local str
local flag
self.isBatchToggle=isToggle

if isToggle then
flag=0
str='设置匿名赠送成功'
else
flag=1
str='取消匿名赠送成功'
end

if flag~=xianMengBaoXiangModel:getNMFlag()then
socketManager:send_20_145(flag)
UIManager.info(str)
end
self:freshToggle()
end

function UIXMZengLiWin:freshToggle()
self.batchToggle:setToggle(self.isBatchToggle)
end