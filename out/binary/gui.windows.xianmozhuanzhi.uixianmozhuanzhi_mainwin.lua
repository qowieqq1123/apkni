







def_class("UIXianMoZhuanZhi_mainWin",UIWindowBase)









function UIXianMoZhuanZhi_mainWin:bindComponents()

self.attrContent=UIObject.get(self,0)
self.attrHelpBtn=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.brokeEffect=UIObject.get(self,3)
self.chongXiuBtn=UIButton.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.daoHengBtn=UIButton.get(self,6)
self.daoHengContent=UIObject.get(self,7)
self.daoHengJinDu=UIObject.get(self,8)
self.daoHengJinDuText=UIText.get(self,9)
self.daoHengYears=UIText.get(self,10)
self.daoHengYearsBtn=UIButton.get(self,11)
self.dzModel=UIObject.get(self,12)
self.expItemBg=UIObject.get(self,13)
self.expItemContent=UIObject.get(self,14)
self.expItemEmpty=UIText.get(self,15)
self.expItemGainBtn=UIButton.get(self,16)
self.expItemMask=UIButton.get(self,17)
self.gainBtn=UIButton.get(self,18)
self.jiaSuBtn=UIButton.get(self,19)
self.jinDu=UIObject.get(self,20)
self.lockBg=UIObject.get(self,21)
self.standEffect=UIObject.get(self,22)
self.tuPoAttr_1=UIText.get(self,23)
self.tuPoAttr_2=UIText.get(self,24)
self.tuPoAttr_3=UIText.get(self,25)
self.tuPoAttr_4=UIText.get(self,26)
self.tuPoBg=UIObject.get(self,27)
self.tuPoBtn=UIButton.get(self,28)
self.tuPoCostIcon=UIObject.get(self,29)
self.tuPoCostText=UIText.get(self,30)
self.tuPoItem_1=UIBaseItem.get(self,31)
self.tuPoItem_2=UIBaseItem.get(self,32)
self.tuPoItem_3=UIBaseItem.get(self,33)
self.tuPoReddot=UIObject.get(self,34)
self.tuPoTips=UIText.get(self,35)
self.ViewPort=UIButton.get(self,36)
self.vocImg=UIImage.get(self,37)
self.xinFaGainBtn=UIButton.get(self,38)
self.xinFaJinDu=UIObject.get(self,39)
self.xinFaJinDuText=UIText.get(self,40)
self.xinFaName=UIText.get(self,41)
self.xinFaSkill=UIButton.get(self,42)
self.xinFaStage=UIText.get(self,43)

self.attrHelpBtn:setButtonClick(function()self:onAttrHelpBtn()end)

