













jiuChongTianJieSubSys_zongmendaoshi=jiuChongTianJieSubSysBase.new({sysType=JIUCHONGTIANJIE_SUB_SYS_TYPE.eZongMenDaoShi})

jiuChongTianJieSubSys_zongmendaoshi.progressType=eJiuChongTianJieSysType.eNumber

jiuChongTianJieSubSys_zongmendaoshi.showProgessNum=10



function jiuChongTianJieSubSys_zongmendaoshi:getProgress()
local max=cfgHelper.get2(cfg_zmdsbaseconfig_get,1,'max')
self.showProgessNum=max
return ZongMenDaoShiController:getZongMenDaoShiProgress()
end

function jiuChongTianJieSubSys_zongmendaoshi:getReddot(isEnter)
return ZongMenDaoShiController:getZongMenDaoShiReddot()
end

function jiuChongTianJieSubSys_zongmendaoshi:jump()
ZongMenDaoShiController:showZongMenDaoShiWin()
end

