







function xianmengModel:clearData_TYSC()
self.data_TYSC=nil
self.sellRewars_TYSC=nil
self.sellRewarsNum_TYSC=nil
self.notesList_tysc=nil
self.showNoteIndex_tysc=nil
self.needopenquickwin=nil

xianmengModel:clearRankList_TYSC()
xianmengModel:clearMonsterList_TYSC()
end


function xianmengModel:checkInit_TYSC()
return self.data_TYSC~=nil
end

function xianmengModel:initData_TYSC(data)
self.data_TYSC=data
end

function xianmengModel:getData_TYSC()
return self.data_TYSC
end

function xianmengModel:getPreScore_TYSC()
if self.data_TYSC then
return self.data_TYSC.jifenPre
end
return 0
end

function xianmengModel:getNowScore_TYSC()
if self.data_TYSC then
return self.data_TYSC.jifenNow
end
return 0
end

function xianmengModel:getMyScore_TYSC()
if self.data_TYSC then
return self.data_TYSC.jifenMy
end
return 0
end

function xianmengModel:getMyRewardScore_TYSC()
if self.data_TYSC then
return self.data_TYSC.myJiFenReward
end
return 0
end

function xianmengModel:getSoreFloor_TYSC(level,score_)
local max=cfgHelper.get3(cfg_skyshouchaojibieconfig_get,level,'pmpReward',1)
local floor=math.floor(score_/max)
local cur=score_%max
return floor,cur,max
end

function xianmengModel:getLevel_TYSC()
if self.data_TYSC then
return self.data_TYSC.level
end
return 0
end

function xianmengModel:getPreLevel_TYSC()
if self.data_TYSC then
return self.data_TYSC.preLevel
end
return 0
end

function xianmengModel:getLevelEx_TYSC()
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eTianYuanShouChao)then
return xianmengModel:getLevel_TYSC()
else
local pre=xianmengModel:getPreLevel_TYSC()
if pre>0 then
return pre
else
return xianmengModel:getLevel_TYSC()
end
end
end

function xianmengModel:getKillMonsterNum_TYSC()
if self.data_TYSC then
return self.data_TYSC.monDieNum
end
return 0
end


function xianmengModel:getBossNum_TYSC()
if self.data_TYSC then
local shoulingList=self.data_TYSC.shoulingList
if shoulingList then
return#shoulingList
end
end
return 0
end


function xianmengModel:getRefreshBossNum_TYSC()
if self.data_TYSC then
return self.data_TYSC.scHisNum
end
return 0
end

function xianmengModel:setRefreshBossNum_TYSC(num)
if self.data_TYSC then
self.data_TYSC.scHisNum=num
end
end

function xianmengModel:getBossDataList_TYSC()
if self.data_TYSC then
return self.data_TYSC.shoulingList
end
return nil
end

function xianmengModel:getBossDataByGuid_TYSC(guid)
if self.data_TYSC then
for i,v in ipairs(self.data_TYSC.shoulingList)do
if mathHelper.compareInt64(v.guid,guid)then
return v
end
end
end
return nil,nil
end


function xianmengModel:updataBossList_TYSC(shouling,changeType)
if self.data_TYSC==nil then return false,nil end
local shoulingList=self.data_TYSC.shoulingList

local isChange=false
if changeType==CHANGE_TYPE.eAdd then
local f
for i,sl in ipairs(shoulingList)do
if mathHelper.compareInt64(sl.guid,shouling.guid)then
shoulingList[i]=shouling
f=i
break
end
end
if not f then
isChange=true
table.insert(shoulingList,shouling)
local monster=xianmengModel:addMonster_TYSC(MONSTER_TYPE.eShouLing,shouling)
if monster then
UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','refreshMonster',monster)
end
end
elseif changeType==CHANGE_TYPE.eDelete then
local f
for i,sl in ipairs(shoulingList)do
if mathHelper.compareInt64(sl.guid,shouling.guid)then
f=i
break
end
end
if f then
isChange=true
local guid_=shouling.guid
local data=table.remove(shoulingList,f)
local posIdx=xianmengModel:removeMonster_TYSC(MONSTER_TYPE.eShouLing,guid_)
if posIdx then
UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','killBoss_anim',MONSTER_TYPE.eShouLing,posIdx)
end
UIManager:invokeUIMethod('UIXM_TYSCquickWin','dealBOSSisDie',guid_)
end
elseif changeType==CHANGE_TYPE.eChanged then
local f
for i,sl in ipairs(shoulingList)do
if mathHelper.compareInt64(sl.guid,shouling.guid)then
shoulingList[i]=shouling
f=i
break
end
end
if f then
isChange=true
local monster=xianmengModel:getMonsterByGuid_TYSC(MONSTER_TYPE.eShouLing,shouling.guid)
if monster then
UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','refreshBossBlood',nil,monster)
end
end
end
return isChange
end


