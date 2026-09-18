







UISettingModel={}
UISettingModel.data={}
local _remove=table.remove
local kuangType=KUANGE_TYPE
local unlockType=KUANGE_UNLOCK_TYPE
local kuangHideType=KUANGE_HIDE_TYPE

local global_setting_init_config=
{
musicVolume=0.8,
soundVolume=0.8,
rolespeakVolumee=0.8,
qualityLevel=GraphicsQualityLevel.High,
}

local setting_init_config=
{
powerSave=false,
systemChannel=true,
jianWenChannel=true,
kuafuChannel=true,
xianMengChannel=true,
privateChatChannel=true,
worldChannel=true,
wifiVoice=true,
localServerVoice=false,
worldVoice=false,
xianMengVoice=false,
privateChatVoice=false,
fightSaveMode=true,
}



local systemIndexType=
{
ShanHai=1,
ShangShi=2,
YiFangLingTian=3,
KongZhan=4,
WengDingCangQiong=5,
XianYu=6,
XianJie=7,
}

local systemTest_reddot_config=
{
[1]={"UIXM_ZZSH_MapWin"},
[2]={"UIShangHangWin"},
[3]={"UIYiFangLingTianMain"},
[4]={"UIAirGameEnterWin"},
[5]={"UIWDCQMainWin"},
[6]={"UIXianJieMainWin"},
[7]={"UIXianJieMainWin"},
}

function UISettingModel:on_app_start()
UISettingModel:initGlobalSettingData()
end

function UISettingModel:on_enter_state()
self.data.unLockHead={}
self.data.unLockHead_lookup={}
self.data.unLockKuang={}
self.data.unLockKuang_lookup={}
self.data.chatKuangData={}
self.data.settingData={}
UISettingModel:loadFirstZongMenNameState()
UISettingModel:loadFirstOpenZongMenNameState()

if not self.testDataList then
self.testDataList={}
end
end

function UISettingModel:on_leave_state()

self:stopChatKuangTimer()
self.data={}





self.testDataList={}
end

function UISettingModel:initActorSettingData()
self:initActorSettingConfig()
self:init_chat_setting()
end

function UISettingModel:initGlobalSettingData()
self:initGlobalSettingConfig()
self:init_volume_setting()
end

function UISettingModel:initActorSettingConfig()
local saveSettingData=userActorSetting.get("_settingConfig",{})
self.settingConfig=saveSettingData
local is_init=false
for k,v in pairs(setting_init_config)do
if self.settingConfig[k]==nil then
is_init=true
self.settingConfig[k]=v
end
end
if is_init then
userActorSetting.set("_settingConfig",self.settingConfig)
end
end

function UISettingModel:initGlobalSettingConfig()
local saveSettingData=userGlobalSetting.get("_settingConfig",{})
self.globalSettingConfig=saveSettingData
local is_init=false
for k,v in pairs(global_setting_init_config)do
if self.globalSettingConfig[k]==nil then
is_init=true
self.globalSettingConfig[k]=v
end
end
if is_init then
userGlobalSetting.set("_settingConfig",self.globalSettingConfig)
end
end

function UISettingModel:flushActorSettingConfig(data)
userActorSetting.set("_settingConfig",data)
userActorSetting.flush()
self.settingConfig=data
end

function UISettingModel:flushGlobalSettingConfig(data)
userGlobalSetting.set("_settingConfig",data)
userGlobalSetting.flush()
self.globalSettingConfig=data
end

function UISettingModel:getActorSettingConfig()
if self.settingConfig==nil then
UISettingModel:initActorSettingConfig()
end
return self.settingConfig
end

function UISettingModel:getGlobalSettingConfig()
if self.globalSettingConfig==nil then
UISettingModel:initGlobalSettingConfig()
end
return self.globalSettingConfig
end

function UISettingModel:getQualityLevel()
if self.globalSettingConfig==nil then
UISettingModel:initGlobalSettingConfig()
end
return self.globalSettingConfig.qualityLevel
end


function UISettingModel:init_chat_setting()
local data=UISettingModel:getActorSettingConfig()

chatControl.setChannelFlag(CHAT_CHANNNEL.eSystem,data.systemChannel)
chatControl.setChannelFlag(CHAT_CHANNNEL.eJianwen,data.jianWenChannel)
chatControl.setChannelFlag(CHAT_CHANNNEL.eKuafu,data.kuafuChannel)
chatControl.setChannelFlag(CHAT_CHANNNEL.eWorld,data.worldChannel)
chatControl.setChannelFlag(CHAT_CHANNNEL.eXianmeng,data.xianMengChannel)
chatControl.setChannelFlag(CHAT_CHANNNEL.ePrivate,data.privateChatChannel)
end


function UISettingModel:init_volume_setting()
local data=UISettingModel:getGlobalSettingConfig()
AudioManager.setBgMusicVolume(data.musicVolume)
AudioManager.setSoundEffectVolume(data.soundVolume)
AudioManager.setRoleSpeakVolume(data.rolespeakVolumee)
end



function UISettingModel:setZMName(name)
self.data.zmName=name
end

function UISettingModel:getZMName()
return self.data.zmName or''
end


function UISettingModel:setActorNameChangeCnt(cnt)
if cnt then
self.data.actorNameChangeCnt=cnt
else
self.data.actorNameChangeCnt=self.data.actorNameChangeCnt+1
end
end

function UISettingModel:getActorNameChangeCnt()
return self.data.actorNameChangeCnt
end


function UISettingModel:setZMNameChangeCnt(cnt)
if cnt then
self.data.zmNameChangeCnt=cnt
else
self.data.zmNameChangeCnt=self.data.zmNameChangeCnt+1
end
end

function UISettingModel:getZMNameChangeCnt()
return self.data.zmNameChangeCnt
end



function UISettingModel:get_head_config()
local sex=playerModel:getActorSex()
local headConfig=cfg_headportraitconfig()
local list={}
for i,v in ipairs(headConfig)do
if v.sex==sex then
table.insert(list,v)
end
end
return list
end

function UISettingModel:initHeadCfg()

