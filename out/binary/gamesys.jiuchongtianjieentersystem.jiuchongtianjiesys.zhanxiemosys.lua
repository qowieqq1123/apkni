





local showSys={
JIUCHONGTIANJIE_SUB_SYS_TYPE.eXinMoJie,
JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie,
JIUCHONGTIANJIE_SUB_SYS_TYPE.eXianJieJieYin,
}

ZhanXieMoSys=jiuChongTianJieSysBase.new({sysType=JIUCHONGTIANJIE_SYS_TYPE.eZhuXieMo,showSys=showSys})

function ZhanXieMoSys:getSysList()
local list=table.weakCopy(self:getConfig().list)


if jiuchongtianjieGuideController:checkShowAskEnter()then
list[#list+1]=JIUCHONGTIANJIE_SUB_SYS_TYPE.eXianJieJieYin
end
return list
end


function ZhanXieMoSys:getConditon()



return systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie3)
end


function ZhanXieMoSys:getConditonTxt()
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(SYSTEM_DEFINE.eJiuChongTianJie3,true)
if not isCan then
local typo=errArgs[1]
local val=errArgs[2]
if typo==SYSTEM_OPEN_TYPE.eJiuChongTianJieOpenDay then
local sec=JiuChongTianJieEnterModel:getOpenTianJieSec()
local now=timeHelper.getServerShortTime()
return FMT.fmt('{0}天后开启',math.ceil(((val*86400+sec)-now)/86400))
elseif typo==SYSTEM_OPEN_TYPE.eJiuChongTianJieJinDu then
local config=cfgHelper.get(cfg_jctjsysconfig_get,JIUCHONGTIANJIE_SYS_TYPE.eZhuXieMo)
return FMT.fmt('完成{0}开启',config.name)
else
return systemModel.getOpenTips(SYSTEM_DEFINE.eJiuChongTianJie3)
end
end
end

function ZhanXieMoSys:getProgress()
local cur,max=0,0
for i,sType in ipairs(self.showSys)do
if sType~=JIUCHONGTIANJIE_SUB_SYS_TYPE.eXianJieJieYin then
local sys=JiuChongTianJieEnterModel:getSubSysClass(sType)
max=max+100
if sys:checkOpen()then
if sys.checkFinish and sys:checkFinish()then
cur=cur+100
else
if sys.getProgress then
local c,m=sys:getProgress()
cur=cur+c/m*100
end
end
end
end
end
return math.floor(cur),max
end