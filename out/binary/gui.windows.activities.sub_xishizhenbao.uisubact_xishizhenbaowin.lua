







def_class("UISubAct_XiShiZhenBaoWin",UIWindowBase)









function UISubAct_XiShiZhenBaoWin:bindComponents()

self.cdn=UIText.get(self,0)
self.cdnFlag=UIObject.get(self,1)
self.closeTag=UIObject.get(self,2)
self.content=UIObject.get(self,3)
self.gainBtn=UIButton.get(self,4)
self.gainText=UIText.get(self,5)
self.gbname=UIImage.get(self,6)
self.jumpBtn=UIButton.get(self,7)
self.modelItem=UIObject.get(self,8)
self.openTag=UIObject.get(self,9)
self.prizeBtn=UIButton.get(self,10)
self.prizeReddot=UIObject.get(self,11)
self.qipaoBg=UIObject.get(self,12)
self.qipaoText=UIText.get(self,13)
self.rewardContent=UIObject.get(self,14)
self.root=UIObject.get(self,15)
self.timeText=UIText.get(self,16)
self.tipsCreater=UIObject.get(self,17)
self.tipsDesc=UIText.get(self,18)
self.tipsTitle=UIText.get(self,19)
self.tipsTitle1=UIObject.get(self,20)
self.tipsTitle2=UIObject.get(self,21)
self.title=UIImage.get(self,22)
self.toggleBtn=UIButton.get(self,23)

self.gainBtn:setButtonClick(function()self:onGainBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.prizeBtn:setButtonClick(function()self:onPrizeBtn()end)

self.toggleBtn:setButtonClick(function()self:onToggleBtn()end)



end


function UISubAct_XiShiZhenBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cdn);self.cdn=nil;
_UIObject_release(self.cdnFlag);self.cdnFlag=nil;
_UIObject_release(self.closeTag);self.closeTag=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.gainBtn);self.gainBtn=nil;
_UIObject_release(self.gainText);self.gainText=nil;
_UIObject_release(self.gbname);self.gbname=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.modelItem);self.modelItem=nil;
_UIObject_release(self.openTag);self.openTag=nil;
_UIObject_release(self.prizeBtn);self.prizeBtn=nil;
_UIObject_release(self.prizeReddot);self.prizeReddot=nil;
_UIObject_release(self.qipaoBg);self.qipaoBg=nil;
_UIObject_release(self.qipaoText);self.qipaoText=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.tipsCreater);self.tipsCreater=nil;
_UIObject_release(self.tipsDesc);self.tipsDesc=nil;
_UIObject_release(self.tipsTitle);self.tipsTitle=nil;
_UIObject_release(self.tipsTitle1);self.tipsTitle1=nil;
_UIObject_release(self.tipsTitle2);self.tipsTitle2=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.toggleBtn);self.toggleBtn=nil;
end


















local _this
local abName="ui/windows/activities/sub_xishizhenbao/xishizhenbao_sprite_atlas_pak.ab"
function UISubAct_XiShiZhenBaoWin:onLoaded(...)
self:bindComponents()
_this=self
self.isToggle=true
self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
end

function UISubAct_XiShiZhenBaoWin:__delete()
self:unbindComponents()
self.actModel=nil
_this=nil
end

function UISubAct_XiShiZhenBaoWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.actModel=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.actModel then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.actModel.start_time
self.endTime=self.actModel.end_time
self.actModel:refreshBuyReddot()

self:refresh()
end

function UISubAct_XiShiZhenBaoWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
_this:freshBuyInfo()
end

function UISubAct_XiShiZhenBaoWin:refresh()
self:freshBuyInfo()

self:freshModelInfo()

self:freshLeftTimer()

self:freshToggle()

self:freshReddot()

self:freshRewardPanel()
end

