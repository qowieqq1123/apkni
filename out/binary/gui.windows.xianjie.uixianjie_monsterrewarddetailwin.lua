







def_class("UIXianJie_monsterRewardDetailWin",UIWindowBase)









function UIXianJie_monsterRewardDetailWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.childChildMenu_1=UIButton.get(self,1)
self.childChildMenu_2=UIButton.get(self,2)
self.childChildMenu2Panel=UIObject.get(self,3)
self.childChildMenuPanel=UIObject.get(self,4)
self.childMenuModel=UIObject.get(self,5)
self.childMenuPanel=UIObject.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.condition=UIObject.get(self,8)
self.conditionTxt=UIText.get(self,9)
self.goBtn=UIButton.get(self,10)
self.goBtn2=UIButton.get(self,11)
self.goBtn2Img=UIImage.get(self,12)
self.menu_1=UIBaseItem.get(self,13)
self.menu_2=UIBaseItem.get(self,14)
self.menu_3=UIBaseItem.get(self,15)
self.menuList=UIObject.get(self,16)
self.root=UIObject.get(self,17)
self.srScrollView=UIObject.get(self,18)
self.stageList=UIObject.get(self,19)
self.tips1=UIText.get(self,20)
self.tips2=UIText.get(self,21)
self.tipsRoot1=UIObject.get(self,22)
self.tipsRoot2=UIObject.get(self,23)
self.tishiRoot=UIObject.get(self,24)
self.tishiTxt=UIText.get(self,25)
self.titleImg=UIImage.get(self,26)
self.topClickMask=UIObject.get(self,27)
self.typeIcon=UIImage.get(self,28)
self.uiRoot=UIObject.get(self,29)

self.childChildMenu_1:setButtonClick(function()self:onChildChildMenu_1()end)

self.childChildMenu_2:setButtonClick(function()self:onChildChildMenu_2()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.goBtn:setButtonClick(function()self:onGoBtn()end)

self.goBtn2:setButtonClick(function()self:onGoBtn2()end)
self.childChildMenu={
self.childChildMenu_1,
self.childChildMenu_2,
}
self.menu={
self.menu_1,
self.menu_2,
self.menu_3,
}



end


function UIXianJie_monsterRewardDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.childChildMenu_1);self.childChildMenu_1=nil;
_UIObject_release(self.childChildMenu_2);self.childChildMenu_2=nil;
_UIObject_release(self.childChildMenu2Panel);self.childChildMenu2Panel=nil;
_UIObject_release(self.childChildMenuPanel);self.childChildMenuPanel=nil;
_UIObject_release(self.childMenuModel);self.childMenuModel=nil;
_UIObject_release(self.childMenuPanel);self.childMenuPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.condition);self.condition=nil;
_UIObject_release(self.conditionTxt);self.conditionTxt=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.goBtn2);self.goBtn2=nil;
_UIObject_release(self.goBtn2Img);self.goBtn2Img=nil;
_UIObject_release(self.menu_1);self.menu_1=nil;
_UIObject_release(self.menu_2);self.menu_2=nil;
_UIObject_release(self.menu_3);self.menu_3=nil;
_UIObject_release(self.menuList);self.menuList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.srScrollView);self.srScrollView=nil;
_UIObject_release(self.stageList);self.stageList=nil;
_UIObject_release(self.tips1);self.tips1=nil;
_UIObject_release(self.tips2);self.tips2=nil;
_UIObject_release(self.tipsRoot1);self.tipsRoot1=nil;
_UIObject_release(self.tipsRoot2);self.tipsRoot2=nil;
_UIObject_release(self.tishiRoot);self.tishiRoot=nil;
_UIObject_release(self.tishiTxt);self.tishiTxt=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
_UIObject_release(self.topClickMask);self.topClickMask=nil;
_UIObject_release(self.typeIcon);self.typeIcon=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.childChildMenu=nil;
self.menu=nil;
end
















local _this

local _ab="ui/windows/xianjie/monsterrewarddetail_atlas_pak.ab"
local _descFMT="解锁条件：仙域累计击败{0}只{1}阶{2}<color=#7d3b17>{3}</color>"

local _menuType=
{
common=1,
boss=2,
xianxu=3,
Mjcommon=4,
}

