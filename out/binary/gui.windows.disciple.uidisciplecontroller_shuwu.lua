







shuWuPDImage=
{
[eMoneyType.mtLingMu]='image_shuwuscdjcc_1',
[eMoneyType.mtXuanTie]='image_shuwuscdjcc_2',
[eMoneyType.mtLingCao]='image_shuwuscdjcc_3',
[eMoneyType.mtTieKuang]='image_shuwuscdjcc_4',
[eMoneyType.mtFuZhi]='image_shuwuscdjcc_5',
[eMoneyType.mtZhenShi]='image_shuwuscdjcc_6',
[eMoneyType.mtLingDan]='image_shuwuscdjcc_7',
}

function UIDiscipleController:onAppStart_shuwu()
socketManager:register_receiver(2,125,self.do_protocol_2_125)
socketManager:register_receiver(2,126,self.do_protocol_2_126)
socketManager:register_receiver(2,127,self.do_protocol_2_127)
socketManager:register_receiver(2,128,self.do_protocol_2_128)
end

function UIDiscipleController:onEnterState_shuwu()
UIDiscipleModel:initShuWuData()

end

function UIDiscipleController:onLeaveState_shuwu()
UIDiscipleModel:clearShuWuData()

end



function UIDiscipleController:reqShuWuData()
socketManager:send_2_125()
end

function UIDiscipleController:reqQiaoJiangLevelUp(dzId)
socketManager:send_2_126(dzId)
end

function UIDiscipleController:reqQiaoJiangSkillLevelUp(dzId,skillId)
socketManager:send_2_127(dzId,skillId)
end



function UIDiscipleController.do_protocol_2_125(len,arr)
UIDiscipleModel:setShuWuDatas(len,arr)
end

function UIDiscipleController.do_protocol_2_126(dzId,level)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
dzData.qiaojianglv=level
UIManager:callWindowFunc('UIDiscipleShuWuSkillWin','refresh')
UIManager:callWindowFunc('UIDiscipleRoleInfoTwoWin','refreshQJInfo')
UIManager:callWindowFunc('UIDiscipleRoleInfo2Win','refreshShuWuInfo')
UIManager:callWindowFunc('UIDiscipleShuWuSkillWin','playLevelUp')

UIDiscipleModel:setShuWuDYEffectDirty()

notifySystem:postNotify(notifyConfig.onDiscipleShuWuQJLevelChange,dzId,level)

end

function UIDiscipleController.do_protocol_2_127(dzId,index,level)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
dzData.swList[index]=level
UIManager:callWindowFunc('UIDiscipleShuWuSkillTipsWin','refresh',level)
UIManager:callWindowFunc('UIDiscipleShuWuSkillWin','setSkill')
UIManager:callWindowFunc('UIDiscipleRoleInfo2Win','refreshShuWuInfo')
UIManager:showWindow('UIDiscipleShuWuUpSkillWin',{dzId=dzId,index=index})

UIDiscipleModel:setShuWuDYEffectDirty()

notifySystem:postNotify(notifyConfig.onDiscipleShuWuLevelChange,dzId,index,level)
end

function UIDiscipleController.do_protocol_2_128(data)
UIDiscipleModel:resetShuWuData(data)
end



function UIDiscipleController:checkShuWuDZReddot(dzId)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if dzData.swList then
for i,v in ipairs(dzData.swList)do
if UIDiscipleController:checkShuWuDZSkillReddot(dzData,i)then
return true
end
end
end
local fvalue=UIDiscipleModel:getShuWuFightValue(dzId)
local check=UIDiscipleController:checkShuWuQJLevelUp(dzData.qiaojianglv,fvalue,dzId)
return check
end

function UIDiscipleController:checkShuWuDZSkillReddot(dzData,index)
local cfg=UIDiscipleModel:getShuWuDZConfig(dzData.id)
local skillId=cfg.skill[index]
local level=dzData.swList[index]
local skillCfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,skillId,level)
local check=UIDiscipleController:checkShuWuQJSkillLevelUp(dzData,skillCfg)
return check
end

function UIDiscipleController:checkShuWuQJLevelUp(qjLevel,fvalue,disciple_guid,wraning)
local cfg=cfgHelper.get1(cfg_discipleqiaojiangconfig_get,qjLevel)
local nextcfg=cfgHelper.get1(cfg_discipleqiaojiangconfig_get,qjLevel+1)
if not nextcfg then
if wraning then
UIManager.error('已满级')
end
return false
end
if fvalue<cfg.strength then
if wraning then

UIManager.error('提升弟子的境界等级可提升弟子实力')
end
return false
end
local dzData=UIDiscipleModel:getDiscipleData(disciple_guid)
local id=dzData.id
local consume=cfg.consume[id]
local check=UIDiscipleController:checkShuWuCost(consume,wraning)
return check
end

function UIDiscipleController:checkShuWuQJSkillLevelUp(dzData,skillCfg,wraning)
local nextcfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,skillCfg.sid,skillCfg.slv+1)
if not nextcfg then
if wraning then
UIManager.error('已满级')
end
return false
end
local cfg=UIDiscipleModel:getShuWuDZConfig(dzData.id)
local nlevel=skillCfg.qiaojiang
if dzData.qiaojianglv<nlevel then
if wraning then
local name,order=UIDiscipleModel:getShuWuQJLevelInfo(cfg.bdId,nlevel)
UIManager.error(FMT.fmt('弟子需达{0}{1}阶',name,order))
end
return false
end

local consume=skillCfg.consume
local check=UIDiscipleController:checkShuWuCost(consume,wraning)
return check
end

function UIDiscipleController:checkShuWuCost(consume,wraning)
for i,v in ipairs(consume)do
local itemId=v[1]
local isMoney=moneyConfig.isMoney(itemId)
local have
if isMoney then
have=moneyModel.getMoney(itemId)
else
have=bagModel.getItemCountById(itemId)
end
if have<v[2]then
local name=itemsConfig.getItemName(itemId)
if wraning then
UIManager.error(FMT.fmt('{0}不足',name))
gainControl:showGainWin(itemId)
end
return false
end
end
return true
end



