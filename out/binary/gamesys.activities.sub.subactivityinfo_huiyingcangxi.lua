









local subActivityInfo_huiyingcangxi={name='huiyingcangxi'}



function subActivityInfo_huiyingcangxi:onInit()

end

function subActivityInfo_huiyingcangxi:onStart()

end

function subActivityInfo_huiyingcangxi:onUpdate()

end

function subActivityInfo_huiyingcangxi:onDelete()

end

function subActivityInfo_huiyingcangxi:getMuralExpLoreBaseConfig(mural_idx)
local data=self.data
if data then
mural_idx=mural_idx or data.mural_idx or 1
else
mural_idx=mural_idx or 1
end
if mural_idx==0 then
mural_idx=1
end
local sub_actcfg=self:getSubActConfig()
local id=sub_actcfg.muralList[mural_idx]
return cfgHelper.get1(cfg_muralexploreconfig_get,id)
end

function subActivityInfo_huiyingcangxi:getMuralFixBaseConfig()
local sub_actcfg=self:getSubActConfig()
return cfgHelper.get1(cfg_muralfixconfig_get,sub_actcfg.fixId)
end

function subActivityInfo_huiyingcangxi:getActTuiTuConfig()
local data=self:getData()

end


function subActivityInfo_huiyingcangxi:getHuiYingCangXi_HuiGuRc()
local huiGuRecord={}
local huiGuRc=userActorSetting.get("huiyingcangxi_HuiGuRc",{})
huiGuRecord.start_time=huiGuRc.start_time
huiGuRecord.muralList={}
if huiGuRc.muralList and next(huiGuRc.muralList)then
for i,v in ipairs(huiGuRc.muralList)do
huiGuRecord.muralList[v.muralIdx]=v.progress
end
end
return huiGuRecord
end

function subActivityInfo_huiyingcangxi:setHuiYingCangXi_HuiGuRc(HuiGuRecord)
local huiGuRc={}
huiGuRc.start_time=self.start_time
huiGuRc.muralList={}
if HuiGuRecord.muralList and next(HuiGuRecord.muralList)then
for muralIdx,progress in pairs(HuiGuRecord.muralList)do
table.insert(huiGuRc.muralList,{muralIdx=muralIdx,progress=progress})
end
end
userActorSetting.set("huiyingcangxi_HuiGuRc",huiGuRc)
userActorSetting.flush()
end


function subActivityInfo_huiyingcangxi:checkCurScreenIsOpen(selectMuralIdx)
local data=self:getData()
local sub_actcfg=self:getSubActConfig()
local isOpen=self:checkCurScreenIsOpen_Flag(sub_actcfg,data,selectMuralIdx)
return isOpen
end


function subActivityInfo_huiyingcangxi:checkCurScreenIsOpen_Flag(sub_actcfg,data,selectMuralIdx)
local ConditionDay=sub_actcfg.openCDN[selectMuralIdx]
local today=self:getStart2NowDay()

local dayOpen=not ConditionDay or today>=ConditionDay


local lastScreenCompleted=self:checkScreenAllCompleted(selectMuralIdx-1)
return dayOpen and lastScreenCompleted
end


