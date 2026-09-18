









function wanBaoXunBaoDuiModel:setCatData(cat_num,catList)
self.cat_num=cat_num
self.originalCatData=catList

if self.cat_num>0 then
for k,v in pairs(catList)do
self.employeeLookUp[tostring(v.guid)]=v
end
end

self:collecteMaomaoEquipedData()

for k,catinfo in pairs(self.employeeLookUp)do
self:updateEmployee(catinfo)
end
end





function wanBaoXunBaoDuiModel:getCatData(guid)
guid=tostring(guid or'')
return self.employeeLookUp[guid]
end





function wanBaoXunBaoDuiModel:changeEmployeeData(num,datalist)
local lvChange={}
local isRestoreTili=false

if num>1 and datalist[1].type==1 then
self.uplevelCatList={}
end

if num>0 then
for k,v in pairs(datalist)do
local sguid=tostring(v.guid)
local catInfo=self.employeeLookUp[sguid]

if v.type==1 then
local temp={}

temp.oldCatData=table.weakCopy(catInfo)

local olv=catInfo.lv

catInfo.lv=v.param1
catInfo.exp=v.param2

if olv~=v.param1 then
table.insert(lvChange,sguid)

temp.newCatData=catInfo
table.insert(self.uplevelCatList,temp)

wanBaoXunBaoDuiModel:updataCatAttrList(catInfo,olv,v.param1)
end
elseif v.type==2 then

catInfo.tili=v.param1
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_SelectEmployeeWin","freshRecoverCatTili",catInfo)
isRestoreTili=true
notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiCatTiLiChange,catInfo.guid)
elseif v.type==3 then

catInfo.state=v.param1
end
end
end


UIManager:invokeUIMethod("UIWanBaoXunBaoDui_EmployeeWin","freshEmployee")

if self.restoreTiliIndexList~=nil and isRestoreTili then
local list=table.weakCopy(self.restoreTiliIndexList)
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MTSceneWin","playRestoreTili",list)
self.restoreTiliIndexList=nil
end

if#lvChange>0 then
notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiCatLevelChange,lvChange)
end

wanBaoXunBaoDuiController:doProcessByEmployeeList(datalist)
end





function wanBaoXunBaoDuiModel:setUpRandomAttr(num,upList)
if not self.startShowResult then
self.uplevelCatList={}
end

local lvChange={}
local isShowUplvWin=false

for i=1,num do
local data=upList[i]
local catguid=tostring(data.guid)
local catInfo=self.employeeLookUp[catguid]

isShowUplvWin=catInfo.lv~=data.lv or isShowUplvWin

if catInfo.lv~=data.lv then
local temp={}

temp.oldCatData=table.deepCopy(catInfo)
temp.newCatData=catInfo

table.insert(lvChange,catInfo.guid)
table.insert(self.uplevelCatList,temp)
end

wanBaoXunBaoDuiModel:updataCatAttrList(catInfo,catInfo.lv,data.lv)

catInfo.lv=data.lv
catInfo.exp=data.exp

for k=1,data.num do
local randProp=data.randPropList[k]
local type=randProp.param_1
local value=randProp.param_2

if catInfo.propList[type]~=nil then
catInfo.propList[type]=catInfo.propList[type]+value
end
end
end

if not isShowUplvWin then
UIManager:invokeUIMethod('UIWanBaoXunBaoDui_EmployeeWin','initUI')
else
local data=upList[1]
local catguid=tostring(data.guid)
local catInfo=self.employeeLookUp[catguid]
UIManager:invokeUIMethod('UIWanBaoXunBaoDui_EmployeeWin','refreshEmployeeUp',catInfo)
if self.uplevelCatList and#self.uplevelCatList>0 and(not self.startShowResult)and(not wanBaoXunBaoDuiController:getXZSReceiveFlag())then
UIFullWanBaoXunBaoDuiController:showWindow('UIWanBaoXunBaoDui_EmployeeUpWin',self.uplevelCatList)
end
end