self.chongXiuBtn:setButtonClick(function()self:onChongXiuBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.daoHengBtn:setButtonClick(function()self:onDaoHengBtn()end)

self.daoHengYearsBtn:setButtonClick(function()self:onDaoHengYearsBtn()end)

self.expItemGainBtn:setButtonClick(function()self:onExpItemGainBtn()end)

self.expItemMask:setButtonClick(function()self:onExpItemMask()end)

self.gainBtn:setButtonClick(function()self:onGainBtn()end)

self.jiaSuBtn:setButtonClick(function()self:onJiaSuBtn()end)

self.tuPoBtn:setButtonClick(function()self:onTuPoBtn()end)

self.ViewPort:setButtonClick(function()self:onViewPort()end)

self.xinFaGainBtn:setButtonClick(function()self:onXinFaGainBtn()end)

self.xinFaSkill:setButtonClick(function()self:onXinFaSkill()end)
self.tuPoAttr={
self.tuPoAttr_1,
self.tuPoAttr_2,
self.tuPoAttr_3,
self.tuPoAttr_4,
}
self.tuPoItem={
self.tuPoItem_1,
self.tuPoItem_2,
self.tuPoItem_3,
}



end


function UIXianMoZhuanZhi_mainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrContent);self.attrContent=nil;
_UIObject_release(self.attrHelpBtn);self.attrHelpBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.brokeEffect);self.brokeEffect=nil;
_UIObject_release(self.chongXiuBtn);self.chongXiuBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.daoHengBtn);self.daoHengBtn=nil;
_UIObject_release(self.daoHengContent);self.daoHengContent=nil;
_UIObject_release(self.daoHengJinDu);self.daoHengJinDu=nil;
_UIObject_release(self.daoHengJinDuText);self.daoHengJinDuText=nil;
_UIObject_release(self.daoHengYears);self.daoHengYears=nil;
_UIObject_release(self.daoHengYearsBtn);self.daoHengYearsBtn=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.expItemBg);self.expItemBg=nil;
_UIObject_release(self.expItemContent);self.expItemContent=nil;
_UIObject_release(self.expItemEmpty);self.expItemEmpty=nil;
_UIObject_release(self.expItemGainBtn);self.expItemGainBtn=nil;
_UIObject_release(self.expItemMask);self.expItemMask=nil;
_UIObject_release(self.gainBtn);self.gainBtn=nil;
_UIObject_release(self.jiaSuBtn);self.jiaSuBtn=nil;
_UIObject_release(self.jinDu);self.jinDu=nil;
_UIObject_release(self.lockBg);self.lockBg=nil;
_UIObject_release(self.standEffect);self.standEffect=nil;
_UIObject_release(self.tuPoAttr_1);self.tuPoAttr_1=nil;
_UIObject_release(self.tuPoAttr_2);self.tuPoAttr_2=nil;
_UIObject_release(self.tuPoAttr_3);self.tuPoAttr_3=nil;
_UIObject_release(self.tuPoAttr_4);self.tuPoAttr_4=nil;
_UIObject_release(self.tuPoBg);self.tuPoBg=nil;
_UIObject_release(self.tuPoBtn);self.tuPoBtn=nil;
_UIObject_release(self.tuPoCostIcon);self.tuPoCostIcon=nil;
_UIObject_release(self.tuPoCostText);self.tuPoCostText=nil;
_UIObject_release(self.tuPoItem_1);self.tuPoItem_1=nil;
_UIObject_release(self.tuPoItem_2);self.tuPoItem_2=nil;
_UIObject_release(self.tuPoItem_3);self.tuPoItem_3=nil;
_UIObject_release(self.tuPoReddot);self.tuPoReddot=nil;
_UIObject_release(self.tuPoTips);self.tuPoTips=nil;
_UIObject_release(self.ViewPort);self.ViewPort=nil;
_UIObject_release(self.vocImg);self.vocImg=nil;
_UIObject_release(self.xinFaGainBtn);self.xinFaGainBtn=nil;
_UIObject_release(self.xinFaJinDu);self.xinFaJinDu=nil;
_UIObject_release(self.xinFaJinDuText);self.xinFaJinDuText=nil;
_UIObject_release(self.xinFaName);self.xinFaName=nil;
_UIObject_release(self.xinFaSkill);self.xinFaSkill=nil;
_UIObject_release(self.xinFaStage);self.xinFaStage=nil;
self.tuPoAttr=nil;
self.tuPoItem=nil;
end


















local jobABName='ui/windows/wenxinguan/wenxinguanjob_atlas_pak.ab'
local standEffect1=20477
local standEffect2=20478
local _this

function UIXianMoZhuanZhi_mainWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:showWindow("UITopMaskWin")
self:showWindow("UITopMoneyWin2",{moneys={{eMoneyType.mtXianQi},{eMoneyType.mtMoQi}},canvasIndex=8})
end


function UIXianMoZhuanZhi_mainWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianMoZhuanZhi_mainWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.bgModel:setChildUIModelShowTarget(5575,1,{},eAnimationID.stand,false,false,0)
end
self.dis_guid=argtable
self.voc=UIDiscipleModel:getDiscipleJob(self.dis_guid)
self.type=UIDiscipleModel:getDiscipleXianMoVoc(self.dis_guid)
self.cfg=cfgHelper.get2(cfg_discipledaohengtreeconfig_get,self.type,self.voc)

local iconName=jobXMType[self.voc][self.type]
self.vocImg:setSprite(jobABName,iconName)

local xinfa_exp_items_list=cfgHelper.get2(cfg_disciplevocconfig_get,1,'xinfa_exp_items')
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(self.dis_guid)
self.xinfa_exp_items=xinfa_exp_items_list[xm_voc]
self.xinfa_exp_items_lookup={}
for i,v in ipairs(self.xinfa_exp_items or{})do
local itemId=v[1]
self.xinfa_exp_items_lookup[itemId]=i
end

