







def_class("UIXianZhangBaoXia",UIWindowBase)









function UIXianZhangBaoXia:bindComponents()

self.ruleBtn=UIButton.get(self,0)
self.centerpanel=UIObject.get(self,1)
self.bxbtn=UIButton.get(self,2)
self.jlbtn=UIButton.get(self,3)
self.taskScroller=UIObject.get(self,4)
self.tips=UIText.get(self,5)
self.notips=UIObject.get(self,6)
self.spine=UIObject.get(self,7)
self.root=UIObject.get(self,8)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.bxbtn:setButtonClick(function()self:onBxbtn()end)

self.jlbtn:setButtonClick(function()self:onJlbtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIXianZhangBaoXia:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.centerpanel);self.centerpanel=nil;
_UIObject_release(self.bxbtn);self.bxbtn=nil;
_UIObject_release(self.jlbtn);self.jlbtn=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.notips);self.notips=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this
local taskindex=
{
selfitem=0,
name=1,
fxbtn=2,
checkbtn=3,
gotflag=4,
time=5,
itemlists={6,7,8}
}
local baoxiaindex=
{
selfitem=0,
icon=1,
num=2,
btn=3,
}
local abname="ui/windows/xianzhangbaoxia/xianzhangbaoxia_atlas_pak.ab"



function UIXianZhangBaoXia:onLoaded(...)
self:bindComponents()
_this=self
self.selectidx=1
self.titlelookup={}
self.timer={}
self.timerlookup={}
end


function UIXianZhangBaoXia:__delete()
self:unbindComponents()
if self.timerlookup then
for guid,v in pairs(self.timerlookup)do
self:clearTimer(guid)
end
end
_this=nil
end

function UIXianZhangBaoXia:clearTimer(guid)
if self.timer[guid]then
self:stopTimerByID(self.timer[guid])
self.timer[guid]=nil
end
end

function UIXianZhangBaoXia:onRuleBtn()
local d={}
d.title='规则'
d.mode=3
d.name='ui_UIMoJieForceMainWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end
function UIXianZhangBaoXia:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eCenter})
end


function UIXianZhangBaoXia:onBxbtn()
if self.selectidx==1 then
return
end
self.selectidx=1
self:freshLeftChoose(self.selectidx)
self:freshPanel()
end

function UIXianZhangBaoXia:onJlbtn()
if self.selectidx==2 then
return
end
self.selectidx=2
self:freshLeftChoose(self.selectidx)
self:freshPanel()
end

function UIXianZhangBaoXia:onShowFenPeiWin(guid)
if not self.isXZ then
return
end
local bxdata=XianMengBaoXiaModel:getXZBXDataByGuid(guid)
local expireTime=bxdata.expireTime
local nowTime=timeHelper.getServerShortTime()
if nowTime<expireTime then

UIManager:showWindow('UIXianZhangBaoXiaFPWin',{guid=guid})
else
UIManager.info("已过期")
end
end

function UIXianZhangBaoXia:onShowCheckBXWin(guid)

UIManager:showWindow('UIXianZhangBaoXiaFPWin',{guid=guid})
end





function UIXianZhangBaoXia:onShow(argtable,afterOnloaded)
self.centerpanel:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupAlpha(0)
self.spine:setChildUIModelShowTarget(6483,1,{},eAnimationID.enter)
self:delayDo(0.3,function()
if _this==nil then return end
self.centerpanel:setChildCanvasGroupDOFade(1,0.4,nil)
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end)
local guildid=xianmengModel:getMyXMGuildID()
if guildid then
xianmengController:reqXMMemberListCheckCD(guildid)
end
self.config=cfg_xianzangbaoxialujingconfig()
self:setAllTitle()
self.isXZ=XianMengBaoXiaController:isMengZhu()

self.selectidx=1
self:freshLeftChoose(self.selectidx)
self:freshPanel()
end


function UIXianZhangBaoXia:onHide()

end
function UIXianZhangBaoXia:oncloseClick()
UIFullXianMengBaoXiaControl:closeUI()
end

function UIXianZhangBaoXia:startTimer(widget,endsec,guid)
self:clearTimer(guid)
local str=''
local tick=function()
local stamp=timeHelper.getServerShortTime()
if endsec>stamp then
str=FMT.fmt('距离过期：{0}',timeHelper.format_time_stamp(endsec-stamp))
widget:SetChildText(taskindex.time,str)
else
widget:SetChildText(taskindex.time,'<color=#f36666>已过期</color>')
widget:SetChildActive(taskindex.gotflag,false)
widget:SetChildActive(taskindex.fxbtn,false)
widget:SetChildActive(taskindex.checkbtn,false)
widget:SetChildLocalPosY(taskindex.time,0)
self:clearTimer(guid)
end
end
tick()
self.timer[guid]=self:setTimer(1,0,tick)
self.timerlookup[guid]=1
end

