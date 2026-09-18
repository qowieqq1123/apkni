






local _MODULENAME="LunHuiDianModel"


def_table(_MODULENAME)
LunHuiDianModel.name=_MODULENAME
LunHuiDianModel.data={}

function LunHuiDianModel:onAppStart()

end


function LunHuiDianModel:onEnterState(isReconnect)

end


function LunHuiDianModel:onProtocolReq()

end


function LunHuiDianModel:onLeaveState(isReconnect)

self.data={}
end



function LunHuiDianModel:setPrizeData(value)
self.data.prizeList=value
end

function LunHuiDianModel:getPrizeData()
if self.data and self.data.prizeList then
return self.data.prizeList
end
end


function LunHuiDianModel:getLeastCanRecruit()
local maxNum=yunjiayingModel:getRemainingCanMakeSoldierCount()
local cfg=cfgHelper.get2(cfg_lunhuidianconfig_get,1,'soul_call_back')
cfg=cfg[1]

local itemNum1=cfg[2]
local itemNum2=cfg[3]
local itemId2=eMoneyType.mtHunPo
local itemId1=eMoneyType.mtLunHuiDian

local needNum1=itemNum1*maxNum
local needNum2=itemNum2*maxNum
local haveNum1=itemsModel.getCount(itemId1)
local haveNum2=itemsModel.getCount(itemId2)

if haveNum1<needNum1 or haveNum2<needNum2 then
needNum1=math.floor(haveNum1/itemNum1)
needNum2=math.floor(haveNum2/itemNum2)

if needNum1<needNum2 then
maxNum=needNum1
else
maxNum=needNum2
end
end

return maxNum
end


function LunHuiDianModel:setHQTdata(len,soldierListToday,len2,soldierListTomorrow,showFlag)
self.data.nowLHnum={}
self.data.nextLHnum={}
self.data.showFlag=showFlag or 0
if len>0 and soldierListToday then
self.data.nowLHnum=soldierListToday
end
if len2>0 and soldierListTomorrow then
self.data.nextLHnum=soldierListTomorrow
end
end
function LunHuiDianModel:freshHQTdata(len,soldierListToday)
if not self.data.nowLHnum then
self.data.nowLHnum={}
end
if len>0 and soldierListToday then
self.data.nowLHnum=soldierListToday
else
self.data.nowLHnum={}
end
end
function LunHuiDianModel:setShowFlag(showFlag)
self.data.showFlag=showFlag or 0
end

function LunHuiDianModel:getHQTNowLHnum()
return self.data.nowLHnum
end

function LunHuiDianModel:getHQTNextLHnum()
return self.data.nextLHnum
end

function LunHuiDianModel:getShowFlag()
return self.data.showFlag
end



function LunHuiDianModel:checkHQTSystem(showtip)
local flag=self:getShowFlag()
if flag and flag==1 then
return true
else
if showtip then
UIManager.info('系统暂未开放')
end
return false
end
end

function LunHuiDianModel:checkReqOpenHQT()
local flag=self:getShowFlag()
if flag and flag==0 then





if not MojiePreviewExtendController.checkPoKaiMoJieFlag()then
return false
end
LunHuiDianController.send_6_193()
end
end

function LunHuiDianModel:getHYReddot()
if not self:checkHQTSystem()then
return false
end
if self:firstHQTReddot()then
return true
end
if yunjiayingModel:getRemainingCanMakeSoldierCount()<=0 then
return false
end
if self.data.nowLHnum then
for k,v in pairs(self.data.nowLHnum)do
local num=v.param_2 and tonumber(tostring(v.param_2))or 0
if num>0 then
return true
end
end
end
return false
end

function LunHuiDianModel:jumpHQTWin()
jumpManager:jump({id=JUMP_TYPE.eXianJieBaoLei},function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eLunHuiDian)
if bdData then
UIFullLunHuiDianControl:showMainHQTWindow(bdData)
end
end,JUMP_BACK.eNoBack)
end

function LunHuiDianModel:firstHQTReddot()
local isfirst=userActorSetting.get('HQTOpen',true)
return isfirst
end