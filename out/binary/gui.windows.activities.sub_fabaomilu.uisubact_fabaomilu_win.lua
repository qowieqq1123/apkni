







def_class("UISubAct_fabaomilu_win",UIWindowBase)









function UISubAct_fabaomilu_win:bindComponents()

self.root=UIObject.get(self,0)
self.selectGridPanel=UIObject.get(self,1)
self.timeTxt=UIText.get(self,2)
self.itemScrollView=UIObject.get(self,3)
self.descTxt=UIText.get(self,4)
self.rewardGridPanel=UIObject.get(self,5)
self.rewardSign=UIObject.get(self,6)
self.rewardEffect=UIObject.get(self,7)
self.rewardBtn=UIButton.get(self,8)
self.numProgress=UIObject.get(self,9)
self.numProgressTxt=UIText.get(self,10)
self.itemGridPanel=UIObject.get(self,11)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UISubAct_fabaomilu_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectGridPanel);self.selectGridPanel=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.rewardGridPanel);self.rewardGridPanel=nil;
_UIObject_release(self.rewardSign);self.rewardSign=nil;
_UIObject_release(self.rewardEffect);self.rewardEffect=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.numProgress);self.numProgress=nil;
_UIObject_release(self.numProgressTxt);self.numProgressTxt=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
end
















local _this
local bgColorLookup={
[1]='image_fabaomiluui_1',
[2]='image_fabaomiluui_2',
[3]='image_fabaomiluui_3',
[4]='image_fabaomiluui_4',
[5]='image_fabaomiluui_4',
}
local signColorLookup={
[1]='image_fabaomiluui_5',
[2]='image_fabaomiluui_5',
[3]='image_fabaomiluui_5',
[4]='image_fabaomiluui_5',
[5]='image_fabaomiluui_6',
}


function UISubAct_fabaomilu_win:onLoaded(...)
_this=self
self:bindComponents()
local pagelookup={
{typo=0,name='全部',icon=nil,icon2=nil},
{typo=1,name='输出',icon='image_fabaolxxtp_1',icon2='image_fabaolxtp_1'},
{typo=2,name='防御',icon='image_fabaolxxtp_2',icon2='image_fabaolxtp_2'},
{typo=3,name='辅助',icon='image_fabaolxxtp_3',icon2='image_fabaolxtp_3'},
{typo=4,name='治疗',icon='image_fabaolxxtp_4',icon2='image_fabaolxtp_4'},
}
self.pagelookup=pagelookup
self.curpage=1
end


function UISubAct_fabaomilu_win:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_fabaomilu_win:onHide()

end




function UISubAct_fabaomilu_win:onShow(argtable,afterOnloaded)
self:refreshItemsScrollView()
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.tab_idx=argtable.tab_idx

self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
end
self:refreshActTime()

self:initView()
self:refreshItemsPanel()
self:refreshProgress()
self:refreshRewardBtn()
end

function UISubAct_fabaomilu_win:refreshActTime()
local lerp=self.sub_actInfo:getEndLeftTime()
if lerp<0 then
lerp=0
end
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(lerp))
self.timeTxt:setText(time_str)
end

function UISubAct_fabaomilu_win:initView()
if self.itemsLookup==nil then
local lp={}
local showItems=self.sub_actcfg.showItems
for i,v in ipairs(showItems)do
local d={}
d.itemID=v[1]
d.signs=v[2]
local itemcfg=itemsConfig.getConfig(d.itemID)
d.typo=itemcfg.type3
d.shentong=itemcfg.shentong
d.idx=i
d.checkLook=function(self_,sub_actInfo)
return sub_actInfo:checkLookRedcord(self_.idx)
end
lp[d.idx]=d
end
self.itemsLookup=lp
end
local c=#self.pagelookup
self.selectGridPanel:setChildLayoutGroupCreateItems(c)
local grids=self.selectGridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
self:refreshPageItem(item,i)
end

local rewards=self.sub_actcfg.reward
local c2=#rewards
self.rewardGridPanel:setChildLayoutGroupCreateItems(c)
local grids2=self.rewardGridPanel:getChildLayoutGroupGridList()
for i=1,c2 do
local rewardItem=grids2[i-1]
local reward=rewards[i]
local itemid=reward[1]
local itemnum=reward[2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickGoodItem(...)
end)
end

local reward_=rewards[1]
local itemid_=reward_[1]
local itemnum_=reward_[2]
local itemcfg_=itemsConfig.getConfig(itemid_)
local name_str=toColorString(itemcfg_.color,itemcfg_.name)
local stage_str=eNumberType:getName(itemcfg_.stage or itemcfg_.color)
local str=FMT.fmt('预览{0}个不同的法宝神通后即获得{1}阶法宝材料 {2} {3}个',self.sub_actcfg.looknum,stage_str,name_str,itemnum_)
self.descTxt:setText(str)
end

function UISubAct_fabaomilu_win:onClickGoodItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_fabaomilu_win:refreshProgress()
local looknum=self.sub_actcfg.looknum
local cur=self.sub_actInfo:getLookRecordNum()
local rate=cur/looknum
if rate>1 then rate=1 end
self.numProgressTxt:setText(FMT.fmt('{0}/{1}',cur,looknum))
self.numProgress:setChildIconFillAmount(rate)
end

function UISubAct_fabaomilu_win:refreshRewardBtn()
local hasReward,isfix=self.sub_actInfo:checkReward()
self.rewardEffect:setActive(hasReward)
if hasReward then
self.rewardEffect:setAnimationStringID('xianshu_light')
end
self.rewardSign:setActive(not hasReward and isfix)
end

