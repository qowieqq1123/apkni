







def_class("UIWorldMonsterHurtTeamLoseWin",UIWindowBase)









function UIWorldMonsterHurtTeamLoseWin:bindComponents()

self.root=UIObject.get(self,0)
self.tips=UILinkImageText.get(self,1)
self.closeTips=UIButton.get(self,2)
self.strengthenScroll=UIObject.get(self,3)
self.worldName=UIText.get(self,4)
self.strengthenCreator=UIObject.get(self,5)

self.closeTips:setButtonClick(function()self:onCloseTips()end)



end


function UIWorldMonsterHurtTeamLoseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.strengthenScroll);self.strengthenScroll=nil;
_UIObject_release(self.worldName);self.worldName=nil;
_UIObject_release(self.strengthenCreator);self.strengthenCreator=nil;
end















local _this=nil



function UIWorldMonsterHurtTeamLoseWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIWorldMonsterHurtTeamLoseWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWorldMonsterHurtTeamLoseWin:onShow(argtable,afterOnloaded)
self.data=argtable
local cur=#self.data.victory
local max=#self.data.monsters
local str=FMT.fmt('本次狩猎击杀妖怪：{0}/{1}',cur,max)
self.tips:setText(str)
local worldNameStr=cfgHelper.get2(cfg_worldconfig_get,self.data.world,"name")
self.worldName:setText(FMT.fmt("猎妖队-{0}",worldNameStr))

self.jumpData=strengthenController:getStrengthenJumpList(strengthenFunctionType.eFightLose,true)
local jumpCnt=#self.jumpData
self.strengthenCreator:setChildLayoutGroupCreateItems(jumpCnt)
local strengthenGrid=self.strengthenCreator:getChildLayoutGroupGridList()
for i=1,jumpCnt do
local item=strengthenGrid[i-1]
local cfg=self.jumpData[i]
item:SetChildIcon(0,FMT.fmt('icon_sjtp_{0}',cfg.icon),false)
item:SetChildText(1,cfg.name)
item:SetChildButtonClickWithID(2,self.onClickStrengthenItem,i,true)
end

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end
self:delayDo(0.4,func)
end
end


function UIWorldMonsterHurtTeamLoseWin:onHide()

end





function UIWorldMonsterHurtTeamLoseWin:onCloseTips()
huntMonsterTeamController:cancelTeamData(self.data)
self:closeSelf()
end

function UIWorldMonsterHurtTeamLoseWin.onClickStrengthenItem(index)
local data=_this.data
local cfg=_this.jumpData[index]
local jumpType=cfg.jumpType
local disciples={}
for i,v in ipairs(data.team)do
if mathHelper.validInt64(v)then
table.insert(disciples,UIDiscipleModel:getDiscipleDataX(v))
end
end
local params={disciples=disciples}
strengthenController:doJump(jumpType,params)
jumpManager:clearBackArgs()


huntMonsterTeamController:cancelTeamData(data)
end