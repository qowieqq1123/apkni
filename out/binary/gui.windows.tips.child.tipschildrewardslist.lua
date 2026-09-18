







def_class("tipsChildRewardsList",UICloneObject)





tipsChildRewardsList.abName="ui/windows/tips/child/tipschildrewardslist.ab"

tipsChildRewardsList.assetName="tipsChildRewardsList"


function tipsChildRewardsList:bindComponents()

self.title=UIText.get(self,0)
self.rewardsList=UIObject.get(self,1)
self.scrollView=UIObject.get(self,2)

end


function tipsChildRewardsList:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rewardsList);self.rewardsList=nil;
end









function tipsChildRewardsList:onLoaded(...)
self:bindComponents()
end


function tipsChildRewardsList:__delete()
self:unbindComponents()
end

function tipsChildRewardsList:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local parentsMove=data.move
local selectNumCmpArgs=attach.selectNumCmpArgs
self.haveSelectNum=selectNumCmpArgs and selectNumCmpArgs.max>1
self.openTipsCount=attach.openTipsCount and attach.openTipsCount+1 or 1
if not parentsMove then

parentsMove=TIPS_MOVE_POS.eRight
end


if parentsMove==TIPS_MOVE_POS.eLeft then

self.move=TIPS_MOVE_POS.eRight
elseif parentsMove==TIPS_MOVE_POS.eDefault or parentsMove==TIPS_MOVE_POS.eRight or parentsMove==TIPS_MOVE_POS.eRightTwo then

self.move=TIPS_MOVE_POS.eLeft
elseif parentsMove==TIPS_MOVE_POS.eCenter then

self.move=TIPS_MOVE_POS.eRightTwo
end

local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig and itemConfig.funcparam or nil
local special_limit=itemConfig and itemConfig.special_limit or nil
if funcparam then
local funType=funcparam.type
local rewardList={}
if funType==item_funtion_type.eBaoXiang or funType==item_funtion_type.eXMZengLi then

local level=zongmenModel:getLevel()
local dropId=funcparam.dropid
if not dropId then
logErr(FMT.fmt("道具id: {0} 的tips控件配置了宝箱道具列表展示模块，但没有找到掉落物id，请检查道具配置是否正确",itemid))
return
end
local awardCfg=itemsAwardConfig:getAwardInConfigByLevel(dropId,level)
if not awardCfg then
logErr(FMT.fmt("找不到掉落物id为{0}所对应的配置，请检查道具配置是否正确",dropId))
return
end

local reward=awardCfg.showItems
if reward and next(reward)then
rewardList=reward
else
logErr(FMT.fmt("找不到掉落物id为{0}所对应的展示奖励配置，请检查道具配置是否正确",dropId))
return
end

elseif funType==item_funtion_type.selectbox then

local itemList=funcparam.itemList
if itemList and next(itemList)then
rewardList=itemList
else

logErr(FMT.fmt("道具id: {0} 的tips控件配置了宝箱道具列表展示模块，但没有找到道具列表，请检查道具配置是否正确",itemid))
return
end
elseif funType==item_funtion_type.eGiftPack then

local giftid=funcparam.giftid
local giftCfg=cfgHelper.get1(cfg_voerseasgiftconfig_get,giftid)
if not giftCfg then
logErr(FMT.fmt("道具id: {0} 没有找到道具礼包配置表礼包 礼包id：{1}",itemid,giftid))
return
end
rewardList=giftCfg.rewards
else
logErr(FMT.fmt("宝箱道具列表展示模块未支持功能参数类型为{0}的道具展示 请检查配置是否正确",funType))
return
end

self:refreshItemList(rewardList)
elseif special_limit then
local rewardList=special_limit[3]
self:refreshItemList(rewardList)
else

logErr(FMT.fmt("道具id: {0} 的tips控件配置了宝箱道具列表展示模块，但没有找到相关功能参数，请检查道具配置是否正确",itemid))
end
end

function tipsChildRewardsList:onRecycle()

end

function tipsChildRewardsList:refreshItemList(rewardList)
local num=#rewardList

local listRow=4
local scrollViewHight=100
local listColumn=math.ceil(num/listRow)
if listColumn>=3 then
if self.haveSelectNum then
scrollViewHight=208
else
scrollViewHight=300
end
else
scrollViewHight=100*listColumn
end
self.widget:SetChildLayoutElementPreferredHeight(self.scrollView:getID(),scrollViewHight)

self.rewardsList:setChildLayoutGroupCreateItems(0)
self.rewardsList:setChildLayoutGroupCreateItems(num)
local gridlist=self.rewardsList:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local widget=gridlist[i-1]
local reward=rewardList[i]
local itemid=reward[1]
local count=reward[2]
local range=reward.range
local odds=reward[4]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
elseif count==-1 and range~=nil and next(range)~=nil then
showCountBG=true
countStr=string.format("%s~%s",range[1],range[2])
end
local isYunZhouEquip=itemsConfig.isYunZhouComponents(itemid)
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=not isYunZhouEquip}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)

widget:SetChildActive(3,isYunZhouEquip)
widget:SetChildActive(2,isYunZhouEquip)
if isYunZhouEquip then
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stage=itemConfig.stage or 0
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,color)
widget:SetChildIcon(3,string.format("icon_suit_%d",suitConfig.icon),false)
local starWidget=widget:GetChildWidgetBase(2)
for i=1,5 do
starWidget:SetChildActive(i-1,i<=stage)
end
end

widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)

local item=widget:GetChildCSGUIBaseItem(0)
local gbid=gubaoLookup:good2GuBao(itemid)
local isSpe=gbid==nil
local callback=function(widget_)
if not isSpe then
widget_:SetChildLocalPos(-1,3,3,0)
end
end
itemsComponentHelper.setUIBaseItemSmallSignCommon(item,1,itemid,false,callback)

widget:SetChildActive(4,odds~=nil and odds>0)
if odds~=nil and odds>0 then
widget:SetChildText(4,FMT.fmt("{0}%",odds))
end
end
end
end




function tipsChildRewardsList:onClickRewardItem(itemId,index,guid,attach)

if self.openTipsCount>=TIPS_MAX_OPEN_COUNT then

return
end

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,
move=self.move,
showModel=false,
backType=TIPS_BACK_TYPE.eNone,
formType=TIPS_FORM_TYPE.eBaoXiangTipsItem,
attach={openTipsCount=self.openTipsCount}})
end