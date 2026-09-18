







def_class("UITianMoJieMonsterAssistWin",UIWindowBase)









function UITianMoJieMonsterAssistWin:bindComponents()

self.background=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.empty=UIObject.get(self,2)
self.monsterBlood=UIProgress.get(self,3)
self.monsterIcon=UIObject.get(self,4)
self.monsterKuang=UIImage.get(self,5)
self.monsterLv=UIText.get(self,6)
self.monsterName=UIText.get(self,7)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UITianMoJieMonsterAssistWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.monsterBlood);self.monsterBlood=nil;
_UIObject_release(self.monsterIcon);self.monsterIcon=nil;
_UIObject_release(self.monsterKuang);self.monsterKuang=nil;
_UIObject_release(self.monsterLv);self.monsterLv=nil;
_UIObject_release(self.monsterName);self.monsterName=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
end















local _this=nil
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)
local _bossKuang={
[monType.LittleMonster]="frame_guaiwukuang_1",
[monType.EliteMonster]="frame_guaiwukuang_1",
[monType.Boss]="frame_guaiwukuang_2",
[monType.BigBoss]="frame_guaiwukuang_2",
[monType.GodAnimal]="frame_guaiwukuang_2",
}
local _colorKuang={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.BigBoss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_5",
}
local _itemCmp={
headBg=0,
head=1,
playerName=2,
serverName=3,
hurtTx=4,
progressBar=5,
}



function UITianMoJieMonsterAssistWin:onLoaded(...)
self:bindComponents()
_this=self

self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

self:addProNotify(34,125,self.on_34_125)
self:addProNotify(34,122,self.on_34_122)
self:addProNotify(34,127,self.on_34_127)
end


function UITianMoJieMonsterAssistWin:__delete()
self:unbindComponents()
_this=nil

tianMoJieModel:clearMonsterAssists(self.actorId,self.monsterGuid)
end




function UITianMoJieMonsterAssistWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self.monsterGuid=argtable.monsterGuid
self.actorId=argtable.actorId
self.monsterData=tianMoJieModel:getMonster(self.actorId,self.monsterGuid)
self:refreshMonsterInfo()
self:refreshMonsterBlood()
self:refreshAssistList()
end


function UITianMoJieMonsterAssistWin:onHide()

end




function UITianMoJieMonsterAssistWin:onCloseBtn()
if self.closeFunc then
self.closeFunc()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UITianMoJieMonsterAssistWin:refreshMonsterInfo()
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,self.monsterData.id)
local monsterGroup=cfgHelper.get1(cfg_monstergroup_get,monsterCfg.monster)
self.monsterName:setText(monsterGroup.name)
self.monsterKuang:setSprite(globalABLookup.global,_colorKuang[monsterGroup.monType])
self.monsterLv:setText(FMT.fmt("[{0}]",UIDiscipleModel:getJJName3(monsterGroup.level)))
comHelper.setChildModelRawImage_monsterGroup(self.winlua,monsterCfg.monster,self.monsterIcon:getID(),0,eHeadCenterType.eHead)
end

function UITianMoJieMonsterAssistWin:refreshMonsterBlood()
self.monsterBlood:setProgressValue(self.monsterData.percent,10000)
self.monsterBlood:setChildProgressText(FMT.fmt("{0}%",self.monsterData.percent/100))
end

function UITianMoJieMonsterAssistWin:refreshAssistList()
self.assistList=tianMoJieModel:getMonsterAssists(self.actorId,self.monsterGuid)
local assistCnt=#self.assistList
self.enhancedscrollscript:initData(assistCnt,105,assistCnt)
self.empty:setActive(assistCnt<=0)
end

function UITianMoJieMonsterAssistWin.on_34_122(actorid)
if mathHelper.compareInt64(actorid,_this.actorId)then
_this.monsterData=tianMoJieModel:getMonster(_this.actorId,_this.monsterGuid)
if _this.monsterData then
_this:refreshMonsterBlood()
tianMoJieController:send_34_125(_this.actorId,_this.monsterGuid)
end
end
end

function UITianMoJieMonsterAssistWin.on_34_125(actorid,tmguid)
if mathHelper.compareInt64(actorid,_this.actorId)and mathHelper.compareInt64(tmguid,_this.monsterGuid)then
_this:refreshAssistList()
end
end

function UITianMoJieMonsterAssistWin.on_34_127(tmguid)
if playerModel:checkActorId(_this.actorId)and mathHelper.compareInt64(tmguid,_this.monsterGuid)then
_this.monsterData=tianMoJieModel:getMonster(_this.actorId,_this.monsterGuid)
if _this.monsterData then
_this:refreshMonsterBlood()
tianMoJieController:send_34_125(_this.actorId,_this.monsterGuid)
end
end
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,self.window.monsterData.id)
local data=self.window.assistList[dataIndex]
playerController:setHeadIcon(cell,_itemCmp.head,{iconInfo=data.iconInfo})
cell:SetChildButtonClick(_itemCmp.headBg,function()
self:onClickActor(data.actorid)
end)
cell:SetChildText(_itemCmp.playerName,data.actorname)
cell:SetChildText(_itemCmp.serverName,loginModel:getServerName(data.serverid))
cell:SetChildProgressValue(_itemCmp.progressBar,data.percent,10000)
cell:SetChildProgressText(_itemCmp.progressBar,FMT.fmt("{0}%",data.percent/100))
local hurtValue=math.floor(monsterCfg.hp*(data.percent/10000))
cell:SetChildText(_itemCmp.hurtTx,FMT.fmt("伤害：{0}",mathHelper.formatNumber3(hurtValue)))
end