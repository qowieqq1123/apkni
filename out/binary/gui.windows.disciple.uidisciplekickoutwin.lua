







def_class("UIDiscipleKickoutWin",UIWindowBase)









function UIDiscipleKickoutWin:bindComponents()

self.titlle=UIText.get(self,0)
self.tipsText=UIText.get(self,1)
self.descText=UIText.get(self,2)
self.rewardRoot=UIObject.get(self,3)
self.okText=UIText.get(self,4)
self.goodGrid=UIObject.get(self,5)
self.cancelBtn=UIObject.get(self,6)



end


function UIDiscipleKickoutWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titlle);self.titlle=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.goodGrid);self.goodGrid=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
end



















local openType=
{
eZhuChu=1,
eZuoHua=2,
}


function UIDiscipleKickoutWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleKickoutWin:__delete()
self:unbindComponents()
end


function UIDiscipleKickoutWin:onHide()

end




function UIDiscipleKickoutWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid

self.openType=argtable.openType or 1
local title,desc_str,okStr=self:getCurOpenTypeStr()
self.descText:setText(desc_str)
self.titlle:setText(title)
self.okText:setText(okStr)
self.cancelBtn:setActive(argtable.useCancel or false)
self:refreshGoodReward()
end

function UIDiscipleKickoutWin:getGoodList()
local guid=self.disciple_guid
self.goodlist=UIDiscipleModel:getKickoutRewards({guid})
end

function UIDiscipleKickoutWin:refreshGoodReward()
self:getGoodList()
local num=#self.goodlist
local showrw=num>0
self.rewardRoot:setActive(showrw)
if showrw then
local title=self:getRewardTitle()
self.tipsText:setText(title)
self.goodGrid:setChildLayoutGroupCreateItems(num)
local grid=self.goodGrid:getChildLayoutGroupGridList()
local c=grid.Count
if c>4 then
self.goodGrid:setLocalPosX(500)
end
for i=1,c do
local data=self.goodlist[i]
local item=grid[i-1]
local show=data~=nil
item:SetChildActive(1,show)
if show then
local itemID=data[1]
local num=data[2]
local str=tostring(num)
local itemConfig=itemsConfig.getConfig(itemID)
local showCountBG=true
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(TIPS_MOVE_POS.eRight,...)end)
end
end
end
end

function UIDiscipleKickoutWin:onGoodItemClick(pos,itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=pos})
end
end

function UIDiscipleKickoutWin:getCurOpenTypeStr()
local title
local desc_str
local okStr
local dzname=UIDiscipleModel:getDiscipleName(self.disciple_guid)
if self.openType==openType.eZhuChu then
title='逐出宗门'
okStr='逐出'
desc_str=FMT.fmt(cfgHelper.getlang('disciple_kickout_desc_1'),dzname)
else
desc_str=FMT.fmt(cfgHelper.getlang('disciple_zuohua_desc_1'),dzname)
title='弟子坐化'
okStr='坐化'
end
local guid=self.disciple_guid
local bdData=zongmenModel:getDiscipleWorkroom(guid)
if bdData then
local plant_id=bdData.plant_id
if plant_id>0 then

local produce_plans=cfgHelper.get3(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level,'produce_plans')
if produce_plans then
local plantcfg=produce_plans[plant_id]
if plantcfg then
local plant_str=FMT.fmt(cfgHelper.getlang('disciple_kickout_desc_3'),plantcfg.display[1])
desc_str=FMT.fmt('{0}\n{1}',plant_str,desc_str)
end
end
elseif UIDanYaoModel:getLianDanFlag(bdData.un_build_id)then

local danyaoData=UIDanYaoModel:get_danYaodata(bdData.un_build_id)
local danfangname=cfgHelper.get2(cfg_danfangconfig_get,danyaoData.dfId,'name')
local danfang_str=FMT.fmt(cfgHelper.getlang('disciple_kickout_desc_4'),danfangname)
desc_str=FMT.fmt('{0}\n{1}',danfang_str,desc_str)
end
end
return title,desc_str,okStr
end

function UIDiscipleKickoutWin:getRewardTitle()
local str
if self.openType==openType.eZhuChu then
str=cfgHelper.getlang('disciple_kickout_desc_2')
else
str=cfgHelper.getlang('disciple_zuohua_desc_2')
end
return str
end

function UIDiscipleKickoutWin:onOKClick()
local guid=self.disciple_guid
if not UIDiscipleModel:checkCanKickOutDzAndTips(guid,true,self.openType)then
return
end
UIDiscipleController:reqKickout(guid,false)
self:closeSelf()
end

function UIDiscipleKickoutWin:onCancelClick()
self:closeSelf()
end