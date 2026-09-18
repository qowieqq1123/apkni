






local _MODULENAME="playerImageModel"


def_table(_MODULENAME)
playerImageModel.name=_MODULENAME
playerImageModel.data={}


function playerImageModel:onAppStart()
playerImageModel:dealAllSuitLookup()
end


function playerImageModel:onEnterState(isReconnect)
self.data={}
self.data.unlockList={}
self.data.unlockLookup={}
self.data.piTimeList={}

self.data.piList=nil

self.data.cnt=0

if not isReconnect then

self.data.newImage={}

self.data.locallist={}
end
self.partlookup=nil
end


function playerImageModel:onLeaveState(isReconnect)
if self.timeLimitedTimer then
self.timeLimitedTimer:cancel()
self.timeLimitedTimer=nil
end

self.data={}
self.data.unlockList={}
self.data.unlockLookup={}
self.data.piTimeList={}

self.data.piList=nil

self.data.cnt=0

if not isReconnect then

self.data.newImage={}

self.data.locallist={}
end
end

function playerImageModel:onProtocolReq(isReconnect)
if not isReconnect then
playerImageModel:readLocal()
end
end

function playerImageModel:onInit(args)
local s_unlocklistlen=args[1]
local s_unlockList=args[2]
local s_pilistlen=args[3]
local s_piList=args[4]
local s_cnt=args[5]
local s_pitimelistlen=args[6]
local s_piTimeList=args[7]
local s_pisuitlistlen=args[8]
local s_piSuitList=args[9]


local data=self.data

data.unlockList={}
data.unlockLookup={}
data.piTimeList={}
data.piSuitList={}

local unlockList=data.unlockList
local unlockLookup=data.unlockLookup
local piTimeList=data.piTimeList
local piSuitList=data.piSuitList

if s_pisuitlistlen>0 then
for i,v in ipairs(s_piSuitList)do
piSuitList[v]=true
end
end

if s_unlocklistlen>0 then
for i=1,s_unlocklistlen do
local typo=i
local s_unlockInfo=s_unlockList[i]
local s_list=s_unlockInfo.list
local s_len=s_unlockInfo.len
if s_len>0 then
if unlockList[i]==nil then unlockList[i]={}end
if unlockLookup[i]==nil then unlockLookup[i]={}end

local list=unlockList[i]
local lookup=unlockLookup[i]

