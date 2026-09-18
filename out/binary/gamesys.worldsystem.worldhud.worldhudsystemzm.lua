









worldHUDSystemZM=simple_class(worldHUDBase)
worldHUDSystemZM.name="worldHUDSystemZM"

local _cmp={
nameTx=0,
nameBg=1,
icon=2,
root=3,
cdBg=4,
cdTx=5,
spineBg=6,
spineTx=7,
cdBg2=8,
cdTx2=9,
}

function worldHUDSystemZM:onCreate()
self.serial=self.data[2]
self.infoData=systemZongMenModel:getInfoData(self.serial)

self.cmp:SetChildButtonClick(1,function()
worldController.onClickUnit(self.data)
end)
self.cmp:SetChildActive(1,true)

worldHUDBase.onCreate(self)
end

function worldHUDSystemZM:onUpdate()
local flagType=self.infoData.flag

local name=flagType==systemZongMenFightFlagType.eExpel and cfgHelper.get2(cfg_syssectbaseconfig_get,1,"ruinName")or systemZongMenModel:getNameStr(self.infoData.id,self.infoData.nameIdx)
local charList=string.toTable(name)
local nameStr
if pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei()then
nameStr=name
else
local charList=string.toTable(name)
nameStr=table.concat(charList,"\n")
end
self.cmp:SetChildText(0,nameStr)


self.cdHandle=systemZongMenModel:getFightFlagHUDHandle(flagType)
if flagType==systemZongMenFightFlagType.eVassal and self.infoData.start_time==-1 then
self.cdHandle.over="附庸中"
end

local nowTime=timeHelper.getServerShortTime()
if not systemZongMenModel:checkWaitNotifyStamp(self.serial,nowTime)then
self.cdHandle=nil
end

if self.cdHandle then
if self.cdHandle.image then
self.cmp:SetChildActive(_cmp.cdBg,true)
self.cmp:SetChildCSImageSprite(_cmp.cdBg,self.cdHandle.image[1],self.cdHandle.image[2])
self.cmp:SetChildActive(_cmp.spineBg,false)
self.cmp:SetChildUIModelRemoveTarget(_cmp.spineBg)
self.cmp:SetChildActive(_cmp.cdBg2,false)
elseif self.cdHandle.spine then
self.cmp:SetChildActive(_cmp.cdBg,false)
self.cmp:SetChildIcon(_cmp.cdBg,"",false)
self.cmp:SetChildActive(_cmp.spineBg,true)
self.cmp:SetChildUIModelShowTarget(_cmp.spineBg,self.cdHandle.spine,0.75,{},eAnimationID.stand,false,false,0,nil)
self.cmp:SetChildActive(_cmp.cdBg2,false)
else
self.cmp:SetChildActive(_cmp.cdBg,false)
self.cmp:SetChildIcon(_cmp.cdBg,"",false)
self.cmp:SetChildActive(_cmp.spineBg,false)
self.cmp:SetChildUIModelRemoveTarget(_cmp.spineBg)
self.cmp:SetChildActive(_cmp.cdBg2,true)
end
if self:updataCDTick()then
self:startCDTick()
end
else
self.cmp:SetChildActive(_cmp.cdBg2,false)
self.cmp:SetChildActive(_cmp.cdBg,false)
self.cmp:SetChildIcon(_cmp.cdBg,"",false)
self.cmp:SetChildActive(_cmp.spineBg,false)
self.cmp:SetChildUIModelRemoveTarget(_cmp.spineBg)
self.cmp:SetChildText(_cmp.cdTx,"")
self:stopCDTick()
end
end

function worldHUDSystemZM:onDestory()
self:stopCDTick()
end

function worldHUDSystemZM:startCDTick()
if not self.cdTick then
self.cdTick=timer.new()
self.cdTick:start(1,function()
self:updataCDTick()
end,-1)
end
end

function worldHUDSystemZM:stopCDTick()
if self.cdTick then
self.cdTick:cancel()
self.cdTick=nil
end
end

function worldHUDSystemZM:updataCDTick()
local nowTime=timeHelper.getServerShortTime()
local cmpTx=nil
if self.cdHandle.image then
cmpTx=_cmp.cdTx
elseif self.cdHandle.spine then
cmpTx=_cmp.spineTx
else
cmpTx=_cmp.cdTx2
end
if not cmpTx then
return false
end
if nowTime>self.infoData.end_time then
local over=self.cdHandle.over
if self.cdHandle.color then
over=FMT.fmt("<color=#{1}>{0}</color>",over,self.cdHandle.color)
end
self.cmp:SetChildText(_cmp.cdTx,over)
self:stopCDTick()
return false
else
local delta=self.infoData.end_time-nowTime
local cdStr=timeHelper.format_time_stamp16(delta)
if self.cdHandle.color then
cdStr=FMT.fmt("<color=#{1}>{0}</color>",cdStr,self.cdHandle.color)
end
cdStr=FMT.fmt("{0}{1}",cdStr,self.cdHandle.postStr or"")
self.cmp:SetChildText(cmpTx,cdStr)
return true
end
end