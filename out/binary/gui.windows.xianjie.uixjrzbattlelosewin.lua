







def_class("UIXJRZBattleLoseWin",UIWindowBase)









function UIXJRZBattleLoseWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.strengthenCreator=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.tgslpanel=UIObject.get(self,3)
self.tgsltxt2=UIText.get(self,4)
self.tgsltxtup=UIObject.get(self,5)
self.tgsltxtup2=UIObject.get(self,6)
self.tgsltxt3=UIText.get(self,7)



end


function UIXJRZBattleLoseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.strengthenCreator);self.strengthenCreator=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tgslpanel);self.tgslpanel=nil;
_UIObject_release(self.tgsltxt2);self.tgsltxt2=nil;
_UIObject_release(self.tgsltxtup);self.tgsltxtup=nil;
_UIObject_release(self.tgsltxtup2);self.tgsltxtup2=nil;
_UIObject_release(self.tgsltxt3);self.tgsltxt3=nil;
end
















local _this=nil




function UIXJRZBattleLoseWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXJRZBattleLoseWin:__delete()
self:unbindComponents()
_this=nil
end


function UIXJRZBattleLoseWin:onHide()

end










function UIXJRZBattleLoseWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end
self:delayDo(0.4,func)
end


self.battleType=argtable.battleType
self.battleId=argtable.battleId
self.parentWin=argtable.parentWin


local title_str=argtable.title or'遗憾战败，请再接再厉'
self.rzdata=argtable.rzdata
if self.rzdata then
if self.rzdata.lose_txt then
title_str=self.rzdata.lose_txt
end
end
self.titleTxt:setText(title_str)


self.jumpParams={}
local disciples={}
if argtable.fightData then
self.fightData=argtable.fightData[1]
for i,data in ipairs(self.fightData.left)do
if data.enityType==fightEntityType.diZi then
local netDataX=UIDiscipleModel:getDiscipleDataX(data.dis_guid)
if netDataX then
table.insert(disciples,netDataX)
end
end
end
end
if#disciples<=0 then
disciples=nil
end
self.jumpParams.disciples=disciples


self.tgsl=argtable.tgsl

































self:delayDo(1,function(...)
self:refreshStrengthenGrids()
self.strengthenCreator:setChildCanvasGroupDOFade(1,0.5,nil)
local comp=self.strengthenCreator:getCommonComponent('UITransitionMonoBehaviour')
comp.enabled=true
end)
end

function UIXJRZBattleLoseWin:refreshStrengthenGrids()
self.jumpData=strengthenController:getStrengthenJumpList(strengthenFunctionType.eFightLose,true)
local jumpCnt=#self.jumpData
self.strengthenCreator:setChildLayoutGroupCreateItems(jumpCnt)
local strengthenGrid=self.strengthenCreator:getChildLayoutGroupGridList()
for i=1,jumpCnt do
local item=strengthenGrid[i-1]
local cfg=self.jumpData[i]
item:SetChildIcon(0,FMT.fmt('icon_sjtp_{0}',cfg.icon),true)
item:SetChildText(1,cfg.name)
item:SetChildButtonClickWithID(2,self.onClickStrengthenItem,i,true)
item:SetChildNewBieComponentId(2,FMT.fmt('UIXJRZBattleLoseWin.item_{0}',i))
end
end



function UIXJRZBattleLoseWin.onClickStrengthenItem(index)
local cfg=_this.jumpData[index]
local jumpParams=_this.jumpParams
local jumpType=cfg.jumpType
local params={disciples=jumpParams.disciples}
local fbid=MysteryModel:get_cur_fbid()
if fbid then
MysteryModel:setQuitNoCloudFlag(true)
end

if _this.parentWin then
if _this.parentWin.isClose then
return
end
local battle=fightModel:getBattle(_this.battleId)

local canClose=_this.parentWin:onCloseTips()
if not canClose then
return
end
if battle then
battle.jump=true
battle:close(false)
end

end

if fbid then
local disciples={}
local probeTeam=MysteryModel:get_fb_probeTeam()
for i,v in ipairs(probeTeam)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
local dis=UIDiscipleModel:getDiscipleDataX(v.unitId)
if dis then
table.insert(disciples,dis)
end
end
end
if#disciples>0 then
params.disciples=disciples
end
strengthenController:setMysteryLeaveFunc(fbid,jumpType,params)
else
strengthenController:doJump(jumpType,params)
end
end
