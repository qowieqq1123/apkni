







local _MODULENAME="fastBuyController"
gameState.addListener(def_table(_MODULENAME))
fastBuyController.name=_MODULENAME

local callbackLookup

function fastBuyController:onAppStart()
socketManager:register_receiver(254,55,self.do_protocol_254_55)
end

function fastBuyController:onEnterState()
callbackLookup={}
end

function fastBuyController:onLeaveState()
callbackLookup=nil
end

function fastBuyController:onPlayerCreate(...)

end

function fastBuyController:onProtocolReq()

end

function fastBuyController:onLostConnection()

end

function fastBuyController.getCfg(itemid,...)
return cfgHelper.get(cfg_fastbuyconfig_get,itemid,...)
end

function fastBuyController.getOnlineDataKey(itemid)
local key=FMT.fmt('faskBuy_{0}',itemid)
return dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,key)

end

function fastBuyController.setOnlineDataKey(itemid,flag)
local key=FMT.fmt('faskBuy_{0}',itemid)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,key,flag)

end

function fastBuyController:checkUse(itemid,usenum,callback,getDescFunc)
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local lerp=haveItem-usenum
if lerp<0 then
fastBuyController:checkBuy(itemid,-lerp,callback)
else
if callback then
callback(itemid)
end
end
end

function fastBuyController:checkUse2(itemid,usenum,callback,getDescFunc)
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local lerp=haveItem-usenum
if lerp<0 then
fastBuyController:checkBuy(itemid,usenum,callback,getDescFunc)
else
if callback then
callback(itemid)
end
end
end

function fastBuyController:checkUse3(itemid,usenum,callback,getDescFunc,callback2)
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local lerp=haveItem-usenum
if lerp<0 then
fastBuyController:checkBuy(itemid,usenum,callback,getDescFunc,callback2)
else
if callback then
callback(itemid)
elseif callback2 then
callback2(itemid)
end
end
end

function fastBuyController:checkUse4(itemid,usenum,callback,getDescFunc,callback2,hidechoose)
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local lerp=haveItem-usenum
if lerp<0 then
fastBuyController:checkBuyAndExchangeMoney(itemid,usenum,callback,getDescFunc,callback2,hidechoose)
else
if callback then
callback(itemid)
elseif callback2 then
callback2(itemid)
end
end
end

function fastBuyController:checkUse5(itemid,usenum,callback,getDescFunc,callback2)
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local lerp=haveItem-usenum

if lerp<0 then
local buynum=usenum-haveItem
fastBuyController:checkBuyAndExchangeMoneyEx(itemid,buynum,callback,getDescFunc,callback2)
else
if callback then
callback(itemid)
elseif callback2 then
callback2(itemid)
end
end
end

function fastBuyController.getCostDesc(uselist)
local str=''
for i,v in ipairs(uselist)do
local s=FMT.fmt('{0}*{1}',moneyModel.getMoneyName(v[1]),v[2])
if i==1 then
str=s
else
str=FMT.fmt('{0}和{1}',str,s)
end
end
return str
end

function fastBuyController.getCostDesc2(uselist)
local str=''
for i,v in ipairs(uselist)do
local s=FMT.fmt('{1}{0}',itemsConfig.getColorName(v[1]),v[2])
if i==1 then
str=s
else
str=FMT.fmt('{0}和{1}',str,s)
end
end
return str
end

function fastBuyController.getCostDescWithIcon(uselist,space)
local str=''
for i,v in ipairs(uselist)do
local s=FMT.fmt('quad-icon={0}-quad{1}',moneyModel.getIconNameEx(v[1]),v[2])
if pfwindowslController:checkIsGameVersion_yuenan()then
s=FMT.fmt('quad-icon={0}-quad  {1}',moneyModel.getIconNameEx(v[1]),v[2])
end
if i==1 then
str=s
else
if pfwindowslController:checkIsGameVersion_yuenan()then
str=FMT.fmt('{0}  {2}{1}',str,s,space or"、")
else
str=FMT.fmt('{0}{2}{1}',str,s,space or"、")
end
end
end
return str
end

function fastBuyController.getCostList(itemid,buynum)
local cfg=fastBuyController.getCfg(itemid)
local money=cfg.money
local uselist={}
local last_moneyType
for i,v in ipairs(money)do
local moneyType=v[1]
local prize=v[2]
local cur=moneyModel.getMoney(moneyType)
local buy=math.floor(cur/prize)
if buy>0 then
local lerp=buynum-buy
local need
if lerp>=0 then
need=buy
buynum=buynum-need
else
need=buynum
buynum=0
end
table.insert(uselist,{moneyType,prize*need,prize,need,i})
end
last_moneyType=moneyType
if buynum<=0 then
break
end
end
local flag=buynum<=0
return flag,uselist,last_moneyType
end

