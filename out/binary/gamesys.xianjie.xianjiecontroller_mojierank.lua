







xianjieController.data_mjRank={}
xianjieController.data_mjJieDuanSan={}
xianjieController.data_ShowRank={}
xianjieController.Ranktype={
xfRank=1,
mhRank=2,
}
xianjieController.ShowRank={
[xianjieController.Ranktype.xfRank]={
name='仙伐榜',

open=function()
return true
end,
openfunction=function(self,win)
xianjieController:OpenMoJieRankWin(2,1)
end,
closefunction=function(self,win)
UIManager:invokeUIMethod("UIMoJieRankBlackWin","onCloseClick")

end,

uinamebig="button_zhenfabang_1",
uiname='button_zhengfabang',
},
[xianjieController.Ranktype.mhRank]={
name='魔核榜',
open=function()
local nowsaijiid=xianjieController:getMoJieSaiJiID()
local mojiecfg=cfgHelper.get1(cfg_mojiemoherankconfig_get,nowsaijiid)
if mojiecfg then
return true
else
return false
end
end,
openfunction=function(self,win)
xianjieController:OpenMoHeRankWin()
end,

closefunction=function(self,win)

UIManager:closeWindow("UIMoJieMoHeBlackWin")
UIManager:closeWindow("UIMoJieRankMoHePeopleWin")
UIManager:closeWindow("UIMoJieRankSelectInternalWin")
UIManager:closeWindow("UIMoJieRankMoHeXMWin")

end,
uinamebig="button_mohebang_1",
uiname='button_mohebang',
}
}
function xianjieController:onAppStart_RankMoJie()
xianjieController:onAppStart_RankMoHe()

socketManager:register_receiver(35,148,xianjieController.recv_protocol_35_148)

socketManager:register_receiver(35,236,xianjieController.recv_protocol_35_236)
socketManager:register_receiver(35,237,xianjieController.recv_protocol_35_237)
socketManager:register_receiver(35,238,xianjieController.recv_protocol_35_238)
end

function xianjieController:onEnterState_RankMoJie(isReconnet)
xianjieController:onEnterState_RankMoHe(isReconnet)
xianjieController:InitmjJieDuanSan()
notifySystem:listenNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
end

function xianjieController:onLeaveState_RankMoJie(isReconnet)
xianjieController:onLeaveState_RankMoHe(isReconnet)
notifySystem:removelistener(notifyConfig.onRankListRefresh,self.onRankListRefresh)
self.data_mjRank={}
self.data_mjJieDuanSan={}
self.data_ShowRank={}
end

function xianjieController:onProtocolReqKF_RankMoJie(isReconnet)

end

function xianjieController:onEnterMap_RankMoJie(ischange,enterParam)

end

function xianjieController:onLeaveMap_RankMoJie(ischange)

end


function xianjieController:send_35_148()
socketManager:send_35_148()
end


function xianjieController.recv_protocol_35_148(arry)
xianjieController:setXianFaListData(arry[1],arry[2],arry[3],arry[4],arry[5],arry[6],arry[7],arry[8])
end

function xianjieController:setXianFaListData(xfval,xfnum,len1,xflist,len2,zmlist,dailylistlen,dailyList)
self.data_mjRank.xfval=xfval or 0
self.data_mjRank.xfnum=xfnum or 0




if len1>0 and xflist then
self.data_mjRank.xfList={}
self.data_mjRank.xsList={}
self.data_mjRank.xsList2={}
for k,v in ipairs(xflist)do
local temp={}
local temp2={}
local index=v.param_1
if 11<=index and index<=19 then
temp={[index-10]=v.param_2}
table.insert(self.data_mjRank.xfList,temp)
elseif 21<=index and index<=29 then
temp={[index-20]=v.param_2}
table.insert(self.data_mjRank.xsList,temp)
temp2={index-20,v.param_2}
table.insert(self.data_mjRank.xsList2,temp2)
end
end
end

self.data_mjRank.zmList={}
if len2>0 and zmlist then
self.data_mjRank.zmList=zmlist
end