if#lvChange>0 then
notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiCatLevelChange,lvChange)
end
end






function wanBaoXunBaoDuiModel:updataCatAttrList(data,oldlv,newlv)
local oldlevelCfg=cfgHelper.get1(cfg_catlvconfig_get,oldlv)
local curlevelCfg=cfgHelper.get1(cfg_catlvconfig_get,newlv)


local oldProp=oldlevelCfg.prop[data.wx_id]or{}
local curProp=curlevelCfg.prop[data.wx_id]or{}

for index=1,5 do
local ov=oldProp[index]or 0
local cv=curProp[index]or 0
local dvalue=cv-ov
data.propList[index]=data.propList[index]+dvalue
end
end





function wanBaoXunBaoDuiModel:dismissEmoployeeList(guid)

self.employeeLookUp[tostring(guid)]=nil
UIManager.info('辞退成功')













UIManager:invokeUIMethod("UIWanBaoXunBaoDui_EmployeeWin","initUI")
notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiCatLevelChange,{guid})
end






function wanBaoXunBaoDuiModel:changeEmoployeeEquip(cguid,pos,equip_guid)
local catInfo=self.employeeLookUp[tostring(cguid)]

if pos==0 then
if catInfo.equip_num==0 then

catInfo.equipList=catInfo.equipList or{}
local equip=wanbaoXunBaoDuiHelper.getWBXBDItem(equip_guid)
table.insert(catInfo.equipList,equip)
catInfo.equip_num=catInfo.equip_num+1
wanBaoXunBaoDuiModel:additionalEquipAttr(1,equip,catInfo)
else

local oldEquipItemData=catInfo.equipList[1]
wanBaoXunBaoDuiModel:additionalEquipAttr(-1,oldEquipItemData,catInfo)

catInfo.equipList={}

local equip=wanbaoXunBaoDuiHelper.getWBXBDItem(equip_guid)
table.insert(catInfo.equipList,equip)
wanBaoXunBaoDuiModel:additionalEquipAttr(1,equip,catInfo)
end
else

local equipItemData=table.remove(catInfo.equipList,pos)
wanBaoXunBaoDuiModel:additionalEquipAttr(-1,equipItemData,catInfo)
catInfo.equip_num=catInfo.equip_num-1
end

wanBaoXunBaoDuiModel:collecteMaomaoEquipedData()

UIManager:invokeUIMethod("UIWanBaoXunBaoDui_EmployeeWin","freshEmployeeDressEquip",catInfo)
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_SelectEquipWin","initUI")

end




function wanBaoXunBaoDuiModel:addEmployee(catInfo)
self.employeeLookUp[tostring(catInfo.guid)]=catInfo
self:updateEmployee(catInfo)
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_EmployeeWin","initUI")
UIManager:showWindow('UIWanBaoXunBaoDui_RecruitmentWin',{type=WBXBD_ReCruitment_TYPE.recruit,catdata={catInfo},statelist={1}})
notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiCatLevelChange,{catInfo.guid})
end




function wanBaoXunBaoDuiModel:addEmployeeList(catList)
local statelist={}
local guidList={}
for k,v in ipairs(catList)do
self.employeeLookUp[tostring(v.guid)]=v
self:updateEmployee(v)
table.insert(statelist,1)
table.insert(guidList,v.guid)
end
UIManager:showWindow('UIWanBaoXunBaoDui_RecruitmentWin',{type=WBXBD_ReCruitment_TYPE.recruit,catdata=catList,statelist=statelist})
notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiCatLevelChange,guidList)
end





function wanBaoXunBaoDuiModel:caculationMaxTili(data)
local lvcfg=cfgHelper.get(cfg_catlvconfig_get,data.lv)
local colorcfg=cfgHelper.get(cfg_catcolorconfig_get,data.color)
local maxTili=colorcfg.tiliMax+lvcfg.upTili
return maxTili
end





