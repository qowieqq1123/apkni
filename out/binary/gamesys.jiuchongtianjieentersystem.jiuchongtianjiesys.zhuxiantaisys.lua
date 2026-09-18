




local showSys={
JIUCHONGTIANJIE_SUB_SYS_TYPE.eZhuXianTai,
JIUCHONGTIANJIE_SUB_SYS_TYPE.eDuJieZhiBao,
JIUCHONGTIANJIE_SUB_SYS_TYPE.eDuJieXianDan,
}

ZhuXianTaiSys=jiuChongTianJieSysBase.new({sysType=JIUCHONGTIANJIE_SYS_TYPE.eZhuXianTai,showSys=showSys})


function ZhuXianTaiSys:getConditon()


return systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie2)
end


function ZhuXianTaiSys:getConditonTxt()
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(SYSTEM_DEFINE.eJiuChongTianJie2,true)
if not isCan then
local typo=errArgs[1]
local val=errArgs[2]
if typo==SYSTEM_OPEN_TYPE.eJiuChongTianJieOpenDay then
local sec=JiuChongTianJieEnterModel:getOpenTianJieSec()
local now=timeHelper.getServerShortTime()
return FMT.fmt('{0}天后开启',math.ceil(((val*86400+sec)-now)/86400))
elseif typo==SYSTEM_OPEN_TYPE.eJiuChongTianJieJinDu then
local config=cfgHelper.get(cfg_jctjsysconfig_get,JIUCHONGTIANJIE_SYS_TYPE.eZhanChenYuan)
return FMT.fmt('完成{0}开启',config.name)
else
return systemModel.getOpenTips(SYSTEM_DEFINE.eJiuChongTianJie2)
end
end
end