function xianmengModel:getChallengeNum1_TYSC()
if self.data_TYSC then
return self.data_TYSC.tzNum1
end
return 0
end


function xianmengModel:refreshChallengeNum1_TYSC()
if self.data_TYSC then
local tzNum1=self.data_TYSC.tzNum1
if tzNum1>0 then
tzNum1=tzNum1-1
end
self.data_TYSC.tzNum1=tzNum1
end
end


function xianmengModel:getChallengeNum2_TYSC(guid)
local sldata=xianmengModel:getBossDataByGuid_TYSC(guid)
if sldata then
local freeNum=cfgHelper.get3(cfg_skyshouchaobaseconfig_get,1,'shoulingNum',1)
local num=freeNum+sldata.buyNum-sldata.tzNum
if num<0 then num=0 end
return num
end
return 0
end


function xianmengModel:getChallengeNum3_TYSC(guid)
local sldata=xianmengModel:getBossDataByGuid_TYSC(guid)
if sldata then
local shoulingNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shoulingNum')
local freeNum=shoulingNum[1]
local maxBuyNum=shoulingNum[2]
local num=freeNum+maxBuyNum-sldata.tzNum
if num<0 then num=0 end
return num
end
return 0
end

function xianmengModel:getCanChallengeBoss()
if self.data_TYSC then
local shoulingList=self.data_TYSC.shoulingList
if shoulingList then
for i,v in ipairs(shoulingList)do
if xianmengModel:getChallengeNum2_TYSC(v.guid)>0 then
return v.guid
end
end
end
end
end


function xianmengModel:refreshChallengeNum2_TYSC(guid)
UIManager:invokeUIMethod('UILimitActStorageWin','refreshTipsShow',LIMIT_ACT_TYPE.eTianYuanShouChao)





end

function xianmengModel:setChallengeStamp(stamp)
if self.data_TYSC then
self.data_TYSC.challengeStamp=stamp
end
end

function xianmengModel:getChallengeStamp()
if not self.data_TYSC then
return 0
end
if not self.data_TYSC.challengeStamp then
return 0
end

if timeHelper.getServerOpenDay()>7 then
return 0
end
return self.data_TYSC.challengeStamp
end

function xianmengModel:getChallengeBuyNum1_TYSC()
if self.data_TYSC then
return self.data_TYSC.scBuyNum
end
return 0
end

function xianmengModel:canBuyChallengeBuyNum1_TYSC()
local shouchaoNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shouchaoNum')
local maxBuyNum=shouchaoNum[2]
local curBuyNum=xianmengModel:getChallengeBuyNum1_TYSC()
return(maxBuyNum-curBuyNum)>0

end


function xianmengModel:getChallengeBuyNum2_TYSC(guid)
local sldata=xianmengModel:getBossDataByGuid_TYSC(guid)
if sldata then
return sldata.buyNum
end
return 0
end

function xianmengModel:getSellRewardNum_TYSC()
if self.data_TYSC then
return self.data_TYSC.pmpNum
end
return 0
end

function xianmengModel:getMonsterLevel_TYSC(monsterType)
if self.data_TYSC then
if monsterType==MONSTER_TYPE.eXiaoGuai then
return self.data_TYSC.monster1Level
else
return self.data_TYSC.monster2Level
end
end
return 0
end

function xianmengModel:getLevelName_TYSC(level)
local name=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,level,'name')
return name
end

function xianmengModel:getLevelName2_TYSC(level)
local name=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,level,'name')
return FMT.fmt('{0}兽潮',name)
end

