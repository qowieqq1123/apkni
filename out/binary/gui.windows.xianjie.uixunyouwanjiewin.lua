







def_class("UIXunYouWanJieWin",UIWindowBase)









function UIXunYouWanJieWin:bindComponents()

self.bgeffect=UIObject.get(self,0)
self.BGeffect2=UIObject.get(self,1)
self.bgmodel=UIObject.get(self,2)
self.bgmodel2=UIObject.get(self,3)
self.btneffect=UIObject.get(self,4)
self.btnmodel=UIObject.get(self,5)
self.CanClick=UIObject.get(self,6)
self.chooseGrid=UIObject.get(self,7)
self.chooseView=UIObject.get(self,8)
self.closeButton=UIButton.get(self,9)
self.havenum=UIText.get(self,10)
self.itemlist=UIObject.get(self,11)
self.monsterDetailBtn=UIButton.get(self,12)
self.peoplemodel=UIObject.get(self,13)
self.root1=UIObject.get(self,14)
self.select=UIToggleButton.get(self,15)
self.setScale=UIObject.get(self,16)
self.souxunBtn=UIButton.get(self,17)
self.timeimg=UIObject.get(self,18)
self.timetext=UIText.get(self,19)
self.title=UIObject.get(self,20)
self.wanfabtn=UIButton.get(self,21)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXunYouWanJieWin")end)

self.monsterDetailBtn:setButtonClick(function()self:onMonsterDetailBtn()end)

self.souxunBtn:setButtonClick(function()self:onSouxunBtn()end)

self.wanfabtn:setButtonClick(function()self:onWanfabtn()end)



end


function UIXunYouWanJieWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgeffect);self.bgeffect=nil;
_UIObject_release(self.BGeffect2);self.BGeffect2=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.bgmodel2);self.bgmodel2=nil;
_UIObject_release(self.btneffect);self.btneffect=nil;
_UIObject_release(self.btnmodel);self.btnmodel=nil;
_UIObject_release(self.CanClick);self.CanClick=nil;
_UIObject_release(self.chooseGrid);self.chooseGrid=nil;
_UIObject_release(self.chooseView);self.chooseView=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.havenum);self.havenum=nil;
_UIObject_release(self.itemlist);self.itemlist=nil;
_UIObject_release(self.monsterDetailBtn);self.monsterDetailBtn=nil;
_UIObject_release(self.peoplemodel);self.peoplemodel=nil;
_UIObject_release(self.root1);self.root1=nil;
_UIObject_release(self.select);self.select=nil;
_UIObject_release(self.setScale);self.setScale=nil;
_UIObject_release(self.souxunBtn);self.souxunBtn=nil;
_UIObject_release(self.timeimg);self.timeimg=nil;
_UIObject_release(self.timetext);self.timetext=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.wanfabtn);self.wanfabtn=nil;
end


















local _this=nil
local abname='ui/windows/xianjie/xg_xunyouwanjie_atlas_pak.ab'
local beginpos=-166
local endpos=-20.3

function UIXunYouWanJieWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onTeQuanInfoChange,self.onTeQuanInfoChange)

end


function UIXunYouWanJieWin:__delete()
self:unbindComponents()
end




function UIXunYouWanJieWin:onShow(argtable,afterOnloaded)
self.jobflag,self.id=xianguanController:checkSelfHasJobByType(5)
_this.tqId=14
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgmodel2:getID(),false,true,false)
self.peoplemodel:setChildUIModelShowTarget(5552,1,{},eAnimationID.idle)
self.bgmodel:setChildUIModelShowTarget(6090,1,{},eAnimationID.idle)
self.bgmodel2:setChildUIModelShowTarget(6091,1,{},eAnimationID.idle)
self.btnmodel:setChildUIModelShowTarget(6092,1,{},eAnimationID.idle)
if self.mytimer==nil then
_this:updateTime()
self.mytimer=self:setTimer(1,0,function()
_this:updateTime()
end)
end
self:refreshwin()
self:refreshSkipBtn()
local arrs=self:getChildCanvas(-1)
local sortLayer=arrs[1]
local sortOrder=arrs[2]-1
self:showWindow("UIRawImageBackWin",{sortLayer=sortLayer,sortOrder=sortOrder})
self.CanClick:setActive(false)
local showMonsterDetail=xianguanHelper.checkTeQuanPlatformLimit(XIANGUAN_PRIVILEGE_ENUM.eXunYouWanJie)
self.monsterDetailBtn:setActive(showMonsterDetail)
end

function UIXunYouWanJieWin:refreshSkipBtn()
local typo=ACTOR_SETTING_TYPE.eXunYouWanJie
local data=userActorArraySetting.getBase(typo,{})
local flag=data['1']==true
self.Skip=flag
data['1']=flag


self.select:setToggle(self.Skip)
self.select:setToggleChange(function(name,isOn)
self.Skip=isOn

self:onSkipBtn()
end)
end

function UIXunYouWanJieWin:onHide()

end
function UIXunYouWanJieWin:refreshAll()


end

function UIXunYouWanJieWin:refreshwin()
local cfglist=cfg_xianguanxianxutypeconfig()
local fatherwid=self.itemlist:getWidgetBase()





for i=0,2 do