self.data_mjRank.dailyList={}
if dailylistlen>0 and dailyList then
for k,v in ipairs(dailyList)do
if v.param_1 and v.param_2 then
self.data_mjRank.dailyList[v.param_1]=mathHelper.int64_to_number(v.param_2)
end
end
end

end

function xianjieController:getXianFaxfval()
return self.data_mjRank.xfval
end

function xianjieController:getXianFaxfnum()
return self.data_mjRank.xfnum
end

function xianjieController:getXianFaList()
return self.data_mjRank.xfList
end

function xianjieController:getXianSunList()
return self.data_mjRank.xsList
end

function xianjieController:getXianSunList2()
return self.data_mjRank.xsList2
end

function xianjieController:getZMList()
return self.data_mjRank.zmList
end

function xianjieController:getDailyList()
return self.data_mjRank.dailyList
end


function xianjieController:getmojieCurrRankType(flag)
if flag==1 then
return eRankListType.eXianFaRank
elseif flag==2 then
return eRankListType.eXianSunRank
elseif flag==3 then
return eRankListType.eZhuMoRank
elseif flag==4 then
return eRankListType.eXMZhuMoRank
end
end

function xianjieController:getmojieRankList(flag)
return rankListModel:getRankList(self:getmojieCurrRankType(flag))
end

function xianjieController:checkmojieRankTime(flag)
return rankListModel:checkRankTime(self:getmojieCurrRankType(flag))
end

function xianjieController:getmojieMyRank(flag)
return rankListModel:getRankNo(self:getmojieCurrRankType(flag))or 0
end

function xianjieController:reqmojieRankData(flag)
rankListController:send_24_5(self:getmojieCurrRankType(flag))
end

function xianjieController.onRankListRefresh(rankType)

UIManager:invokeUIMethod("UIMoJieRankGRZXWin","severmkrankfresh",rankType)
UIManager:invokeUIMethod("UIMoJieRankGRXSWin","severmkrankfresh",rankType)
UIManager:invokeUIMethod("UIMoJieRankGRFMWin","severmkrankfresh",rankType)
UIManager:invokeUIMethod("UIMoJieRankXMFMWin","severmkrankfresh",rankType)
end


function xianjieController:CheckMoJieRankOpen()

local enterData=xianjieModel:getMoJieEnterData()
local nowTime=timeHelper.getServerShortTime()
if enterData==nil or nowTime>=enterData.eTime then

else

end
end

function xianjieController:OpenMoJieRankWin(id,subid)
xianjieController:send_35_148()
if id==1 then
if subid==1 then
if xianjieController:checkmojieRankTime(1)then
xianjieController:reqmojieRankData(1)
end
else
if xianjieController:checkmojieRankTime(2)then
xianjieController:reqmojieRankData(2)
end
end
else
if subid==1 then
if xianjieController:checkmojieRankTime(3)then
xianjieController:reqmojieRankData(3)
end
else
if xianjieController:checkmojieRankTime(4)then
xianjieController:reqmojieRankData(4)
end
end
end

UIManager:showWindow('UIMoJieRankBlackWin',{id=id,subid=subid})
UIManager:showWindow("UIMoJieRankSelectInternalWin",{rankType=xianjieController.Ranktype.xfRank})

end



function xianjieController:getMoJieSaiJiID()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
return enterData.sId
end
end

function xianjieController:getMoJieSaiJiWanFaID()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local cfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
if cfg and cfg.csid then
return cfg.csid
end
end
end

function xianjieController:getMoJieSaiJiChapteridx()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local cfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
if cfg and cfg.csid then
local nowchapteridx,stage=seasonModel:getHandleLastOpenStage(cfg.csid)
return nowchapteridx,stage
end
end
end

function xianjieController:getMoJieSaiJieTime()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
return enterData.eTime,enterData.sTime
end
end





function xianjieController:checkMoJieSaiJieFirstOpen()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local nowTime=timeHelper.getServerShortTime()
local sid=enterData.sId
if sid==0 then
if enterData.sTime then
return nowTime>enterData.sTime
else
logErr('魔界第0赛季开始时间 enterData.sTime = nil')
end
elseif sid>0 then
return true
else
logErr('魔界赛季id为 nil或小于0')
end
end
return false
end

