







local kfZHFPData
local kfBag
local moneylistLookUp={}
function xianmengModel:clearData_kufangZHFP()
kfZHFPData=nil
kfBag=nil
moneylistLookUp={}
end

function xianmengModel:initData_kufangZHFP()
kfZHFPData={}

local moneylist=cfg_xianmengjuanxianbaseconfig_get(1).moneylist
for i,v in ipairs(moneylist)do
moneylistLookUp[v]=true
end
end

function xianmengModel:initkufangBag(array)
if array then
for i,v in ipairs(array)do
xianmengModel:putInkufangBag(v)
end
end
end

function xianmengModel:putInkufangBag(singleArray)
if not kfBag then
kfBag={}
end
local itemId=singleArray.param_1
local count=tonumber(tostring(singleArray.param_2))
local flag
local removeIndex
local change
for i,v in ipairs(kfBag)do
if v[1]==itemId then
v[2]=count
flag=true
change=true
if count<=0 then
removeIndex=i
end
break
end
end
if removeIndex then
table.remove(kfBag,removeIndex)
end
if not flag then
if not moneylistLookUp[itemId]and count>0 then
table.insert(kfBag,{itemId,count})
change=true
end
end
return change
end

function xianmengModel:kufangBagChanged(singleArray)
local change=xianmengModel:putInkufangBag(singleArray)
if change then
UIManager:invokeUIMethod('UIXMKuCunWin','initScrollView')
UIManager:invokeUIMethod('UIXMCK_ZH_FP_Win','initScrollView')
end
end

function xianmengModel:getkufangBag()
if not kfBag then
kfBag={}
end
return kfBag
end

function xianmengModel:setkfZHFPData_FPData(data)
if not kfZHFPData then
kfZHFPData={}
end
if not kfZHFPData.FPData then
kfZHFPData.FPData={}
end
if data then
for i,v in ipairs(data)do
kfZHFPData.FPData[v.param_1]=v.param_2
end
else
kfZHFPData.FPData={}
end
end

function xianmengModel:setkfZHFPData_FSTFData(data)
if not kfZHFPData then
kfZHFPData={}
end
kfZHFPData.FSTFData=data or{}
end

function xianmengModel:getkfZHFPData_FSTFData()
return kfZHFPData.FSTFData
end

function xianmengModel:chexkFSTIsFinsh(actorId)
if not kfZHFPData then
kfZHFPData={}
end
for i,v in ipairs(kfZHFPData.FSTFData or{})do
if actorId==v then
return true
end
end
return false
end



function xianmengModel:getkfZHFPData_FPCnt(itemId)
if not kfZHFPData then
kfZHFPData={}
end
if not kfZHFPData.FPData then
kfZHFPData.FPData={}
end
return kfZHFPData.FPData[itemId]or 0
end

function xianmengModel:setkfZHFPData_FPCnt(itemId,cnt)
if not kfZHFPData then
kfZHFPData={}
end
if not kfZHFPData.FPData then
kfZHFPData.FPData={}
end
kfZHFPData.FPData[itemId]=cnt
end