local level=zongmenModel:getLevel()
local headCfg=UISettingModel:get_head_config()
for i,v in ipairs(headCfg)do
local headUnLock=v.unlock
local isUnLock=UISettingModel:isUnlockHead(kuangType.head,v.id)
if not isUnLock and(headUnLock==nil or headUnLock and headUnLock.type==unlockType.eLevel and level>=headUnLock.param)then

UISettingModel:add_unlock_data(kuangType.head,v.id,-1)
local win=UIManager:findActiveWindow('UIHeadSelectWin')
if win then
win:refreshCurInfo()
win:refreshScrollerView()
end
end
end


local kuangCfg=cfg_headportraitframeconfig()
for i,v in ipairs(kuangCfg)do
local kuangUnLock=v.unlock
local isUnLock=UISettingModel:isUnlockHead(kuangType.headKuang,v.id)
if not isUnLock and(kuangUnLock==nil or kuangUnLock and kuangUnLock.type==unlockType.eLevel and level>=kuangUnLock.param)then

UISettingModel:add_unlock_data(kuangType.headKuang,v.id,-1)
local win=UIManager:findActiveWindow('UIHeadSelectWin')
if win then
win:refreshCurInfo()
win:refreshScrollerView()
end
end
end
end


function UISettingModel:init_head_data(id,len,array)

self.data.unLockHead={}
self.data.unLockHead_lookup={}

self:set_cur_head(id)
if len>0 then
for i,v in ipairs(array)do
UISettingModel:add_unlock_data(kuangType.head,v.param_1,v.param_2)
end
end

local headCfg=self:get_head_config()
for i,v in ipairs(headCfg)do
if v.unlock==nil then

UISettingModel:add_unlock_data(kuangType.head,v.id,-1)
else

local zongmenLv=zongmenModel:getLevel()
if zongmenLv then
local headUnLock=v.unlock
if headUnLock and headUnLock.type==1 and zongmenLv>=headUnLock.param then
UISettingModel:add_unlock_data(kuangType.head,v.id,-1)
end
end
end
end

end


function UISettingModel:get_unlock_head()
return self.data.unLockHead
end


function UISettingModel:init_head_kuang_data(id,len,array)
self:set_cur_head_kuang(id)
if len>0 then
for i,v in ipairs(array)do
UISettingModel:add_unlock_data(kuangType.headKuang,v.param_1,v.param_2)
end
end

local kuangCfg=cfg_headportraitframeconfig()
for i,v in ipairs(kuangCfg)do
if v.unlock==nil then

UISettingModel:add_unlock_data(kuangType.headKuang,v.id,-1)
else

local zongmenLv=zongmenModel:getLevel()
if zongmenLv then
local kuangUnLock=v.unlock
if kuangUnLock and kuangUnLock.type==1 and zongmenLv>=kuangUnLock.param then
UISettingModel:add_unlock_data(kuangType.headKuang,v.id,-1)
end
end
end
end
end


function UISettingModel:get_unlock_headKuang()
return self.data.unLockKuang
end


function UISettingModel:add_unlock_data(typo,id,expiresec)
if typo==kuangType.head or typo==kuangType.headKuang then

if expiresec and expiresec~=-1 then

local nowTime=gameUtilityModel.getServerShortTime()
local lerp=expiresec-nowTime
if lerp<=0 then
self:setExperienceListData(typo,id,expiresec)

return
end
end
end

if typo==kuangType.head then

if self.data.unLockHead_lookup[id]then

self.data.unLockHead_lookup[id].expiresec=expiresec
else