local _menuChildType={
eOne=1,
eTwo=2,
}

local _menuChildChildType={
eOne=1,
eTwo=2,
eThree=3,
}

local _entityTypeToMenuType={
[xjServerEnityType.eMonster]=_menuType.common,
[xjServerEnityType.eBossMonster]=_menuType.boss,
[xjServerEnityType.eMonsterHouse]=_menuType.xianxu,
[xjServerEnityType.eMoJieMoster]=_menuType.Mjcommon,
}

local _menuCofig={
[_menuType.common]={
name='普通',
entityType=xjServerEnityType.eMonster,
child={
[_menuChildType.eOne]={
name='普通',
descname='普通魔物',
titleImg='image_mwjlxq_putongmowu',
bgImg={'image_mwjlxq_chatu1',-266,-110,1},
jumpSelectIndex=1,
child={
[_menuChildChildType.eOne]={
name='仙',
},
[_menuChildChildType.eTwo]={
name='魔',
},
},
childSkin=1,
},
},
},
[_menuType.boss]={
name='首领',
entityType=xjServerEnityType.eBossMonster,
child={
[_menuChildType.eOne]={
name='普通',
descname='首领魔物',
titleImg='image_mwjlxq_shoulingmowu',
bgImg={'image_mwjlxq_chatu2',-257,-98,1},
jumpSelectIndex=3,
child={
[_menuChildChildType.eOne]={
name='仙',
},
[_menuChildChildType.eTwo]={
name='魔',
},
},
childSkin=1,
},
},
getTips1=function(cType,ccType)
return"需进行军阵战斗"
end,
},
[_menuType.xianxu]={
name='仙墟',
entityType=xjServerEnityType.eMonsterHouse,
child={
[_menuChildType.eOne]={
name='普通仙墟',
descname='仙墟魔物',
titleImg='image_mwjlxq_xianxu',
bgImg={'image_mwjlxq_chatu3',-260,-40,0.93},
jumpSelectIndex=4,
child={
[_menuChildChildType.eOne]={
name='仙',
},
[_menuChildChildType.eTwo]={
name='魔',
},
},
childSkin=1,
},
[_menuChildType.eTwo]={
name='界游仙墟',
descname='仙墟魔物',
jumpSelectIndex=5,
child={
[_menuChildChildType.eOne]={
name='绘天阙',
titleImg='image_mowuxqing_03',
bgImg={'image_mwjlxq_huixianque',-255,-10,1},
btnImg='button_mowuxqing_12',
},
[_menuChildChildType.eTwo]={
name='囚仙林',
titleImg='image_mowuxqing_02',
bgImg={'image_mwjlxq_qiuxianling',-255,-10,1},
btnImg='button_mowuxqing_11',
},
[_menuChildChildType.eThree]={
name='混沌源海',
titleImg='image_mowuxqing_04',
bgImg={'image_mwjlxq_hundunyh',-255,-10,1},
btnImg='button_mowuxqing_13',
},
},
childSkin=2,
cond=function()
return xianguanHelper.checkTeQuanPlatformLimit(XIANGUAN_PRIVILEGE_ENUM.eXunYouWanJie)
end,
},
},
getTips1=function(cType,ccType)
return"需仙盟集结，进行军阵战斗"
end,
getTips2=function(cType,ccType)
local entityType=xjServerEnityType.eMonsterHouse
local maxTimes,curTimes,rewardTimeConf
if cType==_menuChildType.eOne then
rewardTimeConf=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"info",1,entityType)
maxTimes=rewardTimeConf[1]
curTimes=xianjieModel:getMonsterRewardTimes(entityType)
elseif cType==_menuChildType.eTwo then
local flag=2
local entityType2=bit.lshift(flag,8)+entityType
rewardTimeConf=xianjieModel:getMonsterInfoCfg(entityType2)
maxTimes=rewardTimeConf[1]
curTimes=xianjieModel:getMonsterRewardTimes(entityType,flag)
end
local remainingNum=0
if curTimes then
remainingNum=maxTimes-curTimes
end
local numStr=tostring(remainingNum)
if remainingNum<=0 then
numStr=FMT.cfmt(FONT_COLOR.eRedColor,numStr)
end
return FMT.fmt("剩余征讨奖励次数：{0}",numStr)
end,
getTips2Ex=function(cType,ccType)
local entityType=xjServerEnityType.eMonsterHouse
if cType==_menuChildType.eOne then
local rewardTimeConf=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"info",1,entityType)
local d1=toColorString(FONT_COLOR.eOrangeColor,FMT.fmt("{0}次",rewardTimeConf[1]))
local d2=toColorString(FONT_COLOR.eOrangeColor,FMT.fmt("{0}次",rewardTimeConf[1]+rewardTimeConf[2]))
local d3=toColorString(FONT_COLOR.eOrangeColor,"次日0点")
return FMT.fmt("每日征讨奖励次数：{0}\n最多累计次数{1}\n{2}恢复次数\n",d1,d2,d3)
elseif cType==_menuChildType.eTwo then
local flag=2
local entityType2=bit.lshift(flag,8)+entityType
local rewardTimeConf=xianjieModel:getMonsterInfoCfg(entityType2)
local maxTimes=rewardTimeConf[1]
local d1=toColorString(FONT_COLOR.eOrangeColor,FMT.fmt("{0}次",maxTimes))
local d2=toColorString(FONT_COLOR.eOrangeColor,"每周一五点")
return FMT.fmt("每周征讨奖励次数：{0}\n{1}恢复次数\n",d1,d2)
end
end,
},
[_menuType.Mjcommon]={
name='普通',
entityType=xjServerEnityType.eMoJieMoster,
child={
[_menuChildType.eOne]={
name='普通',
descname='魔界魔物',
titleImg='image_mwjlxq_putongmowu',
bgImg={'image_mwjlxq_chatu1',-266,-110,1},
jumpSelectIndex=1,
child={
[_menuChildChildType.eOne]={
name='仙',
},
[_menuChildChildType.eTwo]={
name='魔',
},
},
childSkin=1,
},
},
},
}




