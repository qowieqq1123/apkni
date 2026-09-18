






local nextStateStamp=nil
local nowShSeasonId=nil
local needReqSeasonData=nil
local needResetActivity=nil

function zhengzhanshanhaiController:onAppStart_season()
socketManager:register_receiver(44,181,self.recv_44_181)
socketManager:register_receiver(44,182,self.recv_44_182)
socketManager:register_receiver(44,183,self.recv_44_183)
socketManager:register_receiver(44,184,self.recv_44_184)
socketManager:register_receiver(44,185,self.recv_44_185)
socketManager:register_receiver(44,195,self.recv_44_195)
socketManager:register_receiver(44,196,self.recv_44_196)
socketManager:register_receiver(44,221,self.recv_44_221)
socketManager:register_receiver(44,222,self.recv_44_222)
socketManager:register_receiver(44,223,self.recv_44_223)
socketManager:register_receiver(44,224,self.recv_44_224)
socketManager:register_receiver(44,227,self.recv_44_227)
socketManager:register_receiver(44,231,self.recv_44_231)
socketManager:register_receiver(44,228,self.recv_44_228)
socketManager:register_receiver(44,229,self.recv_44_229)
socketManager:register_receiver(44,242,self.recv_44_242)
socketManager:register_receiver(44,233,self.recv_44_233)
socketManager:register_receiver(44,230,self.recv_44_230)
socketManager:register_receiver(44,232,self.recv_44_232)
socketManager:register_receiver(44,235,self.recv_44_235)
socketManager:register_receiver(44,236,self.recv_44_236)
socketManager:register_receiver(44,243,self.recv_44_243)
socketManager:register_receiver(44,244,self.recv_44_244)
socketManager:register_receiver(44,238,self.recv_44_238)
socketManager:register_receiver(44,237,self.recv_44_237)
socketManager:register_receiver(44,254,self.recv_44_254)

socketManager:register_receiver(44,203,self.recv_44_203)
socketManager:register_receiver(44,204,self.recv_44_204)
socketManager:register_receiver(44,205,self.recv_44_205)

socketManager:register_receiver(44,202,self.recv_44_202)
socketManager:register_receiver(44,187,self.recv_44_187)
socketManager:register_receiver(44,188,self.recv_44_188)


end

function zhengzhanshanhaiController:onEnterState_season(isReconnet)
nextStateStamp=nil
nowShSeasonId=nil
needReqSeasonData=nil
needResetActivity=nil
timeEventController.addNormalTimerHandler(1,'zhengzhanshanhaiController_season',self)
end

function zhengzhanshanhaiController:onLeaveState_season(isReconnet)
nextStateStamp=nil
nowShSeasonId=nil
needReqSeasonData=nil
needResetActivity=nil
timeEventController.removeNormalTimerHandler(1,'zhengzhanshanhaiController_season')
end

function zhengzhanshanhaiController:onProtocolReq_season(isReconnet)

end

function zhengzhanshanhaiController:onLostConnection_season()

end




function zhengzhanshanhaiController:reqInfo1_season()
socketManager:send_44_181()
end


function zhengzhanshanhaiController:reqInfo2_season()
socketManager:send_44_182()
end


function zhengzhanshanhaiController:reqSetTeam_season(guidList)


