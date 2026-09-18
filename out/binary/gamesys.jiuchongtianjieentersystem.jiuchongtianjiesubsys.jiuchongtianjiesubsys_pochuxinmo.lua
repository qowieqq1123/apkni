













jiuChongTianJieSubSys_pochuxinmo=jiuChongTianJieSubSysBase.new({sysType=JIUCHONGTIANJIE_SUB_SYS_TYPE.eXinMoJie})

jiuChongTianJieSubSys_pochuxinmo.progressType=eJiuChongTianJieSysType.eNumber

jiuChongTianJieSubSys_pochuxinmo.showProgessNum=0



function jiuChongTianJieSubSys_pochuxinmo:checkFinish()
return false
end

function jiuChongTianJieSubSys_pochuxinmo:getProgress()
return WenXinGuanModel:getProgress()
end

function jiuChongTianJieSubSys_pochuxinmo:getReddot(isEnter)
return false
end

function jiuChongTianJieSubSys_pochuxinmo:jump()
local return_jump_param=
{
id=8300,
args={sysType=3},
}


local guid
if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie3)and
not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
local num=WenXinGuanModel:getFinishDzCount()

if num>=1 then
local list=WenXinGuanModel:getFinishDzList()
if list then
guid=list[1]
end
end
end

local jumpType
if not guid then guid=WenXinGuanModel:getDtDzGuid()end
local winName=WenXinGuanModel:checkDzIsFinishWXG(guid)

local args=
{
guid=guid,
isFull=true,
return_jump_param=return_jump_param,
}

if winName=="UIWenXinGuanEnterWin"then
jumpType=JUMP_TYPE.eWenXinGuan
elseif winName=="UIWenXinGuanMainWin"then
jumpType=JUMP_TYPE.eWenXinGuan_Main
elseif winName=="UIWenXinGuanTransferImmortalWin"then
jumpType=JUMP_TYPE.eWenXinGuan_Immortal
elseif winName=="UIWenXinGuanTransferDevilWin"then
jumpType=JUMP_TYPE.eWenXinGuan_Devli
elseif winName=="UIWenXinGuanUnknownWin"then
local state=WenXinGuanModel:getMemoryTransferWin(guid)
if not state then
jumpType=JUMP_TYPE.eWenXinGuan_Unknow
else
jumpType=JUMP_TYPE.eWenXinGuan_Transfer
end
end
jumpManager:jump({id=jumpType,args=args})
end