function xianmengModel:getLevelName3_TYSC(level)
local name=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,level,'name')
return FMT.fmt('{0}首领',name)
end

function xianmengModel:checkRankReddot_TYSC()
local level=xianmengModel:getLevelEx_TYSC()
if level>0 then
local jifenReward=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,level,'jifenReward')
local score=xianmengModel:getMyScore_TYSC()
local r_score=xianmengModel:getMyRewardScore_TYSC()
for i,v in ipairs(jifenReward)do
local fix=score>=v[1]
local flag=v[1]<=r_score
if fix and not flag then
return true
end
end
end
return false
end

function xianmengModel:checkReddot_TYSC()
if xianmengModel:checkRankReddot_TYSC()then
return true
end


return false
end



function xianmengModel:setSellRewards_TYSC(list)
self.sellRewars_TYSC=list
local num=0
if list then
for i,v in ipairs(list)do
num=num+v.param_2
end
end
self.sellRewarsNum_TYSC=num
end

function xianmengModel:getSellRewards_TYSC()
return self.sellRewars_TYSC or{}
end

function xianmengModel:checkNewSellRewards_TYSC()
local isNew=true
local num_=xianmengModel:getSellRewardNum_TYSC()
if num_>0 then
if self.sellRewars_TYSC~=nil then
local num=self.sellRewarsNum_TYSC or 0
if num==num_ then
isNew=false
end
end
else

isNew=false
end
return isNew
end





function xianmengModel:getXMRankList_TYSC()
return self.xmRankList_TYSC
end

function xianmengModel:setXMRankList_TYSC(list)
self.xmRankList_TYSC=list
self.rankListTime_TYSC=gameUtilityModel.getServerShortTime()
if self.rankListMark_TYSC then
self.rankListMark_TYSC=self.rankListMark_TYSC-1
end
end

function xianmengModel:getmemberRankList_TYSC()
return self.memberRankList_TYSC
end

function xianmengModel:setmemberRankList_TYSC(list)
self.memberRankList_TYSC=list
self.rankListTime_TYSC=gameUtilityModel.getServerShortTime()
if self.rankListMark_TYSC then
self.rankListMark_TYSC=self.rankListMark_TYSC-1
end
end

function xianmengModel:setRankListMark_TYSC()
self.rankListMark_TYSC=2
end

function xianmengModel:clearRankList_TYSC()
self.xmRankList_TYSC=nil
self.memberRankList_TYSC=nil
self.rankListTime_TYSC=nil
self.rankListMark_TYSC=nil
end

function xianmengModel:checkOpenRankList_TYSC()
local mark=self.rankListMark_TYSC
if mark~=nil and mark<=0 then
return true
end
return false
end

function xianmengModel:checkNewRank_TYSC()
local isNew=false
if self.xmRankList_TYSC==nil or self.memberRankList_TYSC==nil then
isNew=true
elseif limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eTianYuanShouChao)then
local cur=gameUtilityModel.getServerShortTime()
local lerp=cur-self.rankListTime_TYSC
if lerp>60 then
isNew=true
end
end
return isNew
end




local monsterID=0
local bigmonsterID=0
local bossmonsterID=0
local getMonsterID=function()
local m_id=monsterID
monsterID=monsterID+1
return m_id
end
local getBigMonsterID=function()
local m_id=bigmonsterID
bigmonsterID=bigmonsterID+1
return m_id
end
local getBossMonsterID=function()
local m_id=bossmonsterID
bossmonsterID=bossmonsterID+1
return m_id
end

function xianmengModel:checkInitMonster_TYSC()
return self.monsterList_TYSC~=nil
end

function xianmengModel:clearMonsterList_TYSC()
self.monsterList_TYSC=nil
self.monsterPosLookup_TYSC=nil
self.bigmonsterList_TYSC=nil
self.bigmonsterPosLookup_TYSC=nil
self.bossList_TYSC=nil
self.bossPosLookup_TYSC=nil
monsterID=0
bigmonsterID=0
end

function xianmengModel:initMonsterList_TYSC()
xianmengModel:clearMonsterList_TYSC()
local list,monsterType