function UIXianJie_monsterRewardDetailWin:onLoaded(...)
_this=self
self.selectMenuType=_menuType.common
self.selectMenuType_c=_menuChildType.eOne
self.selectMenuType_cc=_menuChildChildType.eOne

self.allCfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"monsterRewardDetail")

self:bindComponents()
end


function UIXianJie_monsterRewardDetailWin:__delete()
self:unbindComponents()

_this=nil
end




function UIXianJie_monsterRewardDetailWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(6116,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(0.4,function()
self.root:setChildCanvasGroupAlpha(1)
end)
end)


local menuType,menuType_c
if argtable~=nil then
if argtable.type~=nil then
menuType=_entityTypeToMenuType[argtable.type]
end
menuType_c=argtable.menuType_c
if argtable.menuType_c~=nil then
self.selectMenuType_c=argtable.menuType_c
end

if argtable.cfg~=nil then
local cfg=argtable.cfg
if cfg.flag==2 then
self.selectMenuType_c=_menuChildType.eTwo
self.selectMenuType_cc=cfg.xianguan_xianxu
else
self.selectMenuType_c=_menuChildType.eOne
self.selectMenuType_cc=cfg.xmFlag
end

elseif argtable.menuType_cc~=nil then
self.selectMenuType_cc=argtable.menuType_cc
end
end
if menuType~=nil then
self.selectMenuType=menuType
end
local data=_menuCofig[self.selectMenuType]
local d=data.child[self.selectMenuType_c]
if d.cond~=nil and d.cond()==false then
self.selectMenuType_c=nil
for childType,v in ipairs(data.child)do
if v.cond==nil or v.cond()==true then
self.selectMenuType_c=childType
break
end
end
end
if self.selectMenuType_c~=nil then
self:refreshAll()
else


end
end


function UIXianJie_monsterRewardDetailWin:onHide()

end

function UIXianJie_monsterRewardDetailWin:refreshAll()
self:refreshMenu()
self:refreshRightMenu()
self:refreshScrollview()
self:refreshOther()
end

function UIXianJie_monsterRewardDetailWin:refreshMenu()
for index,menu in ipairs(self.menu)do
local wb=menu:getWidgetBase()
local isSelect=self.selectMenuType==index
wb:SetChildActive(0,not isSelect)
wb:SetChildActive(1,isSelect)
wb:SetBaseItemClickEvent(-1,function()
self:onMenuClick(index)
end)
end
end