function UISubAct_XiShiZhenBaoWin:freshBuyInfo()
local isCanBuy,result=self.actModel:checkCanBuy()
local isShowBuyBtn=isCanBuy or(result==3)
self.gainBtn:setActive(isShowBuyBtn)
if isShowBuyBtn then
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,self.config.recharge_id)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.gainText:setText(str)
end
local isShowCdn=isCanBuy or(result==1 or result==3)
self.cdn:setActive(isShowCdn)
if result==1 then
local itemid=self.config.check_type[2]
local desc=string.format("您已经拥有<color=#C82C2C>%s</color>，不可再购买",itemsConfig.getItemName(itemid))
self.cdn:setText(desc)
elseif isCanBuy or result==3 then
local neednum
local task_conf=self.config.task_conf
if task_conf and task_conf[1]then
neednum=task_conf[1][2]
end
if neednum and neednum>0 then
local curNum=self.actModel.data.task_num
local desc=string.format(self.config.condition_desc,neednum)
desc=string.format("%s(<color=%s>%d/%d</color>)",desc,curNum>=neednum and"#549327"or"#C82C2C",curNum,neednum)
self.cdn:setText(string.format(desc,neednum))
else
self.cdn:setText("")
end
end
self.qipaoBg:setActive(isCanBuy)
if isCanBuy then
self.qipaoText:setText(self.config.dialog)
self.qipaoBg:setChildDOScale(1,0.3)
end

end

function UISubAct_XiShiZhenBaoWin:freshModelInfo()
local nameIcon=self.config.nameIcon
self.gbname:setSprite(abName,nameIcon)
local adIcon=self.config.adIcon
self.title:setSprite(abName,adIcon)
if self.config.jumpCfg then
local jumpIcon=self.config.jumpCfg[1]
self.winlua:SetChildCSImageSprite(self.jumpBtn:getID(),abName,jumpIcon)
end
self:fillModel()
self:freshTips()
end

function UISubAct_XiShiZhenBaoWin:fillModel()
local widget=self.modelItem:getChildWidgetBase()
local type=self.config.check_type[1]
local itemid=self.config.check_type[2]

local model_show=self.config.model_show
if model_show then
local size=model_show[1]
local x=model_show[2]
local y=model_show[3]
widget:SetChildScale(0,Vector3(size,size,size))
widget:SetChildAnchoredPosition(0,Vector2(x,y))
widget:SetChildScale(1,Vector3(size,size,size))
widget:SetChildAnchoredPosition(1,Vector2(x,y))

if type==1 then
local gbid=gubaoLookup:good2GuBao(itemid)
local itemCfg=itemsConfig.getConfig(gbid,ITEM_CONFIG_TYPE.eGuBao)
local pram=itemCfg.relevantPram.pram
local icon=pram.icon or""
if icon==""then
local effectid=pram.effectid
widget:SetChildShowEffect(0,effectid,true)
else
widget:SetChildCSImageIcon(1,icon,true)
end
elseif type==2 then
local modelParams=itemsConfig.getConfig(itemid).model
local effectInfo=self.isToggle and modelParams[2]or modelParams[1]
widget:SetChildShowEffect(0,effectInfo[1],true)
end
else
local icon_show=self.config.icon_show
widget:SetChildCSImageIcon(1,icon,true)
end
end

function UISubAct_XiShiZhenBaoWin:freshToggle()
local isToggle=self.isToggle
self.closeTag:setActive(not isToggle)
self.openTag:setActive(isToggle)
end


function UISubAct_XiShiZhenBaoWin:freshLeftTimer()
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
end
self.tickTimer=nil
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then
self.timeText:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(lerp,true)))
else
self.timeText:setText("活动已结束")
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
end
end
end

self.tickTimer=self:setTimer(1,0,func)

func()
end

function UISubAct_XiShiZhenBaoWin:freshTips()
self.tipsTitle1:setActive(self.isToggle)
self.tipsTitle2:setActive(not self.isToggle)

local type=self.config.check_type[1]
self.tipsTitle:setText(type==1 and"古宝技能"or"武器神通")

local itemid=self.config.check_type[2]
local showAttrs={}
local skill_desc=""
if type==1 then
local gbid=gubaoLookup:good2GuBao(itemid)
local baseAttrs=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'attr')
local minAttrsLookup=gubaoModel:getMinAttrLookup(gbid)
local maxAttrsLookup=self.isToggle and gubaoModel:getMaxAttrLookup(gbid)or minAttrsLookup
for i,v in ipairs(baseAttrs or{})do
local attrType=v[1]
local attrValue=self.isToggle and maxAttrsLookup[attrType]or minAttrsLookup[attrType]
table.insert(showAttrs,{attrType,attrValue})
end