list=self.monsterList_TYSC
if list==nil then
monsterType=MONSTER_TYPE.eXiaoGuai
list={}
local level=xianmengModel:getLevel_TYSC()
local num=cfgHelper.get3(cfg_skyshouchaojibieconfig_get,level,'monsterNum',1)
for idx=1,num do
local m_id=getMonsterID()
local monster=xianmengModel:handelMonster_TYSC(monsterType,m_id)
list[m_id]=monster
end
self.monsterList_TYSC=list
self.monsterPosLookup_TYSC={}
end

list=self.bigmonsterList_TYSC
if list==nil then
monsterType=MONSTER_TYPE.eJingYing
list={}
local level=xianmengModel:getLevel_TYSC()
local num=cfgHelper.get3(cfg_skyshouchaojibieconfig_get,level,'monsterNum',2)
for idx=1,num do
local m_id=getBigMonsterID()
local monster=xianmengModel:handelMonster_TYSC(monsterType,m_id)
list[m_id]=monster
end
self.bigmonsterList_TYSC=list
self.bigmonsterPosLookup_TYSC={}
end

list=self.bossList_TYSC
if list==nil then
monsterType=MONSTER_TYPE.eShouLing
list={}
local shoulingList=xianmengModel:getBossDataList_TYSC()
for idx,sl in ipairs(shoulingList)do
local m_id=getBossMonsterID()
local monster=xianmengModel:handelMonster_TYSC(monsterType,m_id,sl)
list[monster.m_id]=monster
end
self.bossList_TYSC=list
self.bossPosLookup_TYSC={}
end
end

function xianmengModel:getMonsterList_TYSC(monsterType)
if monsterType==MONSTER_TYPE.eXiaoGuai then

return self.monsterList_TYSC
elseif monsterType==MONSTER_TYPE.eJingYing then

return self.bigmonsterList_TYSC
elseif monsterType==MONSTER_TYPE.eShouLing then

return self.bossList_TYSC
end
end

function xianmengModel:randomMonster_TYSC(monsterType)
local level=xianmengModel:getLevel_TYSC()
local list
if monsterType==MONSTER_TYPE.eXiaoGuai then

list=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,level,'monster1')
else

list=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,level,'monster2')
end
return table.randomWeight(list,2),level
end

function xianmengModel:getMonsterByIndex_TYSC(monsterType,m_id)
if monsterType==MONSTER_TYPE.eXiaoGuai then
return self.monsterList_TYSC[m_id]
elseif monsterType==MONSTER_TYPE.eJingYing then
return self.bigmonsterList_TYSC[m_id]
elseif monsterType==MONSTER_TYPE.eShouLing then
return self.bossList_TYSC[m_id]
end
end

function xianmengModel:getMonsterByPosIdx_TYSC(monsterType,posIdx)
if monsterType==MONSTER_TYPE.eXiaoGuai then
return self.monsterPosLookup_TYSC[posIdx]
elseif monsterType==MONSTER_TYPE.eJingYing then
return self.bigmonsterPosLookup_TYSC[posIdx]
elseif monsterType==MONSTER_TYPE.eShouLing then
return self.bossPosLookup_TYSC[posIdx]
end
end

function xianmengModel:getMonsterByGuid_TYSC(monsterType,guid)
local monster
if monsterType==MONSTER_TYPE.eShouLing then
for k,monster_ in pairs(self.bossList_TYSC)do
if mathHelper.compareInt64(monster_.guid,guid)then
monster=monster_
break
end
end
end
return monster
end

function xianmengModel:handelMonster_TYSC(monsterType,m_id,data)
local d={}
d.monsterType=monsterType
if monsterType==MONSTER_TYPE.eShouLing then
local cfg=cfgHelper.get1(cfg_skyshouchaoshoulingconfig_get,data.confId)
d.m_id=m_id
d.guid=data.guid
d.monsterGroupId=cfg.gwzId
d.scale=cfg.scale or 0.5
d.scale_quick=cfg.uiquick_scale and cfg.uiquick_scale[1]or 0.5
d.quick_x=cfg.uiquick_scale and cfg.uiquick_scale[2]or 0
d.quick_y=cfg.uiquick_scale and cfg.uiquick_scale[3]or 0
else
local monstercfg,level=xianmengModel:randomMonster_TYSC(monsterType)
local scale_quick,x,y=xianmengModel:SetMonsterScale_quick(monsterType,monstercfg,level)
d.m_id=m_id
d.guid=int64.new('0')
d.monsterGroupId=monstercfg[1]
d.scale=monstercfg[3]or 0.5
d.scale_quick=scale_quick
d.quick_x=x
d.quick_y=y
end
local rand=math.random(0,1)
if rand==0 then
d.flipX=false
else
d.flipX=true
end
return d
end