self:refreshDaoHengInfo()
self:refreshDaoHengProgressInfo()
self:refreshAttrInfo()
self:refreshXinFaInfo()
self:refreshTuPoInfo()
self:initTimer()
self:refreshExpItemPanel()
self:showDiscipleModel()

local func=function()
self.standEffect:setChildShowEffect(self.type==1 and standEffect1 or standEffect2,true)
end
func()
self.effectTimer=self:setTimer(10,0,func)

local contentHeight=488
local itemHeight=88
local singleStageDaoHeng=self.cfg.client_reward_list[1][1]
local targetIdx=mathHelper.floor(self.daoHeng/singleStageDaoHeng)+1
local jumpY=-(targetIdx*itemHeight)+(contentHeight/2)
self.daoHengContent:setChildAnchoredPosition(Vector2(0,jumpY))
end

function UIXianMoZhuanZhi_mainWin:xinFaTuPoCallBack(isBreak,args)
if isBreak then
self.brokeEffect:setChildShowEffect(10013,true)
self:delayDo(2,function()
UIManager:showWindow('UIXianMoZhuanZhi_XinFaUpWin',args)
end)
end
self:refreshDaoHengInfo()
self:refreshDaoHengProgressInfo()
self:refreshAttrInfo()
self:refreshXinFaInfo()
self:refreshTuPoInfo()
self:initTimer()
end

function UIXianMoZhuanZhi_mainWin:showDiscipleModel()
local modelId_immortal,modelId_devil=WenXinGuanModel:getDzXMSuit(self.dis_guid)
local model=self.type==1 and modelId_immortal or modelId_devil
if model then
local modelParams=self:getModelInfo(self.dis_guid)
if deviceHelper.getAPILevel()>=3 and modelParams.componets[1]~=nil then
self.dzModel:setChildUIModelShowTarget(modelParams.ChangeBody,modelParams.scale,nil,modelParams.anim,false,false)
self.dzModel:setChildAddSkeletonSlot("tou1","head",modelParams.componets[1])
else
self.dzModel:setChildUIModelShowTarget(model,modelParams.scale,modelParams.componets,modelParams.anim,false,false)
end
end
end

