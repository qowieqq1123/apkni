









worldHUDSystemZMOutgoer=simple_class(worldHUDBase)
worldHUDSystemZMOutgoer.name="worldHUDSystemZMOutgoer"

function worldHUDSystemZMOutgoer:onCreate()
local discipleguid=self.data[2]
local data=systemZongMenModel:getOutgoerData(discipleguid)
local zmData=systemZongMenModel:getInfoData(data.serial)
local name=systemZongMenModel:getNameStr(zmData.id,zmData.nameIdx)
local charList=string.toTable(name)
local nameStr
if pfwindowslController:checkIsGameVersion_yuenan()then
nameStr=name
else
local charList=string.toTable(name)
nameStr=table.concat(charList,"\n")
end
self.cmp:SetChildText(0,nameStr)
self.cmp:SetChildButtonClick(1,function()
worldController.onClickUnit(self.data)
end)
self.cmp:SetChildActive(1,true)
end