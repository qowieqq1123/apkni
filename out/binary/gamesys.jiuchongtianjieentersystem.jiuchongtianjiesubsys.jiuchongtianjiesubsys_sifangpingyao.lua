













jiuChongTianJieSubSys_sifangpingyao=jiuChongTianJieSubSysBase.new({sysType=JIUCHONGTIANJIE_SUB_SYS_TYPE.eSiFangPingYao})

jiuChongTianJieSubSys_sifangpingyao.progressType=eJiuChongTianJieSysType.eNumber

jiuChongTianJieSubSys_sifangpingyao.showProgessNum=5



function jiuChongTianJieSubSys_sifangpingyao:checkFinish()
return false
end

function jiuChongTianJieSubSys_sifangpingyao:getProgress()
return SiFangPingYaoController:getallgctjjindu()
end

function jiuChongTianJieSubSys_sifangpingyao:getReddot(isEnter)
return SiFangPingYaoController:getallgctjreddot()
end

function jiuChongTianJieSubSys_sifangpingyao:jump()
jumpManager:jump({id=JUMP_TYPE.eSiFangPingYao})
end

function jiuChongTianJieSubSys_sifangpingyao:checkReward()
local sfpyreddot=SiFangPingYaoController:getallgctjreddot()

local passParm=UITYTongXingZhengController.getBaseInfo(passportDefine.eSFPY,'passParm')
local passporttype=passParm[1]
local sys_id=passParm[2]
local sub_sys_id=passParm[3]
local passport_guid=UITYTongXingZhengModel:getGuidBySysID(passporttype,sys_id,sub_sys_id)
local txzId=UITYTongXingZhengModel:getTXZId(passport_guid)
local isReciveFull=not UITYTongXingZhengModel:isReceiveFull(passport_guid,txzId)


return sfpyreddot or isReciveFull or false
end