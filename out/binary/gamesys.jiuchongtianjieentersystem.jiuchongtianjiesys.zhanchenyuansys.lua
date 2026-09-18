





local showSys={
JIUCHONGTIANJIE_SUB_SYS_TYPE.eSiFangPingYao,
JIUCHONGTIANJIE_SUB_SYS_TYPE.eHongChenJie,
JIUCHONGTIANJIE_SUB_SYS_TYPE.eZongMenDaoShi,
}

ZhanChenYuanSys=jiuChongTianJieSysBase.new({sysType=JIUCHONGTIANJIE_SYS_TYPE.eZhanChenYuan,showSys=showSys})


function ZhanChenYuanSys:getConditon()
return JiuChongTianJieEnterModel:getState()==eJiuChongTianJieStateType.eDoing
end


function ZhanChenYuanSys:getConditonTxt()
return'完成天劫前奏后开启'
end