function UIXianJie_monsterRewardDetailWin:refreshRightMenu()
local childMenuList={}
local childs=_menuCofig[self.selectMenuType].child
for childType,v in ipairs(childs)do
if v.cond==nil or v.cond()==true then
v.childType=childType
local idx=#childMenuList+1
childMenuList[idx]=v
end
end
self.childMenuList=childMenuList
local n=#self.childMenuList
if self.selectMenuType_c_idx~=nil then
if self.selectMenuType_c_idx>n then
self.selectMenuType_c_idx=nil
end
else
for i,v in ipairs(self.childMenuList)do
if self.selectMenuType_c==v.childType then
self.selectMenuType_c_idx=i
end
end
end
if self.selectMenuType_c_idx==nil then
self.selectMenuType_c_idx=1
self.selectMenuType_c=self.childMenuList[self.selectMenuType_c_idx].childType
end
local showChildMenu=n>1
self.childMenuModel:setActive(showChildMenu)
self.childMenuPanel:setActive(showChildMenu)
if showChildMenu==true then
if self.childMenuModelID==nil then
self.childMenuPanel:setChildCanvasGroupAlpha(0)
self.childMenuModelID=6117
self.childMenuModel:setChildUIModelShowTarget(self.childMenuModelID,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(0.4,function()
self.childMenuPanel:setChildCanvasGroupAlpha(1)
end)
end)
else
self.childMenuPanel:setChildCanvasGroupAlpha(1)
end
self.childMenuPanel:setChildLayoutGroupCreateItems(n,function(index)
local item=self.childMenuPanel:getChildLayoutGroupGridItem(index-1)
local info=self.childMenuList[index]
local isSelect=self.selectMenuType_c==index
item:SetChildActive(0,isSelect)
item:SetChildText(1,info.name)
item:SetChildButtonClick(-1,function()
self:onChildMenuClick(index)
end)
end)
else
if self.childMenuModelID~=nil then
self.childMenuModelID=nil
self.childMenuModel:setChildUIModelRemoveTarget()
end
end
self:refreshRightMenu2()
end

function UIXianJie_monsterRewardDetailWin:refreshRightMenu2()
local data=_menuCofig[self.selectMenuType].child[self.selectMenuType_c]
local childSkin=data.childSkin
self.childChildMenuPanel:setActive(childSkin==1)
self.childChildMenu2Panel:setActive(childSkin==2)
local list=data.child
local n=#list
if self.selectMenuType_cc>n then
self.selectMenuType_cc=1
end
if childSkin==1 then
for index,item in ipairs(self.childChildMenu)do
local info=list[index]
local widget=item:getWidgetBase()
local isSelect=self.selectMenuType_cc==index
widget:SetChildActive(0,isSelect)
widget:SetChildText(1,info.name)
end
elseif childSkin==2 then
self.childChildMenu2Panel:setChildLayoutGroupCreateItems(n,function(index)
local item=self.childChildMenu2Panel:getChildLayoutGroupGridItem(index-1)
local info=list[index]
local isSelect=self.selectMenuType_cc==index
item:SetChildActive(0,isSelect)
item:SetChildText(1,info.name)
item:SetChildButtonClick(-1,function()
self:onChildChildMenuClick(index)
end)
end)
end
end

function UIXianJie_monsterRewardDetailWin:onChildChildMenu_1()
self:onChildChildMenuClick(_menuChildChildType.eOne)
end

function UIXianJie_monsterRewardDetailWin:onChildChildMenu_2()
self:onChildChildMenuClick(_menuChildChildType.eTwo)
end

function UIXianJie_monsterRewardDetailWin:onChildChildMenuClick(index)
if index~=self.selectMenuType_cc then
local data=_menuCofig[self.selectMenuType].child[self.selectMenuType_c]
local childSkin=data.childSkin
local widget_o,widget
if childSkin==1 then
local pItem=self.childChildMenu[self.selectMenuType_cc]
widget_o=pItem:getWidgetBase()
pItem=self.childChildMenu[index]
widget=pItem:getWidgetBase()
elseif childSkin==2 then
widget_o=self.childChildMenu2Panel:getChildLayoutGroupGridItem(self.selectMenuType_cc-1)
widget=self.childChildMenu2Panel:getChildLayoutGroupGridItem(index-1)
end
widget_o:SetChildActive(0,false)
self.selectMenuType_cc=index
widget:SetChildActive(0,true)
self.isFadeShow=true
self:refreshScrollview()
self:refreshOther()
end
end