function wanBaoXunBaoDuiModel:sortEmployeeDatas(employeeList)
table.sort(employeeList,function(a,b)
if a.color==b.color then
if a.lv==b.lv then
return a.guid>b.guid
else
return a.lv>b.lv
end
else
return a.color>b.color
end
end)
return employeeList
end




function wanBaoXunBaoDuiModel:getEmployeeList()
local temp={}
for k,v in pairs(self.employeeLookUp)do
temp[#temp+1]=v
end
return self:sortEmployeeDatas(temp)
end




function wanBaoXunBaoDuiModel:getSelectEmployeeDatas()
local temp={}
for k,v in pairs(self.employeeLookUp)do
if self.workingEmployees[v.guid]==nil then
temp[#temp+1]=v
end
end
return self:sortEmployeeDatas(temp)
end




function wanBaoXunBaoDuiModel:getEmployMaxNumber()
local constDef=wanBaoXunBaoDuiModel:getConstDef()
return constDef.catMaxNum
end




function wanBaoXunBaoDuiModel:isFullEmployee()
local maxNum=wanBaoXunBaoDuiModel:getEmployMaxNumber()
local employeeDatas=wanBaoXunBaoDuiModel:getEmployeeList()
return maxNum>#employeeDatas
end






local orderChange={1,2,4,5,3}
function wanBaoXunBaoDuiModel:getEmployeePloygonData(data,maxValue)
maxValue=Mathf.Max(1,maxValue)
local temp={}

for k,v in pairs(orderChange)do
temp[k]=data.propList[v]/maxValue
end
return temp
end





function wanBaoXunBaoDuiModel:getSelectEmployeeBaseAttrData(data)
local temp={}
local names=self:getPropNameList()
for k,v in pairs(orderChange)do
local t={}

t.name=names[v]
t.value=data and data.propList[v]or 0

temp[k]=t
end
return temp
end




function wanBaoXunBaoDuiModel:setUpdateEmoployeeTiliTimer(tili_start_time)
self.tili_start_time=tili_start_time

if self.tili_Update_Timer then
self.tili_Update_Timer:cancel()
self.tili_Update_Timer=nil
end

if tili_start_time>0 then
local const_def=self:getConstDef()
local updateInterver=const_def.recover_time
local servertime=timeHelper.getServerShortTime()

self.tili_Update_Timer=timer.new()

local func=function()
wanBaoXunBaoDuiController:reqUpdateEmployeeTili()
end
self.tili_Update_Timer:start(updateInterver,func,1)
end
end





function wanBaoXunBaoDuiModel:changeEmployeeTili(start_time,add_tili)

for k,v in pairs(self.employeeLookUp)do
local maxTili=self:caculationMaxTili(v)
v.tili=math.min(v.tili+add_tili,maxTili)
end

self:setUpdateEmoployeeTiliTimer(start_time)
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_EmployeeWin","initUI")
end









function wanBaoXunBaoDuiModel:setRecruitInfo(lv,start_time,num,catList)
self.recruitInfo={}

self.recruitInfo.lv=lv
self.recruitInfo.start_time=start_time
self.recruitInfo.num=num
self.recruitInfo.catList=catList or{}

UIManager:invokeUIMethod("UIWanBaoXunBaoDui_RecruitWin","initUI")

if self.recruitInfo.start_time>0 then

local recruitCfg=cfgHelper.get1(cfg_catconfig_get,lv)
local servertime=timeHelper.getServerShortTime()
local needtime=recruitCfg.needTime-(servertime-start_time)

if self.recruitTimer then
self.recruitTimer:cancel()
self.recruitTimer=nil
end

local func=function()
wanBaoXunBaoDuiController:reqOneRecruiter()
end
self.recruitTimer=timer.new()
self.recruitTimer:start(needtime,func,1)
end
end





function wanBaoXunBaoDuiModel:changeRecruitInfoToTime(lv,start_time)

if not self.recruitInfo then
self.recruitInfo={}
end

self.recruitInfo.lv=lv
self.recruitInfo.start_time=start_time






















wanBaoXunBaoDuiController:reqOneRecruiter()
end





function wanBaoXunBaoDuiModel:changeRecruitInfoToSaveInfo(catInfo,start_time)

if not self.recruitInfo then
self.recruitInfo={}
end

local recruitCfg=cfgHelper.get1(cfg_catconfig_get,self.recruitInfo.lv)

self.recruitInfo.start_time=start_time
table.insert(self.recruitInfo.catList,catInfo)





notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiCatComeInterview,catInfo,#self.recruitInfo.catList)

local servertime=timeHelper.getServerShortTime()
local needtime=recruitCfg.needTime-(servertime-start_time)

if self.recruitTimer then
self.recruitTimer:cancel()
self.recruitTimer=nil
end

if self.recruitInfo.start_time>0 then

local func=function()
wanBaoXunBaoDuiController:reqOneRecruiter()
end
self.recruitTimer=timer.new()
self.recruitTimer:start(needtime,func,1)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWanBaoXunBaoDuiRecruit)
end





function wanBaoXunBaoDuiModel:changeRecruitInfoDelInfo(catInfo,start_time)
if not self.recruitInfo then
self.recruitInfo={}
end
self.recruitInfo.start_time=start_time
table.insert(self.recruitInfo.catList,catInfo)
end



function wanBaoXunBaoDuiModel:dealStopRecruitInfo()
if self.recruitInfo then
self.recruitInfo.start_time=0
end

UIManager:invokeUIMethod("UIWanBaoXunBaoDui_RecruitWin","initUI")
end





function wanBaoXunBaoDuiModel:dealRecruitInfo(index,type)
local catGuids={}
if type==1 then

local delindex=nil
for k,v in pairs(self.recruitInfo.catList)do
if k==index then
local tili=self:caculationMaxTili(v)

v.tili=tili
wanBaoXunBaoDuiModel:updateEmployee(v)

self.employeeLookUp[tostring(v.guid)]=v

delindex=k
table.insert(catGuids,v.guid)
end
end
table.remove(self.recruitInfo.catList,delindex)
elseif type==2 then

local delindex=nil
for k,v in pairs(self.recruitInfo.catList)do
if k==index then
delindex=k
end
end
table.remove(self.recruitInfo.catList,delindex)
end






reddotControl.on_change_catch_type(CATCH_TYPE.eWanBaoXunBaoDuiRecruit)

notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiDealCatInterView,index,type)

