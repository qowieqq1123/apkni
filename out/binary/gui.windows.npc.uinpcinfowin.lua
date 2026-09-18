







def_class("UINPCInfoWin",UIWindowBase)









function UINPCInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.roleListPanel=UIScrollView.get(self,1)
self.modelRoot=UIObject.get(self,2)
self.jingjieTxt=UIText.get(self,3)
self.hgdNameTxt=UIText.get(self,4)
self.rewardObj=UIObject.get(self,5)
self.descTxt=UIText.get(self,6)
self.posText=UIText.get(self,7)
self.posLine=UIObject.get(self,8)
self.rewardScrollview=UIObject.get(self,9)
self.rewardTips=UIObject.get(self,10)
self.jobIcon=UIImage.get(self,11)
self.nameTxt=UIText.get(self,12)
self.hgdProgressYellow=UIObject.get(self,13)
self.hgdNumText=UIText.get(self,14)
self.desc2Text=UIText.get(self,15)
self.desc3Text=UIText.get(self,16)
self.rewardTipsTxt=UIText.get(self,17)



end


function UINPCInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.jingjieTxt);self.jingjieTxt=nil;
_UIObject_release(self.hgdNameTxt);self.hgdNameTxt=nil;
_UIObject_release(self.rewardObj);self.rewardObj=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.posText);self.posText=nil;
_UIObject_release(self.posLine);self.posLine=nil;
_UIObject_release(self.rewardScrollview);self.rewardScrollview=nil;
_UIObject_release(self.rewardTips);self.rewardTips=nil;
_UIObject_release(self.jobIcon);self.jobIcon=nil;
_UIObject_release(self.nameTxt);self.nameTxt=nil;
_UIObject_release(self.hgdProgressYellow);self.hgdProgressYellow=nil;
_UIObject_release(self.hgdNumText);self.hgdNumText=nil;
_UIObject_release(self.desc2Text);self.desc2Text=nil;
_UIObject_release(self.desc3Text);self.desc3Text=nil;
_UIObject_release(self.rewardTipsTxt);self.rewardTipsTxt=nil;
end

















function UINPCInfoWin:onLoaded(...)
self:bindComponents()
self._on_select_role=function(...)
self:on_select_role(...)
end
self.roleListPanel:setClickAction(self._on_select_role)
end


function UINPCInfoWin:__delete()
self:unbindComponents()
end


function UINPCInfoWin:onHide()

end




function UINPCInfoWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin

if argtable.canvasIdx then
self:setCanvasIndex(-1,argtable.canvasIdx)
end

local list=npcModel:getAllUnlockNPC(true)
if#list>1 then
table.sort(list,function(a,b)
return a<b
end)
end
self.npcList=list

local npcid=argtable.npcid
if npcid~=nil then
for i,npcid_ in ipairs(list)do
if npcid_==npcid then
self.selectIndex=i
break
end
end
self.selectNPC=npcid
else
self.selectIndex=1
self.selectNPC=list[self.selectIndex]
end
self:refreshDiscipleList()
self:refreshInfo()
end

function UINPCInfoWin:refreshDiscipleList()
local tNum=#self.npcList
self.roleListPanel:freshGridsNum(tNum,tNum,1,true)
local idx=1
for i=1,tNum do
local item=self.roleListPanel:getGridObjectByindex(i-1)
local npcid=self.npcList[i]
local npcItemData=npcModel:getNPCItemData(npcid)
local imagecfg=npcModel:getNPCImageCfg(npcid)

local bgName='button_dizipinzhi_0'
item:SetChildCSImageSprite(0,globalABLookup.global,bgName)

comHelper.setChildModelRawImage_npc(item,imagecfg.id,1,0,eHeadCenterType.eHead)

item:SetChildActive(4,true)
item:SetChildText(5,imagecfg.name)

local isSelect=self.selectNPC==npcid
if isSelect then
idx=i
self.selectIndex=idx
end
self:changItemSelect(item,isSelect)

end
self.roleListPanel:jumpToLockX(idx)
end

function UINPCInfoWin:changItemSelect(item,isSelect)
item:SetChildActive(3,isSelect)
end

function UINPCInfoWin:on_select_role(id,index,guid,attach)
if self.selectIndex==index then return end

local old=self.selectIndex
self.selectIndex=index
if old then
local olditem=self.roleListPanel:getGridObjectByindex(old-1)
self:changItemSelect(olditem,false)
end
local item=self.roleListPanel:getGridObjectByindex(self.selectIndex-1)
self:changItemSelect(item,true)

local npcid=self.npcList[index]
self.selectNPC=npcid

self:refreshInfo()
end

function UINPCInfoWin:refreshInfo()
local npcid=self.npcList[self.selectIndex]
local npcItemData=npcModel:getNPCItemData(npcid)
local hasNPC=npcItemData~=nil
local imagecfg=npcModel:getNPCImageCfg(npcid)
local npccfg=cfgHelper.get1(cfg_npcconfig_get,npcid)

self.nameTxt:setText(imagecfg.name)

local jobid=npcModel:getNPCJob(npcid)
local jobicon=UIDiscipleModel:getJobIconName(jobid)
self.jobIcon:setSprite(globalABLookup.global,jobicon)

