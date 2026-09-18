







def_class("UIWorldNPCListWin",UIWindowBase)









function UIWorldNPCListWin:bindComponents()

self.hideButton=UIButton.get(self,0)
self.CSGUIScrollView=UIComboScrollView.get(self,1)
self.noNPCSign=UIObject.get(self,2)
self.uiRoot=UIObject.get(self,3)
self.root=UIObject.get(self,4)

self.hideButton:setButtonClick(function()self:onHideButton()end)



end


function UIWorldNPCListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.hideButton);self.hideButton=nil;
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.noNPCSign);self.noNPCSign=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this
local main_index=
{
name=0,
jiantou1=1,
jiantou2=2,
reddot=3,
}
local sub_index=
{
select=0,
name=1,
state=2,
head=3,
dialog=4,
reddot=5,
}
local checkType={
NPC_INTERACT_TYPE.eTalk,NPC_INTERACT_TYPE.ePK,NPC_INTERACT_TYPE.eGift,
}


function UIWorldNPCListWin:onLoaded(...)
_this=self
self:bindComponents()
local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.CSGUIScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)

self:listenNotify(notifyConfig.onNPCIntimacyChange,self.onNPCIntimacyChange)
self:listenNotify(notifyConfig.onNPCIntimacyReward,self.onNPCIntimacyReward)
end


function UIWorldNPCListWin:__delete()
_this=nil
self:unbindComponents()
end

function UIWorldNPCListWin.onNPCIntimacyChange(npcid)
if _this==nil then return end
_this:refreshNPCReddot(npcid)
end

function UIWorldNPCListWin.onNPCIntimacyReward(npcid)
if _this==nil then return end
_this:refreshNPCReddot(npcid)
end




function UIWorldNPCListWin:onShow(argtable,afterOnloaded)
self.winlua:SwitchChildParent(self.root:getID(),worldController:isInWorld()and-1 or self.uiRoot:getID(),false)
if afterOnloaded then
self.m_cav=self:getChildCanvas(-1)
end
argtable=argtable or{}
local npcid=argtable.npcid
if npcid==nil then
npcid=npcController:getStageNPCID()
end

self.allNPCList=npcModel:getWorldAreaNPCList()

local c=#self.allNPCList
self.defaultMainIndex=1
for i,v in ipairs(self.allNPCList)do
local npcItemData=v[1]
local npcData=npcItemData.npcData
if worldModel:isSameWorld(npcData.worldid)then
self.defaultMainIndex=i
break
end
end
if npcid~=nil then
local mainIndex,subIndex=self:getNPCIndex(npcid)
if mainIndex~=nil then
self.defaultMainIndex=mainIndex
self.npcid=npcid
end
end
self.CSGUIScrollView:removeAllGrids()
self.CSGUIScrollView:createMainGrids(c,1,true)
self.noNPCSign:setActive(c<=0)



if npcid~=nil then
npcController:showWorldEntityStage(npcid)
end
end


function UIWorldNPCListWin:onHide()
if self.mainIndex then
self.CSGUIScrollView:clickItem(self.mainIndex-1)
self.mainIndex=nil
end
self.npcid=nil
self.defaultMainIndex=nil
self.allNPCList=nil
self.CSGUIScrollView:removeAllGrids()
end

function UIWorldNPCListWin:refreshSelectNPC(npcid)
if npcid~=nil and self.npcid~=npcid then





local mainIndex,subIndex=self:getNPCIndex(npcid)

self.npcid=npcid
if mainIndex~=nil and self.mainIndex~=mainIndex then
self.CSGUIScrollView:clickItem(mainIndex-1)
end
end
end

function UIWorldNPCListWin:getNPCNum(npcList)
local c=0
if npcList~=nil then
for i,v in ipairs(npcList)do
c=c+#v
end
end
return c
end

function UIWorldNPCListWin:getNPCIndex(npcid)
for i,v in ipairs(self.allNPCList)do
for i2,v2 in ipairs(v)do
if v2.npcid==npcid then
return i,i2
end
end
end
return nil,nil
end


function UIWorldNPCListWin:refreshAllItem()
if self.mainIndex then
self.CSGUIScrollView:clickItem(self.mainIndex-1)
end
self.CSGUIScrollView:removeAllGrids()
self.allNPCList=npcModel:getWorldAreaNPCList()
if self.npcid~=nil then
local mainIndex,subIndex=self:getNPCIndex(self.npcid)
if mainIndex~=nil then
self.defaultMainIndex=mainIndex
self.mainIndex=mainIndex
else
self.npcid=nil
self.defaultMainIndex=1
self.mainIndex=nil
end
end
local c=#self.allNPCList
self.CSGUIScrollView:createMainGrids(c,1,true)
self.noNPCSign:setActive(c<=0)
if self.mainIndex then
self.CSGUIScrollView:clickItem(self.mainIndex-1)
end
end

function UIWorldNPCListWin:refreshSubItem(npcid)
local mainIndex,subIndex=UIWorldNPCListWin:getNPCIndex(npcid)
if mainIndex and subIndex then
local subItem=self.CSGUIScrollView:getSubItem(mainIndex-1,subIndex-1)
if subItem then
self:refreshSubItemInfo(subItem,npcid)
end
end
end

function UIWorldNPCListWin:cancelSubItemSelect(npcid_)
if self.npcid==npcid_ then
if npcid_ then


self.npcid=nil
end
end
end

function UIWorldNPCListWin:refreshMainItemSelect(mainItem,mainIndex,flag)
if mainItem==nil then
mainItem=self.CSGUIScrollView:getMainItem(mainIndex-1)
end
if mainItem then
mainItem:SetChildActive(main_index.jiantou1,not flag)
mainItem:SetChildActive(main_index.jiantou2,flag)
end
end