local cfg=cfglist[i+1]
local node=fatherwid:GetChildWidgetBase(i)
local rewardlist=cfg.rewardlist
node:SetChildScrollViewCreateGrids(1,#rewardlist,#rewardlist)
local childgrids=node:GetChildScrollViewItemWidgets(1)
local childcount=childgrids.Count
for child=0,childcount-1 do
local childnode=childgrids[child]
local data=rewardlist[child+1]
local num=data[2]
widgetHelper.setNormalRewardItem(childnode,0,{data[1],num})
end
local modelSet=cfg.modelSet
node:SetChildUIModelShowTarget(2,modelSet[1],modelSet[2],nil,eAnimationID.stand)
node:SetChildUIModelShowTargetOffset(2,modelSet[3],modelSet[4])
node:SetChildText(4,(cfg.probability*100).."%")
node:SetChildCSImageSprite(5,abname,cfg.name)
node:SetChildCSImageSprite(3,abname,cfg.probability_bgimg)
end
end


function UIXunYouWanJieWin:updateTime()
if not _this then
return
end
_this.jobflag,_this.id=xianguanController:checkSelfHasJobByType(5)
if not _this.jobflag then
return
end
local times=xianguanModel:callTeQuanObjFunc(self.id,_this.tqId,"getTimes")
local alltimes=xianguanConfig.getTeQuanCfg(_this.tqId,"times")
local getCd=xianguanModel:callTeQuanObjFunc(_this.id,_this.tqId,"getCd")
if times and times>=alltimes then
_this.timetext:setText("本周次数：")
_this.timeimg:setActive(false)
_this.havenum:setText(string.format("<color=#c82c2c>%d/%d</color>",times,alltimes))
else
if getCd and getCd~=0 then

local nowtime=timeHelper.getServerShortTime()
local lerp=getCd-nowtime
local time_str
if lerp>0 then
time_str=timeHelper.format_time_stamp2(lerp)
_this.timetext:setText("搜寻冷却：")
_this.timeimg:setActive(true)
_this.havenum:setText(string.format("%s",time_str))
else
local times=xianguanModel:callTeQuanObjFunc(self.id,_this.tqId,"getTimes")
local alltimes=xianguanConfig.getTeQuanCfg(_this.tqId,"times")
_this.timetext:setText("本周次数：")
_this.timeimg:setActive(false)
if times>=alltimes then
_this.havenum:setText(string.format("<color=#c82c2c>%d/%d</color>",times,alltimes))
else
_this.havenum:setText(string.format("%d/%d",times,alltimes))
end
end
else
_this.timetext:setText("本周次数：")
_this.timeimg:setActive(false)
if times==alltimes then
_this.havenum:setText(string.format("<color=#c82c2c>%d/%d</color>",times,alltimes))
else
if not times or not alltimes then
_this.havenum:setText(string.format("%d/%d",0,0))
return
end
_this.havenum:setText(string.format("%d/%d",times,alltimes))
end
end
end


end


function UIXunYouWanJieWin:PlayerEffect()
self.bgmodel2:setChildModelAnimationState(eAnimationID.shop_null_to_create)
self.itemlist:setChildCanvasGroupDOFade(0,0.5)
self:delayDo(0.5,function()
self.bgeffect:setChildShowEffect(22638,true)
self.BGeffect2:setChildShowEffect(22641,true)
self.peoplemodel:setChildDOLocalMoveY(endpos,1)
self:delayDo(1,function()
self.peoplemodel:setChildCanvasGroupDOFade(0,1)
self.setScale:setChildDOScale(0,1)

end)
end)

end
function UIXunYouWanJieWin:onSouxunBtn()
self.jobflag,self.id=xianguanController:checkSelfHasJobByType(5)
if not self.jobflag then
UIManager.info("您已失去界游仙君官职，操作失败")
return
end
local state=xianguanHelper.checkTeQuanUseCondition(self.id,_this.tqId,true)
if not state then
return
end
self.btneffect:setChildShowEffect(22639,true)
self.btnmodel:setChildUIModelShowTarget(6092,1,{},eAnimationID.shop_null_to_create)
if not self.Skip then
self.CanClick:setActive(true)
self:PlayerEffect()
self:delayDo(6,function()
xianguanConfig.getJobConfig(nil,self.id)
xianguanController.sendUsePrivilege(self.id,_this.tqId)

end)
self:delayDo(7,function()
self.CanClick:setActive(false)
end)

else
xianguanConfig.getJobConfig(nil,self.id)
xianguanController.sendUsePrivilege(self.id,_this.tqId)
end

end


function UIXunYouWanJieWin.onTeQuanInfoChange(tqData)
if _this==nil then return end
local tqid=tqData.tqid
if tqid==_this.tqId then
_this:refreshAll()
UIManager:showWindow('UIXunYouWanJie_showXX',tqData)
_this.bgmodel2:setChildModelAnimationState(eAnimationID.idle)
_this.itemlist:setChildCanvasGroupDOFade(1,0)

_this.peoplemodel:setChildDOLocalMoveY(beginpos,0)
_this.peoplemodel:setChildCanvasGroupDOFade(1,0)
_this.setScale:setChildDOScale(1,0)

end

end


function UIXunYouWanJieWin:onMonsterDetailBtn()
UIManager:showWindow("UIXianJie_monsterRewardDetailWin",{type=xjServerEnityType.eMonsterHouse,menuType_c=2})
self:closeSelf()
end


function UIXunYouWanJieWin:onWanfabtn()
local d={}
d.title='规则'
d.mode=3
d.name='XunYouWanJie_help_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIXunYouWanJieWin:onSkipBtn()
local typo=ACTOR_SETTING_TYPE.eXunYouWanJie
local data={}
data['1']=self.Skip
userActorArraySetting.setBase(typo,data)
userActorArraySetting.flush(typo)
end