function xianmengModel:SetMonsterScale_quick(monsterType,monstercfg,level)
local scale_quick=0.2
local x=0
local y=0
if monsterType==MONSTER_TYPE.eXiaoGuai then
local monster1_scale=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,level,'monster1_scale')
for k,v in ipairs(monster1_scale)do
if monstercfg[1]==v[1]then
scale_quick=v[2]
x=v[3]
y=v[4]
end
end
else
local monster2_scale=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,level,'monster2_scale')
for k,v in ipairs(monster2_scale)do
if monstercfg[1]==v[1]then
scale_quick=v[2]
x=v[3]
y=v[4]
end
end
end
return scale_quick,x,y
end

function xianmengModel:addMonster_TYSC(monsterType,data)
local monster
if monsterType==MONSTER_TYPE.eXiaoGuai then
local m_id=getMonsterID()
monster=xianmengModel:handelMonster_TYSC(monsterType,m_id)
self.monsterList_TYSC[m_id]=monster
elseif monsterType==MONSTER_TYPE.eJingYing then
local m_id=getBigMonsterID()
monster=xianmengModel:handelMonster_TYSC(monsterType,m_id)
self.bigmonsterList_TYSC[m_id]=monster
else
local m_id=getBossMonsterID()
monster=xianmengModel:handelMonster_TYSC(monsterType,m_id,data)
self.bossList_TYSC[monster.m_id]=monster
end
return monster
end

function xianmengModel:removeMonster_TYSC(monsterType,guid)
local posIdx
if monsterType==MONSTER_TYPE.eShouLing then
local monster=xianmengModel:getMonsterByGuid_TYSC(monsterType,guid)
if monster then
posIdx=monster.posIdx
local m_id=monster.m_id
if posIdx~=nil then
self.bossPosLookup_TYSC[posIdx]=nil
end
self.bossList_TYSC[m_id]=nil
end
end
return posIdx
end

function xianmengModel:removeMonsterEx_TYSC(monsterType,posIdx)
local list
if monsterType==MONSTER_TYPE.eXiaoGuai then
self.monsterPosLookup_TYSC[posIdx]=nil
list=self.monsterList_TYSC
elseif monsterType==MONSTER_TYPE.eJingYing then
self.bigmonsterPosLookup_TYSC[posIdx]=nil
list=self.bigmonsterList_TYSC
elseif monsterType==MONSTER_TYPE.eShouLing then
self.bossPosLookup_TYSC[posIdx]=nil
list=self.bossList_TYSC
end
if list then
for k,monster in pairs(list)do
if monster.posIdx==posIdx then
list[k]=nil
break
end
end
end

end

function xianmengModel:checkMonsterPos_TYSC(monsterType,posIdx)
if monsterType==MONSTER_TYPE.eXiaoGuai then
return self.monsterPosLookup_TYSC[posIdx]~=nil
elseif monsterType==MONSTER_TYPE.eJingYing then
return self.bigmonsterPosLookup_TYSC[posIdx]~=nil
elseif monsterType==MONSTER_TYPE.eShouLing then
return self.bossPosLookup_TYSC[posIdx]~=nil
end
end

function xianmengModel:setMonsterPos_TYSC(monster,posIdx)
local monsterType=monster.monsterType
monster.posIdx=posIdx
if monsterType==MONSTER_TYPE.eXiaoGuai then
self.monsterPosLookup_TYSC[posIdx]=monster
elseif monsterType==MONSTER_TYPE.eJingYing then
self.bigmonsterPosLookup_TYSC[posIdx]=monster
elseif monsterType==MONSTER_TYPE.eShouLing then
self.bossPosLookup_TYSC[posIdx]=monster
end
end

