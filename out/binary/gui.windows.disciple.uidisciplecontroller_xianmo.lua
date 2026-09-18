








function UIDiscipleController:onAppStart_xianmo()
socketManager:register_receiver(2,152,self.do_protocol_2_152)
socketManager:register_receiver(2,153,self.do_protocol_2_153)
socketManager:register_receiver(2,154,self.do_protocol_2_154)
socketManager:register_receiver(2,155,self.do_protocol_2_155)
socketManager:register_receiver(2,156,self.do_protocol_2_156)
socketManager:register_receiver(2,157,self.do_protocol_2_157)
socketManager:register_receiver(2,158,self.do_protocol_2_158)
socketManager:register_receiver(2,159,self.do_protocol_2_159)
socketManager:register_receiver(2,160,self.do_protocol_2_160)
end

function UIDiscipleController:onEnterState_xianmo()
UIDiscipleModel:initXianMoData()
if self.updateTimer then
self.updateTimer:cancel()
end
self.updateTimer=timer.new()
local f=function()
UIDiscipleModel:updateAllXianMoDiscipleAttr()
end
local updateCD=cfgHelper.get2(cfg_disciplevocconfig_get,1,'daoheng_calc_cd')or 300
self.updateTimer:start(updateCD,f,-1)
end

function UIDiscipleController:onLeaveState_xianmo()
UIDiscipleModel:clearXianMoData()
if self.updateTimer then
self.updateTimer:cancel()
end
self.updateTimer=nil
end


function UIDiscipleController:reqXianMoTransfer(discipleguid,type)
socketManager:send_2_153(discipleguid,type)
end

function UIDiscipleController:reqXinFaActive(type,stage)
socketManager:send_2_154(type,stage)
end

function UIDiscipleController:reqXinFaBranchLevelUp(type,stage,id)
socketManager:send_2_155(type,stage,id)
end

function UIDiscipleController:reqXinFaBreakthrough(discipleguid)
socketManager:send_2_156(discipleguid)
end

function UIDiscipleController:reqXianMoTransferReset(discipleguid)
socketManager:send_2_157(discipleguid)
end

function UIDiscipleController:reqXianMoSwitch(discipleguid)
socketManager:send_2_158(discipleguid)
end


function UIDiscipleController:reqXianMoImageHide(discipleguid,hide)
socketManager:send_2_159(discipleguid,hide)
end

function UIDiscipleController:reqUpdateDiscipleXianMoAttr(len,disciple_list)
socketManager:send_2_161(len,disciple_list)
end


function UIDiscipleController.do_protocol_2_152(stage1,stage2,xinfaBranch_len,xinfaBranchData,xmResetCount)
UIDiscipleModel:setXianMoDatas(stage1,stage2,xinfaBranch_len,xinfaBranchData)
UIDiscipleModel:initXianMoDiscipleCache()
UIDiscipleModel:setXinFaBranchUpdateFlag(-1)
UIDiscipleModel:setXianMoAllDiscipleAttrListDirty()
UIDiscipleModel:setXianMoResetCount(xmResetCount)
end

function UIDiscipleController.do_protocol_2_153(discipleguid,type)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData then
netData.xianmo_voc=type
UIDiscipleModel.calculationDiscipleImageBase(netData)
UIDiscipleModel:setDiscipleImageDirty(netData)
if type==1 then
UIDiscipleModel:changeXianMoDiscipleCount(1,0)
else
UIDiscipleModel:changeXianMoDiscipleCount(0,1)
end
end
UIManager:invokeUIMethod("UIDiscipleJingJieWin","refreshWxgBtn")
UIManager:invokeUIMethod('UIDiscipleRoleInfoTwoWin','refreshJJInfoStatic')
UIManager:invokeUIMethod('UIDiscipleMainWin','refreshDiscipleList')
UIManager:invokeUIMethod('UIDiscipleSelectWin','initRoleListPanel')
UIManager:invokeUIMethod('UIWenXinGuanTransferWin','onTransferPlayAnim',type)
if type==1 then
UIManager:invokeUIMethod('UIWenXinGuanTransferImmortalWin','onTransferPlayAnim')
else
UIManager:invokeUIMethod('UIWenXinGuanTransferDevilWin','onTransferPlayAnim')
end
UIDiscipleModel:updateXianMoDiscipleCache(discipleguid)
UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid,DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng,true)
end

