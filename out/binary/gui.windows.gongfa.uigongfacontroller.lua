














UIGongFaController=gameState.addListener({})

local isInit=false

function UIGongFaController:onAppStart()
socketManager:register_receiver(3,101,UIGongFaController.do_protocol_3_101)
socketManager:register_receiver(3,103,UIGongFaController.do_protocol_3_103)
socketManager:register_receiver(3,104,UIGongFaController.do_protocol_3_104)
socketManager:register_receiver(3,102,UIGongFaController.do_protocol_3_102)
socketManager:register_receiver(3,105,UIGongFaController.do_protocol_3_105)
socketManager:register_receiver(3,106,UIGongFaController.do_protocol_3_106)
socketManager:register_receiver(3,107,UIGongFaController.do_protocol_3_107)
socketManager:register_receiver(3,108,UIGongFaController.do_protocol_3_108)
socketManager:register_receiver(3,109,UIGongFaController.do_protocol_3_109)
socketManager:register_receiver(3,110,UIGongFaController.do_protocol_3_110)
end


function UIGongFaController:onProtocolReq()
gongfaLookup:initalize()
end


function UIGongFaController:onProtocolReqKF()
gongfaLookup:initalize()
end

function UIGongFaController:onEnterState()
gongfaLookup:initLookup()
UIGongFaController.hudReddotFuncs={}
for i=1,3 do
local reddotSubType=gongfaBuildHudSheetReddot:getSubReddotKey(i)
local func=function(...)
UIGongFaController.onBuildReddotChange(reddotSubType,...)
end
UIGongFaController.hudReddotFuncs[i]=reddotSubType
reddotClassManager.register_event(reddotSubType,func)
end
isInit=false
end

function UIGongFaController:onLeaveState()
isInit=false
UIGongFaModel:clearData()
gongfaLookup:clearLookup()

if UIGongFaController.hudReddotFuncs then
for k,v in pairs(UIGongFaController.hudReddotFuncs)do
reddotClassManager.unregister_event(k,v)
end
UIGongFaController.hudReddotFuncs=nil
end
end

function UIGongFaController:onPlayerCreate(...)


end

function UIGongFaController:checkInit()
return isInit==true
end

function UIGongFaController:onLostConnection()

end

function UIGongFaController.onBuildReddotChange(reddotSubType,class,sub_typo,last_flag,flag)
UIGongFaController:refreshBuildingStatusHUD()
end

function UIGongFaController:checkDiscipleGFAutoUp(gfID)
local list={}
local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
for k,v in pairs(all)do
local netData=v.netData.net
local gongfaList=netData.gongfaList
if gongfaList then
for i1,v1 in ipairs(gongfaList)do
if v1.param_1==gfID then
local gflv=v1.param_2
local gfexp=v1.param_3
local maxexp=cfgHelper.get3(cfg_disciplegongfaconfig_get,gfID,'exp',gflv)
if maxexp~=nil then
if gfexp>=maxexp then
list.add(netData.discipleguid)
break
end
end
end
end
end
end
end
local c=#list
if c>0 then
UIDiscipleController:requireDiscipleUpGF(gfID,c,list)
end
end

function UIGongFaController:autoLearn(dis_guid)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
local unuse_pos=UIDiscipleModel:getDiscipleUnuseGFPos(netData)
local unuse_list=UIDiscipleModel:getDiscipleUnusingGFList(dis_guid)
local pos_num=#unuse_pos
local gf_num=#unuse_list
if pos_num>0 and gf_num>0 then
for i,pos in ipairs(unuse_pos)do
if gf_num<=0 then break end
local gfID=unuse_list[gf_num]
table.remove(unuse_list,gf_num)
gf_num=gf_num-1
UIDiscipleController:requireDiscipleSetupGF(dis_guid,pos,gfID)
end
end
end

function UIGongFaController:autoLearnEx(dis_guid,gfID)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
local unuse_pos=UIDiscipleModel:getDiscipleUnuseGFPos(netData)
if#unuse_pos>0 then
local pos=unuse_pos[1]
UIDiscipleController:requireDiscipleSetupGF(dis_guid,pos,gfID)
end
end

