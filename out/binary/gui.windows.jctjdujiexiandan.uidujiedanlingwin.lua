







def_class("UIDuJieDanLingWin",UIWindowBase)









function UIDuJieDanLingWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeButton=UIButton.get(self,1)
self.danlingRoot=UIObject.get(self,2)
self.zhuaBuButton=UIButton.get(self,3)
self.skill_1=UIObject.get(self,4)
self.skill_2=UIObject.get(self,5)
self.skill_3=UIObject.get(self,6)
self.materials=UIObject.get(self,7)
self.buffRoot=UIObject.get(self,8)
self.dxsyButton=UIButton.get(self,9)
self.desc=UIText.get(self,10)
self.danlingModel=UIObject.get(self,11)
self.jingjie=UIText.get(self,12)
self.materialsItem_3=UIBaseItem.get(self,13)
self.materialsItem_4=UIBaseItem.get(self,14)
self.materialsItem_1=UIBaseItem.get(self,15)
self.materialsItem_5=UIBaseItem.get(self,16)
self.materialsItem_2=UIBaseItem.get(self,17)
self.buffName=UIText.get(self,18)
self.buffDesc=UIText.get(self,19)
self.buffIcon=UIImage.get(self,20)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIDuJieDanLingWin")end)

self.zhuaBuButton:setButtonClick(function()self:onZhuaBuButton()end)

self.dxsyButton:setButtonClick(function()self:onDxsyButton()end)
self.skill={
self.skill_1,
self.skill_2,
self.skill_3,
}
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
self.materialsItem_3,
self.materialsItem_4,
self.materialsItem_5,
}



end


function UIDuJieDanLingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.danlingRoot);self.danlingRoot=nil;
_UIObject_release(self.zhuaBuButton);self.zhuaBuButton=nil;
_UIObject_release(self.skill_1);self.skill_1=nil;
_UIObject_release(self.skill_2);self.skill_2=nil;
_UIObject_release(self.skill_3);self.skill_3=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.buffRoot);self.buffRoot=nil;
_UIObject_release(self.dxsyButton);self.dxsyButton=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.danlingModel);self.danlingModel=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.materialsItem_3);self.materialsItem_3=nil;
_UIObject_release(self.materialsItem_4);self.materialsItem_4=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.materialsItem_5);self.materialsItem_5=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.buffName);self.buffName=nil;
_UIObject_release(self.buffDesc);self.buffDesc=nil;
_UIObject_release(self.buffIcon);self.buffIcon=nil;
self.skill=nil;
self.materialsItem=nil;
end



















function UIDuJieDanLingWin:onLoaded(...)
self:bindComponents()
end


function UIDuJieDanLingWin:__delete()
self:unbindComponents()
end




function UIDuJieDanLingWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIDuJieDanLingWin:onHide()

end

function UIDuJieDanLingWin:refresh()
local jd=jctjDuJieXianDanModel:getLianZhiJieDuan()
if jd>0 then
if jctjDuJieXianDanModel:getLianZhiKlFlag()==1 then
local isFight=jctjDuJieXianDanModel:getMonDieFlag()==0
local jdConfig=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jd)
local dlId=jdConfig.dlId
local danLingConfig=cfgHelper.get(cfg_djxddanlingconfig_get,dlId)
local day=jctjDuJieXianDanModel:getOpenDanLuDay()
local mon=danLingConfig.gwz[day]
if not mon then
mon=danLingConfig.gwz[#danLingConfig.gwz]
end

self.dlId=dlId
self.mon=mon[1]
self.danlingModel:setChildUIModelShowTarget(danLingConfig.image2[1],danLingConfig.image2[3],danLingConfig.image2[2],0,false,false,0)
self.desc:setText(danLingConfig.desc)
local skillCfg=danLingConfig.skill or{}

for i,item in ipairs(self.skill)do
if skillCfg[i]then
local cfg=cfgHelper.get1(cfg_skillconfig_get,skillCfg[i])
local icon=iconHelper.getSkillIcon(cfg.icon)
local widget=item:getWidgetBase()
widget:SetChildIcon(0,icon,true)
widget:SetChildButtonClick(0,function()
UIManager:showWindow('UIDiscipleJobSkillTipsWin',{skillID=skillCfg[i],skillLv=1,attend=1})
end)
else
item:setActive(false)
end
end

local dropId=mon[2]
local level=zongmenModel:getLevel()
local rewardList=itemsAwardConfig:getAwardInConfigByLevel(dropId,level)
for i,item in ipairs(self.materialsItem)do
local reward=rewardList.showItems[i]
if reward then
local matItemId=reward[1]
local needCount=reward[2]
local showStage=not moneyConfig.isMoney(matItemId)

local conf={itemid=matItemId,itemcount=needCount,showCountBG=true,showStage=showStage,range=reward.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:setActive(true)
item:setChildPropData(prop)
local _onClickMaterialItem=function(...)
self:onClickMaterialItem(...)
end
item:setBaseItemChildID(matItemId)
item:setBaseItemClickEvent(_onClickMaterialItem)
else
item:setActive(false)
end
end

local num=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local needNum=jdConfig.xqcy[1]
if num>=needNum and jdConfig.xqcy[4]and next(jdConfig.xqcy[4])then
self.buffRoot:setActive(true)
local ruleCfg=cfgHelper.getSSlawRule(jdConfig.xqcy[4][1])
local image=ruleCfg.image
local name=ruleCfg.name
local desc=ruleCfg.desc
local descparm=ruleCfg.descparm
if descparm and descparm[level]and next(descparm[level])then
desc=string.format(desc,unpack(descparm[level]))
end
self.buffName:setText(name)
self.buffDesc:setText(desc)
self.buffIcon:setImageIcon(image,false)
else
self.buffRoot:setActive(false)
end

end


end

end
function UIDuJieDanLingWin:onClickMaterialItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end





function UIDuJieDanLingWin:onZhuaBuButton()
if self.dlId then
local mCfg=cfgHelper.get1(cfg_monstergroup_get,self.mon)
fightController.showPrepareWin(eFightPreSelectType.dujiexiandan,
{
enterTxt='渡劫仙丹',
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
monsterList=mCfg.monList,
groupId=self.mon,
enterCallBack=function(guidList,zfId)


fightLaunchController:sendFight(eBattleLaunch.dujiexiandan,guidList,mCfg.mapId or 0,zfId,{})
end
}
)
else
UIManager.error("丹灵已抓捕")
end
end

function UIDuJieDanLingWin:onDxsyButton()
local offset=Vector2.New(60,30)
local desc_str="击败丹灵后将会令仙丹溢出丹香，\n部分宗门弟子获得大量境界经验"
UIManager:showWindow('UIConditionTipsOne',{showType=2,str=desc_str,posItem=self.dxsyButton,pos=offset})
end
