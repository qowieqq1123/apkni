













jiuChongTianJieSubSys_hongchenlilian=jiuChongTianJieSubSysBase.new({sysType=JIUCHONGTIANJIE_SUB_SYS_TYPE.eHongChenJie})

jiuChongTianJieSubSys_hongchenlilian.progressType=eJiuChongTianJieSysType.ePrecent

jiuChongTianJieSubSys_hongchenlilian.showProgessNum=100


function jiuChongTianJieSubSys_hongchenlilian:checkFinish()
local param=cfgHelper.get2(cfg_jctjsubsysconfig_get,self.sysType,'param')
return hongChenJieController:getSystemFinishState(param[1])
end

function jiuChongTianJieSubSys_hongchenlilian:getProgress()
local param=cfgHelper.get2(cfg_jctjsubsysconfig_get,self.sysType,'param')
return hongChenJieController:getProgress(param[1])
end

function jiuChongTianJieSubSys_hongchenlilian:getReddot(isEnter)
local param=cfgHelper.get2(cfg_jctjsubsysconfig_get,self.sysType,'param')
return hongChenJieController:getReddot(param[1])
end

function jiuChongTianJieSubSys_hongchenlilian:jump()
jumpManager:jump({
id=JUMP_TYPE.eHongChenJie
},nil)
end

function jiuChongTianJieSubSys_hongchenlilian:checkReward()
local passParm=UITYTongXingZhengController.getBaseInfo(passportDefine.eHCJ,'passParm')
local passporttype=passParm[1]
local sys_id=passParm[2]
local sub_sys_id=passParm[3]
local passport_guid=UITYTongXingZhengModel:getGuidBySysID(passporttype,sys_id,sub_sys_id)
local txzId=UITYTongXingZhengModel:getTXZId(passport_guid)
local isReciveFull=not UITYTongXingZhengModel:isReceiveFull(passport_guid,txzId)

local param=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eHongChenJie,'param')
local id=param[1]
local data=hongChenJieModel:getGameHandle(id)
if not data then return false end
local hasNotFinishTask=data:checkRankingSelfNotFinish()

return(isReciveFull or false)or hasNotFinishTask
end