function xianjieController:CheckMoJieSaiJieActityeTime()
local enterData=xianjieModel:getMoJieEnterData()
local nowTime=timeHelper.getServerShortTime()
if enterData==nil or nowTime>=enterData.eTime then
return false
end
if nowTime<enterData.sTime then
return false
end
return true
end

function xianjieController:CheckMoJieSaiJieActityeTimeShop()
local enterData=xianjieModel:getMoJieEnterData()
local nowTime=timeHelper.getServerShortTime()
local const_def=cfgHelper.getdef(cfg_devildomshopconfig)
local duration=const_def.duration
if enterData==nil then
return false
end
if not xianjieModel:checkJoin()then
return false
end
if not MojiePreviewExtendController.checkPoKaiMoJieFlag()then
return false
end
if nowTime>=enterData.eTime+duration then
return false
end
if nowTime<enterData.sTime then
return false
end
return true
end

function xianjieController:isMoJiShiLiShow()
local flag=xianjieController:CheckMoJieSaiJieActityeTime()
return flag
end

function xianjieController:CheckMjJieDuanSanShow()

local flag=xianjieController:CheckMoJieSaiJieActityeTime()
local flag2=false
local nowsaijiid=xianjieController:getMoJieSaiJiID()

local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local cfg=nil
local csid=xianjieModel:getMoJieEnterConfig("csid")
cfg=cfg_devildomshenyuanmizangconfig_get(csid)
if not cfg then
cfg=cfg_devildomshenyuanmizangconfig_get(1)
end
local devildom_stage=cfg.devildom_stage
if devildom_stage then
local nowTime=timeHelper.getServerShortTime()
if nowTime<enterData.eTime then
local csid=xianjieModel:getMoJieEnterConfig("csid")
if csid and seasonController:checkSeasonStageBegined(csid,devildom_stage)then
flag2=true
end
end
end
end
return flag and flag2
end




function xianjieController.recv_protocol_35_236(cnt,rewardIdxList,big_reward_cnt,sbig_reward_cnt)
xianjieController:SetmjJieDuanSanCJ(cnt,rewardIdxList,big_reward_cnt,sbig_reward_cnt)
UIManager:invokeUIMethod("UIMoJie_SYMZMainWin","SrverrefreshView",cnt,big_reward_cnt,sbig_reward_cnt)

end

function xianjieController.recv_protocol_35_237(big_reward_cnt,sbig_reward_cnt)
xianjieController:initmjJieDuanSanCJ(big_reward_cnt,sbig_reward_cnt)
end

function xianjieController.recv_protocol_35_238(item_id,x,y,guid)

if guid then
if guid==-1 then
UIManager.info('附近没有空位，暂时无法使用')
logErr(FMT.fmt('35_238 后端生成失败,返回参数-1,x={0},y={1},道具id={2}',x,y,item_id))
elseif guid==-2 then
local monsterTypeName=xianjieModel:getSgMonsterTypeName()
UIManager.info(FMT.fmt('【{0}】现存数量过多，请稍后再使用',monsterTypeName))
else
UIManager:invokeUIMethod("UIMoJieExp_monsterWin","severfreshSG",guid,true)
end
end
end


function xianjieController:InitmjJieDuanSan()
self.data_mjJieDuanSan.cnt=0
self.data_mjJieDuanSan.rewardIdxList={}
self.data_mjJieDuanSan.big_reward_cnt=0
self.data_mjJieDuanSan.sbig_reward_cnt=0
end

function xianjieController:SetmjJieDuanSanCJ(cnt,rewardIdxList,big_reward_cnt,sbig_reward_cnt)
self.data_mjJieDuanSan.cnt=cnt
self.data_mjJieDuanSan.rewardIdxList=rewardIdxList
self.data_mjJieDuanSan.big_reward_cnt=big_reward_cnt
self.data_mjJieDuanSan.sbig_reward_cnt=sbig_reward_cnt
end

function xianjieController:initmjJieDuanSanCJ(big_reward_cnt,sbig_reward_cnt)
self.data_mjJieDuanSan.big_reward_cnt=big_reward_cnt
self.data_mjJieDuanSan.sbig_reward_cnt=sbig_reward_cnt
end