function UIXianMoZhuanZhi_mainWin:getModelInfo(guid)
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(guid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(guid,false,1,{xianmo_voc=xm_voc})

local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local bodyid=imageInfo.sex==SEX_TYPE.eMale and 50001 or 50002
modelParams.ChangeBody=cfgHelper.get2(cfg_disciplebodyimageconfig_get,bodyid,'out_side')

return modelParams
end

function UIXianMoZhuanZhi_mainWin:initTimer()
self:stopTimerByName('refreshTimer')
local _,cur,max=UIDiscipleModel:getDiscipleDaoHeng(self.dis_guid)
if cur<max then
local func=function()
self:refreshDaoHengInfo()
self:refreshDaoHengProgressInfo()
self:refreshAttrInfo()
self:refreshXinFaInfo()
self:refreshTuPoInfo()
end
self.refreshTimer=self:setTimer(10,0,func)
end
end

function UIXianMoZhuanZhi_mainWin:refreshDaoHengInfo()
self.daoHeng,self.remain_exp,self.max_exp=UIDiscipleModel:getDiscipleDaoHeng(self.dis_guid)
self.daoHengYears:setText(string.format("<color=%s>%d年</color>",self.type==1 and"#f1ce78"or"#f36666",self.daoHeng))

local daoHengShuCfg=self.cfg.client_reward_list
local maxTarget=0
local xinfaLevel=UIDiscipleModel:getDiscipleXinFaLevel(self.dis_guid)
self.daoHengContent:setChildLayoutGroupCreateItems(#daoHengShuCfg,function(index)
local item=self.daoHengContent:getChildLayoutGroupGridItem(index-1)
local cfg=daoHengShuCfg[index]

local target_daoHeng=cfg[1]
local target_xinFaLevel=cfg[4]or 0
maxTarget=math.max(maxTarget,target_daoHeng)
local isActive=false
if target_xinFaLevel>0 then
isActive=self.daoHeng>target_daoHeng and xinfaLevel>=target_xinFaLevel
else
isActive=self.daoHeng>=target_daoHeng and xinfaLevel>=target_xinFaLevel
end
item:SetChildActive(0,not isActive)
item:SetChildActive(1,isActive)

item:SetChildText(2,string.format("<color=%s>%d年</color>",isActive and"#F7F7F7"or"#8E8C87",target_daoHeng))

local rewardType=cfg[2]
if rewardType==2 then
local skillid=cfg[3][1]
local skilllevel=cfg[3][2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillid)
if skillCfg then
local icon=iconHelper.getSkillIcon(skillCfg.icon)
item:SetChildIcon(3,icon,false)
item:SetChildButtonClick(3,function()
local args={
skillLv=skilllevel,
changLv=false,
fromCfg=true,
isShowSkill=true,
skillID=skillid,
dis_guid=self.dis_guid,
attend=eSkillTipsType.eDZSkill,


}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end)
end
end
if target_xinFaLevel>0 then
item:SetChildActive(4,true)


else
item:SetChildActive(4,false)
end
end)
self.jinDu:setChildIconFillAmount(self.daoHeng/maxTarget)
end

function UIXianMoZhuanZhi_mainWin:refreshAttrInfo()

local attrsLookup=UIDiscipleModel:getXianMoDaoHengAttrsLookup(self.dis_guid)
local JJRate=UIDiscipleModel:getXianMoJJRate(self.dis_guid)
local LTRate=UIDiscipleModel:getXianMoLTRate(self.dis_guid)

local attrList={}
for attrKey,attrVal in pairs(attrsLookup)do
table.insert(attrList,{attrKey,attrVal})
end

if JJRate>0 then
table.insert(attrList,{-1,JJRate})
end
if LTRate>0 then
table.insert(attrList,{-2,LTRate})
end

self.attrContent:setChildLayoutGroupCreateItems(#attrList,function(index)
local item=self.attrContent:getChildLayoutGroupGridItem(index-1)

local attr=attrList[index]
local attrInfo
if attr[1]==-1 then
attrInfo=FMT.fmt("境界属性加成 <color=#aae252>+{0}%</color>",attr[2]*100)
elseif attr[1]==-2 then
attrInfo=FMT.fmt("炼体属性加成 <color=#aae252>+{0}%</color>",attr[2]*100)
else
attrInfo=helper.getAttributeStr(attr[1],attr[2],1,"{0} <color=#aae252>+{1}</color>")
end
item:SetChildText(-1,attrInfo)
end)
end

function UIXianMoZhuanZhi_mainWin:refreshXinFaInfo()
local xinfaLevel=UIDiscipleModel:getDiscipleXinFaLevel(self.dis_guid)
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfaLevel)
local xinfaStage=xinfaLevelCfg.stage
local xinfaCfg=cfgHelper.get2(cfg_disciplexinfaconfig_get,self.type,xinfaStage)
local isActive=UIDiscipleModel:isXinFaActive(self.type,xinfaStage)
local cur=self.daoHeng
local max=UIDiscipleModel:getDiscipleXinFaTotalExp(self.dis_guid)

self.lockBg:setActive(not isActive)
self.xinFaName:setText(xinfaCfg.name)
self.xinFaStage:setText(xinfaLevelCfg.name)
self.xinFaSkill:setChildIcon(xinfaCfg.icon,false)

self.xinFaJinDuText:setText(string.format("道行上限：%d/%d",cur,max))
end

function UIXianMoZhuanZhi_mainWin:refreshDaoHengProgressInfo()
local cur,max=self.remain_exp,self.max_exp
self.daoHengJinDu:setChildIconFillAmount(cur/max)
self.daoHengJinDuText:setText(string.format("%d/%d",cur,max))
end

function UIXianMoZhuanZhi_mainWin:refreshTuPoInfo()
local cur=self.daoHeng
local max=UIDiscipleModel:getDiscipleXinFaTotalExp(self.dis_guid)
local daoheng_exp,daoheng_max_exp=UIDiscipleModel:getDiscipleDaoHengTotalExp(self.dis_guid)
local xinfaLevel=UIDiscipleModel:getDiscipleXinFaLevel(self.dis_guid)
local max_xinfaLevel=#cfg_discipledaohengconfig()
if cur>=max and daoheng_exp>=daoheng_max_exp and xinfaLevel<max_xinfaLevel then
self.tuPoBg:setActive(true)

