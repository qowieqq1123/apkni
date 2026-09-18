







def_class("UIWorldMonsterInfoWin",UIWindowBase)









function UIWorldMonsterInfoWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.closeTxt=UIText.get(self,1)
self.enterTxt=UIText.get(self,2)
self.quitButton=UIButton.get(self,3)
self.enterButton=UIButton.get(self,4)
self.skillPanel=UIObject.get(self,5)
self.Icon=UIImage.get(self,6)
self.nameTxt=UIText.get(self,7)
self.jjTxt=UIText.get(self,8)
self.itemPanel=UIObject.get(self,9)
self.rewardButton=UIButton.get(self,10)
self.costPanel=UIObject.get(self,11)
self.costTxt=UIText.get(self,12)
self.costImage=UIImage.get(self,13)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIWorldMonsterInfoWin")end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)

self.enterButton:setButtonClick(function()self:onEnterButton()end)

self.rewardButton:setButtonClick(function()self:onRewardButton()end)



end


function UIWorldMonsterInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.closeTxt);self.closeTxt=nil;
_UIObject_release(self.enterTxt);self.enterTxt=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.enterButton);self.enterButton=nil;
_UIObject_release(self.skillPanel);self.skillPanel=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.nameTxt);self.nameTxt=nil;
_UIObject_release(self.jjTxt);self.jjTxt=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.rewardButton);self.rewardButton=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
_UIObject_release(self.costImage);self.costImage=nil;
end



















local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemBgCountIdx=2,
cmpItemTxtCountIdx=3,
cmpItemTxtStage=4,
}


function UIWorldMonsterInfoWin:onLoaded(...)
self:bindComponents()
notifySystem:listenNotify(notifyConfig.swipe,self.on_swipe)
end


function UIWorldMonsterInfoWin:__delete()
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
self:unbindComponents()
end




function UIWorldMonsterInfoWin:onShow(argtable,afterOnloaded)
self:updateData(argtable)
self:initUI()
end


function UIWorldMonsterInfoWin:onHide()

end






function UIWorldMonsterInfoWin:updateData(argtable)

local monster=argtable
self.areaId=monster.areaId
self.worldMonsterId=monster.worldMonsterId
self.guid=monster.guid
local areaId,idx=worldMonsterModel:get_idx(monster.guid)
self.idx=idx
self.posData=monster.posData

end



function UIWorldMonsterInfoWin:initUI()
if not self.worldMonsterId then return end
local config=worldMonsterModel.get_monster_group_config(self.worldMonsterId)


self.nameTxt:setText(config.name)

self.winid:SetChildCSImageIcon(self.Icon:getID(),config.icon,false)

self.jjTxt:setText(UIDiscipleModel:getJJNameXX(config.jingJieLevel))


local length=#config.showSkill
self.skillPanel:setChildLayoutGroupCreateItems(length)
local gridlist=self.skillPanel:getChildLayoutGroupGridList()
local gridNum=gridlist.Count
if gridNum>0 then
for i=1,gridNum do
local item=gridlist[i-1]
local skill=config.showSkill[i]
if item and skill then
local skillID=skill[1]
local level=skill[2]
local skillCfg=cfg_skillconfig_get(skillID)
item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
item:SetChildButtonClick(0,function()
UIManager:showWindow("UIWorldMonsterSkillInfoWin",{skillID,level})
end)
end

end
end
self.showReward=config.showReward
self.itemPanel:setChildLayoutGroupCreateItems(5)
gridlist=self.itemPanel:getChildLayoutGroupGridList()
gridNum=gridlist.Count
if gridNum>0 then
for i=1,gridNum do
local item=gridlist[i-1]
local itemValue=config.showReward[i]
if item and itemValue then
local itemId=itemValue[1]
local count=itemValue[2]
local itemConfig=itemsConfig.getConfig(itemId)
self:fillItem(item,itemId,count,itemConfig)
end
end
end
local cost=config.cost
if cost then
self.cost=type(cost[1])=="number"and cost or cost[1]
end
self.costPanel:setActive(self.cost~=nil)
if self.cost then
self.costImage:setImageIcon(iconHelper.getIconName(self.cost[1]),false)
self.costTxt:setText(-self.cost[2])
end
end

function UIWorldMonsterInfoWin:fillItem(grid,itemid,count,itemConfig)
if not grid then
return
end
grid:SetBaseItemClickEvent(0,function(...)self:onItemClick(...)end)
local prop={}
local color=itemConfig.color
prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,_itemWidgetIdx.cmpItemIconIdx)]=iconHelper.getIconName(itemid)
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemBgCountIdx)]=true
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCountIdx)]=count==-1 and'概率'or count
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtStage)]=itemConfig.stage and FMT.fmt('{0}阶',itemConfig.stage)or''
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=-1
grid:SetChildPropData(0,prop)
end

function UIWorldMonsterInfoWin:refreshUI()

end


function UIWorldMonsterInfoWin.on_swipe(...)

worldController:resetRightView()
end


function UIWorldMonsterInfoWin:onQuitButton()
worldMonsterProtocolController.req_abandon(self.areaId,self.guid)

end

function UIWorldMonsterInfoWin:onEnterButton()
local world=worldModel.world
local pos,block=worldPositionConfig:getPosition_CurrentWorld(self.posData)
local cState=worldBlockModel:getBlockState(world,block)
if cState~=worldBlockModel.BLOCKSTATE.OPEN then
UIManager.error("区块未解锁")
return
end

if self.cost and not moneyModel.checkEnoughMoney(self.cost[1],self.cost[2])then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(self.cost[1])))
gainControl:showGainWin(self.cost[1])
return
end

worldMonsterController:select_disciple(self.guid,self.idx)
end

function UIWorldMonsterInfoWin:onRewardButton()
if self.showReward then
UIManager:showWindow("UIWorldRewardDetailWin",self.showReward)
end
end

function UIWorldMonsterInfoWin:onItemClick(id,index,guid,attach)
itemsComponentHelper.onItemClick(id,index,guid,attach)
end