
UIFullBaGuaLuControl=gameState.addListener(fullScreenUI.create())
local _maxrlen=1000
function UIFullBaGuaLuControl:onAppStart()

local _showBaguaWindow=function(...)
self:showBaguaWindow(...)
end
local _showLianHuaWindow=function(...)
self:showLianHuaWindow(...)
end

local menulist=
{

{tabType=FULL_TAB_TYPE.eBaGuaLu,callback=_showBaguaWindow},

{tabType=FULL_TAB_TYPE.eHechengLianHua,callback=_showLianHuaWindow},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eBaGuaLu,
attachName={'entityId'}
}
self:initUI(args)

local func=function(...)
self:onRongLian(...)
end
socketManager:register_receiver(3,241,func)
end

function UIFullBaGuaLuControl:onEnterState()
self.rlitems={}
self.guidlist={}
self.guidIndex=0
self.startNext=nil
end


function UIFullBaGuaLuControl:onLeaveState()
if self.timer then
self.timer:cancel()
end
self.istiemdelay=nil
self.rlitems={}
self.guidlist={}
self.guidIndex=0
self.startNext=nil
end


function UIFullBaGuaLuControl:setRongLianitemsExtra(len,rlitems)
if len>0 and rlitems then
for k,v in ipairs(rlitems)do
self.rlitems[#self.rlitems+1]=
{
itemid=v.param_1,
num=v.param_2,
}
end
end
end

function UIFullBaGuaLuControl:setRongLianGUID(guidlist,rlitems,containsMoney,delay,isEnableMoneyTips)
if self.startNext then return end
if containsMoney==nil then containsMoney=true end
if delay==nil then delay=false end
self.guidlist=table.weakCopy(guidlist)
self.isEnableMoneyTips=isEnableMoneyTips
self.rlitems={}
for i,v in ipairs(rlitems)do
if containsMoney==true or containsMoney==false and not itemsConfig.isMoney(v[1])then
self.rlitems[#self.rlitems+1]=
{
itemid=v[1],
num=v[2],
}
end
end
self.istiemdelay=delay
UIFullBaGuaLuControl:startNextRongLian()
end

function UIFullBaGuaLuControl:myShowWindow(argstable,tabType)
tabType=tabType or FULL_TAB_TYPE.eBaGuaLu
if tabType==FULL_TAB_TYPE.eBaGuaLu then
self:showBaguaWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eHechengLianHua then
self:showLianHuaWindow(argstable)
end
end

function UIFullBaGuaLuControl:showMyWindowByBuild(args)
local tabType=FULL_TAB_TYPE.eBaGuaLu
local itemid
if args.args~=nil then
if args.args.tabType~=nil then
tabType=args.args.tabType
end
if args.args.itemid~=nil then
itemid=args.args.itemid
end
end

local argstable={
entityId=args.data.entityId,
itemid=itemid,
}
self:myShowWindow(argstable,tabType)
end

function UIFullBaGuaLuControl:showBaguaWindow(argstable)
local tabType=FULL_TAB_TYPE.eBaGuaLu
argstable.showPage=self:getTabIdx(tabType)
local args={
tabType=tabType,
showBg=true,
viewNames={'UIBaGuaLuWin'},
viewArgs={['UIBaGuaLuWin']=argstable},
}
return self:showUI(args)
end


function UIFullBaGuaLuControl:showLianHuaWindow(argstable)
local tabType=FULL_TAB_TYPE.eHechengLianHua
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIHeChengLianHuaWin'},
viewArgs={['UIHeChengLianHuaWin']=argstable},
}
return self:showUI(args)
end

function UIFullBaGuaLuControl:send_3_241(guidlistlen,guidList)
socketManager:send_3_241(guidlistlen or 0,guidList or{})
end

function UIFullBaGuaLuControl:getNextRlGUIDS()
local temp={}
local guidIndex=self.guidIndex
local maxlen=#self.guidlist
local len=maxlen-guidIndex

if len>0 then
local max=math.min(maxlen,guidIndex+_maxrlen)
for i=guidIndex+1,max do
temp[#temp+1]=self.guidlist[i]
end
self.guidIndex=max
end
return temp
end

function UIFullBaGuaLuControl:onRongLian(len,arry)
self.startNext=nil
self:setRongLianitemsExtra(len,arry)
UIManager:callWindowFunc('UIBaGuaLuWin','onRongLian')
UIFullBaGuaLuControl:startNextRongLian()
end

function UIFullBaGuaLuControl:startNextRongLian()
if self.startNext==true then return end
self.startNext=true
local guidlist=UIFullBaGuaLuControl:getNextRlGUIDS()
if#guidlist>0 then
UIFullBaGuaLuControl:send_3_241(#guidlist,guidlist)
else
UIFullBaGuaLuControl:onRongLianFinish()
end
end

function UIFullBaGuaLuControl:onRongLianFinish()
UIFullBaGuaLuControl:clearRongLianData()
self.startNext=nil
local daytime=2
if self.istiemdelay then
daytime=0.5
self.istiemdelay=nil
end
if self.timer then
self.timer:cancel()
end
local func=function()
UIManager:callWindowFunc('UIBaGuaLuWin','onRongLianAni')
if self.rlitems then
if self.isEnableMoneyTips then
for i,v in ipairs(self.rlitems)do
UIManager.rewardInfo(iconHelper.getIconName(v.itemid),FMT.fmt('X{0}',v.num))
end
else
showPrizeControl.showWindow(self.rlitems)
end
self.rlitems=nil
self.isEnableMoneyTips=nil
end
self.timer=nil
end
self.timer=timer.new()
self.timer:start(daytime,func,1)
end


function UIFullBaGuaLuControl:clearRongLianData()
self.guidlist={}
self.guidIndex=0
end
