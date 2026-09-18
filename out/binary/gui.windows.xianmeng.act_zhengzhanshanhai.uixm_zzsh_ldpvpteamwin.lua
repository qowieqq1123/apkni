







def_class("UIXM_ZZSH_ldPvPTeamWin",UIWindowBase)









function UIXM_ZZSH_ldPvPTeamWin:bindComponents()

self.pageGrid=UIObject.get(self,0)
self.noSign=UIObject.get(self,1)
self.itemsScrollView=UIEnhancedScrollerLua.get(self,2)



end


function UIXM_ZZSH_ldPvPTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pageGrid);self.pageGrid=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.itemsScrollView);self.itemsScrollView=nil;
end
















local _this=nil
local UIItemScroller=simple_class(UIEnhancedScroller)


function UIXM_ZZSH_ldPvPTeamWin:onLoaded(...)
_this=self
self:bindComponents()
self.scrollscript=UIItemScroller(self.itemsScrollView:getGameObject(),self.itemsScrollView:getCSharpObject(),nil,nil)
end


function UIXM_ZZSH_ldPvPTeamWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_ldPvPTeamWin:onHide()

end




function UIXM_ZZSH_ldPvPTeamWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.selectPage=1
self:initGrid()
self:refreshView()
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshAllItem()
end)
end
end

function UIXM_ZZSH_ldPvPTeamWin:refreshAllItem()
local raceState=zhengzhanshanhaiModel:getLunState()
self.raceState=raceState
if raceState==eZZSH_State.ePVPFight then
if self.mDataList and#self.mDataList>0 then
self:refreshItemsSV()
end
end
end

function UIXM_ZZSH_ldPvPTeamWin:initGrid()
local names={'洞天','福地'}
local n=#names
self.pageGrid:setChildLayoutGroupCreateItems(n)
local grids=self.pageGrid:getChildLayoutGroupGridList()
for i=1,n do
local item=grids[i-1]

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onGridItemClick(i)
end)

local name_str=names[i]
item:SetChildText(1,name_str)
self:refreshGridItemSelect(item,i,i==self.selectPage)
end
end

function UIXM_ZZSH_ldPvPTeamWin:refreshGridItemSelect(item,idx,flag)
if item==nil then
item=self.pageGrid:getChildLayoutGroupGridItem(idx-1)
end
local icon=flag==true and'button_shsjbianjixzui_2'or'button_shsjbianjixzui_1'
item:SetChildCSImageSprite(0,globalABLookup.zzshicons,icon)
end

function UIXM_ZZSH_ldPvPTeamWin:onGridItemClick(idx)
if self.selectPage==idx then
return
end
if self.selectPage then
self:refreshGridItemSelect(nil,self.selectPage,false)
end
self:refreshGridItemSelect(nil,idx,true)
self.selectPage=idx

self:refreshView(true)
end

function UIXM_ZZSH_ldPvPTeamWin:refreshView(isInit)
local list={}
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
for pos,v in pairs(baseCfg.domain)do
local cfg=zhengzhanshanhaiModel:getLingDiCfgByPos(pos)
if self.selectPage==cfg.type then
local targetid_str=tostring(-cfg.domain)
table.insert(list,{targetid_str,cfg.domain})
end
end
self.mDataList=list
local num=#self.mDataList
self.noSign:setActive(num<=0)
self:refreshItemsSV(isInit)
end


function UIXM_ZZSH_ldPvPTeamWin:getPvPTargetState(targetData)
local name
if targetData:checkInFight()then
name=toColorStringX('#c82c2c','争夺中')
elseif targetData:checkInStandby()then
name=toColorStringX('#65615f','等待争夺')
else
if targetData.attackidx<=targetData.len then
name=toColorStringX('#65615f','等待争夺')
else

name=toColorStringX('#6833c0','战斗已结束')
end
end
return name
end



function UIXM_ZZSH_ldPvPTeamWin:refreshItemsSV(isInit)
if not self.initSV or isInit then
self.initSV=true
local n=#self.mDataList
self.scrollscript:initData(nil,126,n)
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
local data=_this.mDataList[dataIndex]
local targetid_str=data[1]
local domainid=data[2]
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)

local cfg=zhengzhanshanhaiModel:getLingDiCfg(domainid)
local name_str=cfg.name
item:SetChildText(0,name_str)

local ismy=false
local ldData=zhengzhanshanhaiModel:getLDData(domainid)
if ldData then
local xmData=ldData:getXM()
if xmData then
ismy=xianmengModel:isMyXM(xmData.guildid)
end
end
if not ismy and targetData then
local my_guildid=xianmengModel:myXMGuildID()
if my_guildid then
ismy=targetData:checkXM(tostring(my_guildid))
end
end
item:SetChildActive(5,ismy)

local showCheck=targetData~=nil
item:SetChildActive(3,showCheck)
if showCheck then
item:SetChildButtonClick(3,function()
self:onCheckBtn(dataIndex)
end)
end

item:SetChildButtonClick(4,function()
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
local data=_this.mDataList[dataIndex]
local targetid_str=data[1]
local domainid=data[2]
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
if targetData==nil then

item:SetChildText(2,'状态：<color=#65615f>暂无争夺信息</color>')
else

local name=_this:getPvPTargetState(targetData)

local state_str=FMT.fmt('状态：{0}',name)
item:SetChildText(2,state_str)
end

local xmData
if _this.raceState==eZZSH_State.ePVPFight then
if targetData then
local winner=targetData:findWinner()
if winner then
xmData=zhengzhanshanhaiModel:getXMData(winner)
end
end
end
if xmData==nil then
local ldData=zhengzhanshanhaiModel:getLDData(domainid)
if ldData then
xmData=ldData:getXM()
end
end
local name_str
if xmData~=nil then
name_str=FMT.fmt('归属：<color=#171311>{0}</color>',xmData.guildname)
else
name_str='归属：<color=#65615f>无</color>'
end
item:SetChildText(1,name_str)
end

function UIItemScroller:onCheckBtn(dataIndex)
if _this==nil then return end
local data=_this.mDataList[dataIndex]
local targetid_str=data[1]
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
if targetData then
local idx_=targetData:getShowIndex()
zhengzhanshanhaiModel:checkOpenPvPAttackDataWin(targetData.targetid,idx_)
end
end

function UIItemScroller:onGoBtn(dataIndex)
if _this==nil then return end
local data=_this.mDataList[dataIndex]
local targetid_str=data[1]
local domainid=data[2]
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
if targetData then
zhengzhanshanhaiModel:jumpPvPTarget(targetData)
UIManager:invokeUIMethod(self.parentWin,'onClickClose')
else
local ldData=zhengzhanshanhaiModel:getLDData(domainid)
if ldData~=nil then
local e_x,e_y=zhengzhanshanhaiModel:getLingDiGridPos(domainid)
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',e_x,e_y,0,false,0,function()
UIManager:showWindow('UIXM_ZZSH_lindiWin',{cfgID=domainid})
end)
UIManager:invokeUIMethod(self.parentWin,'onClickClose')
end
end
end