if#catGuids>0 then
notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiCatLevelChange,catGuids)
end
end




function wanBaoXunBaoDuiModel:getRecruitDatas()
local temp=self.recruitInfo and self.recruitInfo.catList or{}
local deepTemp=table.deepCopy(temp)

for k,catinfo in pairs(deepTemp)do
wanBaoXunBaoDuiModel:updateEmployee(catinfo)
end
return deepTemp
end




function wanBaoXunBaoDuiModel:getRecruitLv()
return self.recruitInfo.lv>0 and self.recruitInfo.lv or wanBaoXunBaoDuiModel:getLocalRecruitLv()
end




function wanBaoXunBaoDuiModel:getLocalRecruitLv()
return userActorSetting.get('WBXBD_Recruit_Lv',1)
end




function wanBaoXunBaoDuiModel:setLocalRecruitLv(lv)
userActorSetting.set('WBXBD_Recruit_Lv',lv)
userActorSetting.flush()
end




function wanBaoXunBaoDuiModel:getRecruitState()
return self.recruitInfo.start_time>0
end




function wanBaoXunBaoDuiModel:getRecruitLeftTime()

local servertime=timeHelper.getServerShortTime()
local recruitcfg=cfgHelper.get(cfg_catconfig_get,self.recruitInfo.lv)

return recruitcfg.needTime-(servertime-self.recruitInfo.start_time)
end





function wanBaoXunBaoDuiModel:getRealRecruitIndex(guid)
local index
for k,v in pairs(self.recruitInfo.catList)do
if v.guid==guid then
index=k
break
end
end
return index
end





