







def_class("UICommonLookRival_select3TeamWin",UIWindowBase)









function UICommonLookRival_select3TeamWin:bindComponents()

self.selectTeamBtnList=UIObject.get(self,0)



end


function UICommonLookRival_select3TeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.selectTeamBtnList);self.selectTeamBtnList=nil;
end
















local _this




function UICommonLookRival_select3TeamWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UICommonLookRival_select3TeamWin:__delete()
self:unbindComponents()
_this=nil
end




function UICommonLookRival_select3TeamWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
if argtable.data then
self.data=argtable.data
end
self.lookType=argtable.lookType
self.selectTeamIndex=1
self:refresh()
end
end


function UICommonLookRival_select3TeamWin:onHide()

end

function UICommonLookRival_select3TeamWin:refresh()
local teamCount=self.data.teamCount
local grids=self.selectTeamBtnList:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
if i<=teamCount then

item:SetChildActive(-1,true)
local isSelect=i==self.selectTeamIndex
item:SetChildActive(0,not isSelect)
item:SetChildActive(1,isSelect)

local teamNameStr=FMT.fmt("第 {0} 队",i)
item:SetChildText(2,teamNameStr)

item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onTeamBtnClick(i)
end)
else

item:SetChildActive(-1,false)
end
end
end


function UICommonLookRival_select3TeamWin:onTeamBtnClick(teamIndex)
if teamIndex==self.selectTeamIndex then
return
end


local item=self.selectTeamBtnList:getChildCommonLayoutGroupWidgetItem(self.selectTeamIndex-1)
item:SetChildActive(0,true)
item:SetChildActive(1,false)
self.selectTeamIndex=teamIndex
item=self.selectTeamBtnList:getChildCommonLayoutGroupWidgetItem(teamIndex-1)
item:SetChildActive(0,false)
item:SetChildActive(1,true)


if self.parentWin then
UIManager:invokeUIMethod(self.parentWin,'selectTeam',teamIndex)
end
end

