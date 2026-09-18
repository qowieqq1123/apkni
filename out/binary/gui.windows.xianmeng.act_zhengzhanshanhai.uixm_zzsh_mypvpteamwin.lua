







def_class("UIXM_ZZSH_myPvPTeamWin",UIWindowBase)









function UIXM_ZZSH_myPvPTeamWin:bindComponents()

self.noSign=UIObject.get(self,0)
self.itemPanel=UIObject.get(self,1)



end


function UIXM_ZZSH_myPvPTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
end
















local _this=nil


function UIXM_ZZSH_myPvPTeamWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_ZZSH_myPvPTeamWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_myPvPTeamWin:onHide()

end




function UIXM_ZZSH_myPvPTeamWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self:refreshView()
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshAllItem()
end)
end
end

function UIXM_ZZSH_myPvPTeamWin:refreshAllItem()
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVPFight then
if self.mDataList then
local num=#self.mDataList
if num>0 then
local grids=self.itemPanel:getChildLayoutGroupGridList()
for idx,v in ipairs(self.mDataList)do
local item=grids[idx-1]
self:refreshItem(item,idx)
end
end
end
end
end

function UIXM_ZZSH_myPvPTeamWin:refreshView()
local list={}
local allorders=zhengzhanshanhaiModel:getAllPvPOrder()
if allorders then
local max=zhengzhanshanhaiModel:getAtkTeamMaxNum()
for i=1,max do
local orderData=allorders[i]
if orderData then
local targetData=orderData:getpvpTargetData()
if targetData then
table.insert(list,{i,orderData.targetid_str})
end
end
end
if allorders[0]then
local guildid=xianmengModel:myXMGuildID()
if guildid then

local targetid_str=tostring(guildid)
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
if targetData then
table.insert(list,{0,targetid_str})
end

local ldData=zhengzhanshanhaiModel:getLDDataByXM(guildid)
if ldData then
local targetid_str=tostring(-ldData.domainid)
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
if targetData then
table.insert(list,{0,targetid_str})
end
end
end
end
end
self.mDataList=list
local num=#self.mDataList
self.noSign:setActive(num<=0)
self.itemPanel:setChildLayoutGroupCreateItems(num,function(idx)
if _this==nil then return end
_this:initGridItem(nil,idx)
end)
end

function UIXM_ZZSH_myPvPTeamWin:initGridItem(item,idx)
if item==nil then
item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local data=self.mDataList[idx]
local teamtype=data[1]
local targetid_str=data[2]

item:SetChildText(0,tostring(idx))

local name_str=zhengzhanshanhaiModel:getTeamZhenRongName2(teamtype)
item:SetChildText(1,name_str)

item:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onDetailBtn(teamtype)
end)

local signIcon=teamtype>0 and'image_shanhaisjui_18'or'image_shanhaisjui_19'
item:SetChildCSImageSprite(3,globalABLookup.zzshicons,signIcon)

local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
local desc
if teamtype>0 then
if targetData.guildid then
local xmData=zhengzhanshanhaiModel:getXMData(targetData.guildid)
if xmData then
desc=FMT.fmt('掠夺 <color=#7d3b17>{0}</color> 仙盟物资',xmData.guildname)
end
elseif targetData.domainid then
local cfg=zhengzhanshanhaiModel:getLingDiCfg(targetData.domainid)
if cfg then
local ldData=zhengzhanshanhaiModel:getLDData(targetData.domainid)
local xmData
if ldData then
xmData=ldData:getXM()
end
if xmData then
desc=FMT.fmt('占领 <color=#7d3b17>{0}</color> 的领地 <color=#7d3b17>{1}</color>',xmData.guildname,cfg.name)
else
desc=FMT.fmt('占领领地 <color=#7d3b17>{0}</color>',cfg.name)
end
end
end
else
if targetData.guildid then
desc='防守仙盟被掠夺'
elseif targetData.domainid then
local cfg=zhengzhanshanhaiModel:getLingDiCfg(targetData.domainid)
if cfg then
desc=FMT.fmt('防守领地 <color=#7d3b17>{0}</color> 被占领',cfg.guildname)
end
end
end
item:SetChildText(4,desc)

item:SetChildButtonClick(6,function()
if _this==nil then return end
_this:onCheckBtn(idx)
end)

item:SetChildButtonClick(7,function()
if _this==nil then return end
_this:onGoBtn(idx)
end)

self:refreshItem(item,idx)
end


function UIXM_ZZSH_myPvPTeamWin:getPvPTargetState(targetData)
local name
if targetData:checkInFight()then
if targetData.guildid then
name='战斗中'
else
name='争夺中'
end
name=toColorStringX('#c82c2c',name)
elseif targetData:checkInStandby()then
if targetData.guildid then
name='待战中'
else
name='等待争夺'
end
name=toColorStringX('#65615f',name)
else
if targetData.attackidx<=targetData.len then
if targetData.guildid then
name='待战中'
else
name='等待争夺'
end
name=toColorStringX('#65615f',name)
else

name=toColorStringX('#6833c0','战斗已结束')
end
end
return name
end

function UIXM_ZZSH_myPvPTeamWin:refreshItem(item,idx)
if item==nil then
item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return nil end
local data=self.mDataList[idx]
local teamtype=data[1]
local targetid_str=data[2]
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
if targetData==nil then return nil end

local name=self:getPvPTargetState(targetData)

local state_str=FMT.fmt('状态：{0}',name)
item:SetChildText(5,state_str)
end

function UIXM_ZZSH_myPvPTeamWin:onDetailBtn(teamtype)
local guildid=xianmengModel:myXMGuildID()
if guildid then
zhengzhanshanhaiModel:checkOpenOtherTeamWin(guildid,1,teamtype)
end
end

function UIXM_ZZSH_myPvPTeamWin:onCheckBtn(idx)
local data=self.mDataList[idx]
local teamtype=data[1]
local targetid_str=data[2]
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
local idx_=targetData:getShowIndex()
zhengzhanshanhaiModel:checkOpenPvPAttackDataWin(targetData.targetid,idx_)
end

function UIXM_ZZSH_myPvPTeamWin:onGoBtn(idx)
local data=self.mDataList[idx]
local teamtype=data[1]
local targetid_str=data[2]
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
zhengzhanshanhaiModel:jumpPvPTarget(targetData)
UIManager:invokeUIMethod(self.parentWin,'onClickClose')
end