local active=true
local xinfaStage=UIDiscipleModel:getDiscipleXinFaStage(self.dis_guid)
local nextXinFaStage=cfgHelper.get2(cfg_discipledaohengconfig_get,xinfaLevel+1,'stage')
if nextXinFaStage~=xinfaStage then
active=UIDiscipleModel:isXinFaActive(self.type,xinfaStage+1)
end
self.tuPoBtn:setActive(active)
self.xinFaGainBtn:setActive(not active)
if not active then
self.tuPoTips:setText(string.format("%s阶心法未激活，无法突破",mathHelper.numberToChinese(xinfaStage+1)))
else
local reddot=UIDiscipleModel:checkDiscipleXianMoXinFaReddot(self.dis_guid)
self.tuPoReddot:setActive(reddot)
end
local xinfaLevel=UIDiscipleModel:getDiscipleXinFaLevel(self.dis_guid)
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfaLevel)
local consume=xinfaLevelCfg.consume[self.type]
local moneyCost
local itemCost={}
for i,v in ipairs(consume)do





table.insert(itemCost,{v[1],v[2]})
end

if moneyCost then
self.tuPoCostIcon:setActive(true)
self.tuPoCostText:setActive(true)
self.tuPoCostIcon:setChildIcon(iconHelper.getIconName(moneyCost[1]),false)
local have=itemsModel.getCount(moneyCost[1])
local str=have<moneyCost[2]and string.format("<color=#c82c2c>%s</color>",mathHelper.formatNumber(have))or mathHelper.formatNumber(have)
self.tuPoCostText:setText(string.format("%s/%s",str,moneyCost[2]))
else
self.tuPoCostIcon:setActive(false)
self.tuPoCostText:setActive(false)
end

for i,v in ipairs(self.tuPoItem)do
local items=itemCost[i]
if items then
v:setActive(true)
local itemId,needNum=unpack(items)
local isMoney=moneyConfig.isMoney(itemId)
local itemNum=itemsModel.getCount(itemId)
local colorStr=itemNum<needNum and'#c82c2c'or'#FFFFFF'
local countStr
if isMoney then
countStr=string.format("<color=%s>%s</color>",colorStr,mathHelper.formatNumber7(needNum,2,2))
else
countStr=string.format("<color=%s>%s</color>/%s",colorStr,mathHelper.formatNumber(itemNum),mathHelper.formatNumber7(needNum,2,2))
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
v:setBaseItemClickEvent(function(...)
itemsComponentHelper.onItemClick(...)
end)
v:setChildPropData(prop)
else
v:setActive(false)
end
end

local nextXinFaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfaLevel+1)
local xinfa_attr=nextXinFaLevelCfg and nextXinFaLevelCfg.xinfa_attr[self.voc]or{}
for i,v in ipairs(self.tuPoAttr)do
local attr=xinfa_attr[i]
if attr then
v:setActive(true)
local attrInfo=helper.getAttributeStr(attr[1],attr[2],1,"{0}<color=#aae252>+{1}</color>")
v:setText(attrInfo)
else
v:setActive(false)
end
end
else
self.tuPoBg:setActive(false)
end
end

function UIXianMoZhuanZhi_mainWin:refreshExpItemPanel()
local xinfa_exp_items=self.xinfa_exp_items
local empty=true
for i,v in ipairs(xinfa_exp_items)do
local itemId=v[1]
local itemNum=itemsModel.getCount(itemId)
if itemNum>0 then
empty=false
break
end
end
self.expItemEmpty:setActive(empty)
local clickCount=0
local cb=function(idx)
clickCount=clickCount+1
if clickCount>1 then return end
clickCount=0
if not self or self.isClose then return end
self:onAccItemClick(idx)
end
local finishCb=function(idx)
self:onAccItemClick_fn(idx)
end
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(self.dis_guid)
self.expItemContent:setChildLayoutGroupCreateItems(#xinfa_exp_items,function(index)
local item=self.expItemContent:getChildLayoutGroupGridItem(index-1)
local itemId,addExp=unpack(xinfa_exp_items[index])
local itemNum=itemsModel.getCount(itemId)
if itemNum<=0 then
item:SetChildActive(-1,false)
else
item:SetChildActive(-1,true)
local countStr=mathHelper.formatNumber(itemNum)
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)

