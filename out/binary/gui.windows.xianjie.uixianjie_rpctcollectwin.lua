







def_class("UIXianJie_RPCtCollectWin",UIWindowBase)









function UIXianJie_RPCtCollectWin:bindComponents()

self.cdBg=UIObject.get(self,0)
self.cdTx=UIText.get(self,1)
self.commitBtn=UIButton.get(self,2)
self.costBg=UIObject.get(self,3)
self.costIcon=UIImage.get(self,4)
self.costNum=UIText.get(self,5)
self.costTimeTxt=UIText.get(self,6)
self.mask=UIButton.get(self,7)
self.monsterIcon=UIObject.get(self,8)
self.monsterKuang=UIImage.get(self,9)
self.monsterLvBg=UIImage.get(self,10)
self.monsterLvTx=UIText.get(self,11)
self.monsterName=UIText.get(self,12)
self.monsterSourceTx=UIText.get(self,13)
self.posTxt=UIText.get(self,14)
self.recommendedTxt=UIText.get(self,15)
self.recordBtn=UIButton.get(self,16)
self.rewardPanel=UIObject.get(self,17)
self.root=UIObject.get(self,18)
self.ruleBtn=UIButton.get(self,19)
self.showRewardBtn=UIButton.get(self,20)
self.stateLayout=UIObject.get(self,21)
self.stateTimeTxt=UIText.get(self,22)
self.stateTxt=UIText.get(self,23)
self.xgdesc=UIText.get(self,24)
self.jnrankItem=UIObject.get(self,25)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.showRewardBtn:setButtonClick(function()self:onShowRewardBtn()end)



end


function UIXianJie_RPCtCollectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cdBg);self.cdBg=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costTimeTxt);self.costTimeTxt=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.monsterIcon);self.monsterIcon=nil;
_UIObject_release(self.monsterKuang);self.monsterKuang=nil;
_UIObject_release(self.monsterLvBg);self.monsterLvBg=nil;
_UIObject_release(self.monsterLvTx);self.monsterLvTx=nil;
_UIObject_release(self.monsterName);self.monsterName=nil;
_UIObject_release(self.monsterSourceTx);self.monsterSourceTx=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.recommendedTxt);self.recommendedTxt=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.showRewardBtn);self.showRewardBtn=nil;
_UIObject_release(self.stateLayout);self.stateLayout=nil;
_UIObject_release(self.stateTimeTxt);self.stateTimeTxt=nil;
_UIObject_release(self.stateTxt);self.stateTxt=nil;
_UIObject_release(self.xgdesc);self.xgdesc=nil;
_UIObject_release(self.jnrankItem);self.jnrankItem=nil;
end















local _this=nil
local _colorKuang={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.BigBoss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_5",
}
local itemidex=
{
itemself=0,
reScrollview=1,
rwItemlist={2,3,4}
}



function UIXianJie_RPCtCollectWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
self:addNotify(notifyConfig.onXianJieResPointDataChange,self.onXianJieResPointDataChange)
self:addNotify(notifyConfig.onXianJieResPointMarchChange,self.onXianJieResPointMarchChange)
end


function UIXianJie_RPCtCollectWin:__delete()
self:unbindComponents()
_this=nil


xianjieController:closeWin2(self.__name)
local rpData=xianjieModel:getResPointData(self.guid)
if rpData then
rpData:selectEntity(false)
end
end




function UIXianJie_RPCtCollectWin:onShow(argtable,afterOnloaded)
self.guid=argtable.guid
self:refreshView()
if afterOnloaded then
local rpData=xianjieModel:getResPointData(self.guid)
if rpData then
rpData:selectEntity(true)
end
end
end


function UIXianJie_RPCtCollectWin:onHide()

end

function UIXianJie_RPCtCollectWin:onShowArgRecv(argtable)
local oldGuid=self.guid
if oldGuid and oldGuid~=argtable.guid then
local data=xianjieModel:getResPointData(oldGuid)
if data then
data:selectEntity(false)
end
data=xianjieModel:getResPointData(argtable.guid)
if data then
data:selectEntity(true)
end
end
self:onShow(argtable,false)
end




function UIXianJie_RPCtCollectWin:onCommitBtn()
local _guid=self.guid
local _taskId=self._taskId

