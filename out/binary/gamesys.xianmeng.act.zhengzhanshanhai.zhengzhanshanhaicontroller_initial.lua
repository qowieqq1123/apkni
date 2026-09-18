






function zhengzhanshanhaiController:onAppStart_initial()
socketManager:register_receiver(20,181,self.recv_20_181)
socketManager:register_receiver(20,182,self.recv_20_182)
socketManager:register_receiver(20,183,self.recv_20_183)
socketManager:register_receiver(20,184,self.recv_20_184)
socketManager:register_receiver(20,185,self.recv_20_185)
socketManager:register_receiver(20,195,self.recv_20_195)
socketManager:register_receiver(20,196,self.recv_20_196)
socketManager:register_receiver(20,221,self.recv_20_221)
socketManager:register_receiver(20,222,self.recv_20_222)
socketManager:register_receiver(20,223,self.recv_20_223)
socketManager:register_receiver(20,224,self.recv_20_224)
socketManager:register_receiver(20,227,self.recv_20_227)
socketManager:register_receiver(20,231,self.recv_20_231)
socketManager:register_receiver(20,228,self.recv_20_228)
socketManager:register_receiver(20,229,self.recv_20_229)
socketManager:register_receiver(20,242,self.recv_20_242)
socketManager:register_receiver(20,233,self.recv_20_233)
socketManager:register_receiver(20,230,self.recv_20_230)
socketManager:register_receiver(20,232,self.recv_20_232)
socketManager:register_receiver(20,235,self.recv_20_235)
socketManager:register_receiver(20,236,self.recv_20_236)
socketManager:register_receiver(20,243,self.recv_20_243)
socketManager:register_receiver(20,244,self.recv_20_244)
socketManager:register_receiver(20,238,self.recv_20_238)
socketManager:register_receiver(20,237,self.recv_20_237)
socketManager:register_receiver(20,254,self.recv_20_254)

socketManager:register_receiver(20,203,self.recv_20_203)
socketManager:register_receiver(20,204,self.recv_20_204)
socketManager:register_receiver(20,205,self.recv_20_205)

socketManager:register_receiver(20,202,self.recv_20_202)
socketManager:register_receiver(20,187,self.recv_20_187)
socketManager:register_receiver(20,188,self.recv_20_188)


end

function zhengzhanshanhaiController:onEnterState_initial(isReconnet)

end

function zhengzhanshanhaiController:onLeaveState_initial(isReconnet)

end

function zhengzhanshanhaiController:onProtocolReq_initial(isReconnet)

end

function zhengzhanshanhaiController:onLostConnection_initial()

end




function zhengzhanshanhaiController:reqInfo1_initial()
socketManager:send_20_181()
end


function zhengzhanshanhaiController:reqInfo2_initial()
socketManager:send_20_182()
end


function zhengzhanshanhaiController:reqSetTeam_initial(guidList)