for ii,v in ipairs(s_list)do
for j=1,32 do
local id=j+(ii-1)*32
local flag=mathHelper.getBitValue(v,j-1)
if flag then
list[#list+1]=id
lookup[id]=true
end
end
end
end
end
end


local sex=playerModel:getActorSex()
for _,tabid in pairs(PLAYER_IMAGE_TYPE)do
local cfgs=playerImageConfig.getAllSubConfig(sex,tabid)
for _,vv in ipairs(cfgs)do
if vv.cost==nil then
local id=vv.id
if unlockList[tabid]==nil then unlockList[tabid]={}end
if unlockLookup[tabid]==nil then unlockLookup[tabid]={}end

local list=unlockList[tabid]
local lookup=unlockLookup[tabid]
if not lookup[id]then
lookup[id]=true
list[#list+1]=id
end
end
end
end

data.piList=s_piList
if s_pilistlen>0 then
local piList=data.piList
for _,v in pairs(PLAYER_IMAGE_TYPE)do
if data.piList==nil then
data.piList={}
piList=data.piList
end
if piList[v]==nil then
piList[v]=playerImageConfig.getDefaultImage(v,sex)
end
end
data.piList=piList
end

local max=playerImageConfig.getPlayerImageFreeCnt()
if s_cnt>max then s_cnt=max end
data.cnt=s_cnt

if s_pitimelistlen>0 then
local stamp=timeHelper.getServerShortTime()
local flag=false
local flag2=false
local piList=table.weakCopy(data.piList)
local piSulist={}
for i=1,s_pitimelistlen do
local piSub=s_piTimeList[i]
local tabid=piSub.pitype
if piTimeList[tabid]==nil then piTimeList[tabid]={}end
for ii,vv in pairs(piSub.list)do
local id=vv.param_1

if unlockList[tabid]==nil then unlockList[tabid]={}end
if unlockLookup[tabid]==nil then unlockLookup[tabid]={}end
local list=unlockList[tabid]
local lookup=unlockLookup[tabid]

if vv.param_2>stamp then

piTimeList[tabid][id]=vv.param_2
else

if lookup[id]then
lookup[id]=nil
table.removeValue(list,id)
flag2=true
end

if piList[tabid]==id then

piList[tabid]=playerImageConfig.getDefaultImage(tabid,sex)
flag=true
end

local suitId=playerImageModel:getSuitId(tabid,id)
if suitId then
piSulist[suitId]=true
end
end
end
end
if flag then
playerImageController:reqSetPlayerImage(piList,true)
elseif flag2 then
UIManager:callWindowFunc('UIPlayerChangeImageWin','changeNewModel')
UIManager:callWindowFunc('UIPlayerChangeImageWin','freshInfo')
end
if next(piSulist)then
for k,v in pairs(piSulist)do
if playerImageModel:checkSuitAttrActive(k)then
playerImageController:reqSuitAttrOverTime(k)
end
end
end
playerImageModel:resetTimeLimitedTimer()
end
end

function playerImageModel:resetTimeLimitedTimer()
local sex=playerModel:getActorSex()

local func=function()
local data=playerImageModel.data
local unlockList=data.unlockList
local unlockLookup=data.unlockLookup
local piTimeList=data.piTimeList

local hasPiTime=false
local endTimeList={}
local curStamp=timeHelper.getServerShortTime()
for tabid,v in pairs(piTimeList)do
for id,stamp in pairs(v)do
if stamp<=curStamp then
table.insert(endTimeList,{tabid,id})
else
hasPiTime=true
end
end
end
local hasNew=false
if#endTimeList>0 then
local piList=table.weakCopy(data.piList)
for tabid,id in pairs(piList)do
local isUnlock=playerImageModel:isUnlockImage(tabid,id)

if not isUnlock then
piList[tabid]=playerImageConfig.getDefaultImage(tabid,sex)
hasNew=true
end
end
local piSulist={}
for i,v in pairs(endTimeList)do
local tabid=v[1]
local id=v[2]

if piList[tabid]==id then
piList[tabid]=playerImageConfig.getDefaultImage(tabid,sex)
hasNew=true
end

if unlockList[tabid]==nil then unlockList[tabid]={}end
if unlockLookup[tabid]==nil then unlockLookup[tabid]={}end

local list=unlockList[tabid]
local lookup=unlockLookup[tabid]


if lookup[id]then
lookup[id]=nil
table.removeValue(list,id)
end
piTimeList[tabid][id]=nil

local suitId=playerImageModel:getSuitId(tabid,id)
if suitId then
piSulist[suitId]=true
end
end

if hasNew then
playerImageController:reqSetPlayerImage(piList,true)
else
UIManager:callWindowFunc('UIPlayerChangeImageWin','changeNewModel')
UIManager:callWindowFunc('UIPlayerChangeImageWin','freshInfo')
end
if next(piSulist)then
for k,v in pairs(piSulist)do
if playerImageModel:checkSuitAttrActive(k)then
playerImageController:reqSuitAttrOverTime(k)
end
end
end
end
if not hasPiTime then
if self.timeLimitedTimer then
self.timeLimitedTimer:cancel()
self.timeLimitedTimer=nil
end
end
end
if self.timeLimitedTimer==nil then
self.timeLimitedTimer=timer.new()
self.timeLimitedTimer:start(1,func)
end
end
function playerImageModel:resetCnt()
self.data.cnt=0
end

function playerImageModel:getDefaultImage(sex)
local list={}
sex=sex or playerModel:getActorSex()
for _,v in pairs(PLAYER_IMAGE_TYPE)do
list[v]=playerImageConfig.getDefaultImage(v,sex)
end
return list
end

function playerImageModel:onUnlockImage(s_len,s_list,s_duration)
if s_len>0 then
local data=self.data

local unlockList=data.unlockList
local unlockLookup=data.unlockLookup
local piTimeList=data.piTimeList
local stamp=timeHelper.getServerShortTime()
local sex=playerModel:getActorSex()

for i,v in ipairs(s_list)do
local tabid=v.param_1
local id=v.param_2
if unlockList[tabid]==nil then unlockList[tabid]={}end
if unlockLookup[tabid]==nil then unlockLookup[tabid]={}end

local list=unlockList[tabid]
local lookup=unlockLookup[tabid]
if not lookup[id]then
list[#list+1]=id
lookup[id]=true
playerImageModel:setNewImageFlag(tabid,id,true)
else
loggerUtil.debugErrFMT('已解锁子页签{0}id={1}的形象',tabid,id)
end

if s_duration>0 then
if piTimeList[tabid]==nil then piTimeList[tabid]={}end
local old_duration=piTimeList[tabid][id]
if not old_duration or old_duration<=stamp then
old_duration=stamp
end
piTimeList[tabid][id]=old_duration+s_duration
end
end
playerImageModel:resetTimeLimitedTimer()
end
end

function playerImageModel:onSetPlayerImage(s_pilistlen,s_piList,isNotAdd)
self.data.piList=s_piList
local max=playerImageConfig.getPlayerImageFreeCnt()
if not isNotAdd then
self.data.cnt=self.data.cnt+1
end
if self.data.cnt>max then self.data.cnt=max end
end


function playerImageModel:getPlayerImage()
return table.deepCopy(self.data.piList)
end

function playerImageModel:getUseCnt()
local max=playerImageConfig.getPlayerImageFreeCnt()
return self.data.cnt or 0
end

function playerImageModel:getLeftCnt()
local max=playerImageConfig.getPlayerImageFreeCnt()
local use=playerImageModel:getUseCnt()
return max-use,use,max
end

function playerImageModel:getPiTime(tabid,id)
if self.data.piTimeList==nil or self.data.piTimeList[tabid]==nil then return 0 end
local time=self.data.piTimeList[tabid][id]or 0
return time
end


function playerImageModel:isUnlockImage(tabid,id)
if self.data.unlockLookup==nil or self.data.unlockLookup[tabid]==nil then
return false
end

if playerImageConfig.checkClientUnlock(tabid,id)then
return true
end

return self.data.unlockLookup[tabid][id]==true
end


function playerImageModel:isCanUnlockImage(tabid,id)
if playerImageModel:isUnlockImage(tabid,id)then return false end
local cost=playerImageConfig.getUnlockCost(tabid,id)
if cost==nil then return false end
for i,v in ipairs(cost)do
local itemid=v[1]
local need=v[2]
local count=itemsModel.getCount(itemid)
if need>count then
return false,{itemid,need}
end
end
return true
end

function playerImageModel:isImageEnable(tabid,id)
local piList=self.data.piList
if piList==nil then return false end
return piList[tabid]==id
end

function playerImageModel:isSupportTab(support,tabid)
if support==nil then return true end
local cfg=support[tabid]
if cfg==nil then return true end
if cfg.status then
return cfg.status==1
end
return true
end

function playerImageModel:isSupportByCfg(support,tabid,id)
if support==nil then return true end
local cfg=support[tabid]
if cfg==nil then return true end
if cfg.status then
return cfg.status==1
elseif cfg.open then
local list=cfg.open
for _,v in ipairs(list)do
if v==id then return true end
end
return false
elseif cfg.close then
local list=cfg.close
for _,v in ipairs(list)do
if v==id then return false end
end
return true
end
return true
end


function playerImageModel:isSupportImage(playerImage,tabid,id)
local list={}
for i,v in ipairs(playerImage)do
if tabid~=i then
list[i]=v
end
end


for k,v in pairs(list)do
local cfg=playerImageConfig.getSubConfig(k,v)
if cfg and not self:isSupportByCfg(cfg.support,tabid,id)then
return false,{1,k,v}
end
end
local cfg=playerImageConfig.getSubConfig(tabid,id)

for k,v in pairs(list)do
if cfg and not self:isSupportByCfg(cfg.support,k,v)then
return false,{2,k,v}
end
end

return true
end


function playerImageModel:isSupportImageTab(playerImage,tabid)

local list={}
for i,v in ipairs(playerImage)do
if tabid~=i then
list[i]=v
end
end


for k,v in pairs(list)do
local cfg=playerImageConfig.getSubConfig(k,v)
if cfg and not playerImageModel:isSupportTab(cfg.support,tabid)then
return false,k
end
end

return true
end

function playerImageModel:getSupportImage(playerImage,maintabid)

local id=playerImage[maintabid]
local imagelist={[maintabid]=id}
local mainCfg=playerImageConfig.getSubConfig(maintabid,id)
for i,v in ipairs(playerImage)do
if i~=maintabid then
if mainCfg and self:isSupportByCfg(mainCfg.support,i,v)then
imagelist[i]=v
end
end
end
return imagelist
end


function playerImageModel:isNotSupportAllTab(tabid,id)
local pageid=playerImageConfig.getPageByTabId(tabid)
local cfgs=playerImageConfig.getAllSubTabId(pageid)
local mainCfg=playerImageConfig.getSubConfig(tabid,id)
for _,v in ipairs(cfgs)do
if v~=tabid then
if mainCfg and playerImageModel:isSupportTab(mainCfg.support,v)then
return false
end
end
end
return true
end


function playerImageModel:isActiveAnyImage(itemCfg,sex)
local funcparam=itemCfg.funcparam
if funcparam and funcparam.type==item_funtion_type.playerimage then
sex=sex or playerModel:getActorSex()
for i,v in ipairs(funcparam.list[sex])do
if playerImageModel:isUnlockImage(v[1],v[2])then return true end
end
end
return false
end


function playerImageModel:isDurationImage(itemCfg)
local funcparam=itemCfg.funcparam
if funcparam and funcparam.duration then
return true
end
return false
end


function playerImageModel:setNewImageFlag(tabid,id,flag)
if self.data.newImage[tabid]==nil then self.data.newImage[tabid]={}end
local oldflag=self.data.newImage[tabid][id]or false
if oldflag==flag then return false end
self.data.newImage[tabid][id]=flag
return true
end


function playerImageModel:readImage(tabid,id)
return playerImageModel:setNewImageFlag(tabid,id,false)
end

function playerImageModel:readAllImageByTab(tabid)
if tabid==nil then return end
local sex=playerModel:getActorSex()
if not sex then return false end
local cfgs=playerImageConfig.getAllSubConfig(sex,tabid)
local ret=false
for _,v in ipairs(cfgs)do
ret=ret or self:readImage(tabid,v.id)
end
if ret then
UIManager:callWindowFunc('UIPlayerInfoWin','refreshImageReddot')
UIManager:callWindowFunc('UIMain','refreshActorHeadReddot')
end
end


function playerImageModel:isNewImage(tabid,id)
if self.data.newImage[tabid]==nil then return false end
return self.data.newImage[tabid][id]==true
end


function playerImageModel:hasAnyNewImage(tabid)
local sex=playerModel:getActorSex()
if not sex then return false end
local cfgs=playerImageConfig.getAllSubConfig(sex,tabid)
for _,v in ipairs(cfgs)do
if playerImageModel:isNewImage(tabid,v.id)then return true,v end
end
return false
end


function playerImageModel:hasAnyNewImageInPage(pageid)
local tablist=playerImageConfig.getAllSubTabId(pageid)
for i,v in ipairs(tablist)do
if playerImageModel:hasAnyNewImage(v)then return true end
end
return false
end


function playerImageModel:hasAnyNewImageTotal()
local cfgs=playerImageConfig.getAllPageCfgs()
for i,v in ipairs(cfgs)do
if playerImageModel:hasAnyNewImageInPage(v.id)then return true end
end
return false
end

function playerImageModel:checkChangeSexReddot()

local changeSexReddot=userActorSetting.get('playerImageModel_changeSex',false)
return not changeSexReddot
end






function playerImageModel:readLocal()
self.data.locallist=nil

end




































function playerImageModel:freshLocal()
userActorArraySetting.flush(ACTOR_SETTING_TYPE.ePlayerImage)
end

function playerImageModel:getPreviewPlayerImage()
return self.data.locallist
end


function playerImageModel:savePreviewPlayerImage(plist)
self.data.locallist=plist


end


function playerImageModel:dealAllSuitConfig()
local sex=playerModel:getActorSex()
self.data.suitData={}
local allSuitCfg=cfg_playersuitconfig()
self.data.lookupActiveItem={}
for index,suitCfg in pairs(allSuitCfg)do
local temp={}
temp.imageList=playerImageModel:getDefaultImage(sex)
temp.isUnlock=true
temp.isCanSelect=false
temp.cfg=suitCfg
temp.activeItemListState={}
temp.loopUpItem={}
temp.parts={}
temp.reddot=playerImageModel:canActiveSuitAttr(suitCfg.id)
local activeOnePart=false
for itemIndex,itemid in pairs(suitCfg.activeItems)do
local itemCfg=itemsConfig.getConfig(itemid)
local state=true
if itemCfg.funcparam and itemCfg.funcparam.list then
for _,partData in pairs(itemCfg.funcparam.list[sex])do
temp.imageList[partData[1]]=partData[2]
temp.loopUpItem[partData[1]]=itemid
local isActivePart=playerImageModel:isUnlockImage(partData[1],partData[2])
temp.parts[#temp.parts+1]=partData
state=state and isActivePart
activeOnePart=activeOnePart or isActivePart
if not isActivePart then










end
end
end

self.data.lookupActiveItem[itemid]=suitCfg
temp.activeItemListState[itemid]=state
temp.isUnlock=temp.isUnlock and state
temp.isCanSelect=temp.isCanSelect or state
temp.name=suitCfg.name
temp.sort=temp.isUnlock and 1 or 0

end
if suitCfg.isshow or activeOnePart then
self.data.suitData[#self.data.suitData+1]=temp
end
end

if#self.data.suitData>1 then
table.sort(self.data.suitData,function(a,b)
if a.sort==b.sort then
return a.cfg.id<b.cfg.id
else
return a.sort>b.sort
end
end)
end

local suitPartSort=cfgHelper.getdef(cfg_playerimagesubtabconfig,"suitpartsort")
for k,v in pairs(self.data.suitData)do
table.sort(v.parts,function(a,b)
local sort_a=suitPartSort[a[1]]or 100
local sort_b=suitPartSort[b[1]]or 100
return sort_a<sort_b
end)
end
end

function playerImageModel:dealAllSuitLookup()
local suitPartLookup={}
local suitIdLookup={}
for i=1,2 do
suitIdLookup[i-1]={}
suitPartLookup[i-1]={}
end
local allSuitCfg=cfg_playersuitconfig()
for index,suitCfg in pairs(allSuitCfg)do
local suitid=suitCfg.id
for i=1,2 do
suitPartLookup[i-1][suitid]={}
end
for _,itemid in pairs(suitCfg.activeItems)do
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.funcparam and itemCfg.funcparam.list then
for i=1,2 do
local sex=i-1
for _,partData in pairs(itemCfg.funcparam.list[sex])do
local tabid=partData[1]
local id=partData[2]
local suitIdSexLookup=suitIdLookup[sex]
if suitIdSexLookup[tabid]==nil then suitIdSexLookup[tabid]={}end
suitIdSexLookup[tabid][id]=suitid
suitPartLookup[sex][suitid][tabid]=id
end
end
end
end
end
self.suitIdLookup=suitIdLookup
self.suitPartLookup=suitPartLookup
end


function playerImageModel:getFullSuit(playerImage,sex)
local suitIdLookup,suitPartLookup=playerImageModel:getSuitLookup(sex)
local suitid
for _,tabid in pairs(PLAYER_IMAGE_TYPE)do
local id=playerImage[tabid]
if id and suitid==nil and suitIdLookup[tabid]and suitIdLookup[tabid][id]then
suitid=suitIdLookup[tabid][id]
end
end

if suitid==nil then return end

local partlookup=suitPartLookup[suitid]
if partlookup==nil then return end
for _,tabid in pairs(PLAYER_IMAGE_TYPE)do
local id=partlookup[tabid]
if id and playerImage[tabid]~=id then return end
end

return suitid
end

function playerImageModel:getSuitLookup(sex)
if not self.data.suitIdLookup then
self:dealAllSuitLookup()
end
return self.suitIdLookup[sex],self.suitPartLookup[sex]
end

function playerImageModel:getSuitData()
if not self.data.suitData then
self:dealAllSuitConfig()
end
return self.data.suitData
end

function playerImageModel:getLookupActiveItem()
if not self.data.lookupActiveItem then
self:dealAllSuitConfig()
end
return self.data.lookupActiveItem
end

function playerImageModel:getSuitReddot()
local reddot=true
for k,v in pairs(self.data.suitData)do
reddot=reddot and v.reddot
end
return reddot
end

function playerImageModel:getSuitActiveState()
self:dealAllSuitConfig()
for k,v in pairs(self.data.suitData)do
if v.isCanSelect then
return true
end
end
return false
end



function playerImageModel:checkSuitAttrActive(suitId)
if not self.data.piSuitList then
return false
end
return self.data.piSuitList[suitId]==true
end


function playerImageModel:canActiveSuitAttr(suitId)
if self:checkSuitAttrActive(suitId)then
return false
end
local suitCfg=cfg_playersuitconfig_get(suitId)
if not suitCfg.attr then
return false
end
local sex=playerModel:getActorSex()
for itemIndex,itemid in pairs(suitCfg.activeItems)do
local itemCfg=itemsConfig.getConfig(itemid)
local state=true
if itemCfg.funcparam and itemCfg.funcparam.list then
for _,partData in pairs(itemCfg.funcparam.list[sex])do
local isActivePart=playerImageModel:isUnlockImage(partData[1],partData[2])
if not isActivePart then
return false
end
end
end
end
return true
end


function playerImageModel:setSuitAttrActiveState(suitId,flag)
if not self.data.piSuitList then
self.data.piSuitList={}
end
self.data.piSuitList[suitId]=flag
end


function playerImageModel:checkSuitAttrActiveReddot()
local suitCfgs=cfg_playersuitconfig()
for i,v in ipairs(suitCfgs)do
if playerImageModel:canActiveSuitAttr(v.id)then return true end
end
return false
end


function playerImageModel:initSuitAttrlookup()
self.partlookup={}
local sex=playerModel:getActorSex()
local cfgs=cfg_playersuitconfig()
for i,v in pairs(cfgs)do
if v.attr then
local suitId=v.id
for itemIndex,itemid in pairs(v.activeItems)do
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.funcparam and itemCfg.funcparam.list then
for _,partData in pairs(itemCfg.funcparam.list[sex])do
local tabId=partData[1]
local subId=partData[2]
if not self.partlookup[tabId]then
self.partlookup[tabId]={}
end
self.partlookup[tabId][subId]=suitId
end
end
end
end
end
end

function playerImageModel:getSuitId(tabId,subId)
if not self.partlookup then
playerImageModel:initSuitAttrlookup()
end
if self.partlookup[tabId]then
return self.partlookup[tabId][subId]
end
end


function playerImageModel:getAddAttrList()
local lookupList=nil
local cfgs=cfg_playersuitconfig()
for i,v in pairs(cfgs)do
if v.attr then
local suitId=v.id
if playerImageModel:checkSuitAttrActive(suitId)then
for i2,vv in ipairs(v.attr)do
local attrId=vv[1]
local attrCfgVal=vv[2]
if not lookupList then
lookupList={}
end
lookupList[attrId]=(lookupList[attrId]or 0)+attrCfgVal
end
end
end
end
return lookupList
end

function playerImageModel:SetSkintable(sex,skincolor,id)
if not self.data.Skintable then
self.data.Skintable={}
end
local config=playerImageConfig.getAllSubConfig(sex,id)

if not config then
return
end
for k,v in pairs(config)do
if v.skincolor then
if not self.data.Skintable[v.sex]then
self.data.Skintable[v.sex]={}
end
if not self.data.Skintable[v.sex][id]then
self.data.Skintable[v.sex][id]={}
end
if not self.data.Skintable[v.sex][id][v.skincolor]then
self.data.Skintable[v.sex][id][v.skincolor]={}
end
table.insert(self.data.Skintable[v.sex][id][v.skincolor],v.id)
end
end
if not self.data.Skintable[sex]or not self.data.Skintable[sex][id]then
return
end
return self.data.Skintable[sex][id][skincolor]
end

function playerImageModel:GetSkintable(sex,skincolor,imagetype)
if self.data.Skintable and self.data.Skintable[sex]and self.data.Skintable[sex][imagetype]and self.data.Skintable[sex][imagetype][skincolor]then
return self.data.Skintable[sex][imagetype][skincolor]
else
return playerImageModel:SetSkintable(sex,skincolor,imagetype)
end
end