function xianjieController:send_35_236(cnt)
socketManager:send_35_236(cnt)
end

function xianjieController:send_35_238(item_id,x,y)
socketManager:send_35_238(item_id,x,y)
end














function xianjieController:check_MjJieDuanSan_SYMZEnter()
local flag=xianjieController:CheckMjJieDuanSanShow()
return flag
end

function xianjieController:check_MjJieDuanSan_SYMZReddot()
local cfg=nil
local csid=xianjieModel:getMoJieEnterConfig("csid")
cfg=cfg_devildomshenyuanmizangconfig_get(csid)

if cfg and cfg.cost then
local Cost2=cfg.cost[2]
if Cost2 then
local moneyId=Cost2[1]
local many=Cost2[2]
local havenum=itemsModel.getCount(moneyId)
if havenum<many then
return false
else
return true
end
end
end
return false
end

function xianjieController:open_MjJieDuanSan_SYMZWin()
UIManager:showWindow('UIMoJie_SYMZMainWin')
end


function xianjieController:check_MjJieDuanSan_SYMZCostItemId(itemId)
local cfg=nil
local csid=xianjieModel:getMoJieEnterConfig("csid")
cfg=cfg_devildomshenyuanmizangconfig_get(csid)

if cfg and cfg.cost then
local costList=cfg.cost
for _,v in ipairs(costList)do
local costItemId=v[1]
if itemId==costItemId then
return true
end
end
end
return false
end


function xianjieController:get_MjJieDuanSan_bigcnt()
return self.data_mjJieDuanSan.big_reward_cnt or 0
end
function xianjieController:get_MjJieDuanSan_Sbigcnt()
return self.data_mjJieDuanSan.sbig_reward_cnt or 0
end

function xianjieController:get_MjJieDuanSan_ItemId()

local create_monster=cfgHelper.get2(cfg_devildombaseconfig_get,1,'create_monster')
local itemid
if create_monster then
local csid=xianjieModel:getMoJieEnterConfig('csid')
local creatermonster=create_monster[csid]
if not creatermonster then
logErr("上古魔物缺少对应赛季玩法配置")
return
end
for key,v in pairs(creatermonster)do
itemid=key
end
end
return itemid
end

function xianjieController:get_MjJieDuanSan_MaxNum(entityType)
local create_monster_limit=cfgHelper.get2(cfg_devildombaseconfig_get,1,'create_monster_limit')
return create_monster_limit[entityType]or 0
end

function xianjieController:check_MjJieDuanSan_ZongMenBenZhen()
local sceneType=xianjieModel:getScenceType()
if xianjienSceneType:isMoJie(sceneType)then
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local sceneidx=zmPos[1]
local gridX=zmPos[2]
local gridZ=zmPos[3]
local areaID_zm=xianjieModel:checkMapGridDataAreaID(sceneidx,gridX,gridZ)
if areaID_zm~=0 then
return true
end
end
return false
end


function xianjieController:creat_MjJieDuanSan_Entity(item_id,raduis)
if self:check_MjJieDuanSan_ZongMenBenZhen()then
UIManager.info('仙域本阵内受阵法保护，无法使用裂隙石')
return
end
local arry=xianjieController:get_MjJieDuanSan_Pos(raduis)
if arry then
local x=arry[1]
local y=arry[2]

else
UIManager.info('附近没有空位，暂时无法使用')
end
end

function xianjieController:get_MjJieDuanSan_Pos(raduis)
local sceneType=xianjieModel:getScenceType()
if xianjienSceneType:isMoJie(sceneType)then
raduis=raduis or 10
local arry={0,0,0}
local entityType=xjServerEnityType.eMoJieShangGuMoster
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local gridWidth,gridHeight=xianjieModel:getZongMenSize()
local sceneidx=zmPos[1]
local gridX=zmPos[2]
local gridZ=zmPos[3]
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,gridWidth,gridHeight)
local cfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,entityType)