function UISubAct_fabaomilu_win:onRewardBtn()
local hasReward=self.sub_actInfo:checkReward()
if hasReward then
local json_str=jsonHelper.encode({})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
else
local rewards=self.sub_actcfg.reward
local reward_=rewards[1]
local itemid_=reward_[1]
tipsManager.showTips({itemid=itemid_,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
end



function UISubAct_fabaomilu_win:refreshPageItem(item,idx)
if item==nil then
item=self.selectGridPanel:getChildLayoutGroupGridItem(idx-1)
end

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onPageItemClick(idx)
end)

self:refreshPageItemSelect(item,idx,self.curpage==idx)

local page=self.pagelookup[idx]
item:SetChildText(2,page.name)

local icon=page.icon
local showIcon=icon~=nil
item:SetChildActive(3,showIcon)
if showIcon then
item:SetChildCSImageSprite(3,globalABLookup.fabaomiluicons,icon)
end
end

function UISubAct_fabaomilu_win:refreshPageItemSelect(item,idx,flag)
if item==nil then
item=self.selectGridPanel:getChildLayoutGroupGridItem(idx-1)
end
item:SetChildActive(1,flag)
end

function UISubAct_fabaomilu_win:onPageItemClick(idx)
if self.curpage==idx then return end
self:refreshPageItemSelect(nil,self.curpage,false)
self:refreshPageItemSelect(nil,idx,true)
self.curpage=idx
self:refreshItemsPanel()
end





function UISubAct_fabaomilu_win:refreshItemsScrollView()
local w=self.root:getChildRectWidth()
w=math.floor(w)

if w>1624 then w=1624 end
local w_=1334
local lerp=(w-w_)/2
if self.itemSVWidth==nil then
self.itemSVWidth=self.itemScrollView:getChildRectWidth()
end
local w2=self.itemSVWidth+lerp
self.itemScrollView:setChildSizeDelta(w2,515)
end

function UISubAct_fabaomilu_win:refreshItemsPanel()
self.itemslist={}
local page=self.pagelookup[self.curpage]
local curTypo=page.typo
for idx,v in pairs(self.itemsLookup)do
if curTypo==0 or v.typo==curTypo then

table.insert(self.itemslist,v)
end
end
local c=#self.itemslist
if c>1 then
table.sort(self.itemslist,function(a,b)
return a.idx<b.idx
end)
end
self.itemGridPanel:setChildLayoutGroupCreateItems(c,function(idx)
self:refreshItem(nil,idx)
end)
self.itemGridPanel:setLocalPosX(0)
end

function UISubAct_fabaomilu_win:refreshAllItemState()
local c=#self.itemslist
for i=1,c do
self:refreshItemState(nil,i)
end
end

function UISubAct_fabaomilu_win:refreshItem(item,idx)
if item==nil then
item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local d=self.itemslist[idx]
local itemcfg=itemsConfig.getConfig(d.itemID)

local bgIcon=bgColorLookup[itemcfg.color]
item:SetChildCSImageSprite(10,globalABLookup.fabaomiluicons,bgIcon)

local page=self.pagelookup[d.typo+1]
local posIcon=page.icon2
item:SetChildCSImageSprite(0,globalABLookup.fabaomiluicons,posIcon)

item:SetChildText(1,itemcfg.name)

local itemicon=iconHelper.getIconName(d.itemID)
item:SetChildCSImageIcon(2,itemicon,true)

local skillCfg=cfgHelper.get1(cfg_skillconfig_get,d.shentong)
item:SetChildCSImageIcon(3,iconHelper.getSkillIcon(skillCfg.icon),true)

item:SetChildText(4,skillCfg.name)

local signs=d.signs
local c=#signs
item:SetChildLayoutGroupCreateItems(5,c)
local grids=item:GetChildLayoutGroupGridList(5)
for i=1,c do
local signItem=grids[i-1]
local sid=signs[i]
local signcfg=cfgHelper.get1(cfg_fabaomilusignconfig_get,sid)
local frameIcon=signColorLookup[signcfg.color]
signItem:SetChildCSImageSprite(0,globalABLookup.fabaomiluicons,frameIcon)
signItem:SetChildText(1,signcfg.name)
end

item:SetChildButtonClick(6,function()
if _this==nil then return end
_this:onItemLookClick(idx)
end)

self:refreshItemState(item,idx)

item:SetChildButtonClick(8,function()
if _this==nil then return end
_this:onItemClick(idx)
end)

item:SetChildButtonClick(9,function()
if _this==nil then return end
_this:onItemSkillClick(idx)
end)
end

function UISubAct_fabaomilu_win:refreshItemState(item,idx)
if item==nil then
item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local d=self.itemslist[idx]
local isReddot=not d:checkLook(self.sub_actInfo)and not self.sub_actInfo:checkFixAndGot()
item:SetChildActive(7,isReddot)
end

function UISubAct_fabaomilu_win:onItemClick(idx)
local d=self.itemslist[idx]
tipsManager.showTips({itemid=d.itemID,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_fabaomilu_win:onItemSkillClick(idx)
local d=self.itemslist[idx]
local args={skillID=d.shentong,skillLv=1,attend=eSkillTipsType.eDZSTSkill,changLv=false}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end

function UISubAct_fabaomilu_win:onItemLookClick(idx)
local d=self.itemslist[idx]


local check=false
if d.shentong then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,d.shentong)
local display=skillCfg.display
if display then
check=true
reportDisplayController:displayReport(display[3],display[1],display[2],nil,{skillId=d.shentong})
else



end
end

local islook=d:checkLook(self.sub_actInfo)
if not islook and check then
self.sub_actInfo:setLookRedcord(d.idx)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshItemState(nil,idx)
self:refreshProgress()
self:refreshRewardBtn()
end
end



function UISubAct_fabaomilu_win:rec_refresh()
self:refreshRewardBtn()
self:refreshAllItemState()
end