function UIXianJie_monsterRewardDetailWin:onChildMenuClick(index)
if index~=self.selectMenuType_c_idx then
local item_o=self.childMenuPanel:getChildLayoutGroupGridItem(self.selectMenuType_c_idx-1)
item_o:SetChildActive(0,false)
self.selectMenuType_c_idx=index
local info=self.childMenuList[index]
self.selectMenuType_c=info.childType
local item=self.childMenuPanel:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(0,true)

self:refreshRightMenu2()
self:refreshScrollview()
self:refreshOther()
self.stageList:setChildAnchoredPos(0,0)
end
end

function UIXianJie_monsterRewardDetailWin:onMenuClick(index)
if self.selectMenuType~=index then
local item=self.menu[self.selectMenuType]
local widget=item:getWidgetBase()
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
item=self.menu[index]
widget=item:getWidgetBase()
widget:SetChildActive(0,false)
widget:SetChildActive(1,true)
self.selectMenuType=index

self:refreshRightMenu()
self:refreshScrollview()
self:refreshOther()
self.stageList:setChildAnchoredPos(0,0)
end
end

function UIXianJie_monsterRewardDetailWin:refreshScrollview()
local stageCfg=self.allCfg[self.selectMenuType][self.selectMenuType_c][self.selectMenuType_cc]or{}
local len=#stageCfg

local entityType=_menuCofig[self.selectMenuType].entityType
local maxJieDuan=xianjieController:getJieShuMax(entityType)
local jieduan=cfgHelper.get(cfg_fairylandrefreshstageconfig_get,entityType,maxJieDuan,'jieduan')

if jieduan then
len=Mathf.Min(jieduan,len)
end

local createFunc=function(index)
local item=self.stageList:getChildLayoutGroupGridItem(index-1)
local dropId=stageCfg[index]

local isShow=dropId~=nil
item:SetChildActive(-1,isShow)

if isShow then
local name=FMT.fmt("{0}阶",index)
item:SetChildText(0,name)

local rewards=zongmenControl:getRewardConfigData(dropId,zongmenModel:getLevel())
local rewardLen=#rewards





item:SetChildLayoutGroupCreateItems(1,rewardLen,function(rindex)
local ritem=item:GetChildLayoutGroupGridItem(1,rindex-1)
local rewardData=rewards[rindex]

local isShowReward=rewardData~=nil
ritem:SetChildActive(-1,isShowReward)
if isShowReward then
local itemid=rewardData[1]
local itemcount=rewardData[2]
local percent=rewardData[4]

local isPercent=percent~=nil
local isShowCount,countStr,range

if isPercent then
isShowCount=false
countStr=""
else
isShowCount=itemcount>1
countStr=isShowCount and itemcount or""
range=rewardData.range
end

local conf={
itemid=itemid,
itemcount=countStr,
showCountBG=isShowCount or range~=nil,
showStage=true,
showname=false,
range=range
}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
ritem:SetChildPropData(0,propData)

ritem:SetChildActive(1,itemcount==-1 and range==nil and percent==nil)
ritem:SetChildActive(2,isPercent)
if isPercent then
ritem:SetChildText(3,FMT.fmt("{0}%",percent))
end

ritem:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemid)
end)
end
end)
item:SetChildScrollRectEnable(3,rewardLen>5)
item:SetChildAnchoredPos(1,0,0)

if self.isFadeShow then
item:SetChildCanvasGroupAlpha(3,0)
item:SetChildCanvasGroupDOFade(3,1,0.2)
end

local isUnlock=self:checkUnLock(index)
item:SetChildActive(2,not isUnlock)
end
end

self.stageList:setChildLayoutGroupCreateItems(len,createFunc)

self.isFadeShow=false
self:refreshCondition()
end