local data=xianjieModel:getResPointData(_guid)
local cfg=data:getCfg()
local choiceslist=cfg.choices
if#choiceslist==1 then
self:showWindow("UIXJ_RPCtOnlyWin",{guid=_guid,taskId=_taskId})
else
self:showWindow("UIXJ_RPCtOneWin",{guid=_guid,taskId=_taskId})
end
end


function UIXianJie_RPCtCollectWin:onMask()
xianjieController:closeWin('UIXianJie_RPCtCollectWin')
end

function UIXianJie_RPCtCollectWin:onRecordBtn()
local data=xianjieModel:getResPointData(self.guid)
if data then
local cfg=data:getCfg()
local _nameStr=cfg.name or"提交资源采集点"
local temp=
{
gridX=self.sharex,
gridZ=self.sharez,
Point_Share=xianjie_Point_Share.dhcaijidian,
nameStr=_nameStr,
sharename=_nameStr,
ishujian=false,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end
end
function UIXianJie_RPCtCollectWin:onRuleBtn()



local d={}
d.title='规则'
d.mode=3
d.name='UIXianJie_RPCtCollectWin_help_%d'
d.showBlack=true
self:showWindow('UIRuleWin',d)
end

function UIXianJie_RPCtCollectWin:onShowRewardBtn()
local data=xianjieModel:getResPointData(self.guid)
local cfg=data:getCfg()
local args={
parentWin=self,
dropId=cfg.drop_id,
}
self:showWindow("UIXianJie_RPMonsterDropWin",args)
end


function UIXianJie_RPCtCollectWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end
function UIXianJie_RPCtCollectWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end
function UIXianJie_RPCtCollectWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then return end
_this:onMask()
end
function UIXianJie_RPCtCollectWin.onXianJieResPointDataChange(etype,guid)
if _this.guid==guid then
if etype==xjResPointChangeEventType.eDelete then
_this:onMask()
end
end
end
function UIXianJie_RPCtCollectWin.onXianJieResPointMarchChange(etype,guid)
if _this.guid==guid then
_this:refreshMarchInfo()
end
end



function UIXianJie_RPCtCollectWin:refreshView()
local data=xianjieModel:getResPointData(self.guid)
local cfg=data:getCfg()



self.winlua:SetChildIcon(self.monsterIcon:getID(),cfg.headimage,true)
self.monsterName:setText(cfg.name or"")
self.xgdesc:setText(cfg.npcdesc or"")

local taskid
if data.source and data.source.srctype==xjResPointSourceType.eXianBangTask then
taskid=data.source.taskid
self._taskId=taskid
end
if taskid then
local taskcfg=cfg_xianbangtaskconfig_get(taskid)
if taskcfg and taskcfg.color then
self.monsterKuang:setSprite(globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",taskcfg.color))
end
end


local gridX_c,gridZ_c=data:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c


local rewardList=cfg.rewards or{}
self.rewardPanel:setChildLayoutGroupCreateItems(#rewardList,function(index)
local rewardItem=self.rewardPanel:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardList[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local showCountBG=rewardNum>1 or rewardData.range~=nil
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or""
local conf={itemid=rewardId,itemcount=countStr,showname=false,showCountBG=showCountBG,range=rewardData.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
rewardItem:SetChildActive(1,rewardData.range~=nil and rewardNum<0)
end)

self:freshrwinfo(cfg)
end



function UIXianJie_RPCtCollectWin:freshrwinfo(cfg)
local choiceslist=cfg.choices
local item=self.jnrankItem:getWidgetBase()
local choicedata=choiceslist[1]
local len2=#choicedata


for idx=1,len2 do
local widget=item:GetChildWidgetBase(itemidex.rwItemlist[idx])
local data=choicedata[idx]
if data then
widget:SetChildActive(0,true)
local itemid=data[1]
local itemnum=data[2]
local itemcount=""
local havecount=0
local graynum=0
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end
local str2=mathHelper.formatNumber7(itemnum,nil,2)
if havecount>=itemnum then
itemcount=FMT.fmt('<color=#aae252>{0}</color>',str2)
else
itemcount=FMT.fmt('<color=#f36666>{0}</color>',str2)
graynum=0
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=true,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(1,prop)
widget:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
self:onClickItem(...)
end)
end
end
end

function UIXianJie_RPCtCollectWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end