socketManager:send_44_183(#guidList,guidList)
end


function zhengzhanshanhaiController:reqMapListen_season(flag)


local listenMark=zhengzhanshanhaiController:getListenMark()
if flag==0 then
if listenMark then
socketManager:send_44_184(flag)
end
else
zhengzhanshanhaiModel:checkBaseDataRefersh()
if not listenMark then
socketManager:send_44_184(flag)
end
end
end


function zhengzhanshanhaiController:reqJoin_season()
socketManager:send_44_195()
end


function zhengzhanshanhaiController:reqMove_season(x,y)


socketManager:send_44_196(x,y)
end


function zhengzhanshanhaiController:reqSearch_season()
socketManager:send_44_237()
end


function zhengzhanshanhaiController:reqXMJiJie_season()
socketManager:send_44_222()
end


function zhengzhanshanhaiController:reqSHBaodi_season()
socketManager:send_44_223()
end


function zhengzhanshanhaiController:reqOpenBaoXia_season(len,list,flag,prizeType)
if flag then
prizeType=prizeType or ePrizeType.eCommon
socketManager:send_44_224(len,list,prizeType)
else
local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()or 1
local boxName=cfgHelper.get(cfg_zhengzhanshanhaiboxnewconfig_get,shSeasonLv,list[1][1],'item_name')
local text=FMT.fmt("{0}今日剩余开启次数已用完。",boxName)
UIManager.error(text)
end
end


function zhengzhanshanhaiController:reqMonsterDetail_season(guid)

socketManager:send_44_227(guid)
end


function zhengzhanshanhaiController:reqResourceDetail_season(guid)

socketManager:send_44_231(guid)
end


function zhengzhanshanhaiController:reqMonsterJiJie_season(guid,setoutnum,dzlist)






socketManager:send_44_228(guid,setoutnum,#dzlist,dzlist)
end


function zhengzhanshanhaiController:reqMonsterJion_season(guid,dzlist)



socketManager:send_44_229(guid,#dzlist,dzlist)
end


function zhengzhanshanhaiController:reqMonsterGo_season(guid)

socketManager:send_44_236(guid)
end


function zhengzhanshanhaiController:reqMonsterChange_season(guid,setoutnum)




socketManager:send_44_243(guid,setoutnum)
end


function zhengzhanshanhaiController:reqMonsterJiJieKickout_season(guid,taractorid)


socketManager:send_44_244(guid,taractorid)
end


function zhengzhanshanhaiController:reqMonsterXMDetail_season(guid)

socketManager:send_44_233(guid)
end


function zhengzhanshanhaiController:reqMonsterZhaoJi_season(guid)

socketManager:send_44_230(guid)
end


function zhengzhanshanhaiController:reqMonsterJiJieDel_season(guid)

socketManager:send_44_254(guid)
end


function zhengzhanshanhaiController:reqResourceCollect_season(guid,dzlist)



zhengzhanshanhaiController:setOpenCollectMark(true)
socketManager:send_44_232(guid,#dzlist,dzlist)
end


function zhengzhanshanhaiController:reqPvETeamBack_season(guid)

socketManager:send_44_238(guid)
end


function zhengzhanshanhaiController:reqZCMomentRankData_season()
socketManager:send_44_203()
end


function zhengzhanshanhaiController:reqXMMomentRankData_season()
socketManager:send_44_204()
end


function zhengzhanshanhaiController:reqBZMomentRankData_season()
socketManager:send_44_205()
end


function zhengzhanshanhaiController:reqRaceXMRankData_season()
socketManager:send_44_202()
end


function zhengzhanshanhaiController:reqlocalXMData_season()
socketManager:send_44_187()
end


function zhengzhanshanhaiController:reqHisData_season()
socketManager:send_44_188()
end





function zhengzhanshanhaiController.recv_44_181(args)
return zhengzhanshanhaiController.recv_getData(args,true)
end


function zhengzhanshanhaiController.recv_44_183(guidlistlen,guidList)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_teamChange(guidlistlen,guidList)
end


function zhengzhanshanhaiController.recv_44_184(flag)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_changeListenMark(flag)
end


function zhengzhanshanhaiController.recv_44_195(x,y)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_randomPos(x,y)
end


function zhengzhanshanhaiController.recv_44_196(x,y)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_movePos(x,y)
end




function zhengzhanshanhaiController.recv_44_182(args)




















local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end

zhengzhanshanhaiController.recv_getInfo(args,true)
end


function zhengzhanshanhaiController.recv_44_185(args)






























local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getPrepareFightData(args)
end


function zhengzhanshanhaiController.recv_44_221(len,targetList)










local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getPVEData(len,targetList)
end


function zhengzhanshanhaiController.recv_44_235(guid,reason)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_releasePvEWaiPaiQingBaoTeam(guid,reason)
end


function zhengzhanshanhaiController.recv_44_222(len,list)







local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getYiShouJiJieList(len,list)
end


function zhengzhanshanhaiController.recv_44_223(len,list)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getPvEResourceDatas(len,list)
end


function zhengzhanshanhaiController.recv_44_224(len,list)
zhengzhanshanhaiController.recv_openTreasureBox(len,list,true)
end





function zhengzhanshanhaiController.recv_44_227(args)



















local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getYiShouDetailData(args)
end


function zhengzhanshanhaiController.recv_44_231(args)
















local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getBaoDiDetailData(args)
end






function zhengzhanshanhaiController.recv_44_228(guid,setoutnum,len,list,ret)
















local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_initiatePvEWaiPai_JiJie(guid,setoutnum,len,list,ret)
end


function zhengzhanshanhaiController.recv_44_229(guid,len,list,ret)














local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_joinPvEWaiPai_JiJie(guid,len,list,ret)
end


function zhengzhanshanhaiController.recv_44_242(guid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getPvEJoinMsg(guid)
end


function zhengzhanshanhaiController.recv_44_236(guid,ret)








local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_startPvEWaiPai_JiJie(guid,ret)
end


function zhengzhanshanhaiController.recv_44_243(guid,setoutnum,actorid)









local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_changePvEWaiPai_JiJie(guid,setoutnum,actorid)
end


function zhengzhanshanhaiController.recv_44_244(guid,taractorid,actorid)








local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_kickOutPvEWaiPai_JiJie(guid,taractorid,actorid)
end


function zhengzhanshanhaiController.recv_44_233(guid,len,list,setoutnum)


















local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getPvEJiJieDetailData(guid,len,list,setoutnum)
end


function zhengzhanshanhaiController.recv_44_230(guid,ret)







local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_zhaoji(guid,ret)
end






function zhengzhanshanhaiController.recv_44_232(args)













local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_caiJiPvEWaiPai_BaoDi(args)
end




function zhengzhanshanhaiController.recv_44_238(guid,ret)





local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_retractPvEWaiPaiTeam(guid,ret)
end


function zhengzhanshanhaiController.recv_44_237(searchtimes,actorid)








local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_refreshYiShouSearch(searchtimes,actorid)
end


function zhengzhanshanhaiController.recv_44_254(guid,ret)






local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end

return zhengzhanshanhaiController.recv_delPvEWaiPai_JiJie(guid,ret)
end


function zhengzhanshanhaiController.recv_44_203(attacklistlen,attacklist,defendlistlen,defendlist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getZCMomentumData(attacklistlen,attacklist,defendlistlen,defendlist)
end


function zhengzhanshanhaiController.recv_44_204(attacklistlen,XMattacklist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getXMMomentumData(attacklistlen,XMattacklist)
end


function zhengzhanshanhaiController.recv_44_205(attacklistlen,BZattacklist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getBZMomentumData(attacklistlen,BZattacklist)
end



function zhengzhanshanhaiController.recv_44_202(XMRanklen,RaceXMRankList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getXMRankList(XMRanklen,RaceXMRankList)
end


function zhengzhanshanhaiController.recv_44_187(localXMDataLen,localXMDataList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
for i,v in ipairs(localXMDataList)do
v.isSeason=true
end
return zhengzhanshanhaiController.recv_getLocalXMDataList(localXMDataLen,localXMDataList)
end


function zhengzhanshanhaiController.recv_44_188(hisListLen,hisList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
for i,v in ipairs(hisList)do
v.isSeason=true
end
return zhengzhanshanhaiController.recv_getHisList(hisListLen,hisList)
end


function zhengzhanshanhaiController:onNormalUpdate()

if not nextStateStamp then
return
end
if not nowShSeasonId then
nowShSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
end

local nowTime=timeHelper.getServerLongTime()
if nowTime>nextStateStamp then
local originalSeasonId=nowShSeasonId
zhengzhanshanhaiModel:setSHSeasonId_DirtyMark()

nowShSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local isChangeSeason=originalSeasonId~=nowShSeasonId
if isChangeSeason then

needResetActivity=true
zhengzhanshanhaiModel:clearData_changeSeason()
zhengzhanshanhaiController:reqInfo1_season()
zhengzhanshanhaiController:reqInfo2_season()
if UIManager:isActive('UIXM_ZZSH_MapWin')then

zhengzhanshanhaiController:req_weekTaskInit()
else
needReqSeasonData=true
end


zhengzhanshanhaiController:activeActivity(true)
end


notifySystem:postNotify(notifyConfig.onZZSHSeasonStateChange,isChangeSeason)


self:refreshSeasonNextStateStamp()
end
end

function zhengzhanshanhaiController:refreshSeasonNextStateStamp()

nextStateStamp=nil
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then


local seasonState=zhengzhanshanhaiModel:getSeasonState()
if seasonState==1 then

local finalSettleTime=zhengzhanshanhaiModel:getInitialSeasonSettleTime()
if finalSettleTime then
nextStateStamp=timeHelper.convertLongStamp(finalSettleTime)
end
else

local firstTime=zhengzhanshanhaiModel:getFirstSeasonBeginTime()
if firstTime then
nextStateStamp=timeHelper.convertLongStamp(firstTime)
end
end
else


local seasonState=zhengzhanshanhaiModel:getSeasonState()
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()
if seasonState==0 then

nextStateStamp=startTime
elseif seasonState==1 then

nextStateStamp=settleTime
elseif seasonState==2 then

nextStateStamp=settleEndTime
elseif seasonState==3 then

nextStateStamp=endTime
end
end
end

function zhengzhanshanhaiController:checkNeedReqSeasonData()
if needReqSeasonData then


needReqSeasonData=nil
zhengzhanshanhaiController:req_weekTaskInit()
end
end

function zhengzhanshanhaiController:checkNeedResetActivity()
local isActiveActivity
if needResetActivity then
needResetActivity=nil

isActiveActivity=true
end
UIManager:invokeUIMethod("UIXM_ZZSH_MapWin","onSeasonDataInit",isActiveActivity)
end

function zhengzhanshanhaiController:isInActivityReset()
return needResetActivity or false
end