local templist=xianjieModel:findPointByDistance(sceneidx,gridX_c,gridZ_c,raduis,cfg.size[1],cfg.size[2])
local list={}
for k,v in ipairs(templist)do











if v[1]<194 or v[1]>192 then

end
end

local count=#list
if count>0 then
local point=count>1 and list[math.random(1,#list)]or list[1]
arry[1]=point[1]
arry[2]=point[2]
arry[3]=sceneidx
else
if xianjieController:checkGridInMap(gridX+5,gridZ,sceneidx)then
arry[1]=gridX+5
arry[2]=gridZ
arry[3]=sceneidx
else
arry[1]=gridX-5
arry[2]=gridZ
arry[3]=sceneidx
end
local areaID_=xianjieModel:checkMapGridDataAreaIDHuJian(arry[3],arry[1],arry[2])
if areaID_>0 then
return
end
end
return arry
else
return
end
end

function xianjieController:check_MoJieMonster_FightTip(infoguid)
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData then
local flag,g_list,errorParams=monsterData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法进攻本阵内的魔物"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法进攻阵外的魔物"
else

errStr="处于本阵内无法进攻其他本阵内的魔物"
end
UIManager.error(errStr)
end
return false
end
end
return true
end


function xianjieController:can_MjJieDuanSan_BXcaiji()
local entitytype=xjServerEnityType.eMoJieBox
local sg_rewardTimeConf=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"info",1,entitytype)
if sg_rewardTimeConf and entitytype==xjServerEnityType.eMoJieBox then
local maxTimes=sg_rewardTimeConf[1]
local curTimes=xianjieModel:getMonsterRewardTimes(entitytype)
local least=maxTimes-curTimes
if least<=0 then
return false
else
return true
end
end
return true
end

function xianjieController:is_MjJieDuanSan_BXcaijied(infoguid)
if xianjieModel:checkMJboxgatherLookup(infoguid)then
return true
end
end

function xianjieController:is_MjJieDuanSan_BXcaijiedEX(infoguid_str)
if xianjieModel:checkMJboxgatherLookupEX(infoguid_str)then
return true
end
end

function xianjieController:findToZongMenDistance(gridX_c,gridZ_c,gridX_c_,gridZ_c_)
local dis=mathHelper.distance(gridX_c,gridZ_c,gridX_c_,gridZ_c_)or 0
return math.abs(dis)
end

function xianjieController:check_MjJieDuanSan_BaoXiangNum()
if not self:can_MjJieDuanSan_BXcaiji()then
return false
end
local mindis=-1
local get_infoguid
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local xmGuid=xianmengModel:myXMGuildID()
if zmPos then
local gridX=zmPos[2]
local gridZ=zmPos[3]
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,1,1)
local MJboxDatas=xianjieModel:getMJboxData()

if MJboxDatas then
local WaiPaiTeam=self:get_WaiPaiTeamData()
for infoguid_str,v in pairs(MJboxDatas)do
local monsterData=xianjieModel:getMonsterDataEx(infoguid_str)
if monsterData and not monsterData.isExpire then
local Caijied=self:is_MjJieDuanSan_BXcaijiedEX(infoguid_str)
local isWaiPai=WaiPaiTeam[infoguid_str]
local isSelf=xianmengModel:compareTwoGuildID(xmGuid,monsterData.owner_guild_id)
if not Caijied and not isWaiPai and isSelf then
local dis=self:findToZongMenDistance(monsterData.gridX_c,monsterData.gridZ_c,gridX_c,gridZ_c)
if mindis<0 then
mindis=dis
get_infoguid=infoguid_str
end
if dis<mindis then
mindis=dis
get_infoguid=infoguid_str
end
end
end
end
end
end
return get_infoguid
end

function xianjieController:get_WaiPaiTeamData()
local temp={}
local teamDataList=xianjieModel:getOnlyWaiPaiTeamData()
if teamDataList then
for _,v in ipairs(teamDataList)do
local teamData=v.teamData
local occupytype=v.occupytype
if occupytype==xjWaiPiaBaseType.eMarckTeam then
local guid=teamData.tarcbid
if guid then
temp[tostring(guid)]=true
end
end
end
end
return temp
end

