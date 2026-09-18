







def_class("UISubAct_wzdjScoreWin",UIWindowBase)









function UISubAct_wzdjScoreWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.itemGridPanel=UIObject.get(self,1)
self.titleTxt=UIText.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_wzdjScoreWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end
















local _this


function UISubAct_wzdjScoreWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_wzdjScoreWin:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_wzdjScoreWin:onHide()

end




function UISubAct_wzdjScoreWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.curTaskIndex=argtable.curTaskIndex
self.curTaskData=self.sub_actInfo:getTaskData(self.curTaskIndex)

self:refreshView()
end

function UISubAct_wzdjScoreWin:refreshView()
local lerp=self.curTaskData:getEndLeftTime()
local isDoing=lerp>0

local taskData=self.curTaskData
self.titleTxt:setText(taskData.name)

local jumplist=taskData.jumplist or{}
self.itemGridPanel:setChildLayoutGroupCreateItems(#jumplist,function(index)
if _this==nil then return end
local item=_this.itemGridPanel:getChildLayoutGroupGridItem(index-1)
local jumpData=jumplist[index]

local jumpParam=jumpData[4]
local showBtn=jumpParam~=nil
item:SetChildActive(2,showBtn)
if showBtn then

item:SetChildImageExGray(2,not isDoing)
item:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onItemGotoClick(index)
end)
end

item:SetChildText(0,jumpData[1])

local tipstr=jumpData[2]
local showTips=tipstr~=nil
item:SetChildActive(3,showTips)
if showTips==true then
item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onItemTipsClick(index)
end)
end

item:SetChildText(1,FMT.fmt('{0}积分',jumpData[3]))
end)
end

function UISubAct_wzdjScoreWin:onItemGotoClick(index)
local lerp=self.curTaskData:getEndLeftTime()
if lerp==0 then
UIManager.error('该阶段已结束')
return
elseif lerp<0 then
UIManager.error('未开启，该阶段正在筹备中')
return
end
local jumpData=self.curTaskData.jumplist[index]
local jumpParam=jumpData[4]
if jumpParam then
jumpManager:jump(jumpParam)
AudioManager.playBtnClick()
end
end

function UISubAct_wzdjScoreWin:onItemTipsClick(index)
local item=self.itemGridPanel:getChildLayoutGroupGridItem(index-1)
local jumpData=self.curTaskData.jumplist[index]
local tipstr=jumpData[2]
local pos=Vector2.New(-15,15)
UIManager:showWindow('UIConditionTipsOne',{str=tipstr,posWidget=item,posWidgetIndex=3,pos=pos})
end

function UISubAct_wzdjScoreWin:onCloseBtn()
self:closeSelf()
end