function UIGongFaController:getBuildData()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eCangJingGe)
if bdDatas==nil or#bdDatas<=0 then return nil end
return bdDatas[1]
end

function UIGongFaController:refreshBuildingStatusHUD()
local bdData=UIGongFaController:getBuildData()
if bdData==nil then return end
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end

function UIGongFaController.setLearnGFDiscipleAttrListDirty(gfID,showFightTips)
local all_dis=UIDiscipleModel:getAllDiscipleData()
if all_dis then
for k,v in pairs(all_dis)do
local guid=v.netData.net.discipleguid
if UIDiscipleModel:isDiscipleLearnGF(guid,gfID)then
UIGongFaController.setDiscipleGFAttrListDirty(guid,showFightTips)
end
end
end
end

function UIGongFaController.setDiscipleGFAttrListDirty(guid,showFightTips)
UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eGongFa,showFightTips)
skillModel:setSkillLvPlusLookupDirty({dis_guid=guid})
end




function UIGongFaController:reqGongFaList()
socketManager:send_3_101()
end


function UIGongFaController:reqDiscipleLearn(discipleguid,gongfaid)


socketManager:send_3_103(discipleguid,gongfaid)
end


function UIGongFaController:reqDiscipleForget(discipleguid,gongfaid)


socketManager:send_3_104(discipleguid,gongfaid)
end


function UIGongFaController:reqCollectPage(gongfaid,itemid)


socketManager:send_3_102(gongfaid,itemid)
end


function UIGongFaController:reqGongFaReward(gongfaid,flagid)


socketManager:send_3_105(gongfaid,flagid)
end


function UIGongFaController:reqGongFaStudy(gongfaid,usespe,assistant)



socketManager:send_3_106(gongfaid,usespe,assistant or 0)
end

function UIGongFaController:reqGongFaCollectAndReward(gfID,pagelist)
if pagelist==nil or#pagelist<=0 then return end
local pages={}
local rewards={}
for i,v in ipairs(pagelist)do
table.insert(pages,v[1])
end
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
local pieces=gfCfg.piece
local gfNetData=UIGongFaModel:getGongFaNetData(gfID)
if gfNetData then
for i1,v1 in ipairs(pieces)do
if UIGongFaModel:hasActivePageRewardEx(gfID,i1)then
table.insert(rewards,i1)
end
end
if UIGongFaModel:hasActiveAllPageRewardEx(gfID)then
table.insert(rewards,0)
end
else
for i1,v1 in ipairs(pieces)do
table.insert(rewards,i1)
end
table.insert(rewards,0)
end
UIGongFaController:reqGongFaCollectAndRewardEx(gfID,pages,rewards)
end

function UIGongFaController:reqGongFaRewards(gfID)
local pages={}
local rewards={}
local pieces=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'piece')
for i,v in ipairs(pieces)do
if UIGongFaModel:hasActivePageReward(gfID,i)then
table.insert(rewards,i)
end
end
if UIGongFaModel:hasActiveAllPageReward(gfID)then
table.insert(rewards,0)
end
if#rewards>0 then
UIGongFaController:reqGongFaCollectAndRewardEx(gfID,pages,rewards)
end
end

function UIGongFaController:reqGongFaCollectAndRewardEx(gfID,pages,rewards)



