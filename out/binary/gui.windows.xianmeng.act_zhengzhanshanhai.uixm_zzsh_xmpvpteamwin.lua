







def_class("UIXM_ZZSH_xmPvPTeamWin",UIWindowBase)









function UIXM_ZZSH_xmPvPTeamWin:bindComponents()

self.noSign=UIObject.get(self,0)
self.itemsScrollView=UIEnhancedScrollerLua.get(self,1)



end


function UIXM_ZZSH_xmPvPTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.itemsScrollView);self.itemsScrollView=nil;
end
















local _this=nil
local UIItemScroller=simple_class(UIEnhancedScroller)


function UIXM_ZZSH_xmPvPTeamWin:onLoaded(...)
_this=self
self:bindComponents()
self.scrollscript=UIItemScroller(self.itemsScrollView:getGameObject(),self.itemsScrollView:getCSharpObject(),nil,nil)
end


function UIXM_ZZSH_xmPvPTeamWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_xmPvPTeamWin:onHide()

end




function UIXM_ZZSH_xmPvPTeamWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self:refreshView()
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshAllItem()
end)
end
end

function UIXM_ZZSH_xmPvPTeamWin:refreshAllItem()
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVPFight then
if self.mDataList and#self.mDataList>0 then
self:refreshItemsSV()
end
end
end

function UIXM_ZZSH_xmPvPTeamWin:refreshView()
local list={}
local pvpTargets=zhengzhanshanhaiModel:getpvpTargetsLookup()
if pvpTargets then
for k,targetData in pairs(pvpTargets)do
if targetData.len>0 and targetData.guildid then
table.insert(list,targetData.targetid_str)
end
end
end
self.mDataList=list
local num=#self.mDataList
self.noSign:setActive(num<=0)
self:refreshItemsSV()
end


function UIXM_ZZSH_xmPvPTeamWin:getPvPTargetState(targetData)
local name
if targetData:checkInFight()then
name=toColorStringX('#c82c2c','战斗中')
elseif targetData:checkInStandby()then
name=toColorStringX('#65615f','待战中')
else
if targetData.attackidx<=targetData.len then
name=toColorStringX('#65615f','待战中')
else

name=toColorStringX('#6833c0','战斗已结束')
end
end
return name
end



function UIXM_ZZSH_xmPvPTeamWin:refreshItemsSV()
if not self.initSV then
self.initSV=true
local n=#self.mDataList
self.scrollscript:initData(nil,112,n)
else
self.scrollscript:doRefreshActiveCellViews()
end
end

function UIItemScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIItemScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:refreshItemState(dataIndex,cellIndex,cell)
end

function UIItemScroller:RefreshCell(dataIndex,cellIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local targetid_str=_this.mDataList[dataIndex]
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)

local xmData=zhengzhanshanhaiModel:getXMData(targetData.guildid)
local name_str=xmData.guildname
item:SetChildText(0,name_str)

local ismy=xianmengModel:isMyXM(targetData.guildid)or zhengzhanshanhaiModel:checkHasOrder(targetData.guildid,nil)~=nil
item:SetChildActive(4,ismy)

item:SetChildButtonClick(2,function()
self:onCheckBtn(dataIndex)
end)

item:SetChildButtonClick(3,function()
self:onGoBtn(dataIndex)
end)

self:refreshItemState(dataIndex,cellIndex,item)
end

function UIItemScroller:refreshItemState(dataIndex,cellIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local targetid_str=_this.mDataList[dataIndex]
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
if targetData==nil then return nil end

local name=_this:getPvPTargetState(targetData)

local state_str=FMT.fmt('状态：{0}',name)
item:SetChildText(1,state_str)
end

function UIItemScroller:onCheckBtn(dataIndex)
if _this==nil then return end
local targetid_str=_this.mDataList[dataIndex]
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
local idx_=targetData:getShowIndex()
zhengzhanshanhaiModel:checkOpenPvPAttackDataWin(targetData.targetid,idx_)
end

function UIItemScroller:onGoBtn(dataIndex)
if _this==nil then return end
local targetid_str=_this.mDataList[dataIndex]
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
zhengzhanshanhaiModel:jumpPvPTarget(targetData)
UIManager:invokeUIMethod(self.parentWin,'onClickClose')
end