self.modelRoot:setChildUIModelRemoveTarget()
local modelParams=npcModel:getImageInfo(imagecfg.id)
comHelper.setChildInSideModelEx(self.modelRoot,modelParams,0.85,0,0,0,false,true)

local jjlv=npcModel:getNPCJingJie(npcid)
local jjname=UIDiscipleModel.getJJNameCommon(jjlv,3)
self.jingjieTxt:setText(jjname)

self.descTxt:setText(npcModel:getNPCDesc(npcid))

local hgd=npcModel:getNPCIntimacy(npcid)
local hgdname=npcModel.getHaoGanDuName(hgd)
self.hgdNameTxt:setText(hgdname)

local lv,rate,cur,max,isFull=npcModel.getHaoGanDuLevel(hgd)
if isFull then
rate=1
end
self.hgdProgressYellow:setChildIconFillAmount(0)
helper.playProgressAnim(self.hgdProgressYellow,rate,0,nil,nil,nil,0.2)

local numstr
if not isFull then
numstr=FMT.fmt('{0}/{1}',cur,max)
else
numstr='已满'
end
self.hgdNumText:setText(numstr)

local lovestr=FMT.fmt('<color=#7d3b17>喜好：</color>{0}',npccfg.lovestr)
self.desc2Text:setText(lovestr)

local hatestr=FMT.fmt('<color=#7d3b17>厌恶：</color>{0}',npccfg.hatestr)
self.desc3Text:setText(hatestr)

local goodlist
if hasNPC then
local roomID=xianzhanModel:getNPCInRoom(npcid)
if roomID then
goodlist=xianzhanModel:roomCustomerGoods2NPC(roomID)or{}
else
if npcItemData.bagList then
goodlist=table.deepCopy(npcItemData.bagList)
else
goodlist={}
end
end
else
goodlist={}
end
local num=#goodlist
if num>1 then
for i,v in ipairs(goodlist)do
local itemConfig=itemsConfig.getConfig(v.itemid)
v.color=itemConfig.color
end
table.sort(goodlist,function(a,b)
return a.color>b.color
end)
end

local showGoods=num>0
self.rewardScrollview:setActive(showGoods)
self.rewardTips:setActive(not showGoods)
if showGoods then
local goodnum=num
if goodnum<5 then goodnum=5 end
self.rewardScrollview:setChildScrollViewCreateGrids(goodnum,goodnum)
local grids=self.rewardScrollview:getChildScrollViewItemWidgets()
for i=1,goodnum do
local item=grids[i-1]
local widget=item:GetChildWidgetBase(0)
local good=goodlist[i]
local isShow=good~=nil
item:SetChildActive(0,isShow)
item:SetChildActive(1,not isShow)
if isShow then
local count=good.itemcount
local itemid=good.itemid
local itemguid=good.itemguid
local countStr=count>1 and mathHelper.formatNumber(count)or''
local showCountBG=count>1
local conf={itemid=itemid,showCountBG=showCountBG,itemcount=countStr,showStage=true,showname=false,
itemguid=itemguid,itemIndex=i}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
end
end
else
self.rewardTipsTxt:setText('不知晓其储物袋中的道具')
end

local pos_str
local title_str='所在位置：'
if hasNPC then
local npcData=npcItemData.npcData
local groupType=NPC_TYPE:getNPCGroupType(npcData.npctype)
local name
if groupType==NPC_GROUP_TYPE.eWorld then
name=cfgHelper.get3(cfg_worldblockconfig_get,npcData.worldid,npcData.blockid,'name')
elseif groupType==NPC_GROUP_TYPE.eZongMen then
name=cfgHelper.get2(cfg_monijysfconfig_get,npcData.sfid,'name')

end
pos_str=FMT.fmt('{0}<color=#549327>{1}</color>',title_str,name)
else
pos_str=FMT.fmt('{0}{1}',title_str,'不知所踪')
end
self.posText:setText(pos_str)
self.posLine:setActive(hasNPC)
end

function UINPCInfoWin:onItemClick(id,index,guid,attach)
itemsComponentHelper.onItemClick(id,index,guid,attach)
end

function UINPCInfoWin:onPosClick()
local npcid=self.npcList[self.selectIndex]
local npcItemData=npcModel:getNPCItemData(npcid)
local hasNPC=npcItemData~=nil
if hasNPC then
if not npcController.checkNPCOpen(true)then
return
end
local npcData=npcItemData.npcData
local groupType=NPC_TYPE:getNPCGroupType(npcData.npctype)
if groupType==NPC_GROUP_TYPE.eWorld then

local callBack=function(flag_)
if flag_ then
npcController:showWorldEntityStage(npcid)

end
end
cameraMoveController:Begin({eSceneType.eWorld,npcData.worldid},nil,callBack)
elseif groupType==NPC_GROUP_TYPE.eZongMen then

cameraMoveController:Begin({eSceneType.eZongmen,npcData.sfid})
end
self.parentWin:onClickClose()
if UIManager:isActive('UINPCSelectWin')then
UIFullSectPalaceControl:closeUI()
end
end
end

function UINPCInfoWin:onRelationBtn()
local npcid=self.npcList[self.selectIndex]
UIManager:showWindow('UINPCRelationWin',{npcid=npcid})
end