function UIDiscipleController.do_protocol_2_154(type,stage)
if type==1 then
UIDiscipleModel:setXianXinFaStage(stage)
elseif type==2 then
UIDiscipleModel:setMoXinFaStage(stage)
end
UIManager.info(string.format("%s阶%s心法已激活",mathHelper.numberToChinese(stage),type==1 and"仙术"or"魔功"))
UIManager:invokeUIMethod("UIXinFaMainWin","refreshBranchSkill")
UIManager:invokeUIMethod("UIXinFaMainWin","refreshStageReddot",stage)
UIGongFaController:refreshBuildingStatusHUD()
UIDiscipleModel:checkTargetXinFa(type,stage)
end

function UIDiscipleController.do_protocol_2_155(type,stage,id,level)
UIDiscipleModel:setXinFaBranchLevel(id,level)
UIDiscipleModel:setXinFaBranchUpdateFlag(-1)
UIManager:invokeUIMethod("UIXianMoZhuanZhi_xinFaPreviewWin","refreshBranchSkill")
UIManager:invokeUIMethod("UIXinFaMainWin","refreshBranchSkill")
UIManager:invokeUIMethod("UIXinFaMainWin","refreshStageReddot",stage)
UIManager:invokeUIMethod("UIXinFaBranchWin","upLevelCallBack")
UIDiscipleModel:setXianMoAllDiscipleAttrListDirty()
UIGongFaController:refreshBuildingStatusHUD()
end

function UIDiscipleController.do_protocol_2_156(discipleguid,daoheng_level,xinfa_level,daoheng_exp,xinfa_check_t)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

local oldSkillList=UIDiscipleModel:getDiscipleXianMoSkillList(discipleguid)

local old_xinfa_level=netData.xinfa_level
local old_xinfa_exp=netData.daoheng_exp
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,old_xinfa_level)
local old_xinfa_stage=xinfaLevelCfg.stage
local exp=xinfaLevelCfg.exp
local new_xinfa_stage=cfgHelper.get2(cfg_discipledaohengconfig_get,xinfa_level,'stage')
local nowTime=timeHelper.getServerShortTime()
if xinfa_check_t>nowTime then
netData.xinfa_check_t=nowTime
else
netData.xinfa_check_t=xinfa_check_t
end
netData.daoheng_level=daoheng_level
netData.xinfa_level=xinfa_level
netData.daoheng_exp=daoheng_exp

UIDiscipleModel:updateXianMoDiscipleCache(discipleguid)
local oldattrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(discipleguid,false)
UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid,DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng,true)
local attrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(discipleguid,false)




local args={}
args.dis_guid=discipleguid
args.attrLookup=attrLookup
args.oldattrLookup=oldattrLookup
args.xinfaLevel=xinfa_level
args.oldxinfaLevel=old_xinfa_level
args.oldSkillList=oldSkillList
UIManager:invokeUIMethod("UIXianMoZhuanZhi_mainWin","xinFaTuPoCallBack",true,args)
end

function UIDiscipleController.do_protocol_2_157(discipleguid,xmResetCount)
if xmResetCount~=nil then
UIDiscipleModel:setXianMoResetCount(xmResetCount)
end
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData then
if netData.xianmo_voc==1 then
UIDiscipleModel:changeXianMoDiscipleCount(-1,0)
elseif netData.xianmo_voc==2 then
UIDiscipleModel:changeXianMoDiscipleCount(0,-1)
end
netData.xianmo_voc=0
netData.xinfa_level=0
netData.daoheng_exp=0
netData.daoheng_level=0
netData.xinfa_check_t=0
local isSpDz=UIDiscipleModel:isSPDiscipleEx(discipleguid)
if isSpDz then