function UIXianJie_monsterRewardDetailWin:refreshCondition()
local stageCfg=self.allCfg[self.selectMenuType][self.selectMenuType_c][self.selectMenuType_cc]or{}
local len=#stageCfg
local entityType=_menuCofig[self.selectMenuType].entityType
local totalStage=cfgHelper.get1(cfg_fairylandrefreshstageconfig_get,entityType)
local curUnlockStage=xianjieController:getjieshuData(entityType)
local nextStage=Mathf.Min(#totalStage,curUnlockStage+1)
local lockCfg=totalStage[nextStage]

if lockCfg then
local isUnlockAll=lockCfg.sid>=len

if isUnlockAll then
self.conditionTxt:setText("已解锁全部阶数魔物")
else
if lockCfg then
local desc=self:getUnlockDesc(lockCfg)
self.conditionTxt:setText(desc)
end
end
end
end

function UIXianJie_monsterRewardDetailWin:refreshOther()
local data=_menuCofig[self.selectMenuType]
local isShowTips1=data.getTips1~=nil
self.tipsRoot1:setActive(isShowTips1)
if isShowTips1 then
self.tips1:setText(data.getTips1(self.selectMenuType_c,self.selectMenuType_cc))
end

local isShowTips2=data.getTips2~=nil
self.tipsRoot2:setActive(isShowTips2)
if isShowTips2 then
self.tips2:setText(data.getTips2(self.selectMenuType_c,self.selectMenuType_cc))
end

self.tishiRoot:setActive(false)
local d=data.child[self.selectMenuType_c]
if d.bgImg==nil then
d=d.child[self.selectMenuType_cc]
end
local bgImg=d.bgImg
self.typeIcon:setCSImageSprite(_ab,bgImg[1])
self.typeIcon:setChildAnchoredPos(bgImg[2],bgImg[3])
local scale=bgImg[4]
self.typeIcon:setScale(Vector3(scale,scale,1))

local showGoto1=d.btnImg==nil
self.goBtn:setActive(showGoto1)
self.goBtn2:setActive(not showGoto1)
if not showGoto1 then
self.goBtn2Img:setCSImageSprite(_ab,d.btnImg)
end

self.titleImg:setCSImageSprite(_ab,d.titleImg)
end

function UIXianJie_monsterRewardDetailWin:onClickTishi()
local data=_menuCofig[self.selectMenuType]
local isShowTipsEx=data.getTips2Ex~=nil
self.tishiRoot:setActive(isShowTipsEx)
self.topClickMask:setActive(isShowTipsEx)
if isShowTipsEx then
self.tishiTxt:setText(data.getTips2Ex(self.selectMenuType_c,self.selectMenuType_cc))
end
self.exRoot=self.tishiRoot
end


function UIXianJie_monsterRewardDetailWin:checkUnLock(sid)
local entityType=_menuCofig[self.selectMenuType].entityType
local curUnlockStage=xianjieController:getjieshuData(entityType)

local maxLevel=cfgHelper.get3(cfg_fairylandrefreshstageconfig_get,entityType,curUnlockStage,'maxlevel')

if sid>maxLevel then
return false
end

return true
end

function UIXianJie_monsterRewardDetailWin:getUnlockDesc(cfg)
local type=cfg.etype
local stage,needKillNum=next(cfg.condition)
local killNum=xianjieController:getJiShaDatajsnum(type,stage)
killNum=Mathf.Min(killNum,needKillNum)

local isOk=killNum>=needKillNum
local color=isOk and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor

local d=_menuCofig[self.selectMenuType].child[self.selectMenuType_c]
local pDesc=toColorString(color,FMT.fmt("({0}/{1})",killNum,needKillNum))
return FMT.fmt(_descFMT,needKillNum,stage,d.descname,pDesc)
end




function UIXianJie_monsterRewardDetailWin:onCloseBtn()
self:closeSelf()
end

function UIXianJie_monsterRewardDetailWin:onGoBtn()
local d=_menuCofig[self.selectMenuType].child[self.selectMenuType_c]
local id=d.jumpSelectIndex
self:onCloseBtn()
xianjieController:openWin('UIXianJieExplorationWin',{page=1,extra={selectid=id}})
end

function UIXianJie_monsterRewardDetailWin:onGoBtn2()
self:onGoBtn()
end

function UIXianJie_monsterRewardDetailWin:hideTopClickMask()
self.topClickMask:setActive(false)
if self.exRoot~=nil then
self.exRoot:setActive(false)

self.exRoot=nil
end
end