item:SetChildText(1,itemsConfig.getItemName(itemId))

local exp_rate=gubaoModel:getXianMo_DaoHangEXPSpeed(xm_voc)/100
item:SetChildText(2,string.format("经验+%d",mathHelper.safe_floor(addExp*(1+exp_rate))))

item:SetChildButtonEnable(3,itemNum>0,itemNum<=0)
item:SetChildLongPress(3,index,cb,finishCb)
end
end)
end

function UIXianMoZhuanZhi_mainWin:onAccItemClick(idx)
local itemId,addExp=unpack(self.xinfa_exp_items[idx])
local have=bagModel.getItemCountById(itemId)
if have<=0 then
self:stopItemLongPress(idx)

return
end
local _,cur,max=UIDiscipleModel:getDiscipleDaoHeng(self.dis_guid)
if cur>=max then
self:stopItemLongPress(idx)
UIManager.info("当前心法经验已满")
return
end
local num=1
if self.useGoodTime~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.useGoodTime
if lerp>=10 then
num=10
elseif lerp>=6 then
num=5
elseif lerp>=3 then

num=3
elseif lerp>=2 then

num=2
end
else
self.useGoodTime=Time.realtimeSinceStartup
end
if num>have then
num=have
end

bagProtocolControl.req_dizi_use_item(self.dis_guid,itemId,num)
end

function UIXianMoZhuanZhi_mainWin:onAccItemClick_fn(idx)
self.useGoodTime=nil
self:recordClickCount()
end

function UIXianMoZhuanZhi_mainWin:recordClickCount()
if self.clickTime==nil or(Time.realtimeSinceStartup-self.clickTime<0.5)then
self.clickCount=self.clickCount==nil and 1 or(self.clickCount+1)
else
self.clickCount=0
end
if self.clickCount>=5 then
self.clickCount=0
end
self.clickTime=Time.realtimeSinceStartup
end

function UIXianMoZhuanZhi_mainWin:stopItemLongPress(idx)
local item=self.expItemContent:getChildLayoutGroupGridItem(idx-1)
if item then
item:SetChildLongPressStop(3)
end
self:onAccItemClick_fn(idx)
end

function UIXianMoZhuanZhi_mainWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
if _this.xinfa_exp_items_lookup[itemid]then
if newcount<=0 or(oldcount<=0 and newcount>0)then
_this:refreshExpItemPanel()
else
local idx=_this.xinfa_exp_items_lookup[itemid]
local item=_this.expItemContent:getChildLayoutGroupGridItem(idx-1)
if item then
item:SetChildItemData(0,PropIndex(DataPropKey.eWidgetActive,2),newcount>1)
item:SetChildItemData(0,PropIndex(DataPropKey.eWidgetText,3),newcount>1 and tostring(newcount)or'')
item:SetChildButtonEnable(3,newcount>0,newcount<=0)
if newcount<=0 then
_this:stopItemLongPress(idx)
end
end
end
local _,cur,max=UIDiscipleModel:getDiscipleDaoHeng(_this.dis_guid)
if cur>=max then
_this:onExpItemMask()
end
end
_this:refreshTuPoInfo()
end

function UIXianMoZhuanZhi_mainWin:onChongXiuBtn()













self:showWindow("UIXianMoZhuanZhi_resetWin",self.dis_guid)
end

function UIXianMoZhuanZhi_mainWin:onCloseBtn()
local dis_guid=self.dis_guid
self:closeSelf()
UIManager:showWindow('UIDiscipleJingJieWin',{guid=dis_guid})
end

function UIXianMoZhuanZhi_mainWin:onDaoHengBtn()
self:showWindow("UIXianMoZhuanZhi_daoHengShuWin",self.dis_guid)
end

function UIXianMoZhuanZhi_mainWin:onViewPort()
self:showWindow("UIXianMoZhuanZhi_daoHengShuWin",self.dis_guid)
end

function UIXianMoZhuanZhi_mainWin:onGainBtn()
local xinfaStage=UIDiscipleModel:getDiscipleXinFaStage(self.dis_guid)
local xinfaCfg=cfgHelper.get2(cfg_disciplexinfaconfig_get,self.type,xinfaStage)
gainControl:showGainWin(xinfaCfg.gain_itemid)
end

