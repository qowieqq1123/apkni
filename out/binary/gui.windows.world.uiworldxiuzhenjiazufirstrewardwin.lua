







def_class("UIWorldXiuZhenJiaZuFirstRewardWin",UIWindowBase)









function UIWorldXiuZhenJiaZuFirstRewardWin:bindComponents()

self.modelObj=UIObject.get(self,0)
self.nameObj=UIObject.get(self,1)
self.talkdesc=UIText.get(self,2)
self.rewardObj=UIObject.get(self,3)
self.modelImage=UIObject.get(self,4)
self.rewardBtn=UIButton.get(self,5)
self.txtSpeak=UIText.get(self,6)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIWorldXiuZhenJiaZuFirstRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.nameObj);self.nameObj=nil;
_UIObject_release(self.talkdesc);self.talkdesc=nil;
_UIObject_release(self.rewardObj);self.rewardObj=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.txtSpeak);self.txtSpeak=nil;
end



















function UIWorldXiuZhenJiaZuFirstRewardWin:onLoaded(...)
self:bindComponents()
end


function UIWorldXiuZhenJiaZuFirstRewardWin:__delete()
self:unbindComponents()
end




function UIWorldXiuZhenJiaZuFirstRewardWin:onShow(argtable,afterOnloaded)
if not argtable then
return
end
local world=worldModel.world
self.guid=argtable
local familyData=worldXiuZhenJiaZuModel:getFamilyDataByGuid(self.guid)
self.familyData=familyData
local familyId=familyData.familyId

local zuZhangCfg=worldXiuZhenJiaZuModel:getElderConfig(familyId)
local model=worldXiuZhenJiaZuModel:getZuZhangImageInfoInSide(zuZhangCfg.model)
local softmask=nil
self.modelImage:setChildUIModelShowTarget(model.body,1,model.componets,0,false,false)


if not softmask then

self.modelObj:setChildSizeDelta(10000,10000)
else
self.modelObj:setChildSizeDelta(572,572)
end

local nameObjWidget=self.nameObj:getChildWidgetBase()
local name=worldXiuZhenJiaZuModel:getZuZhangName(self.guid)
nameObjWidget:SetChildText(1,name)

local talkList=zuZhangCfg.first_reward_talk
local rand=math.random(1,#talkList)
local talkContent=talkList[rand]
self.txtSpeak:setText(talkContent)

local familyCfg=worldXiuZhenJiaZuModel:getFamilyConfig(familyId)
self.talkdesc:setText(familyCfg.intro)

local rewardwiget=self.rewardObj:getChildWidgetBase()
local firstReward
local initFamilyCfg=cfg_xiuzhenfamilyinitdataconfig()
for i,v in ipairs(initFamilyCfg)do
if v.familyId==familyId then
firstReward=v.helloRewards
break
end
end
local hasreward=firstReward~=nil
rewardwiget:SetChildActive(2,hasreward)
if hasreward then
local grid=rewardwiget:GetChildCommonLayoutGroupWidgetList(0)
for i=1,3 do
local data=firstReward[i]
local item=grid[i-1]
local show=data~=nil
item:SetChildActive(1,show)
if show then
local itemID=data[1]
local num=data[2]
local str=''
if num>0 then
str=tostring(num)
end
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=str~='',showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)
end
end
end
end


function UIWorldXiuZhenJiaZuFirstRewardWin:onHide()

end

function UIWorldXiuZhenJiaZuFirstRewardWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end



function UIWorldXiuZhenJiaZuFirstRewardWin:onRewardBtn()
worldXiuZhenJiaZuController:req_firstReward_xzfamily(worldModel.world,self.guid)
self:closeSelf()
end

function UIWorldXiuZhenJiaZuFirstRewardWin:onBackClick()
self:onRewardBtn()
end