







def_class("UIMonsterInfoWin",UIWindowBase)









function UIMonsterInfoWin:bindComponents()

self.click=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.challengeBtn=UIButton.get(self,2)
self.rwScrollView=UIObject.get(self,3)
self.desc=UIText.get(self,4)
self.skillpanel=UIObject.get(self,5)
self.leftBtn=UIButton.get(self,6)
self.rightBtn=UIButton.get(self,7)
self.name=UIText.get(self,8)
self.title=UIText.get(self,9)
self.closeBtn=UIButton.get(self,10)
self.level=UIText.get(self,11)
self.tips=UIText.get(self,12)
self.need=UIObject.get(self,13)
self.skills=UIObject.get(self,14)
self.moneyText=UIText.get(self,15)
self.moneyIcon=UIObject.get(self,16)
self.slIcon=UIObject.get(self,17)
self.head=UIObject.get(self,18)
self.title2=UIText.get(self,19)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIMonsterInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.skillpanel);self.skillpanel=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.need);self.need=nil;
_UIObject_release(self.skills);self.skills=nil;
_UIObject_release(self.moneyText);self.moneyText=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.slIcon);self.slIcon=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.title2);self.title2=nil;
end



















function UIMonsterInfoWin:onLoaded(...)
self:bindComponents()

self.root:setChildAnchoredPosition(Vector2.New(0,0))
self.root:setChildDOAnchorPosX(-470,0.35,nil)

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIMonsterInfoWin:__delete()
self:unbindComponents()

if self.args.close_callback then
self.args.close_callback()
end
end





















function UIMonsterInfoWin:onShow(argtable,afterOnloaded)
self.args=argtable
local groupId=argtable.groupId
self.title:setText(argtable.title)
if argtable.title2 then
self.title2:setText(argtable.title2)
end
self.name:setText(argtable.name)
self.level:setText(argtable.level)
comHelper.setChildModelRawImage_monsterGroup(self.winlua,groupId,self.head:getID(),0,eHeadCenterType.eHead)
local skills=argtable.skills
self.skillpanel:setActive(skills~=nil)
if skills then
self:setSkills(skills)
self.desc:setText('')
else
self.desc:setText(argtable.desc)
end
local rewards=argtable.rewards or{}
self:setRewards(rewards)

self.slIcon:setActive(argtable.show_boos_sign)

self.leftBtn:setActive(argtable.left_btn_callback~=nil)
self.rightBtn:setActive(argtable.right_btn_callback~=nil)

self.click:setActive(argtable.active_bg_click)

self.challengeBtn:setActive(argtable.callback~=nil)
local showNeed=argtable.need~=nil
self.need:setActive(showNeed)
if showNeed then
local needData=argtable.need
local cfg=itemsConfig.getConfig(needData[1])
self.moneyIcon:setChildIcon(iconHelper.getIconName(cfg.id),true)
self.moneyText:setText(needData[2])
end
if argtable.challenge_tips then
self.tips:setText(argtable.challenge_tips)
else
self.tips:setText('')
end

if webGLHelper:isNeedAdaption()then
self.closeBtn:setActive(false)
self.click:setActive(true)
end
end


function UIMonsterInfoWin:onHide()

end

function UIMonsterInfoWin:setRewards(rewards)
local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,4))
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
local cfg=itemsConfig.getConfig(data[1])
widgetHelper.setNormalRewardItem(item,0,{data[1],data[2],stage=cfg.stage})
end
end

function UIMonsterInfoWin:setSkills(skills)
self.skills:setChildLayoutGroupCreateItems(#skills)
local items=self.skills:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local sdata=skills[i+1]
local skillID=sdata[1]
local skillLv=sdata[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0
item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),true)
item:SetChildImageExGray(0,islock)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)
item:SetChildButtonClick(3,function()
UIManager:showWindow('UIDiscipleJobSkillTipsWin',{skillID=skillID,skillLv=skillLv,attend=1})
end)
item:SetChildActive(4,not islock)
if not islock then
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end
item:SetChildActive(5,islock)
end
end



function UIMonsterInfoWin:onLeftBtn()
self.args.left_btn_callback()
end

function UIMonsterInfoWin:onRightBtn()
self.args.right_btn_callback()
end

function UIMonsterInfoWin:onChallengeBtn()
self.args.callback()
end

function UIMonsterInfoWin:onCloseClick()
self:closeSelf()
end

function UIMonsterInfoWin:onCloseBtn()
self:onCloseClick()
end