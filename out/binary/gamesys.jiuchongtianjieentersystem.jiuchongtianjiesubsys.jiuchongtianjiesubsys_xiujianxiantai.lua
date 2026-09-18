













jiuChongTianJieSubSys_xiujianxiantai=jiuChongTianJieSubSysBase.new({sysType=JIUCHONGTIANJIE_SUB_SYS_TYPE.eZhuXianTai})

jiuChongTianJieSubSys_xiujianxiantai.progressType=eJiuChongTianJieSysType.ePrecent

jiuChongTianJieSubSys_xiujianxiantai.showProgessNum=0



function jiuChongTianJieSubSys_xiujianxiantai:checkFinish()
local now,max=jiuChongTianJieSubSys_xiujianxiantai:getProgress()
return now==max
end

function jiuChongTianJieSubSys_xiujianxiantai:getProgress()
local now,max=FeiShengTaiModel:GetFSTRepair()

if now==max then
return 100,100
end
local nowprogress=math.floor(100/max*now)
jiuChongTianJieSubSys_xiujianxiantai.showProgessNum=nowprogress
return nowprogress,100
end

function jiuChongTianJieSubSys_xiujianxiantai:getReddot(isEnter)
return FeiShengTaiModel:GetFSTreddot()
end

function jiuChongTianJieSubSys_xiujianxiantai:jump()
FeiShengTaiModel:OpenFeiShenTaiWin()
end

function jiuChongTianJieSubSys_xiujianxiantai:getBuffList()
local list={}
local num=FeiShengTaiModel:GetFeiShengPeople()
local itemreduce,timereduce=FeiShengTaiModel:judeReducedata(num)
if itemreduce>0 then
local desc=FMT.fmt("修复消耗减少{0}%",itemreduce)
table.insert(list,desc)
end
if timereduce>0 then
local desc2=FMT.fmt("修复耗时减少{0}%",timereduce)
table.insert(list,desc2)
end
return list
end