function wanBaoXunBaoDuiModel:caculationEmployeeLevelCatCount(level)
level=level or-1
local cnt=0
for i,v in pairs(self.employeeLookUp)do
if v.lv>=level then
cnt=cnt+1
end
end
return cnt
end





function wanBaoXunBaoDuiModel:getSelectEmployeeData(channelData)
local employeeList=wanBaoXunBaoDuiModel:getSelectEmployeeDatas()

local needTx=cfgHelper.get2(cfg_catmapconfig_get,channelData.task_Id,'needTx')
local tili=cfgHelper.get2(cfg_catmapconfig_get,channelData.task_Id,'tili')

local txConditionListLookUp={}
local catlist=table.weakCopy(employeeList)

for k,v in pairs(needTx)do
txConditionListLookUp[v]=true
end

for k,catData in pairs(catlist)do

catData.sortWeigetHight=(catData.color+catData.lv)
if not bitHelper.check_pos(catData.state,0)then

catData.sortWeigetHight=catData.sortWeigetHight*100

for _,attr in pairs(catData.propList)do
catData.sortWeigetHight=catData.sortWeigetHight+attr
end

if catData.tili>=tili then
catData.sortWeigetHight=catData.sortWeigetHight*10000
end

if catData.texing_num>0 then
for _,txid in pairs(catData.txList)do
if txConditionListLookUp[txid]~=nil then
catData.sortWeigetHight=catData.sortWeigetHight*10
if catData.tili>=tili then
catData.tuijian=true
end
end
end
end
end
end

table.sort(catlist,function(catA,catB)
if catA.sortWeigetHight==catB.sortWeigetHight then
return catA.tili>catB.tili
else
return catA.sortWeigetHight>catB.sortWeigetHight
end
end)

return catlist
end




function wanBaoXunBaoDuiModel:updateEmployee(catinfo)


local propAdd=cfgHelper.get2(cfg_catshowconfig_get,catinfo.wx_id,'propAdd')
if propAdd then
for index=1,5 do

local value=propAdd[index]

catinfo.propList[index]=catinfo.propList[index]+value
catinfo.propList[index]=Mathf.Max(0,catinfo.propList[index])
end
end

if catinfo.lv>1 then
local lvCfg=cfgHelper.get1(cfg_catlvconfig_get,catinfo.lv)

if lvCfg.prop~=nil then
local addProp=lvCfg.prop[catinfo.wx_id]or{}
for index=1,5 do
catinfo.propList[index]=catinfo.propList[index]+(addProp[index]or 0)
end
end
end


if catinfo.rand_prop_num and catinfo.rand_prop_num>0 then
for pid,pvalue in pairs(catinfo.randPropList)do
catinfo.propList[pid]=catinfo.propList[pid]+pvalue
end
end


if catinfo.texing_num>0 then
catinfo.sortTxSpe={}
for index,txid in pairs(catinfo.txList)do
local txCfg=cfgHelper.get1(cfg_cattxconfig_get,txid)
local prop=txCfg.prop

if prop~=nil then
for pindex,pdata in pairs(prop)do

local pid=pdata[1]
local pvalue=pdata[2]

catinfo.propList[pid]=catinfo.propList[pid]+pvalue
end
end


if txCfg.spe~=nil then
for sindex,sdata in pairs(txCfg.spe)do

local sid=sdata[1]

if catinfo.sortTxSpe[sid]==nil then
catinfo.sortTxSpe[sid]={}
end
table.insert(catinfo.sortTxSpe[sid],sdata)
end
end

end
end


if catinfo.equip_num>0 then
for index=1,catinfo.equip_num do

local equipData=catinfo.equipList[index]

wanBaoXunBaoDuiModel:additionalEquipAttr(1,equipData,catinfo)
end
end
end