function UIXianMoZhuanZhi_mainWin:onXinFaGainBtn()
local xinfaStage=UIDiscipleModel:getDiscipleXinFaStage(self.dis_guid)
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(self.dis_guid)
local type=xm_voc==1 and FULL_TAB_TYPE.eCangJingGeXianShu or FULL_TAB_TYPE.eCangJingGeMoGong
local dis_guid=self.dis_guid
UIDiscipleModel:setTargetXinFaData(xm_voc,xinfaStage+1,dis_guid)
UIFullCangJingGeXinFaControl:showXinFaWindow(type,{selectStage=xinfaStage+1})
end

function UIXianMoZhuanZhi_mainWin:onExpItemGainBtn()
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local default_item=baseCfg.default_exp_items[self.type]
gainControl:showGainWin(default_item)
end

function UIXianMoZhuanZhi_mainWin:onJiaSuBtn()
local _,cur,max=UIDiscipleModel:getDiscipleDaoHeng(self.dis_guid)
if cur>=max then
local xinfaLevel=UIDiscipleModel:getDiscipleXinFaLevel(self.dis_guid)
if xinfaLevel>=#cfg_discipledaohengconfig()then
local xinfaStage=UIDiscipleModel:getDiscipleXinFaStage(self.dis_guid)
return UIManager.info(string.format("%s阶心法未开放，敬请期待",mathHelper.numberToChinese(xinfaStage+1)))
end
UIManager.info("当前心法经验已满")
return
end
if not self.openExpItemPanel then
self.openExpItemPanel=true
self.expItemBg:setActive(true)
self.expItemMask:setActive(true)
self:refreshExpItemPanel()
else
self.openExpItemPanel=false
self.expItemBg:setActive(false)
self.expItemMask:setActive(false)
end
end

function UIXianMoZhuanZhi_mainWin:onExpItemMask()
self.openExpItemPanel=false
self.expItemBg:setActive(false)
self.expItemMask:setActive(false)
self:onAccItemClick_fn()
end

function UIXianMoZhuanZhi_mainWin:onTuPoBtn()
local xinfaStage=UIDiscipleModel:getDiscipleXinFaStage(self.dis_guid)
local xinfaLevel=UIDiscipleModel:getDiscipleXinFaLevel(self.dis_guid)
if xinfaLevel>=#cfg_discipledaohengconfig()then
return UIManager.info("心法已修炼圆满")
end
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfaLevel)
local consume=xinfaLevelCfg.consume[self.type]
for i,v in ipairs(consume)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
local needCount=v[2]
if itemsConfig.isMoney(v[1])then
needCount=0
end
return gainControl:showGainWin(v[1],false,{needCount=needCount})
end
end
local nextXinFaStage=cfgHelper.get2(cfg_discipledaohengconfig_get,xinfaLevel+1,'stage')
if nextXinFaStage~=xinfaStage then
local active=UIDiscipleModel:isXinFaActive(self.type,xinfaStage+1)
if not active then
UIManager.error(string.format("%s阶心法未激活",mathHelper.numberToChinese(xinfaStage+1)))
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(self.dis_guid)
local type=xm_voc==1 and FULL_TAB_TYPE.eCangJingGeXianShu or FULL_TAB_TYPE.eCangJingGeMoGong
return UIFullCangJingGeXinFaControl:showXinFaWindow(type,{selectStage=xinfaStage+1})
end
end
UIDiscipleController:reqXinFaBreakthrough(self.dis_guid)
end

function UIXianMoZhuanZhi_mainWin:onXinFaSkill()
self:showWindow("UIXianMoZhuanZhi_xinFaPreviewWin",self.dis_guid)
end

function UIXianMoZhuanZhi_mainWin:onDaoHengYearsBtn()
local contentStr=string.format('当前道行:%d年',self.daoHeng)
local pos=Vector2.New(10,15)
self:showWindow('UIConditionTipsOne',{showType=2,str=contentStr,posItem=self.daoHengYears,pos=pos})
end

function UIXianMoZhuanZhi_mainWin:onAttrHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.showBlack=true
d.name='xianmodaohengattr_help_%d'
UIManager:showWindow('UIRuleWin',d)
end