function xianmengModel:getMonsterFight_TYSC(monsterType,m_id)
if monsterType==MONSTER_TYPE.eShouLing then
local monster=xianmengModel:getMonsterByIndex_TYSC(monsterType,m_id)
local sl=xianmengModel:getBossDataByGuid_TYSC(monster.guid)
return sl.fight
else

return 0
end
end

function xianmengModel:checkBossLookFlag(guid)
local look=userActorSetting.get('tysc_boss_look',nil)
if look then
local guid_str=tostring(guid)
return look[guid_str]==true
end
return false
end

function xianmengModel:setBossLookFlag(guid)
local look=userActorSetting.get('tysc_boss_look',nil)
local guid_str=tostring(guid)
local change=false
if look then
if look[guid_str]==nil then
look[guid_str]=true
change=true
end
else
look={}
look[guid_str]=true
look.time=gameUtilityModel.getServerShortTime()
change=true
end
if change then
userActorSetting.set('tysc_boss_look',look)
userActorSetting.flush()
end
end

function xianmengModel:clearBossLookFlag(s_time,e_time)
local look=userActorSetting.get('tysc_boss_look',nil)
if look then
if look.time<s_time or look.time>=e_time then
userActorSetting.set('tysc_boss_look',nil)
userActorSetting.flush()
end
end
end





function xianmengModel:handleNote_TYSC(note)
local fmt_str
local note_fmt=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'note_fmt')
if note.gbType==1 then
fmt_str=note_fmt[1]
else
fmt_str=note_fmt[2]
end
local mname=cfgHelper.get2(cfg_monstergroup_get,note.gwzId,"name")
note.desc=FMT.fmt(fmt_str,note.name,mname)
note.playeId_str=mathHelper.int64_to_string(note.playeId)
end

function xianmengModel:initNotes_TYSC(loglist)
local notesList={}
if loglist then
for i,note in ipairs(loglist)do
self:handleNote_TYSC(note)
table.insert(notesList,note)
end
end
self.notesList_tysc=notesList
end

function xianmengModel:setNotesNew_TYSC(note)
if note==nil then return end
if self.notesList_tysc==nil then
self.notesList_tysc={}
end
self:handleNote_TYSC(note)
if note.gbType==1 then
local f
for i,v in ipairs(self.notesList_tysc)do
if v.gbType==1 and v.playeId_str==note.playeId_str then
f=i
break
end
end
if f then
table.remove(self.notesList_tysc,f)
end
end
if#self.notesList_tysc>=5 then
table.remove(self.notesList_tysc,1)
end
table.insert(self.notesList_tysc,note)
self.showNoteIndex_tysc=#self.notesList_tysc
end

function xianmengModel:getOneNoteStr_TYSC()
if self.notesList_tysc then
local c=#self.notesList_tysc
if c>0 then
if self.showNoteIndex_tysc==nil or self.showNoteIndex_tysc>c or self.showNoteIndex_tysc<=0 then
self.showNoteIndex_tysc=c
end
local note=self.notesList_tysc[self.showNoteIndex_tysc]
self.showNoteIndex_tysc=self.showNoteIndex_tysc-1

local nextRound=false
return note.desc,nextRound
end
end
end

function xianmengModel:clearNoteSelect_TYSC()
self.showNoteIndex_tysc=nil
end





function xianmengModel:GeTMonsterData(arg)
local monsterdata={}
local monsterTypeList={MONSTER_TYPE.eXiaoGuai,MONSTER_TYPE.eJingYing,MONSTER_TYPE.eShouLing}
for i,monsterType in ipairs(monsterTypeList)do
local monsterList=xianmengModel:getMonsterList_TYSC(monsterType)

monsterdata[monsterType]={}
for k,monster in pairs(monsterList)do
if monsterType==MONSTER_TYPE.eShouLing then
monsterdata[monsterType][#monsterdata[monsterType]+1]={monster}
else
monsterdata[monsterType][monster.monsterGroupId]={monster}
end
end
end
local sc_level=xianmengModel:getLevel_TYSC()
UIManager:showWindow("UIXM_TYSCquickWin",{monsterdata,sc_level,arg})

end


function xianmengModel:SetNeedOpenquickWin(flag)

self.needopenquickwin=flag
end

function xianmengModel:GetNeedOpenquickWin()

return self.needopenquickwin
end