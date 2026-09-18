







def_class("UIQieCuoBattleLoseWin",UIWindowBase)









function UIQieCuoBattleLoseWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.strengthenCreator=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.headdatapanel=UIObject.get(self,3)
self.headIcon=UIButton.get(self,4)
self.headIcontwo=UIButton.get(self,5)
self.selfname=UIText.get(self,6)
self.selfserver=UIText.get(self,7)
self.othername=UIText.get(self,8)
self.otherserver=UIText.get(self,9)
self.shareBtn=UIButton.get(self,10)
self.selfpanel=UIObject.get(self,11)
self.selffrightvalue=UIText.get(self,12)
self.otherpanel=UIObject.get(self,13)
self.otherfrightvalue=UIText.get(self,14)
self.selfimg=UIImage.get(self,15)
self.otherimg=UIImage.get(self,16)

self.headIcon:setButtonClick(function()self:onHeadIcon()end)

self.headIcontwo:setButtonClick(function()self:onHeadIcontwo()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UIQieCuoBattleLoseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.strengthenCreator);self.strengthenCreator=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.headdatapanel);self.headdatapanel=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.headIcontwo);self.headIcontwo=nil;
_UIObject_release(self.selfname);self.selfname=nil;
_UIObject_release(self.selfserver);self.selfserver=nil;
_UIObject_release(self.othername);self.othername=nil;
_UIObject_release(self.otherserver);self.otherserver=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.selfpanel);self.selfpanel=nil;
_UIObject_release(self.selffrightvalue);self.selffrightvalue=nil;
_UIObject_release(self.otherpanel);self.otherpanel=nil;
_UIObject_release(self.otherfrightvalue);self.otherfrightvalue=nil;
_UIObject_release(self.selfimg);self.selfimg=nil;
_UIObject_release(self.otherimg);self.otherimg=nil;
end

















local _this


function UIQieCuoBattleLoseWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIQieCuoBattleLoseWin:__delete()
self:unbindComponents()
_this=nil
end


function UIQieCuoBattleLoseWin:onHide()

end










function UIQieCuoBattleLoseWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end
self:delayDo(0.4,func)
end

self.headdata_param=argtable.headdata_param
local headdata=argtable.headdata_param
if headdata and#headdata>0 then

self.headdatapanel:setActive(true)

local headParams_self
headParams_self={iconInfo=headdata[3],scale=0.8}
playerController:setHeadIcon(self.winlua,self.headIcon:getID(),headParams_self)
self.selfname:setText(headdata[8])
local serverName=loginModel:getServerName(headdata[2])
local str=FMT.fmt('[{0}]',serverName)
self.selfserver:setText(str)

local headParams
headParams={iconInfo=headdata[6],scale=0.8}
playerController:setHeadIcon(self.winlua,self.headIcontwo:getID(),headParams)
self.othername:setText(headdata[7]or'')
local otherserverName=loginModel:getServerName(headdata[5])
local otherstr=FMT.fmt('[{0}]',otherserverName)
self.otherserver:setText(otherstr)
self.shareBtn:setActive(headdata[9])


local selfFright=headdata[10]
local otherFright=headdata[11]
if selfFright then
local value=mathHelper.int64_to_number(selfFright)
self.selfpanel:setActive(true)
self.selffrightvalue:setText(mathHelper.formatNumber(value))
else
self.selfpanel:setActive(false)
end
if otherFright then
local value=mathHelper.int64_to_number(otherFright)
self.otherpanel:setActive(true)
self.otherfrightvalue:setText(mathHelper.formatNumber(value))
else
self.otherpanel:setActive(false)
end
end

self.battleType=argtable.battleType
self.battleId=argtable.battleId

self.parentWin=argtable.parentWin
end

function UIQieCuoBattleLoseWin:refreshStrengthenGrids()
self.jumpData=strengthenController:getStrengthenJumpList(strengthenFunctionType.eFightLose,true)
local jumpCnt=#self.jumpData
self.strengthenCreator:setChildLayoutGroupCreateItems(jumpCnt)
local strengthenGrid=self.strengthenCreator:getChildLayoutGroupGridList()
for i=1,jumpCnt do
local item=strengthenGrid[i-1]
local cfg=self.jumpData[i]
item:SetChildIcon(0,FMT.fmt('icon_sjtp_{0}',cfg.icon),true)
item:SetChildText(1,cfg.name)
item:SetChildButtonClickWithID(2,self.onClickStrengthenItem,i,true)
end
end



function UIQieCuoBattleLoseWin.onClickStrengthenItem(index)
local cfg=_this.jumpData[index]
local jumpParams=_this.jumpParams
local jumpType=cfg.jumpType
local params={disciples=jumpParams.disciples}
local fbid=MysteryModel:get_cur_fbid()
if fbid then
MysteryModel:setQuitNoCloudFlag(true)
end

if _this.parentWin then
if _this.parentWin.isClose then
return
end
local battle=fightModel:getBattle(_this.battleId)
if battle then
battle.jump=true
end
local canClose=_this.parentWin:onCloseTips()
if not canClose then
return
end
end

if fbid then
local disciples={}
local probeTeam=MysteryModel:get_fb_probeTeam()
for i,v in ipairs(probeTeam)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
local dis=UIDiscipleModel:getDiscipleDataX(v.unitId)
if dis then
table.insert(disciples,dis)
end
end
end
if#disciples>0 then
params.disciples=disciples
end
strengthenController:setMysteryLeaveFunc(fbid,jumpType,params)
else
strengthenController:doJump(jumpType,params)
end
end

function UIQieCuoBattleLoseWin:onHeadIcon()

end
function UIQieCuoBattleLoseWin:onHeadIcontwo()

end

function UIQieCuoBattleLoseWin:onShareBtn()
UIManager:showWindow('UIShareQieCuoInfoWin',{guid=self.disciple_guid,headdata=_this.headdata_param,result=2,zhanbao=nil})
end