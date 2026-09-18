









worldHUDScenery=simple_class(worldHUDBase)
worldHUDScenery.name="worldHUDScenery"

function worldHUDScenery:onCreate()
local name=UISettingModel:getZMName()
local nameStr
if pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei()then
nameStr=name
else
local charList=string.toTable(name)
nameStr=table.concat(charList,"\n")
end
self.cmp:SetChildText(0,nameStr)
self.cmp:SetChildButtonClick(1,function()
worldController.onClickUnit(self.data)
end)
self.cmp:SetChildActive(1,name and name~=""or false)






end