local headInfo={id=id,expiresec=expiresec}
self.data.unLockHead[#self.data.unLockHead+1]=headInfo
self.data.unLockHead_lookup[id]=self.data.unLockHead[#self.data.unLockHead]
end
elseif typo==kuangType.headKuang then

if self.data.unLockKuang_lookup[id]then

self.data.unLockKuang_lookup[id].expiresec=expiresec
else

local kuangInfo={id=id,expiresec=expiresec}
self.data.unLockKuang[#self.data.unLockKuang+1]=kuangInfo
self.data.unLockKuang_lookup[id]=self.data.unLockKuang[#self.data.unLockKuang]
end
UISettingModel:refrshSettingData(typo,id,expiresec)
elseif typo==kuangType.chatKuang then
UISettingModel:setChatKuangData(id,expiresec)
else
UISettingModel:refrshSettingData(typo,id,expiresec)
end
end


function UISettingModel:remove_unlock_data(typo,id)
if typo==1 then
self.data.unLockHead_lookup[id]=nil
local removeIndex=nil

for i,v in ipairs(self.data.unLockHead)do
if v.id==id then
removeIndex=i
break
end
end
if removeIndex then
table.remove(self.data.unLockHead,removeIndex)
end
else
self.data.unLockKuang_lookup[id]=nil
local removeIndex=nil

for i,v in ipairs(self.data.unLockKuang)do
if v.id==id then
removeIndex=i
break
end
end
if removeIndex then
table.remove(self.data.unLockKuang,removeIndex)
end
end
end


function UISettingModel:up_star_data(type,id,star)
local settingData=self.data.settingData
if not settingData then
self.data.settingData={}
settingData=self.data.settingData
end
local settingTypeData=settingData[type]
if not settingTypeData then
settingData[type]={}
settingTypeData=settingData[type]
settingTypeData.settingId=id
settingTypeData.unlockList={}
settingTypeData.limtUnlockList={}
settingTypeData.starList={}
end
settingTypeData.starList[id]=star
end

function UISettingModel:set_cur_head(id)
self.data.curHeadId=id
end


function UISettingModel:get_cur_head()
return self.data.curHeadId
end

function UISettingModel:get_curhead_icon()
local headId=self:get_cur_head()
local headIcon=playerModel:getActorIconById(headId)
return headIcon
end

function UISettingModel:set_cur_head_kuang(id)
self.data.curHeadKuangId=id
end


function UISettingModel:get_cur_head_kuang()
return self.data.curHeadKuangId
end

function UISettingModel:get_curkuang_icon()
local kuangId=self:get_cur_head_kuang()
local icon=playerModel:getActorFrameIconById(kuangId)
return icon
end

function UISettingModel:get_curkuang_anim()
local kuangId=self:get_cur_head_kuang()
local animType,anim=playerModel:getActorFrameAnimById(kuangId)
return animType,anim
end

function UISettingModel:getHeadBGIcon()
return 1
end

function UISettingModel:isCanOverlay(typo,id)
local cfg=UISettingConfig.getCfg(typo,id)
return cfg.unlock and cfg.unlock.duration~=nil or false
end



function UISettingModel:isUnlockHead(typo,id,itemid)

if typo==kuangType.head and self.data.unLockHead then







if self.data.unLockHead_lookup[id]then
if self.data.unLockHead_lookup[id].expiresec~=-1 then
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.data.unLockHead_lookup[id].expiresec-nowTime
if lerp<=0 then

return false
end
end
return true
end
elseif typo==kuangType.chatKuang then
return UISettingModel:isChatKuangUnlock(id)
elseif self.data.unLockKuang then







if self.data.unLockKuang_lookup[id]then
if self.data.unLockKuang_lookup[id].expiresec~=-1 then
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.data.unLockKuang_lookup[id].expiresec-nowTime
if lerp<=0 then

return false
end
end
return true
end
end
return false
end


function UISettingModel:isExpireHeadType(typo,id)
if typo==kuangType.head and self.data.unLockHead then
if self.data.unLockHead_lookup[id]then

return self.data.unLockHead_lookup[id].expiresec
end
elseif typo==kuangType.headKuang and self.data.unLockKuang then
if self.data.unLockKuang_lookup[id]then

return self.data.unLockKuang_lookup[id].expiresec
end
end


return nil
end


function UISettingModel:getUnExpireHeadId(typo)

if typo==kuangType.head then
local headId=self.data.unLockHead[#self.data.unLockHead].id
local cfg=cfgHelper.get1(cfg_headportraitconfig_get,headId)
if not cfg.unlock then

if#self.data.unLockHead>1 then

headId=self.data.unLockHead[#self.data.unLockHead-1].id
end
end

return headId
else
local kuangId=self.data.unLockKuang[#self.data.unLockKuang].id
local cfg=cfgHelper.get1(cfg_headportraitframeconfig_get,kuangId)
if not cfg.unlock then

if#self.data.unLockKuang>1 then

kuangId=self.data.unLockKuang[#self.data.unLockKuang-1].id
end
end

return kuangId
end
end


function UISettingModel:isCanUnLockHead(cost)
local itemid=cost[1]
local need=cost[2]
local have=0
local countStr=''
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
countStr=FMT.fmt('{0}',need)
else
have=itemBagModel:getItemCountByItemID(itemid)
countStr=FMT.fmt('{0}',need)
end
local isEnough=have>=need
local isCanUse=itemsLookup:checkUseItemCondition(itemid,true)or false
return isEnough and isCanUse,countStr,isEnough,isCanUse
end


function UISettingModel:checkSelectHeadReddot()
return UISettingModel:checkReddotHead()or
UISettingModel:checkReddotHeadKuang()or
UISettingModel:hasChatKuangReddot()or
UISettingModel:hasZongMenReddot()or
UISettingModel:hasFeiJianReddot()or
UISettingModel:hasYunZhouReddot()
end


function UISettingModel:checkReddotHead()
local config=self:get_head_config()
for i,v in ipairs(config)do
local hideType=v.hideType
if hideType~=kuangHideType.eAlwaysHide then
local unlockLimit=v.unlock

local isUnLock=UISettingModel:isUnlockHead(kuangType.head,v.id)
if not isUnLock and unlockLimit and unlockLimit.type==unlockType.eItem then
local canUnLock=UISettingModel:isCanUnLockHead(unlockLimit.param)
if canUnLock then
return true,v.id
end
end
end
end
return false
end


function UISettingModel:checkReddotHeadKuang()
local config=cfg_headportraitframeconfig()
for i,v in ipairs(config)do
local hideType=v.hideType
if hideType~=kuangHideType.eAlwaysHide then
local unlockLimit=v.unlock

local isUnLock=UISettingModel:isUnlockHead(kuangType.headKuang,v.id)
if not isUnLock and unlockLimit and unlockLimit.type==unlockType.eItem then
local canUnLock=UISettingModel:isCanUnLockHead(unlockLimit.param)
if canUnLock then
return true,v.id
end
end
end
end
return false
end


function UISettingModel:getHeadOrKuangCostList()
local costList={}
local headCfg=self:get_head_config()
for i,v in ipairs(headCfg)do
local unlockLimit=v.unlock

local isUnLock=UISettingModel:isUnlockHead(kuangType.head,v.id)
if not isUnLock and unlockLimit and unlockLimit.type==2 then
local cost=unlockLimit.param
costList[cost[1]]=cost[2]
end
end
local kuangCfg=cfg_headportraitframeconfig()
for i,v in ipairs(kuangCfg)do
local unlockLimit=v.unlock

local isUnLock=UISettingModel:isUnlockHead(kuangType.headKuang,v.id)
if not isUnLock and unlockLimit and unlockLimit.type==2 then
local cost=unlockLimit.param
costList[cost[1]]=cost[2]
end
end
return costList
end


function UISettingModel:setChangeWithExpireMark(type,flag)
if not self.data.HeadExpireMark then
self.data.HeadExpireMark={}
end
self.data.HeadExpireMark[type]=flag
end


function UISettingModel:getChangeWithExpireMarkByKuangType(type)
if self.data.HeadExpireMark and self.data.HeadExpireMark[type]then
return true
end

return false
end

















































































function UISettingModel:getDiziCountByJingjieLv(jingjie_lv)
local dizi_count=0
local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
for k,v in pairs(all)do
local data=v.netData.net
if data.jingjielv>=jingjie_lv then
dizi_count=dizi_count+1
end
end
end
return dizi_count
end

function UISettingModel:getDiziCountByLiantiLv(lianti_lv)
local dizi_count=0
local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
for k,v in pairs(all)do
local data=v.netData.net
if data.liantilv>=lianti_lv then
dizi_count=dizi_count+1
end
end
end
return dizi_count
end


function UISettingModel:checkZongMenLevelBreak()
local zonmenLv=zongmenModel:getLevel()
local nextConfig
local all_cfg=cfg_guildexpconfig()
for i,v in ipairs(all_cfg)do
if v.condition then
if zonmenLv+1==v.id then
nextConfig=v
end
end
end
local canBreak=false
if nextConfig then
local need_jingjie=nextConfig.condition[1][3]
local need_count=nextConfig.condition[1][1]
local count=UISettingModel:getDiziCountByJingjieLv(need_jingjie)
canBreak=zonmenLv>=(nextConfig.id-1)and count>=need_count
end
return canBreak
end

function UISettingModel:checkZongMenLevelReddot()
local zonmenLv=zongmenModel:getLevel()
local nextConfig=cfgHelper.get1(cfg_guildexpconfig_get,zonmenLv+1)
if UISettingModel:checkZMMaxLv()then return false end
if nextConfig then
local enoughExp=zongmenModel:checkLevelUp()
if enoughExp then
if nextConfig.sysid then
if systemModel.isOpen(nextConfig.sysid)then
return true
end
elseif nextConfig.condition then
local need_jingjie=nextConfig.condition[1][3]
local need_count=nextConfig.condition[1][1]
local count=UISettingModel:getDiziCountByJingjieLv(need_jingjie)
return count>=need_count
else
return true
end
end
end
return false
end

function UISettingModel:checkZMMaxLv(lv)
local zonmenLv=lv or zongmenModel:getLevel()
local maxlv=zongmenModel:getZongMenLimitLv()
return zonmenLv>=maxlv
end

function UISettingModel:getcommonname_len()
local gameVersion=pfwindowslController:getGameVersion()
local namelen=cfgHelper.getglobal1('namelen')
local namelen=namelen[gameVersion]or namelen[1]
return namelen
end

function UISettingModel:getdisciplename_len()
local gameVersion=pfwindowslController:getGameVersion()
local disciplenamelen=cfgHelper.getglobal1('disciplenamelen')
local disciplenamelen=disciplenamelen[gameVersion]or disciplenamelen[1]
return disciplenamelen
end

function UISettingModel:getzmname_len()
local config=cfgHelper.get1(cfg_systemsetconfig_get,1)
local gameVersion=pfwindowslController:getGameVersion()
local lenLimit=config.zmname_len[gameVersion]or config.zmname_len[1]
return lenLimit
end


function UISettingModel:checkZMName(inputStr,optionStr)
if inputStr==nil or inputStr==''then
UIManager.error('宗门名称不能为空')
return false
end
local namelenCfg=UISettingModel:getzmname_len()
if not pfwindowslController.checkNameLenInvalid(inputStr,namelenCfg)then
return
end

local curName=UISettingModel:getZMName()
local changeName=FMT.fmt('{0}{1}',inputStr,optionStr)
if changeName==curName then
UIManager.error('宗门名称重复')
return false
end
local config=cfgHelper.get1(cfg_systemsetconfig_get,1)
local freeCnt=config.zmname_free_count
local changedCnt=UISettingModel:getZMNameChangeCnt()
if freeCnt<=changedCnt then
local cost=config.change_zmname_cost
for i,v in ipairs(cost)do
local have=0
local itemid=v[1]
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=itemBagModel:getItemCountByItemID(itemid)
end
if have<v[2]then

gainControl:showGainWin(itemid)
return false
end
end
end
return true
end


function UISettingModel:loadFirstZongMenNameState()
self.firstZMName=userActorSetting.get('firstZongMenName',true)
end

function UISettingModel:saveFirstZongMenNameState(flag)
userActorSetting.set('firstZongMenName',flag)
userActorSetting.flush()
end

function UISettingModel:getFirstZongMenNameState()
return self.createZMWin
end


function UISettingModel:loadFirstOpenZongMenNameState()
self.createZMWin=userActorSetting.get('firstOpenZongMenNameWin',false)
end

function UISettingModel:saveFirstOpenZongMenNameState()
self.createZMWin=true
userActorSetting.set('firstOpenZongMenNameWin',true)
userActorSetting.flush()
end

function UISettingModel:getFirstOpenZongMenNameState()
return self.createZMWin
end



function UISettingModel:initChatKuangCfg()
local level=zongmenModel:getLevel()
local kuangCfg=cfg_bubbleframeconfig()
for i,v in ipairs(kuangCfg)do
local kuangUnlock=v.unlock
local kuangid=v.id
local isUnlock=UISettingModel:isChatKuangUnlock(kuangid)
if not isUnlock and(kuangUnlock==nil or kuangUnlock and kuangUnlock.type==unlockType.eLevel and level>=kuangUnlock.param)then
UISettingModel:add_unlock_data(kuangType.chatKuang,kuangid,-1)
end
end
end

function UISettingModel:initChatKuangData(kuangid,len,array)
array=array or{}
local data=self.data.chatKuangData
data.kuangid=kuangid
data.lookup={}
data.data=array
data.tick={}
data.experience={}
if len==0 then return end
local lookup=data.lookup
local tick=data.tick
local experience=data.experience
local curStamp=timeHelper.getServerShortTime()
local flag=false
for i,v in ipairs(array)do
local stamp=v.param_2
local _kuangid=v.param_1
lookup[_kuangid]=stamp
if stamp>0 then
local cfg=cfg_bubbleframeconfig_get(_kuangid)
if curStamp>stamp then
experience[_kuangid]=v
self:setExperienceListData(kuangType.chatKuang,_kuangid,stamp)
if kuangid==_kuangid then
flag=true
end
else
tick[#tick+1]={_kuangid,stamp,cfg}
end
end
end
if flag then
UISettingModel:useNewChatKuang()
end
self:startChatKuangTimer()
end

function UISettingModel:setChatKuangData(kuangid,stamp)
local chatKuangData=self.data.chatKuangData
if chatKuangData.lookup==nil then chatKuangData.lookup={}end
local lookup=chatKuangData.lookup
lookup[kuangid]=stamp
if chatKuangData.data==nil then chatKuangData.data={}end
if chatKuangData.experience==nil then chatKuangData.experience={}end
local experience=chatKuangData.experience
if chatKuangData.tick==nil then chatKuangData.tick={}end
local tick=chatKuangData.tick
local data=chatKuangData.data
local flag=false
for i,v in ipairs(data)do
if v.param_1==kuangid then
v.param_2=stamp
flag=true
break
end
end
if not flag then
data[#data+1]={param_1=kuangid,param_2=stamp}
end
local curStamp=timeHelper.getServerShortTime()
if stamp>0 then
local cfg=cfg_bubbleframeconfig_get(kuangid)
if curStamp>stamp then
experience[kuangid]=stamp
self:setExperienceListData(kuangType.chatKuang,kuangid,stamp)
UISettingModel:useNewChatKuang()
else
experience[kuangid]=nil
local flag=false
for i,v in ipairs(tick)do
if v[1]==kuangid then
v[2]=stamp
flag=true
break
end
end
if not flag then
tick[#tick+1]={kuangid,stamp,cfg}
end
end
end
self:startChatKuangTimer()
end

function UISettingModel:isChatKuangExperience(kuangid)
local data=self.data.chatKuangData
if data==nil or data.experience==nil then return false end
return data.experience[kuangid]~=nil
end

function UISettingModel:setCurrentChatKuang(kuangid)
self.data.chatKuangData.kuangid=kuangid
end

function UISettingModel:getCurrentChatKuang()
return self.data.chatKuangData.kuangid
end

function UISettingModel:freshChatKuangUse(kuangids)
if kuangids==nil or#kuangids==0 then return end
local selectId=self:getCurrentChatKuang()
local needfreshUse=false
for i,v in ipairs(kuangids)do
if selectId==v then
needfreshUse=true
break
end
end
if needfreshUse then
UISettingModel:useNewChatKuang()
end
end

function UISettingModel:useNewChatKuang()
local newid=self:findOneBestChatKuang()
if newid==nil then
loggerUtil.logErrFMT("没找到气泡框")
newid=1
end
UISettingModel:setChangeWithExpireMark(kuangType.chatKuang,true)
UISettingController:reqUseKuang(kuangType.chatKuang,newid)
end

function UISettingModel:isChatKuangUnlock(kuangid)
local chatKuangData=self.data.chatKuangData
if chatKuangData==nil then return false end
local lookup=chatKuangData.lookup
if lookup==nil or lookup[kuangid]==nil then return false end
local stamp=lookup[kuangid]
if stamp==-1 then return true end
return timeHelper.getServerShortTime()<=stamp
end

function UISettingModel:getLeftChatKuangExpireTime(kuangid)
local chatKuangData=self.data.chatKuangData
if chatKuangData==nil then return 0,1 end
local lookup=chatKuangData.lookup
if lookup==nil or lookup[kuangid]==nil then return 0,1 end
local stamp=lookup[kuangid]
if stamp==-1 then return 0,2 end
local left=stamp-timeHelper.getServerShortTime()
return left
end

function UISettingModel:isCanChatKuangUnlockByItem(kuangid)
if UISettingModel:isChatKuangUnlock(kuangid)then return false end
local cfg=cfg_bubbleframeconfig_get(kuangid)
local unlock=cfg.unlock
if unlock and unlock.type==unlockType.eItem then
local param=unlock.param
local itemid=param[1]
local need=param[2]
return itemsModel.getCount(itemid)>=need
end
return false
end

function UISettingModel:getUnlockChatKuang(itemid)
local cfgs=cfg_bubbleframeconfig()
local defaultid
for i,v in ipairs(cfgs)do
local unlock=v.unlock
if unlock then
if unlock.type==unlockType.eItem then
if unlock.param[1]==itemid then
local id=v.id
defaultid=id
if not UISettingModel:isChatKuangUnlock(id)then
break
end
end
end
end
end
return defaultid
end

function UISettingModel:getUnlockCfg(chatkuangid)
local cfg=cfg_bubbleframeconfig_get(chatkuangid)
return cfg.unlock
end


function UISettingModel:findOneBestChatKuang()
local data=self.data.chatKuangData
if data==nil or data.data==nil then return end

local data=data.data
local id
for i,v in ipairs(data)do
local kuangid=v.param_1
local cfg=cfg_bubbleframeconfig_get(kuangid)
if cfg.unlock and cfg.unlock.type==unlockType.eItem then
if not self:isChatKuangExperience(kuangid)then
if id==nil or kuangid>id then
id=kuangid
end
end
else
if id==nil or kuangid>id then
id=kuangid
end
end
end
return id
end

function UISettingModel:startChatKuangTimer()
if self.chatKuangTimer then return end
local chatKuangData=self.data.chatKuangData
if chatKuangData==nil
or chatKuangData.tick==nil
or#chatKuangData.tick==0 then return end
self.chatKuangTimer=timer.new()
local func=function()
local chatKuangData=self.data.chatKuangData
if chatKuangData==nil
or chatKuangData.tick==nil
or#chatKuangData.tick==0 then
self:stopChatKuangTimer()
else
if chatKuangData.experience==nil then chatKuangData.experience={}end
local experience=chatKuangData.experience
local curStamp=timeHelper.getServerShortTime()
local tick=chatKuangData.tick
local len=#tick
local experienceList
for i=len,1,-1 do
local v=tick[i]
local kuangid=v[1]
local stamp=v[2]
if curStamp>stamp then
experience[kuangid]=stamp
self:setExperienceListData(kuangType.chatKuang,kuangid,stamp)
_remove(tick,i)
if experienceList==nil then experienceList={}end
experienceList[#experienceList+1]=kuangid

end
end
if experienceList then
self:freshChatKuangUse(experienceList)
notifySystem:postNotify(notifyConfig.chatBgExperience,experienceList)
end
end
end
self.chatKuangTimer:start(1,func)
func()
end

function UISettingModel:stopChatKuangTimer()
if self.chatKuangTimer then
self.chatKuangTimer:cancel()
end
self.chatKuangTimer=nil
end

function UISettingModel:hasChatKuangReddot()
local cfgs=cfg_bubbleframeconfig()
for i,v in ipairs(cfgs)do
local hideType=v.hideType
if hideType~=kuangHideType.eAlwaysHide then
local unlock=v.unlock
if unlock then
local kuangid=v.id
if unlock.type==unlockType.eItem and not UISettingModel:isChatKuangUnlock(kuangid)then
local canUnLock=UISettingModel:isCanUnLockHead(unlock.param)
if canUnLock then return true,kuangid end
end
end
end
end
return false
end


function UISettingModel:setTestDataList(arg)
self.testDataList=arg

end


function UISettingModel:getTestDataList()
if not self.testDataList then
self.testDataList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eTestTagData,"systemTestData",{})
end
return self.testDataList
end


function UISettingModel:checkTestTagReddot(systemId)
self.testDataList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eTestTagData,"systemTestData",{})
local idStr=tostring(systemId)

local time=cfgHelper.get2(cfg_testtagconfig_get,systemId,'time')
local startTime=timeHelper.getSeconds(time[1][1],time[1][2],time[1][3],time[1][4],time[1][5],time[1][6])
local giftid=cfgHelper.get2(cfg_testtagconfig_get,systemId,'reward')
local isget=FreeGiftModel:IsCanGetGift(giftid,FreeGiftType.system,nil)
if not isget then
return false
end

if self.testDataList[idStr]then

if not self.testDataList[idStr].isCanReward then
if self.testDataList[idStr].startTime<startTime then
self.testDataList[idStr].isCanReward=true
self.testDataList[idStr].startTime=startTime
self:setTestDataList(self.testDataList)
end
end

return self.testDataList[idStr].isCanReward
end
return true
end

function UISettingModel:getWinNameConfig()
return systemTest_reddot_config or nil
end

function UISettingModel:getWinNameConfigById(sysid)
return systemTest_reddot_config[sysid]or nil
end


function UISettingModel:checkIsOpenTest(systemId)
local openTime=cfgHelper.get2(cfg_testtagconfig_get,systemId,'time')
if openTime then
local sTime=openTime[1]
local eTime=openTime[2]
local nowTime=timeHelper.getServerLongTime()
local startTime=timeHelper.getSeconds(sTime[1],sTime[2],sTime[3],sTime[4],sTime[5],sTime[6])
local endTime=timeHelper.getSeconds(eTime[1],eTime[2],eTime[3],eTime[4],eTime[5],eTime[6])

if nowTime>=startTime and nowTime<endTime then
return true
else
return false
end
else
return false
end
end


function UISettingModel:getSystemIndexType()
return systemIndexType
end




















function UISettingModel:initSettingData(len,array)
self.data.settingData={}
local settingData=self.data.settingData

if len<=0 then
return
end
array=array or{}
local curStamp=timeHelper.getServerShortTime()
local experienceList
for _,settingStruct in ipairs(array)do
local settingType=settingStruct.settingtype
local settingTypeId=settingStruct.settingid
local settingTypeLen=settingStruct.len
local settingTypelist=settingStruct.list
settingData[settingType]={}
local settingTypeData=settingData[settingType]
settingTypeData.settingId=settingTypeId
settingTypeData.unlockList={}
settingTypeData.limtUnlockList={}
settingTypeData.starList={}

if settingTypeLen>0 then
for __,commUShortInt in ipairs(settingTypelist)do
local settingid=commUShortInt.param_1
local star=commUShortInt.param_2
local time=commUShortInt.param_3
settingTypeData.starList[settingid]=star or 0

if time==-1 then
settingTypeData.unlockList[settingid]=true
else

if curStamp<time then
settingTypeData.limtUnlockList[settingid]=time
else

self:setExperienceListData(settingType,settingid,time)

if settingid==settingTypeId then
if not experienceList then
experienceList={}
end
experienceList[settingType]=settingid
end
end
end
end
end
end
if experienceList then
for k,v in pairs(experienceList)do
local settingType=k
self:useNewSettingId(settingType)
if settingType==kuangType.zongmen or settingType==kuangType.yunzhou then
UISettingController.jzAttrChange(settingType,v)
end
end
end
self:checkSettingExperienceTimer()
end


function UISettingModel:hasZongMenReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eZongMengSuit)then
return false
end
local type=kuangType.zongmen
return UISettingModel:checkSettingTypeReddot(type)
end

function UISettingModel:hasFeiJianReddot()
return false


end

function UISettingModel:hasYunZhouReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eZongMengSuit)then
return false
end
local type=kuangType.yunzhou
return UISettingModel:checkSettingTypeReddot(type)
end

function UISettingModel:checkSettingTypeReddot(type)
local cfgs=UISettingConfig.getSelfAllCfg(type)
for i,v in pairs(cfgs)do
local id=v.id
if v.hideType~=kuangHideType.eAlwaysHide then
local canUnLock=UISettingModel:isCanUnlock(type,id)
local canUpStar=UISettingModel:isCanUpStar(type,id)
if canUnLock or canUpStar then
return true,id
end
end
end
return false
end

function UISettingModel:useNewSettingId(settingType)
local defaultId=self:getSettingTypeDefaultId(settingType)
if defaultId==nil then
loggerUtil.logErrFMT("没找到气泡框")
return
end
UISettingModel:setChangeWithExpireMark(settingType,true)
UISettingController:reqUseKuang(settingType,defaultId)
end

function UISettingModel:getSettingTypeDefaultId(settingType)
local cfgs=UISettingConfig.getSelfAllCfg(settingType)
local defid
for i,v in pairs(cfgs)do
if v.isdef then
return v.id
end
if UISettingModel:checkSettingIdUnlock_Type(settingType,v.id)then
defid=v.id
end
end
return defid
end

function UISettingModel:checkSettingExperienceTimer()
if self.experienceTimer then return end
local settingData=self.data.settingData
if settingData==nil then
return
end
self.experienceTimer=timer.new()
local func=function()
local settingData=self.data.settingData
if settingData==nil then
self:stopSettingExperienceTimer()
else
local curStamp=timeHelper.getServerShortTime()
local stopflag=true
local experienceList
local changeList
for type,settingTypeData in pairs(settingData)do
local limtUnlockList=settingTypeData.limtUnlockList
local settingId=settingTypeData.settingId
if limtUnlockList and next(limtUnlockList)then
stopflag=false
for id,stamp in pairs(limtUnlockList)do
if curStamp>=stamp then

if not experienceList then
experienceList={}
end
if not experienceList[type]then
experienceList[type]={}
end
table.insert(experienceList[type],id)

self:setExperienceListData(type,id,stamp)
if settingId==id then
if not changeList then
changeList={}
end
changeList[type]=true
end
else

end
end
end
end

if experienceList then
for type,v in pairs(experienceList)do
local idlist=v
for i,id in ipairs(v)do
self:refrshSettingData(type,id)
UISettingController.jzAttrChange(type,id)
end
notifySystem:postNotify(notifyConfig.onSettingTypeExperience,type,idlist)
end
end
if changeList then
for type,v in pairs(changeList)do
self:useNewSettingId(type)



end
end
if stopflag then
self:stopSettingExperienceTimer()
end
end
end
self.experienceTimer:start(1,func)
func()
end

function UISettingModel:stopSettingExperienceTimer()
if self.experienceTimer then
self.experienceTimer:cancel()
end
self.experienceTimer=nil
end

function UISettingModel:getunlockId(itemid)
local cfg=UISettingConfig.getSelfCfgBySex(itemid)
local id
if cfg then

id=cfg[1].id
end
return id
end

function UISettingModel:hasSettingTypeReddot(type)
if type==kuangType.zongmen then
return UISettingModel:hasZongMenReddot()
elseif type==kuangType.feijian then
return UISettingModel:hasFeiJianReddot()
elseif type==kuangType.yunzhou then
return UISettingModel:hasYunZhouReddot()
end
return false
end

function UISettingModel:getCurSettingId_Type(type)
local settingData=self.data.settingData
if not settingData then
return
end
local settingTypeData=settingData[type]
if not settingTypeData then
return
end
return settingTypeData.settingId
end

function UISettingModel:setExperienceListData(type,id,time)
local allexperienceList=self.data.allexperienceList
if not allexperienceList then
self.data.allexperienceList={}
allexperienceList=self.data.allexperienceList
end
local experienceList=allexperienceList[type]
if not experienceList then
allexperienceList[type]={}
experienceList=allexperienceList[type]
end
table.insert(experienceList,{id,time})
end

function UISettingModel:getExperienceList_Type(type)
local allexperienceList=self.data.allexperienceList
if not allexperienceList then
return
end
return allexperienceList[type]
end

function UISettingModel:checkSettingIdUnlock_Type(type,settingId)
local settingcfg=UISettingConfig.getCfg(type,settingId)
local unlock=settingcfg.unlock
if not unlock then
return true
end
local settingData=self.data.settingData
if not settingData then
return false
end
local settingTypeData=settingData[type]
if not settingTypeData then
return false
end
if settingTypeData.unlockList[settingId]==true then
return true,SETTING_ACTIVE_TYPE.eForever
end
if settingTypeData.limtUnlockList[settingId]~=nil then
return true,SETTING_ACTIVE_TYPE.eLimit
end
return false
end

function UISettingModel:getLeftExpireTime(type,settingId)
local settingData=self.data.settingData
if not settingData then
return
end
local settingTypeData=settingData[type]
if not settingTypeData then
return
end
local limtUnlockList=settingTypeData.limtUnlockList
local stamp=limtUnlockList[settingId]
local left
if stamp then
left=stamp-timeHelper.getServerShortTime()
end
return left
end

function UISettingModel:getStarNum(type,settingId)
local settingData=self.data.settingData
if not settingData then
return
end
local settingTypeData=settingData[type]
if not settingTypeData then
return
end
local starList=settingTypeData.starList
return starList[settingId]or 0
end

function UISettingModel:isCanUnlock(type,settingId)
local unlock,activeType=UISettingModel:checkSettingIdUnlock_Type(type,settingId)
local settingcfg=UISettingConfig.getCfg(type,settingId)
local unlockParams=settingcfg.unlock

if unlock and((unlockParams and unlockParams.type~=unlockType.eItemChange)or activeType==SETTING_ACTIVE_TYPE.eForever)then

return false
end


if unlockParams then
if unlockParams.type==unlockType.eLevel then
local unLockLevel=unlockParams.param
return playerModel:checkActorLevel(unLockLevel)
elseif unlockParams.type==unlockType.eFSRank then
local unlockRank=unlockParams.param
local info=rankListModel:getPlayerInfo(eRankListType.eDuJieFeiSheng)
local curRank=info and info.number or 0


if curRank==0 then
return false
end
return unlockRank>=curRank
elseif unlockParams.type==unlockType.eItem then
local param=unlockParams.param
local itemid=param[1]
local need=param[2]
return itemsModel.getCount(itemid)>=need
elseif unlockParams.type==unlockType.eItemChange then
local param=unlockParams.param
for i=#param,1,-1 do
local v=param[i]

if not unlock or(unlock and#v==2)then
local itemid=v[1]
local need=v[2]
if itemsModel.getCount(itemid)>=need then
return true,#v>=3 and SETTING_ACTIVE_TYPE.eLimit or SETTING_ACTIVE_TYPE.eForever,i
end
end
end
return false















end
end
return false
end


function UISettingModel:isCanUpStar(type,settingId)
local settingcfg=UISettingConfig.getCfg(type,settingId)
local unlock,activeType=UISettingModel:checkSettingIdUnlock_Type(type,settingId)
local starNum=UISettingModel:getStarNum(type,settingId)
if unlock and activeType==SETTING_ACTIVE_TYPE.eForever and settingcfg.star~=nil then
local costList=settingcfg.star[starNum+1]or{}
local len=#costList
if len>0 then
for i=1,len do
local itemid=costList[i][1]
local need=costList[i][2]
local has=itemsModel.getCount(itemid)
if has<need then
return false
end
end
return true
end
end
return false
end

function UISettingModel:setSettingId(type,settingId)
local settingData=self.data.settingData
if not settingData then
return
end
local settingTypeData=settingData[type]
if not settingTypeData then
return
end
settingTypeData.settingId=settingId
end

function UISettingModel:refrshSettingData(type,id,expiresec)
local settingData=self.data.settingData
if not settingData then
self.data.settingData={}
settingData=self.data.settingData
end
local settingTypeData=settingData[type]
if not settingTypeData then
settingData[type]={}
settingTypeData=settingData[type]
settingTypeData.settingId=id
settingTypeData.unlockList={}
settingTypeData.limtUnlockList={}
settingTypeData.starList={}
end
local time=expiresec
if time then

if time==-1 then
settingTypeData.unlockList[id]=true
settingTypeData.limtUnlockList[id]=nil
else
local curStamp=timeHelper.getServerShortTime()

if curStamp<time then
settingTypeData.limtUnlockList[id]=time
self:checkSettingExperienceTimer()
else
settingTypeData.limtUnlockList[id]=nil
end
end
else
settingTypeData.unlockList[id]=false
settingTypeData.limtUnlockList[id]=nil
end
end

function UISettingModel:checkShowExperienceWin()
if not systemModel.isOpen(SYSTEM_DEFINE.eZongMengSuit)then
return false
end
local showRecord=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eSettingTypeExperience,{})
local showList
local curTime=timeHelper.getServerShortTime()
local experienceTime=cfgHelper.get2(cfg_systemsetconfig_get,1,"experienceTime")
for k,type in pairs(kuangType)do
local strType=tostring(type)
local list=self:getExperienceList_Type(type)
if list then
local limitTime=experienceTime[type]
if not showRecord[strType]then
showRecord[strType]={}
end
local typeRecord=showRecord[strType]
for i,v in ipairs(list)do
local id=v[1]
local strId=tostring(id)
local time=v[2]
local recordTime=typeRecord[strId]
if recordTime~=time and(not limitTime or((curTime-time)<=limitTime))then
if not showList then
showList={}
end
table.insert(showList,{type,id,time})
typeRecord[strId]=time
end
end
end
end
if showList then

userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eSettingTypeExperience,showRecord)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSettingTypeExperience)
local arg={}
arg.experienceList=showList
UIManager:showWindow("UISettingExperienceWin",arg)
end

end


function UISettingModel:getSettingType(id)



return kuangType.yunzhou
end

function UISettingModel:getAddAttrList()
local lookupList=nil
local attrtypeList={
kuangType.zongmen,
kuangType.yunzhou,
kuangType.headKuang,
kuangType.chatKuang,
}
for i,settingType in ipairs(attrtypeList)do
local cfgs=UISettingConfig.getSelfAllCfg(settingType)
for _,v in pairs(cfgs)do
local unlock=UISettingModel:checkSettingIdUnlock_Type(settingType,v.id)
if v.attr and unlock then
local starNum=UISettingModel:getStarNum(settingType,v.id)
for __,v2 in ipairs(v.attr)do
if not lookupList then
lookupList={}
end
if lookupList[v2[1]]then
lookupList[v2[1]]=lookupList[v2[1]]+v2[2]
else
lookupList[v2[1]]=v2[2]
end
end
if starNum>0 then
for __,v2 in ipairs(v.star_attr[starNum])do
if not lookupList then
lookupList={}
end
if lookupList[v2[1]]then
lookupList[v2[1]]=lookupList[v2[1]]+v2[2]
else
lookupList[v2[1]]=v2[2]
end
end
end
end
end
end
return lookupList
end

function UISettingModel:getAddJZAttrList()
local lookupList=nil
local attrtypeList={
kuangType.zongmen,
kuangType.yunzhou,
kuangType.headKuang,
kuangType.chatKuang,
}
for i,settingType in ipairs(attrtypeList)do
local cfgs=UISettingConfig.getSelfAllCfg(settingType)
for _,v in pairs(cfgs)do
local unlock=UISettingModel:checkSettingIdUnlock_Type(settingType,v.id)
if v.jzattr and unlock then
local starNum=UISettingModel:getStarNum(settingType,v.id)
for __,v2 in ipairs(v.jzattr)do
if not lookupList then
lookupList={}
end
if lookupList[v2[1]]then
lookupList[v2[1]]=lookupList[v2[1]]+v2[2]
else
lookupList[v2[1]]=v2[2]
end
end
if starNum>0 then
for __,v2 in ipairs(v.star_jzattr[starNum])do
if not lookupList then
lookupList={}
end
if lookupList[v2[1]]then
lookupList[v2[1]]=lookupList[v2[1]]+v2[2]
else
lookupList[v2[1]]=v2[2]
end
end
end
end
end
end
return lookupList
end

function UISettingModel:getAddJZAttrAttachList()
local lookupList={}
local attrtypeList={
kuangType.zongmen,
kuangType.yunzhou,
}
local attachList={}
for i,settingType in ipairs(attrtypeList)do
local cfgs=UISettingConfig.getSelfAllCfg(settingType)
for _,v in pairs(cfgs)do

if v.jzattr then
for __,v2 in ipairs(v.jzattr)do
local attrId=v2[1]
if not lookupList[attrId]then
lookupList[attrId]=true
attachList[#attachList+1]=attrId
end
end
end
end
end
return attachList
end


function UISettingModel:setShowcaseTeamList(teamList)
self.data.showcaseTeamList=teamList
end

function UISettingModel:getShowcaseTeamList()
return self.data.showcaseTeamList
end

function UISettingModel:initRedDotShowcase()
local l_red=userActorSetting.get('showcaseTeamRedDot',false)
self.data.showcaseTeamRedDot=not l_red and systemModel.isOpen(SYSTEM_DEFINE.eTeamShowcase)
end

function UISettingModel:checkRedDotShowcase()
return self.data.showcaseTeamRedDot
end
