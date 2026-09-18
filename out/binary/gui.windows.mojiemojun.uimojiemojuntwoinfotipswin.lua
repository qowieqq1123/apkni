







def_class("UIMoJieMoJunTwoInfoTipsWin",UIWindowBase)









function UIMoJieMoJunTwoInfoTipsWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.desc=UIText.get(self,2)
self.fzBg=UIImage.get(self,3)
self.fzDesc=UIText.get(self,4)
self.fzIcon=UIImage.get(self,5)
self.root=UIObject.get(self,6)
self.skillGrid=UIObject.get(self,7)
self.spine=UIObject.get(self,8)
self.tabBtn_1=UIObject.get(self,9)
self.tabBtn_2=UIObject.get(self,10)
self.spine2=UIObject.get(self,11)
self.root2=UIObject.get(self,12)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.tabBtn={
self.tabBtn_1,
self.tabBtn_2,
}



end


function UIMoJieMoJunTwoInfoTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.fzBg);self.fzBg=nil;
_UIObject_release(self.fzDesc);self.fzDesc=nil;
_UIObject_release(self.fzIcon);self.fzIcon=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillGrid);self.skillGrid=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.tabBtn_1);self.tabBtn_1=nil;
_UIObject_release(self.tabBtn_2);self.tabBtn_2=nil;
_UIObject_release(self.spine2);self.spine2=nil;
_UIObject_release(self.root2);self.root2=nil;
self.tabBtn=nil;
end



















function UIMoJieMoJunTwoInfoTipsWin:onLoaded(...)
self:bindComponents()
end


function UIMoJieMoJunTwoInfoTipsWin:__delete()
self:unbindComponents()
end




function UIMoJieMoJunTwoInfoTipsWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id

self.selectTabIdx=1

self:initTab()
self:refreshPanel()

self.root:setChildCanvasGroupAlpha(0)
self.root2:setChildCanvasGroupAlpha(0)
self.spine:setChildUIModelShowTarget(6438,1,{},eAnimationID.enter,false,false,0)
self.spine2:setChildUIModelShowTarget(6437,1,{},eAnimationID.enter,false,false,0)
self:delayDo(0.6,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
self.root2:setChildCanvasGroupDOFade(1,0.2)
end)
end


function UIMoJieMoJunTwoInfoTipsWin:onHide()

end


function UIMoJieMoJunTwoInfoTipsWin:initTab()
for i=1,2 do
local item=self.tabBtn[i]:getChildWidgetBase()
item:SetChildActive(0,self.selectTabIdx==i)
item:SetChildButtonClick(2,function()
self:onClickTab(i)
end)
end
end


function UIMoJieMoJunTwoInfoTipsWin:refreshPanel()
local mojunData=xianjieModel:getMoJunData()
local build_id
local gwzid
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
if self.selectTabIdx==1 then
build_id=cfg.bodyInit
gwzid=cfg.gwzList[1]
self.desc:setText(FMT.fmt("魔君生命高于<color=#7D3B17>{0}%</color>，形态为初形",cfg.initHP/100))
else
build_id=cfg.bodyReal
gwzid=cfg.gwzList[2]
self.desc:setText(FMT.fmt("魔君生命低于<color=#7D3B17>{0}%</color>，形态为真身",cfg.initHP/100))
end

local mjCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
local fzData=mjCfg.param.fzlist[1]

local config=cfgHelper.get1(cfg_sslawruleconfig_get,fzData[1])
self.fzDesc:setText(config.desc)
self.fzIcon:setChildIcon(config.image,true)

local mcfg=cfgHelper.get1(cfg_monstergroup_get,gwzid)
local skillList=mcfg.showSkills or{}
self.skillGrid:setChildLayoutGroupCreateItems(#skillList,function(index)
local skillItem=self.skillGrid:getChildLayoutGroupGridItem(index-1)
local skillData=skillList[index]
local skillID=skillData[1]
local skillLv=skillData[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
skillItem:SetChildActive(-1,true)

skillItem:SetChildIcon(1,iconHelper.getSkillIcon(skillCfg.icon),false)
skillItem:SetChildText(2,skillCfg.name)
skillItem:SetChildText(3,skillCfg.desc)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
skillItem:SetChildActive(4,is_bd)
end)
end

function UIMoJieMoJunTwoInfoTipsWin:onClickTab(idx)
local oldIdx=self.selectTabIdx
self.selectTabIdx=idx
local olditem=self.tabBtn[oldIdx]:getChildWidgetBase()
if olditem then
olditem:SetChildActive(0,false)
end
local item=self.tabBtn[idx]:getChildWidgetBase()
item:SetChildActive(0,true)

self:refreshPanel()
end




function UIMoJieMoJunTwoInfoTipsWin:onBackground()
self:onCloseBtn()
end

function UIMoJieMoJunTwoInfoTipsWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