function UIXianZhangBaoXia:freshsever(bxType)
if bxType==1 then
self:setAllTitle()
elseif bxType==2 then
end
local timeend=self.bx_list.expireTime
local stamp=timeHelper.getServerShortTime()
self.isBXEnd=stamp>timeend
self:freshlist()
end


function UIXianZhangBaoXia:freshLeftChoose(select)
local bxweight=self.bxbtn:getWidgetBase()
local jlweight=self.jlbtn:getWidgetBase()
if select==1 then
bxweight:SetChildActive(0,true)
bxweight:SetChildActive(1,false)
jlweight:SetChildActive(0,false)
jlweight:SetChildActive(1,true)
else
bxweight:SetChildActive(0,false)
bxweight:SetChildActive(1,true)
jlweight:SetChildActive(0,true)
jlweight:SetChildActive(1,false)
end
end

function UIXianZhangBaoXia:setAllTitle()
self.titlelookup={}
local data=XianMengBaoXiaModel:getXZBXData()
if data then
for k,v in pairs(data)do
local guid=v.guid
local itemList=v.itemList
self:setSingleTitle(guid,itemList)
end
end

end

function UIXianZhangBaoXia:setSingleTitle(guid,itemList)
for _,k in ipairs(self.config)do
local items=k.items
local flag=true
for __,v in ipairs(itemList)do
if not items[v.itemId]then
flag=false
break
end
end
if flag then
self.titlelookup[guid]=k.lujingname
end
end
end


function UIXianZhangBaoXia:freshPanel()
if self.selectidx==1 then
self:freshRewadPanel()
elseif self.selectidx==2 then

end
end

function UIXianZhangBaoXia:getListSort()
local list={}
local data=XianMengBaoXiaModel:getXZBXData()
if data then
local nowTime=timeHelper.getServerShortTime()
for k,v in pairs(data)do
if nowTime<v.expireTime then
table.insert(list,{guid=v.guid,expireTime=v.expireTime})
end
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.expireTime<b.expireTime
end)
end

return list
end

function UIXianZhangBaoXia:freshRewadPanel()
local list=self:getListSort()
local dataNum=#list

if dataNum>0 then
self.taskScroller:setActive(true)
self.notips:setActive(false)
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local listdata=list[i]
local guid=listdata.guid
local bxdata=XianMengBaoXiaModel:getXZBXDataByGuid(guid)
local itemList=bxdata.itemList
local expireTime=bxdata.expireTime
local iscanfp=false



if self.titlelookup[guid]then
item:SetChildText(taskindex.name,self.titlelookup[guid])
else
item:SetChildText(taskindex.name,"仙藏宝匣")
end


if itemList then
for k=1,3 do
local baoxiaitem=item:GetChildWidgetBase(taskindex.itemlists[k])
local itemdata=itemList[k]
if itemdata then
if itemdata.itemNum2>0 then
iscanfp=true
end
baoxiaitem:SetChildActive(baoxiaindex.selfitem,true)

local iconname=iconHelper.getIconName(itemdata.itemId)
baoxiaitem:SetChildIcon(baoxiaindex.icon,iconname,false)
baoxiaitem:SetChildText(baoxiaindex.num,FMT.fmt("x{0}",itemdata.itemNum))
baoxiaitem:SetChildButtonClick(baoxiaindex.btn,function()
if _this==nil then return end
self:onClickRewardItem(itemdata.itemId)
end)
else
baoxiaitem:SetChildActive(baoxiaindex.selfitem,false)
end
end
end


if iscanfp then
item:SetChildActive(taskindex.gotflag,false)
if self.isXZ then
item:SetChildActive(taskindex.fxbtn,true)
item:SetChildActive(taskindex.checkbtn,false)
item:SetChildButtonClick(taskindex.fxbtn,function()
if _this==nil then return end
self:onShowFenPeiWin(guid)
end)
else
item:SetChildActive(taskindex.fxbtn,false)
item:SetChildActive(taskindex.checkbtn,true)
item:SetChildButtonClick(taskindex.checkbtn,function()
if _this==nil then return end
self:onShowCheckBXWin(guid)
end)
end
else
item:SetChildActive(taskindex.gotflag,true)
item:SetChildActive(taskindex.fxbtn,false)
item:SetChildActive(taskindex.checkbtn,false)
end


item:SetChildLocalPosY(taskindex.time,-31)
self:startTimer(item,expireTime,guid)
end
end
else
self.taskScroller:setActive(false)
self.notips:setActive(true)
end
end