function wanBaoXunBaoDuiModel:caculateEquipAttr(equip_item_data)
local itemID=equip_item_data.itemid
local itemCfg=itemsConfig.getConfig(itemID)
local staticAttr=itemCfg.static
local attrId=staticAttr[1]
local attrBaseValue=staticAttr[2]
local upProp=cfgHelper.get2(cfg_catequipjlconfig_get,attrId,'upProp')
local itemData=equip_item_data.itemData
local equipLv=itemData.jl_lv
local upValue=upProp[equipLv]or 0
local value=attrBaseValue+upValue
return attrId,value
end


function wanBaoXunBaoDuiModel:additionalEquipAttr(option_flag,equip_item_data,cat_info)
local equipAttrID,equipAttrValue=wanBaoXunBaoDuiModel:caculateEquipAttr(equip_item_data)

cat_info.propList[equipAttrID]=cat_info.propList[equipAttrID]+option_flag*equipAttrValue
end







function wanBaoXunBaoDuiModel:updateEmployeeAttrToEquip(cat_info,equip_item_data,oldLv,newLv)
local itemID=equip_item_data.itemid
local itemCfg=itemsConfig.getConfig(itemID)
local staticAttr=itemCfg.static
local attrId=staticAttr[1]
local upProp=cfgHelper.get2(cfg_catequipjlconfig_get,attrId,'upProp')
local oldVal=upProp[oldLv]or 0
local newVal=upProp[newLv]or 0

cat_info.propList[attrId]=cat_info.propList[attrId]+(newVal-oldVal)
end





function wanBaoXunBaoDuiModel:isWorking(guid)
return self.workingEmployees[guid]~=nil
end




function wanBaoXunBaoDuiModel:getMaxUpLevel()
local catLvCfg=cfg_catlvconfig()
return#catLvCfg
end





function wanBaoXunBaoDuiModel:getCatCurTili(guid)
local catData=self:getCatData(guid)
return catData.tili
end






function wanBaoXunBaoDuiModel:getEntrustCatInfo(wtSlotData,guid)
local wtType=wtSlotData.data.entrustType
local ex_reward_config=cfgHelper.get2(cfg_catentrusttypeconfig_get,wtType,'ex_reward_config')

local funcs=catEntrustConfig.getEntrustFuncObj(wtType)
local infos={}

local catData=self:getCatData(guid)

local attrid=ex_reward_config[1]

local attrNameList=wanBaoXunBaoDuiModel:getPropNameList()


local val=catData.propList[attrid]
local tinfo=FMT.fmt("{0}：{1}",attrNameList[attrid],val)
infos[#infos+1]=tinfo


local upRate=funcs.getCatEntrustRewardUpRate(wtSlotData,guid)
local isHasUpRate=upRate>0
if isHasUpRate then
local addInfo=funcs.getRewardInfo(upRate,wtSlotData.data)
infos[#infos+1]=addInfo
else
local info=FMT.fmt("{0}达到{1}以上可提升收益",attrNameList[attrid],ex_reward_config[2])
infos[#infos+1]=info
end

return infos,isHasUpRate
end





function wanBaoXunBaoDuiModel:getCatTotalAttrVal(guid)
local catData=self:getCatData(guid)

local total=0
if catData.propList then
for k,val in ipairs(catData.propList)do
total=total+val
end
end

return total
end






function wanBaoXunBaoDuiModel:getCatSortListBySingleAttr(attrid,selectCatGuid)
selectCatGuid=selectCatGuid or 0



local catlist=wanBaoXunBaoDuiModel:getEmployeeList()

local temp={}

for k,catData in pairs(catlist)do
if not catEntrustModel:isWorking(catData.guid)or(catData.guid==selectCatGuid)then
temp[#temp+1]=catData
end
end

table.sort(temp,function(catA,catB)
local catA_Attr=catA.propList[attrid]
local catB_Attr=catB.propList[attrid]

if catA_Attr==catB_Attr then
return catA.guid>catB.guid
else
return catA_Attr>catB_Attr
end
end)

return temp
end