function subActivityInfo_huiyingcangxi:checkScreenAllCompleted(selectMuralIdx)
if not selectMuralIdx or selectMuralIdx<1 then
return true
end
local data=self:getData()
local baseCfg=self:getMuralExpLoreBaseConfig(selectMuralIdx)
local AllCompleted=data.mural_idx>selectMuralIdx or(data.mural_idx==selectMuralIdx and data.progress==#baseCfg.eventList)
return AllCompleted
end


function subActivityInfo_huiyingcangxi:checkAllFixReddot()
local data=self:getData()
local baseCfg=self:getMuralFixBaseConfig()
local isFixCompleted=self:checkFixCompleted()
if isFixCompleted then
return false
end

for fixIdx,v in ipairs(baseCfg.fixConfig)do
if not data.fixListLookup[fixIdx]then
local flag=true
for ii,vv in ipairs(v[1])do
local itemid=vv[1]
local itemnum=vv[2]
local hasnum
if itemsConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
else
hasnum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if hasnum<itemnum then
flag=false
break
end
end
if flag then
return true
end
end
end
return false
end


function subActivityInfo_huiyingcangxi:getFixCostLookup()
local data=self:getData()
local isFixCompleted=self:checkFixCompleted()
if isFixCompleted then
return{}
end
local baseCfg=self:getMuralFixBaseConfig()
if not data.fixCostLookup then
local fixCostLookup={}
for fixIdx,v in ipairs(baseCfg.fixConfig)do
for ii,vv in ipairs(v[1])do
local itemid=vv[1]
fixCostLookup[itemid]=itemid
end
end
data.fixCostLookup=fixCostLookup
end
return data.fixCostLookup
end


function subActivityInfo_huiyingcangxi:checkFixCompleted()
local data=self:getData()
local baseCfg=self:getMuralFixBaseConfig()
local isCompleted=data.fix_list_len==#baseCfg.fixConfig
return isCompleted
end


function subActivityInfo_huiyingcangxi:checkCurScreenReddot(sub_actcfg,data,selectMuralIdx)
local isOpen=self:checkCurScreenIsOpen_Flag(sub_actcfg,data,selectMuralIdx)
if isOpen then
local AllCompleted=self:checkScreenAllCompleted(selectMuralIdx)
if not AllCompleted then
return true
end
local isFixRed=self:checkAllFixReddot()
if isFixRed then
return true
end
end
return false
end


function subActivityInfo_huiyingcangxi:checkAllScreenReddot()
local data=self:getData()
local sub_actcfg=self:getSubActConfig()
local len=#sub_actcfg.muralList
for i=1,len do
local flag=self:checkCurScreenReddot(sub_actcfg,data,i)
if flag then
return flag
end
end
return false
end


function subActivityInfo_huiyingcangxi:checkLeftScreenReddot(sub_actcfg,data,selectMuralIdx)
if selectMuralIdx<=1 then
return false
end
for i=1,selectMuralIdx-1 do
local flag=self:checkCurScreenReddot(sub_actcfg,data,i)
if flag then
return flag
end
end
return false
end


function subActivityInfo_huiyingcangxi:checkRightScreenReddot(sub_actcfg,data,selectMuralIdx)
if selectMuralIdx>=#sub_actcfg.muralList then
return false
end
for i=selectMuralIdx+1,#sub_actcfg.muralList do
local flag=self:checkCurScreenReddot(sub_actcfg,data,i)
if flag then
return flag
end
end
return false
end



function subActivityInfo_huiyingcangxi:isAllCompleted()
local sub_actcfg=self:getSubActConfig()
return self:checkScreenAllCompleted(#sub_actcfg.muralList)
end


function subActivityInfo_huiyingcangxi:checkProgressIsReceive()
local data=self:getData()
if data.reward_flag~=1 then
local sub_actcfg=self:getSubActConfig()
local curExp=0
for i,v in ipairs(sub_actcfg.muralList)do
if data.mural_idx>=i then
local baseCfg=self:getMuralExpLoreBaseConfig(i)
local progress=0
if data.mural_idx>i then
progress=#baseCfg.eventList
elseif data.mural_idx==i then
progress=data.progress
end
for ii,vv in ipairs(baseCfg.eventList)do
if progress>=ii then
curExp=curExp+vv[4]
end
end
end
end
if data.fix_list_len>0 then
local fixBaseCfg=self:getMuralFixBaseConfig()
for i,v in ipairs(data.fix_list)do
local val=fixBaseCfg.fixConfig[v][3]or 0
curExp=curExp+val
end
end
local isReceive=curExp>=sub_actcfg.gressMax
return isReceive
end
return false
end

function subActivityInfo_huiyingcangxi:checkReddot()
local data=self.data
if data then
if data.reward_flag==0 then
local sub_actcfg=self:getSubActConfig()
local curProgress=data.progress
if curProgress==#sub_actcfg.muralList then
return true
end
end
if self:checkAllScreenReddot()then
return true
end
if self:checkProgressIsReceive()then
return true
end
end
return false
end

return subActivityInfo_huiyingcangxi