socketManager:send_20_183(#guidList,guidList)
end


function zhengzhanshanhaiController:reqMapListen_initial(flag)


local listenMark=zhengzhanshanhaiController:getListenMark()
if flag==0 then
if listenMark then
socketManager:send_20_184(flag)
end
else
zhengzhanshanhaiModel:checkBaseDataRefersh()
if not listenMark then
socketManager:send_20_184(flag)
end
end
end


function zhengzhanshanhaiController:reqJoin_initial()
socketManager:send_20_195()
end


function zhengzhanshanhaiController:reqMove_initial(x,y)


socketManager:send_20_196(x,y)
end


function zhengzhanshanhaiController:reqSearch_initial()
socketManager:send_20_237()
end


function zhengzhanshanhaiController:reqXMJiJie_initial()
socketManager:send_20_222()
end


function zhengzhanshanhaiController:reqSHBaodi_initial()
socketManager:send_20_223()
end


function zhengzhanshanhaiController:reqOpenBaoXia_initial(len,list,flag,prizeType)
if flag then
prizeType=prizeType or ePrizeType.eCommon
socketManager:send_20_224(len,list,prizeType)
else
local boxName=cfgHelper.get2(cfg_zhengzhanshanhaiboxconfig_get,list[1][1],'item_name')
local text=FMT.fmt("{0}今日剩余开启次数已用完。",boxName)
UIManager.error(text)
end
end


function zhengzhanshanhaiController:reqMonsterDetail_initial(guid)

socketManager:send_20_227(guid)
end


function zhengzhanshanhaiController:reqResourceDetail_initial(guid)

socketManager:send_20_231(guid)
end


function zhengzhanshanhaiController:reqMonsterJiJie_initial(guid,setoutnum,dzlist)






socketManager:send_20_228(guid,setoutnum,#dzlist,dzlist)
end


function zhengzhanshanhaiController:reqMonsterJion_initial(guid,dzlist)



socketManager:send_20_229(guid,#dzlist,dzlist)
end


function zhengzhanshanhaiController:reqMonsterGo_initial(guid)

socketManager:send_20_236(guid)
end


function zhengzhanshanhaiController:reqMonsterChange_initial(guid,setoutnum)




socketManager:send_20_243(guid,setoutnum)
end


function zhengzhanshanhaiController:reqMonsterJiJieKickout_initial(guid,taractorid)


socketManager:send_20_244(guid,taractorid)
end


function zhengzhanshanhaiController:reqMonsterXMDetail_initial(guid)

socketManager:send_20_233(guid)
end


function zhengzhanshanhaiController:reqMonsterZhaoJi_initial(guid)

socketManager:send_20_230(guid)
end


function zhengzhanshanhaiController:reqResourceCollect_initial(guid,dzlist)



zhengzhanshanhaiController:setOpenCollectMark(true)
socketManager:send_20_232(guid,#dzlist,dzlist)
end


function zhengzhanshanhaiController:reqPvETeamBack_initial(guid)

socketManager:send_20_238(guid)
end


function zhengzhanshanhaiController:reqMonsterJiJieDel_initial(guid)

socketManager:send_20_254(guid)
end


function zhengzhanshanhaiController:reqZCMomentRankData_initial()
socketManager:send_20_203()
end


function zhengzhanshanhaiController:reqXMMomentRankData_initial()
socketManager:send_20_204()
end


function zhengzhanshanhaiController:reqBZMomentRankData_initial()
socketManager:send_20_205()
end


function zhengzhanshanhaiController:reqRaceXMRankData_initial()
socketManager:send_20_202()
end


function zhengzhanshanhaiController:reqlocalXMData_initial()
socketManager:send_20_187()
end


function zhengzhanshanhaiController:reqHisData_initial()
socketManager:send_20_188()
end





function zhengzhanshanhaiController.recv_20_181(args)
return zhengzhanshanhaiController.recv_getData(args)
end


function zhengzhanshanhaiController.recv_20_183(guidlistlen,guidList)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_teamChange(guidlistlen,guidList)
end


function zhengzhanshanhaiController.recv_20_184(flag)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_changeListenMark(flag)
end


function zhengzhanshanhaiController.recv_20_195(x,y)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_randomPos(x,y)
end


function zhengzhanshanhaiController.recv_20_196(x,y)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_movePos(x,y)
end




function zhengzhanshanhaiController.recv_20_182(args)




















local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getInfo(args)
end


function zhengzhanshanhaiController.recv_20_185(args)






























local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getPrepareFightData(args)
end


function zhengzhanshanhaiController.recv_20_221(len,targetList)










local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getPVEData(len,targetList)
end


function zhengzhanshanhaiController.recv_20_235(guid,reason)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_releasePvEWaiPaiQingBaoTeam(guid,reason)
end


function zhengzhanshanhaiController.recv_20_222(len,list)







local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getYiShouJiJieList(len,list)
end


function zhengzhanshanhaiController.recv_20_223(len,list)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getPvEResourceDatas(len,list)
end


function zhengzhanshanhaiController.recv_20_224(len,list)
return zhengzhanshanhaiController.recv_openTreasureBox(len,list)
end





function zhengzhanshanhaiController.recv_20_227(args)



















local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getYiShouDetailData(args)
end


function zhengzhanshanhaiController.recv_20_231(args)
















local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getBaoDiDetailData(args)
end






function zhengzhanshanhaiController.recv_20_228(guid,setoutnum,len,list,ret)















local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end


return zhengzhanshanhaiController.recv_initiatePvEWaiPai_JiJie(guid,setoutnum,len,list,ret)
end


function zhengzhanshanhaiController.recv_20_229(guid,len,list,ret)













local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end


return zhengzhanshanhaiController.recv_joinPvEWaiPai_JiJie(guid,len,list,ret)
end


function zhengzhanshanhaiController.recv_20_242(guid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getPvEJoinMsg(guid)
end


function zhengzhanshanhaiController.recv_20_236(guid,ret)








local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_startPvEWaiPai_JiJie(guid,ret)
end


function zhengzhanshanhaiController.recv_20_243(guid,setoutnum,actorid)








local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_changePvEWaiPai_JiJie(guid,setoutnum,actorid)
end


function zhengzhanshanhaiController.recv_20_244(guid,taractorid,actorid)







local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_kickOutPvEWaiPai_JiJie(guid,taractorid,actorid)
end


function zhengzhanshanhaiController.recv_20_233(guid,len,list,setoutnum)


















local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getPvEJiJieDetailData(guid,len,list,setoutnum)
end


function zhengzhanshanhaiController.recv_20_230(guid,ret)







local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_zhaoji(guid,ret)
end






function zhengzhanshanhaiController.recv_20_232(args)













local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_caiJiPvEWaiPai_BaoDi(args)
end




function zhengzhanshanhaiController.recv_20_238(guid,ret)





local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_retractPvEWaiPaiTeam(guid,ret)
end


function zhengzhanshanhaiController.recv_20_237(searchtimes,actorid)








local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_refreshYiShouSearch(searchtimes,actorid)
end


function zhengzhanshanhaiController.recv_20_254(guid,ret)






local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_delPvEWaiPai_JiJie(guid,ret)
end


function zhengzhanshanhaiController.recv_20_203(attacklistlen,attacklist,defendlistlen,defendlist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getZCMomentumData(attacklistlen,attacklist,defendlistlen,defendlist)
end


function zhengzhanshanhaiController.recv_20_204(attacklistlen,XMattacklist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getXMMomentumData(attacklistlen,XMattacklist)
end


function zhengzhanshanhaiController.recv_20_205(attacklistlen,BZattacklist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getBZMomentumData(attacklistlen,BZattacklist)
end



function zhengzhanshanhaiController.recv_20_202(XMRanklen,RaceXMRankList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getXMRankList(XMRanklen,RaceXMRankList)
end


function zhengzhanshanhaiController.recv_20_187(localXMDataLen,localXMDataList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getLocalXMDataList(localXMDataLen,localXMDataList)
end


function zhengzhanshanhaiController.recv_20_188(hisListLen,hisList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getHisList(hisListLen,hisList)
end