function UIWorldNPCListWin:refreshSubItemSelect(subItem,mainIndex,subIndex,flag)
if subItem==nil then
subItem=self.CSGUIScrollView:getSubItem(mainIndex-1,subIndex-1)
end
if subItem then
subItem:SetChildActive(sub_index.select,flag)
end
end

function UIWorldNPCListWin:refreshNPCReddot(npcid)
if self.allNPCList==nil then return end
local mainIndex,subIndex=self:getNPCIndex(npcid)
if mainIndex~=nil then
local mainItem=self.CSGUIScrollView:getMainItem(mainIndex-1)
if mainItem then
self:refreshMainItemReddot(mainItem)
end
if subIndex then
local subItem=self.CSGUIScrollView:getSubItem(mainIndex-1,subIndex-1)
if subItem then
self:refreshSubItemInfo(subItem,npcid)
end
end
end
end



function UIWorldNPCListWin:mainClickAction(mainItem)
local oldMainIndex=self.mainIndex
local index=mainItem.Index+1
if index==oldMainIndex then
if oldMainIndex~=nil then
self:refreshMainItemSelect(nil,oldMainIndex,false)
self.mainIndex=nil
end
return
end
self.mainIndex=index
self:refreshMainItemSelect(mainItem,index,true)
if oldMainIndex~=nil then
self:refreshMainItemSelect(nil,oldMainIndex,false)
end
end

function UIWorldNPCListWin:subClickAction(subItem)
local subIndex=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local npclist=self.allNPCList[mainIndex]
local npcItemData=npclist[subIndex]
local npcData=npcItemData.npcData
local npcid=npcItemData.npcid
local old_npcid=self.npcid
self.npcid=npcid

local ischange=old_npcid~=npcid
if ischange then


if old_npcid~=nil then
local oldMainIndex,oldSubIndex=self:getNPCIndex(old_npcid)
self:refreshSubItemSelect(nil,oldMainIndex,oldSubIndex,false)
end
self:refreshSubItemSelect(subItem,mainIndex,subIndex,true)


if not npcController.checkNPCOpen(true)then
return
end
end

if worldModel.world~=npcData.worldid then
local worldName=cfgHelper.get2(cfg_worldconfig_get,npcData.worldid,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local func=function(flag_)
if flag_ then
npcController:showWorldEntityStage(npcid)
end
end
cameraMoveController:Begin({eSceneType.eWorld,npcData.worldid},nil,func)
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else
npcController:showWorldEntityStage(npcid)
end
end

function UIWorldNPCListWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local npclist=self.allNPCList[index]
if npclist then
local npcItemData=npclist[1]
local npcData=npcItemData.npcData
local name=cfgHelper.get2(cfg_worldconfig_get,npcData.worldid,'name')
mainItem:SetChildText(main_index.name,name)


self:refreshMainItemSelect(mainItem,index,false)

self:refreshMainItemReddot(mainItem)

mainItem:SetAddExpandColumCount(#npclist)
if index==#self.allNPCList then
if self.defaultMainIndex~=nil then
self.CSGUIScrollView:clickItem(self.defaultMainIndex-1)
self.defaultMainIndex=nil
end
end
end
end

function UIWorldNPCListWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local npclist=self.allNPCList[mainIndex]
local npcItemData=npclist[index]
local npcid=npcItemData.npcid
local imagecfg=npcModel:getNPCImageCfg(npcid)


subItem:SetChildText(sub_index.name,imagecfg.name)

comHelper.setChildModelRawImage_npc(subItem,imagecfg.id,sub_index.head,0,eHeadCenterType.eHead)

subItem:SetChildNewBieComponentId(-1,FMT.fmt('UIWorldNPCListWin.itemPrefab.subItem.{0}',index))

self:refreshSubItemInfo(subItem,npcid)
self:refreshSubItemSelect(subItem,mainIndex,index,false)
end


function UIWorldNPCListWin:onExpandAction(index)
self.npcid=nil
end

function UIWorldNPCListWin:refreshMainItemReddot(mainItem)
local index=mainItem.Index+1
local isReddot=false
local npclist=self.allNPCList[index]
if npclist then
for i,npcItemData in ipairs(npclist)do
local npcid=npcItemData.npcid
isReddot=npcModel:checkIntimacyReward(npcid)~=nil
break
end
end
mainItem:SetChildActive(main_index.reddot,isReddot)
end

function UIWorldNPCListWin:refreshSubItemInfo(subItem,npcid)
local intimacy=npcModel:getNPCIntimacy(npcid)
local hgdStr=npcModel.getHaoGanDuName2(intimacy)
subItem:SetChildText(sub_index.state,hgdStr)

local showEvent=npcModel:checkIntimacyReward(npcid)~=nil
local showDiaLog=false
for i,v in ipairs(checkType)do
local temp=npcModel:checkInteractTypeEnough(npcid,v,false)
if temp then
showDiaLog=true
break
end
end
local iconname
if showEvent then
iconname='icon_gantanhao_1'
elseif showDiaLog then
iconname='icon_tyduihuadian_1'
end
local isShow=iconname~=nil
subItem:SetChildActive(sub_index.dialog,isShow)
if isShow then
subItem:SetChildCSImageSprite(sub_index.dialog,globalABLookup.global,iconname)
end
end

function UIWorldNPCListWin:getTalkCanvas()
return{self.m_cav[1],self.m_cav[2]+1}
end

function UIWorldNPCListWin:onHideButton()
worldController:resetLeftView()
end