local switchDataList=netData.switchList
if switchDataList then
for switchidx,switchData in pairs(switchDataList)do
switchData.xianmo_voc=0
end
end
end

UIDiscipleModel.calculationDiscipleImageBase(netData)
UIDiscipleModel:setDiscipleImageDirty(netData)
end
UIManager:invokeUIMethod("UIDiscipleJingJieWin","refreshWxgBtn")
UIManager:invokeUIMethod('UIDiscipleRoleInfoTwoWin','refreshJJInfoStatic')
UIManager:invokeUIMethod('UIDiscipleMainWin','refreshDiscipleList')
UIManager:invokeUIMethod('UIDiscipleSelectWin','initRoleListPanel')
UIManager:closeWindow("UIXianMoZhuanZhi_mainWin")


























UIManager:invokeUIMethod('UIWenXinGuanTransferWin','onResetPlayAnim')
UIDiscipleModel:updateXianMoDiscipleCache(discipleguid)
UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid,DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng)
end

function UIDiscipleController.do_protocol_2_158(discipleguid)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
local type=1
if netData then
if netData.xianmo_voc==1 then
netData.xianmo_voc=2
type=2
UIDiscipleModel:changeXianMoDiscipleCount(-1,1)
elseif netData.xianmo_voc==2 then
netData.xianmo_voc=1
type=1
UIDiscipleModel:changeXianMoDiscipleCount(1,-1)
end
UIDiscipleModel.calculationDiscipleImageBase(netData)
UIDiscipleModel:setDiscipleImageDirty(netData)
end
UIManager:invokeUIMethod("UIDiscipleJingJieWin","refreshWxgBtn")
UIManager:invokeUIMethod('UIDiscipleRoleInfoTwoWin','refreshJJInfoStatic')
UIManager:invokeUIMethod('UIDiscipleMainWin','refreshDiscipleList')
UIManager:invokeUIMethod('UIDiscipleSelectWin','initRoleListPanel')
UIManager:closeWindow("UIXianMoZhuanZhi_mainWin")
UIManager:invokeUIMethod('UIWenXinGuanTransferWin','onTransferPlayAnim',type)
UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid,DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng)
end


function UIDiscipleController.do_protocol_2_159(discipleguid,hide)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
netData.hidexianmodress=hide
UIDiscipleModel.calculationDiscipleImageBase(netData)
UIDiscipleModel:setDiscipleImageDirty(netData)

equipsControl.freshWindow('showModel')
equipsControl.freshWindow('onChangeClothing',discipleguid)
UIManager:callWindowFunc("UIDiscipleShiZhuangComponent","recvXianMoToggleBtn")
equipsControl.freshWindow('onChangeClothing',discipleguid)
UIManager:callWindowFunc("UIDiscipleRoleInfo2Win","refreshDiscipleInfo")
UIManager:callWindowFunc("UIDiscipleMainWin","refreshDiscipleList")
UIManager:callWindowFunc("UIDiscipleListComponent","freshDZList")

if mainControl:isInScene(eSceneType.eZongmen)then
discipleStateManager:refreshDiscipleModel(discipleguid)
end
if MysteryModel:is_in_mystery()then
mysteryPlayerController.setPlayerModel()
end
end

function UIDiscipleController.do_protocol_2_160(discipleguid,xinfa_level,daoheng_level,daoheng_exp,xinfa_check_t)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData then
netData.xinfa_level=xinfa_level
netData.daoheng_level=daoheng_level
netData.daoheng_exp=daoheng_exp
netData.xinfa_check_t=xinfa_check_t
end
UIManager:invokeUIMethod("UIXianMoZhuanZhi_mainWin","xinFaTuPoCallBack")
UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid,DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng,true)
end

function UIDiscipleController.onNewMonth5am_XianMo(islogin)
if not islogin then
UIDiscipleModel:setXianMoResetCount(0)
end
end