function fastBuyController:checkBuy(itemid,buynum,callback,getDescFunc,callback2,hidechoose)
if buynum<=0 then return end

local flag,uselist,last_moneyType=fastBuyController.getCostList(itemid,buynum)
if not flag then

local cfg=fastBuyController.getCfg(itemid)
local lastCfg=cfg.money[#cfg.money]
local itemName=itemsConfig.getColorName(itemid)
local useStr=self.getCostDesc2({lastCfg})
local lastName=itemsConfig.getColorName(last_moneyType)
local contentStr=FMT.fmt("购买{0}需要消耗{1}\n\n祖师的{2}不足，是否前往购买？",itemName,useStr,lastName)

local show_data={
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='前往',
canceltext='取消',
okcallback=function()
moneySystem:showBuyDialogue()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
if getDescFunc then
local check=fastBuyController.getOnlineDataKey(itemid)

if not check then
local contentStr=getDescFunc(uselist)
local choosetext='今日不再提示'
local choosecallback=function(flag)
fastBuyController.setOnlineDataKey(itemid,flag)
end
if hidechoose then
choosetext=nil
choosecallback=nil
end
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
allowclickBG='false',
choosetext=choosetext,
choosecallback=choosecallback,
okcallback=function(...)
fastBuyController:reqBuy(itemid,uselist,callback)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
fastBuyController:reqBuy(itemid,uselist,callback,callback2)
end
else
fastBuyController:reqBuy(itemid,uselist,callback,callback2)
end
end
end


function fastBuyController:checkBuyAndExchangeMoney(itemid,buynum,callback,getDescFunc,callback2,hidechoose)
if buynum<=0 then return end

local flag,uselist,last_moneyType=fastBuyController.getCostList(itemid,buynum)
local reqFunc=function(useList)
if getDescFunc then
local check=fastBuyController.getOnlineDataKey(itemid)

if not check then
local contentStr=getDescFunc(useList)
local choosetext='今日不再提示'
local choosecallback=function(flag)
fastBuyController.setOnlineDataKey(itemid,flag)
end
if hidechoose then
choosetext=nil
choosecallback=nil
end
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
allowclickBG='false',
choosetext=choosetext,
choosecallback=choosecallback,
okcallback=function(...)
fastBuyController:reqBuy(itemid,useList,callback)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
fastBuyController:reqBuy(itemid,useList,callback,callback2)
end
else
fastBuyController:reqBuy(itemid,useList,callback,callback2)
end
end

if not flag then
local cfg=fastBuyController.getCfg(itemid)
local lastCfg=cfg.money[#cfg.money]
local moneyType=lastCfg[1]
local needValue=lastCfg[2]*buynum
moneySystem:useMoney(moneyType,needValue,function()
local flag,useList,_=fastBuyController.getCostList(itemid,buynum)
if flag then
return reqFunc(useList)
end
end,WARNING_TYPE.eWarning)
else
return reqFunc(uselist)
end
end


function fastBuyController:checkBuyAndExchangeMoneyEx(itemid,buynum,callback,getDescFunc,callback2)
if buynum<=0 then return end

local flag,uselist,last_moneyType=fastBuyController.getCostList(itemid,buynum)
local reqFunc=function(useList)
if getDescFunc then
local check=fastBuyController.getOnlineDataKey(itemid)
if not check then
local contentStr=getDescFunc(useList)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
fastBuyController:reqBuy(itemid,useList,callback)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
fastBuyController:reqBuy(itemid,useList,callback,callback2)
end
else
fastBuyController:reqBuy(itemid,useList,callback,callback2)
end
end

if not flag then
local cfg=fastBuyController.getCfg(itemid)
local lastCfg=cfg.money[#cfg.money]
local moneyType=lastCfg[1]
local needValue=lastCfg[2]*buynum
moneySystem:useMoney(moneyType,needValue,function()
local flag,useList,_=fastBuyController.getCostList(itemid,buynum)
if flag then
return reqFunc(useList)
end
end,WARNING_TYPE.eWarning)
else
return reqFunc(uselist)
end
end

function fastBuyController:reqBuy(itemid,uselist,callback,callback2)
callbackLookup[itemid]=callback2
for i,v in ipairs(uselist)do
socketManager:send_254_55(itemid,v[4],v[5])
end
if callback then
callback()
end
end

function fastBuyController:reqBuyBack(itemid)
if callbackLookup~=nil then
local cb=callbackLookup[itemid]
if cb then
cb(itemid)
callbackLookup[itemid]=nil
end
end
end


function fastBuyController.do_protocol_254_55(itemid,buynum,idx)



UIManager.info(FMT.fmt("成功购买{0}",itemsConfig.getItemName(itemid)))
fastBuyController:reqBuyBack(itemid)
end