function xianjieController:check_MoJieEntityHuJian_Unlock(sceneidx,gridX,gridZ)
if not xianjienSceneIndexType:isMoJie(sceneidx)then
return true
end
local Allarea=xianjieModel:getMoJieEnterConfig("area")
local csid=xianjieModel:getMoJieEnterConfig("csid")
local areaID=xianjieModel:checkMapGridDataAreaIDHuJian(sceneidx,gridX,gridZ)
local chapter_idx=Allarea[areaID]
if areaID and chapter_idx then
if chapter_idx==0 then
return true
end
if seasonController:checkSeasonStageBegined(csid,chapter_idx)then
return true
end
else



end
return false
end

function xianjieController:check_MoJieEntityFight_Gate(sceneidx,gridX,gridZ)
if not xianjienSceneIndexType:isMoJie(sceneidx)then
return true
end
local csid=xianjieModel:getMoJieEnterConfig("csid")
local gateChapterIdx=seasonModel:getStageIdx(csid,seasonStageType.eGKYS)
if gateChapterIdx==nil then return false end


local zmData=xianjieModel:getZongMenOutPos_mojie()
if zmData==nil then return false end
local zmAreaID=xianjieModel:checkMapGridDataAreaIDHuJian(zmData[1],zmData[2],zmData[3])


local Allarea=xianjieModel:getMoJieEnterConfig("area")
local entityAreaID=xianjieModel:checkMapGridDataAreaIDHuJian(sceneidx,gridX,gridZ)

local entityChapterIdx=Allarea[entityAreaID]
local zmChapterIdx=Allarea[zmAreaID]

if entityChapterIdx==zmChapterIdx then
return true
elseif entityChapterIdx<=gateChapterIdx and zmChapterIdx<=gateChapterIdx then
return true
elseif entityChapterIdx>gateChapterIdx and zmChapterIdx>gateChapterIdx then
return true
else
return false
end
end



function xianjieController:MoJieShop_Enter()
local isOpen=self:CheckMoJieSaiJieActityeTimeShop()
if isOpen then
local hasXM=xianmengModel:hasXM()
if not hasXM then
UIManager.info('未加入仙盟')
else
if not zongmenControl:isRequireBuilding(SLG_SYSTEM_TYPE.eXianMengShanDian)then
UIManager.info('未建造仙盟商店')
return false
end
funcShopController:openShopWin({shopId=eFuncShopType.eMojieSaiJi})
end
else
UIManager.info('魔界赛季已休赛')
end
end

function xianjieController:checkMoJieYanShiShop()
local enterData=xianjieModel:getMoJieEnterData()
local nowTime=timeHelper.getServerShortTime()
local const_def=cfgHelper.getdef(cfg_devildomshopconfig)
local duration=const_def.duration
if enterData==nil then
return false
end
if nowTime<enterData.sTime then
return false
end
if nowTime>enterData.eTime then
if nowTime<enterData.eTime+duration then
return true
end
end
return false
end

function xianjieController:showMoJieYanShiShop()
local enterData=xianjieModel:getMoJieEnterData()
local nowTime=timeHelper.getServerShortTime()
local const_def=cfgHelper.getdef(cfg_devildomshopconfig)
local duration=const_def.duration
if enterData then
if not xianjieModel:checkJoin()then
return false
end
if not MojiePreviewExtendController.checkPoKaiMoJieFlag()then
return false
end
if nowTime>=enterData.eTime then
if nowTime<=enterData.eTime+duration then
local begintime=nowTime
local endtime=enterData.eTime+duration
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eMoJieShop,begintime,endtime)
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMoJieShop)
if not flag then

local cfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
if cfg.auto and cfg.auto[1]then
local moneyType=cfg.auto[1][1]
local num=itemsModel.getCount(moneyType)
if num>0 then


msgWinControl:addMsgWin(msgWinType.eMoJieShop,{},nil,true)

end
end
end
end
end
end
end

function xianjieController:testttMoJieYanShiShop()
local enterData=xianjieModel:getMoJieEnterData()
local const_def=cfgHelper.getdef(cfg_devildomshopconfig)
local duration=const_def.duration
local nowTime=timeHelper.getServerShortTime()
local begintime=nowTime
local endtime=nowTime+120

limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eMoJieShop,begintime,endtime)
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMoJieShop)
if not flag then
msgWinControl:addMsgWin(msgWinType.eMoJieShop)
end
end

function xianjieController:testttMoJieYanShiShop2()
UIManager:showWindow('UIMJ_ShopWinChangeTipsWin')
end



function xianjieController:testttjump1(agrs)
jumpManager:jump(agrs)

end

function xianjieController:jump_MjShenYuanMiZang(args)
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启")
return false
end
local isSGshow=xianjieController:CheckMjJieDuanSanShow()
if not isSGshow then
local nowsaijiid=xianjieController:getMoJieSaiJiID()
local cfg=nil
if not nowsaijiid then
cfg=cfg_devildomshenyuanmizangconfig_get(1)
else
local csid=xianjieModel:getMoJieEnterConfig("csid")
cfg=cfg_devildomshenyuanmizangconfig_get(csid)
end
local devildom_stage=cfg.devildom_stage or 2
local num_str=FMT.fmt('魔界第{0}章节未开启，无法使用',mathHelper.numberToChinese(devildom_stage))
UIManager.error(num_str)
return false
end
local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)then
xianjieController:open_MjJieDuanSan_SYMZWin()
else
local sceneType=xianjieModel:getCurrentMoJieSceneType()
xianjieController:jumpXianJie(sceneType,nil,function()
xianjieController:open_MjJieDuanSan_SYMZWin()
end)
end
end

function xianjieController:jump_MjShouXun_hujian(args)
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启")
return false
end
local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)then
xianjieController:openWin('UIMoJieExplorationWin',{page=args.page,extra=args.extra})
else
local sceneType=xianjieModel:getCurrentMoJieSceneType()
xianjieController:jumpXianJie(sceneType,nil,function()
xianjieController:openWin('UIMoJieExplorationWin',{page=args.page,extra=args.extra})
end)
end
end

function xianjieController:jump_MjShouXun_ShangGuMonster(args)


local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启")
return false
end
local isSGshow=xianjieController:CheckMjJieDuanSanShow()
if not isSGshow then
local cfg=nil

local csid=xianjieModel:getMoJieEnterConfig("csid")
cfg=cfg_devildomshenyuanmizangconfig_get(csid)

local devildom_stage=cfg.devildom_stage or 2
local num_str=FMT.fmt('魔界第{0}章节未开启，无法使用',mathHelper.numberToChinese(devildom_stage))
UIManager.error(num_str)
return false
end
local sceneidx=xianjieModel:getSceneIndex()
if sceneidx and xianjienSceneIndexType:isMoJie(sceneidx)then
xianjieController:openWin('UIMoJieExplorationWin',{page=1,extra={selecttype=17,selectsttype=17,isguMonster=true}})
else
local sceneType=xianjieModel:getCurrentMoJieSceneType()
xianjieController:jumpXianJie(sceneType,nil,function()
xianjieController:openWin('UIMoJieExplorationWin',{page=1,extra={selecttype=17,selectsttype=17,isguMonster=true}})
end)
end
end

function xianjieController:jump_MjFore_SkillUP(args)
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启")
return false
end
local win=UIManager:findActiveWindow("UIJiuYuanMainMJWin")
local win2=UIManager:findActiveWindow("UIYuJingMainMJWin")
local win3=UIManager:findActiveWindow("UIPengLaiMainMJWin")
if win or win2 or win3 then
UIManager:closeWindow('UIMoJieForceTaskWin')
local temp
if args and args.showtips then
temp={}
temp.flag=1
temp.showtips=args.showtips
end
xianjieController:OpenMoJieShiLiSkillWin(temp)
else
local temp
if args and args.showtips then
temp={}
temp.flag=1
temp.showtips=args.showtips
end
xianjieController:OpenMoJieShiLiWinByForce(temp)
end
end



function xianjieController:GetShowRank()
local tabledata={}
for k,v in ipairs(xianjieController.ShowRank)do
if v.open()then
table.insert(tabledata,v)
end
end
return tabledata
end