local cfg=cfg_gubaoconfig_get(gbid)
local starlv=self.isToggle and#cfg.star or 0
local awakelv=self.isToggle and#cfg.awake or 0
local skilllv=self.isToggle and cfg.level and 1 or 0
local n_skilllv=self.isToggle and gubaoModel:getSkillLvEx(gbid,starlv,awakelv,skilllv)or skilllv
local skill_str,skill_str_2,skill_str_3=gubaoModel:getSkillDesc(gbid,self.isToggle and n_skilllv or skilllv)
if skill_str_2 then
skill_str=FMT.fmt('{0}\n{1}',skill_str,skill_str_2)
end
skill_desc=skill_str
elseif type==2 then
local maxStarlv=daobingConfig.getStarMaxLv(itemid)
local maxJinglianlv=daobingConfig.getCurrentJinglianMaxLv(itemid,maxStarlv)
local starlv=self.isToggle and maxStarlv or 0
local jllv=self.isToggle and maxJinglianlv or 0
local daobingAttrs=daobingHelper.getEquipBaseAttrsLookupByItemid(itemid,starlv,jllv)
for attrType,attrValue in ipairs(daobingAttrs or{})do
table.insert(showAttrs,{attrType,attrValue})
end

local skillids=daobingHelper.getWeaponShentong(itemid)
local len=#skillids
if len>0 then
local skilllv=daobingConfig.getWeaponShentongLvByStar(starlv)
for i=1,len do
local skillid=skillids[i]
local cfg=fabaoConfig.getShentongConfig(skillid)
local name=cfg.name
local nameTitle=FMT.fmt('<color=#CA631D>【{0}{1}级】</color>',name,skilllv)
local desc=skillModel:getSkillDesc(skillid,skilllv)
desc=FMT.fmt('{0}{1}',nameTitle,desc)
local descEx=skillModel:getSkillDescEx(skillid,skilllv)or{}
for i,v in ipairs(descEx)do
local str=FMT.fmt('<color=#171311>{0}</color>',v)
desc=FMT.fmt('{0}\n{1}',desc,str)
end
desc=FMT.cfmt2('#171311',desc)
skill_desc=skill_desc==""and desc or FMT.fmt('{0}\n{1}',skill_desc,desc)
end
end
end


local len=#showAttrs
self.tipsCreater:setChildLayoutGroupCreateItems(len)
local grids=self.tipsCreater:getChildLayoutGroupGridList()
for i=1,len do
local item=grids[i-1]
local attr=showAttrs[i]
local attrType=attr[1]
local attrValue=attr[2]
self:fillAttr(item,attrType,attrValue,0)
end

self.tipsDesc:setText(skill_desc)
end

function UISubAct_XiShiZhenBaoWin:fillAttr(item,attrType,attrValue,add)
local name,valstr=equipsHelper.getAttr(attrType,attrValue)
local attrStr=FMT.fmt('{0}：{1}',name,valstr)
item:SetChildText(0,attrStr)
item:SetChildActive(1,add>0)
if add>0 then
item:SetChildText(3,add)
end
end

function UISubAct_XiShiZhenBaoWin:freshReddot()
local reddot=self.actModel:checkFree()
self.prizeReddot:setActive(reddot)
self.prizeBtn:setActive(reddot)
end

function UISubAct_XiShiZhenBaoWin:freshRewardPanel()
local rewards=self.config.rewards_show or self.config.rewards
local flag=self.config.rewards_flag or{}
self.rewardContent:setChildLayoutGroupCreateItems(#rewards,function(index)
local widget=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local items=rewards[index]
local itemId,itemNum=unpack(items)
local countStr=itemNum
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
widget:SetChildPropData(0,prop)
widget:SetChildActive(1,flag[index]==1)
end)
end

function UISubAct_XiShiZhenBaoWin:onToggleBtn()
self.isToggle=not self.isToggle
self:freshToggle()
self:fillModel()
self:freshTips()
end

function UISubAct_XiShiZhenBaoWin:onGainBtn()
call_activitiesHandle_func('activitiesHandle_xishizhenbao','reqBuy',self.activityId,self.subId)
end

function UISubAct_XiShiZhenBaoWin:onPrizeBtn()
call_activitiesHandle_func('activitiesHandle_xishizhenbao','reqFreeGift',self.activityId,self.subId)
end

function UISubAct_XiShiZhenBaoWin:onJumpBtn()
if self.config.jumpCfg then
local jumpParam=self.config.jumpCfg[2]
jumpManager:jump(jumpParam)
end
end