pages=pages or{}
rewards=rewards or{}
socketManager:send_3_107(gfID,#pages,pages,#rewards,rewards)
end

function UIGongFaController:reqGongFaReset(gfID)

socketManager:send_3_108(gfID)
end


function UIGongFaController:reqGongFaRecycle(gongfaid,itemid,num)



socketManager:send_3_109(gongfaid,itemid,num)
end


function UIGongFaController:reqGongFaOneKeyRecycle(list_len,back_list)


socketManager:send_3_110(list_len,back_list)
end





function UIGongFaController.do_protocol_3_101(len,gongfaList)







local temp=nil
if gongfaList then
temp={}
for i,v in ipairs(gongfaList)do
local isDefault=UIGongFaModel:isGongFaDefaultActive(v.gongfaid)
if isDefault then
table.insert(temp,v)
elseif not isDefault and v.flag~=0 then
table.insert(temp,v)
end
end
end
UIGongFaModel:initData(temp)
isInit=true

UIGongFaController:refreshBuildingStatusHUD()
if temp~=nil then
for i,v in ipairs(temp)do
local gfID=v.gongfaid
if v.studylv>0 then
UIGongFaController.setLearnGFDiscipleAttrListDirty(gfID,false)
end
end
end
end


function UIGongFaController.do_protocol_3_103(discipleguid,gongfaid)



UIManager.info('修炼功法成功')
UIDiscipleModel:discipleLearnGongFa(discipleguid,gongfaid)
UIManager:invokeUIMethod('UIGongFaDiscipleInfoWin','rec_learGF',discipleguid)
UIManager:invokeUIMethod('UIDiscipleSkillInfoWin','rec_learGF',discipleguid,gongfaid)
UIManager:invokeUIMethod('UIDiscipleGFSetupWin','rec_learGF',discipleguid,gongfaid)
UIManager:invokeUIMethod('UIGongFaDiscipleSelectWin','rec_learGF',discipleguid)

notifySystem:postNotify(notifyConfig.onDiscipleLearnGongFa,discipleguid,gongfaid)
UIGongFaController.setDiscipleGFAttrListDirty(discipleguid,true)
lingshouModel:setAttrListDirtyXByDzGuid(discipleguid,lingshouAttributeType.eDzGongFa,true)

UIGongFaController:autoLearnEx(discipleguid,gongfaid)
end


function UIGongFaController.do_protocol_3_104(discipleguid,gongfaid,way)



local pos=UIDiscipleModel:discipleForgetGongFa(discipleguid,gongfaid)
UIGongFaController.setDiscipleGFAttrListDirty(discipleguid,true)
notifySystem:postNotify(notifyConfig.onDiscipleGongFaChange,discipleguid,nil,gongfaid)


if way==0 then
UIManager.info('成功遗忘功法')
end

UIManager:closeWindow('UIGongFaTipsWin')
UIManager:invokeUIMethod('UIGongFaDiscipleInfoWin','rec_forgetGF',discipleguid,gongfaid,pos)
UIManager:invokeUIMethod('UIDiscipleSkillInfoWin','rec_forgetGF',discipleguid,gongfaid,pos)
UIManager:invokeUIMethod('UIDiscipleGFSetupWin','rec_forgetGF',discipleguid,gongfaid,pos)
UIManager:invokeUIMethod('UIGongFaDiscipleSelectWin','rec_forgetGF',discipleguid)
lingshouModel:setAttrListDirtyXByDzGuid(discipleguid,lingshouAttributeType.eDzGongFa,true)
end


function UIGongFaController.do_protocol_3_102(gongfaid,flag)




UIGongFaModel:activeGongFaPage(gongfaid,flag)

if UIGongFaModel:getGFPieceNum(gongfaid)>1 then
UIGongFaController:checkDiscipleGFAutoUp()
end

UIManager:invokeUIMethod('UIGongFaSelectWin','rec_activepage')
UIManager:invokeUIMethod('UIGongFaMainWin','rec_activepage')
UIGongFaController:refreshBuildingStatusHUD()
notifySystem:postNotify(notifyConfig.onGongFaActive,gongfaid)
end


function UIGongFaController.do_protocol_3_105(gongfaid,flagid)



local gfNetData=UIGongFaModel:getGongFaNetData(gongfaid)
local flag=gfNetData.flag
local idx=flagid
if idx>0 then
idx=idx*2
end
flag=mathHelper.setbit(flag,idx)
gfNetData.flag=flag

UIManager:invokeUIMethod('UIGongFaTipsThreeWin','rec_pageReward')
UIManager:invokeUIMethod('UIGongFaSelectWin','rec_pageReward')

UIManager:showWindow('UIGongFaPageRewardWin',{gfID=gongfaid,pieces={flagid}})

UIGongFaController:refreshBuildingStatusHUD()
end


function UIGongFaController.do_protocol_3_106(gongfaid,usespe,assistant,spenum)





if assistant==0 then
UIManager.info('功法研习成功')

AudioManager.playAudio(546)
end
local o_lv,n_lv=UIGongFaModel:recStudyGF(gongfaid,spenum)
UIGongFaModel:refreshGongFaFullStudy(gongfaid)

UIGongFaController:refreshBuildingStatusHUD()


UIGongFaController.setLearnGFDiscipleAttrListDirty(gongfaid,true)

UIManager:invokeUIMethod('UIGongFaStudyWin','rec_study',gongfaid)
UIManager:invokeUIMethod('UIGongFaSelectWin','rec_study',gongfaid)
UIManager:invokeUIMethod('UIGongFaTipsThreeWin','rec_study',gongfaid)
UIManager:invokeUIMethod('UIGongFaStudyWin','refreshResetBtn',gongfaid)
UIManager:invokeUIMethod('UIGongFaMainWin','refreshRecycle')

notifySystem:postNotify(notifyConfig.onGongFaStudyLevelChange,gongfaid,o_lv,n_lv,assistant)
end


function UIGongFaController.do_protocol_3_107(gongfaid,flag)




if flag==0 then return end

local gfNetData=UIGongFaModel:getGongFaNetData(gongfaid)
local oldflag=0
if gfNetData then
oldflag=gfNetData.flag
end
UIGongFaModel:activeGongFaPage(gongfaid,flag)

local pieces_collects={}
local pieces_rewards={}
local pieces=cfgHelper.get2(cfg_disciplegongfaconfig_get,gongfaid,'piece')
for i,v in ipairs(pieces)do
if mathHelper.getBitValue(flag,i*2-1)~=mathHelper.getBitValue(oldflag,i*2-1)then
table.insert(pieces_collects,i)
end
if mathHelper.getBitValue(flag,i*2)~=mathHelper.getBitValue(oldflag,i*2)then
table.insert(pieces_rewards,i)
end
end
if mathHelper.getBitValue(flag,0)~=mathHelper.getBitValue(oldflag,0)then
table.insert(pieces_rewards,0)
end

local change_collects=#pieces_collects>0
local change_rewards=#pieces_rewards>0
if change_collects then
UIManager:invokeUIMethod('UIGongFaSelectWin','rec_activepage')
UIManager:invokeUIMethod('UIGongFaMainWin','rec_activepage')
notifySystem:postNotify(notifyConfig.onGongFaActive,gongfaid)
end

if change_rewards then
UIManager:invokeUIMethod('UIGongFaTipsThreeWin','rec_pageReward')
UIManager:invokeUIMethod('UIGongFaSelectWin','rec_pageReward')
UIManager:showWindow('UIGongFaPageRewardWin',{gfID=gongfaid,pieces=pieces_rewards})
end

if change_collects or change_rewards then
UIGongFaController:refreshBuildingStatusHUD()
end
end


function UIGongFaController.do_protocol_3_108(gongfaid)

UIManager.info('功法重置成功')
UIGongFaModel:setGongFaSpenum(gongfaid,0)
UIGongFaModel:refreshGongFaFullStudy(gongfaid)

UIGongFaController.setLearnGFDiscipleAttrListDirty(gongfaid,true)
UIManager:invokeUIMethod('UIGongFaStudyWin','rec_study',gongfaid)
UIManager:invokeUIMethod('UIGongFaSelectWin','rec_study',gongfaid)
UIManager:invokeUIMethod('UIGongFaTipsThreeWin','rec_study',gongfaid)
UIManager:invokeUIMethod('UIGongFaStudyWin','refreshResetBtn',gongfaid)
UIManager:invokeUIMethod('UIGongFaMainWin','refreshRecycle')
end


function UIGongFaController.do_protocol_3_109(gongfaid,itemid,num)
UIManager:invokeUIMethod('UIGongFaMainWin','refreshRecycle')
UIGongFaController:refreshBuildingStatusHUD()
end


function UIGongFaController.do_protocol_3_110(list_len,back_list)
UIManager:invokeUIMethod('UIGongFaRecycleWin','onShow')
UIManager:invokeUIMethod('UIGongFaMainWin','refreshRecycle')
UIGongFaController:refreshBuildingStatusHUD()
end

