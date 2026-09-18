







def_class("UISubAct_guitutequan_Win",UIWindowBase)









function UISubAct_guitutequan_Win:bindComponents()

self.bgModel=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.time=UIText.get(self,2)
self.rankFirstList=UIObject.get(self,3)
self.titleimg=UIImage.get(self,4)



end


function UISubAct_guitutequan_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.rankFirstList);self.rankFirstList=nil;
_UIObject_release(self.titleimg);self.titleimg=nil;
end

















local _this
local itemindex=
{
bg=0,
icon=1,
name=2,
desc=3,
tag=4,
tagtxt=5,
}
local abname="ui/windows/activities/sub_guitutequan/guitutequan_atlas_pak.ab"



function UISubAct_guitutequan_Win:onLoaded(...)
self:bindComponents()
_this=self

end


function UISubAct_guitutequan_Win:__delete()
self:unbindComponents()
self.isOver=nil
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
_this=nil
end




function UISubAct_guitutequan_Win:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.myData=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.moneyType=eMoneyType.mtLingYu
self.isShowMoney=self.config.isShowMoney
self.fmTweenerList={}
if self.info then
local leftTime=self.info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("<color=#FD8950>活动剩余时间：</color>{0}",timeHelper.format_time_stamp11(leftTime,true)))
else
self.time:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("<color=#FD8950>活动剩余时间：</color>{0}",timeHelper.format_time_stamp11(leftTime,true)))
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end

end)
else
self.time:setText("活动已结束")
self.isOver=true
end
self.bgModel:setChildUIModelShowTarget(5349,1,{},eAnimationID.stand,false,false,0,nil)
self:onRefresh()
end


function UISubAct_guitutequan_Win:onHide()

end


function UISubAct_guitutequan_Win:onRefresh()
local _iconName=cfg_guitutequanactivityconfig_get(_this.subid).imgename or"image_guitutequan_01"
_this.winlua:SetChildCSImageSprite(self.titleimg:getID(),abname,_iconName)
local showList=cfg_guitutequanactivityconfig_get(_this.subid).buffList
local worldLevel=self.myData.worldLevel or 0
if worldLevel>0 then
local buffList2=cfg_guitutequanactivityconfig_get(_this.subid).buffList2
for k,v in ipairs(buffList2)do
if v[1]<=worldLevel and v[2]>=worldLevel then
showList=v[3]
end
end
end
if showList and#showList>0 then
local effectlist={}
for k,v in ipairs(showList)do
local cfg=cfg_guildstateconfig_get(v)
local effects=cfg.effects
for i,j in ipairs(effects)do
effectlist[#effectlist+1]=j
end
end
if#effectlist>0 then
self.rankFirstList:setActive(true)
self.rankFirstList:setChildScrollViewCreateGrids(#effectlist,#effectlist)
local grids=self.rankFirstList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]

local effectid=effectlist[i]
local cfg_effectlist=cfg_guitutequanactivityconfig_get(_this.subid).effectlist
if worldLevel>0 then
local effectlist2=cfg_guitutequanactivityconfig_get(_this.subid).effectlist2
for k,v in ipairs(effectlist2)do
if v[1]<=worldLevel and v[2]>=worldLevel then
cfg_effectlist=v[3]
end
end
end

local name=cfg_effectlist[effectid][1]
item:SetChildText(itemindex.name,name)

local desc=cfg_effectlist[effectid][2]
item:SetChildText(itemindex.desc,desc)

local iconid=cfg_effectlist[effectid][3]
local iconname=FMT.fmt("image_guitutequan_ch0{0}",iconid)
item:SetChildCSImageSprite(itemindex.icon,abname,iconname)

local isspecial=cfg_effectlist[effectid][4]
if isspecial then
local buffnum=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eZongmenMiJingDoubleChanged)or 0
local num=MysteryModel:getMJbuffUseNum()
item:SetChildActive(itemindex.tag,true)
local str=FMT.fmt("{2}：<color=#7d3b17>{0}/{1}</color>",num,buffnum,name)
item:SetChildText(itemindex.name,str)
end
end
else
self.rankFirstList:setActive(false)
end
else
self.rankFirstList:setActive(false)
end
end