







local _plan={}

moneyPlanModel={}

function moneyPlanModel:clearPlanModel()
_plan={}
end

function moneyPlanModel:setPlanNumber(itemid,sysid,num)

local t=_plan[itemid]
if not t then
t={lookup={},sum=0,}
_plan[itemid]=t
end
local oNum=t.lookup[sysid]or 0
t.lookup[sysid]=num
t.sum=t.sum+(num-oNum)
end

function moneyPlanModel:haveMoneyPlan(itemid)
local t=_plan[itemid]
return t and t.sum>0
end

function moneyPlanModel:checkMoneyPlan(itemid,cost)
local t=_plan[itemid]
if t then
local have=itemsModel.getCount(itemid)
local plan=t.sum
return have>=(plan+cost)
end
return true
end

function moneyPlanModel:promptPlan(itemid,callback,tips)
local t=_plan[itemid]
local itemName=itemsConfig.getColorName(itemid)
local content=nil
for sysId,num in pairs(t.lookup)do
local sysName=systemConfig.getSystemName(sysId)
local str=FMT.fmt("{0}已计划使用{1}*{2}",sysName,itemName,num)
if content then
content=FMT.fmt("{0}\n{1}",content,str)
else
content=str
end
end
content=FMT.fmt("{0}\n{1}",content or"",tips or"")
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
if callback then
callback()
end
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function moneyPlanModel:checkHandle(itemid,cost,callback,tips)
if self:haveMoneyPlan(itemid)then
if not self:checkMoneyPlan(itemid,cost)then
self:promptPlan(itemid,callback,tips)
return
end
end
if callback then
callback()
end
end
