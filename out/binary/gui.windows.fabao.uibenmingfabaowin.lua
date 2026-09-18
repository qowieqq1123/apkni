







def_class("UIBenMingFabaoWin",UIWindowBase)









function UIBenMingFabaoWin:bindComponents()

self.root=UIObject.get(self,0)
self.effect2=UIObject.get(self,1)
self.previewRoot=UIObject.get(self,2)
self.btnLianzhi=UIButton.get(self,3)
self.effect3=UIObject.get(self,4)
self.costRoot=UIObject.get(self,5)
self.parent=UIObject.get(self,6)
self.effect1=UIObject.get(self,7)
self.items_1=UIBaseItem.get(self,8)
self.items_2=UIBaseItem.get(self,9)
self.ypicon=UIImage.get(self,10)
self.fbIcon1=UIImage.get(self,11)
self.fbIcon2=UIImage.get(self,12)
self.fbIcon3=UIImage.get(self,13)
self.fbicon=UIObject.get(self,14)
self.fabaoClick=UIButton.get(self,15)
self.itemYuanPei=UIBaseItem.get(self,16)
self.itemFaBaoSlot_2=UIBaseItem.get(self,17)
self.itemFaBaoSlot_3=UIBaseItem.get(self,18)
self.itemFaBaoSlot_1=UIBaseItem.get(self,19)
self.model=UIObject.get(self,20)
self.dzname=UIText.get(self,21)
self.dzBtn=UIButton.get(self,22)
self.btnSelect=UIObject.get(self,23)
self.bgModel=UIObject.get(self,24)
self.modelClick=UIButton.get(self,25)
self.help=UIButton.get(self,26)
self.changeMainFabaoBtn=UIButton.get(self,27)
self.changeMainFabaoBtn2=UIButton.get(self,28)
self.effect4=UIObject.get(self,29)

self.btnLianzhi:setButtonClick(function()self:onBtnLianzhi()end)

self.fabaoClick:setButtonClick(function()self:onFabaoClick()end)

self.dzBtn:setButtonClick(function()self:onDzBtn()end)

self.modelClick:setButtonClick(function()self:onModelClick()end)

self.help:setButtonClick(function()self:onHelp()end)

self.changeMainFabaoBtn:setButtonClick(function()self:onChangeMainFabaoBtn()end)

self.changeMainFabaoBtn2:setButtonClick(function()self:onChangeMainFabaoBtn2()end)
self.items={
self.items_1,
self.items_2,
}
self.itemFaBaoSlot={
self.itemFaBaoSlot_1,
self.itemFaBaoSlot_2,
self.itemFaBaoSlot_3,
}



end


function UIBenMingFabaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.previewRoot);self.previewRoot=nil;
_UIObject_release(self.btnLianzhi);self.btnLianzhi=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.parent);self.parent=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.items_1);self.items_1=nil;
_UIObject_release(self.items_2);self.items_2=nil;
_UIObject_release(self.ypicon);self.ypicon=nil;
_UIObject_release(self.fbIcon1);self.fbIcon1=nil;
_UIObject_release(self.fbIcon2);self.fbIcon2=nil;
_UIObject_release(self.fbIcon3);self.fbIcon3=nil;
_UIObject_release(self.fbicon);self.fbicon=nil;
_UIObject_release(self.fabaoClick);self.fabaoClick=nil;
_UIObject_release(self.itemYuanPei);self.itemYuanPei=nil;
_UIObject_release(self.itemFaBaoSlot_2);self.itemFaBaoSlot_2=nil;
_UIObject_release(self.itemFaBaoSlot_3);self.itemFaBaoSlot_3=nil;
_UIObject_release(self.itemFaBaoSlot_1);self.itemFaBaoSlot_1=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.dzname);self.dzname=nil;
_UIObject_release(self.dzBtn);self.dzBtn=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.modelClick);self.modelClick=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.changeMainFabaoBtn);self.changeMainFabaoBtn=nil;
_UIObject_release(self.changeMainFabaoBtn2);self.changeMainFabaoBtn2=nil;
_UIObject_release(self.effect4);self.effect4=nil;
self.items=nil;
self.itemFaBaoSlot=nil;
end

















local _colorBg=fabaoConfig.bmQualityBg

local _previewBg=
{
[eQualityColor.ePurple]='image_benmingfbdpz_1',
[eQualityColor.eOrange]='image_benmingfbdpz_2',
[eQualityColor.eRed]='image_benmingfbdpz_3',
}

function UIBenMingFabaoWin:onLoaded(...)
self:bindComponents()
self.fbitemguids={}
self.mainfb=nil
self.mainfbIdx=nil
self.previewItemguid=nil
self.dzguid=nil
self.bgModel:setChildUIModelShowTarget(4085,1,{},eAnimationID.stand,false,false,0)

self.checkList={}
self.on_money_changed=function(mtype,last,curr)
if self.checkList[mtype]then
self:freshInfo()
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end

function UIBenMingFabaoWin:__delete()
self:stopBehavior()
self:unbindComponents()

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end

function UIBenMingFabaoWin:onShow(argtable,afterOnloaded)
if argtable then
local guid=argtable.entityId
self.entityId=guid
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)
self.buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.ubdId=self.bdData.build_id
end
self:freshInfo()
end

function UIBenMingFabaoWin:onShowArgRecv(argtable)
local oldId=self.entityId
local newId=argtable.entityId
if newId~=oldId then
self:__delete()
self:onLoaded()
self:onShow(argtable)
end
end

function UIBenMingFabaoWin:onHide()
self:stopBehavior()
end





function UIBenMingFabaoWin:onBtnLianzhi()
if self.dzguid==nil then
UIManager.error('尚未选择法宝主人')
return
end
if self.mainfb==nil then
UIManager.error('请先设置主法宝')
self:onChangeMainFabaoBtn()
return
end
if not self:checkItemEnough()then
return
end


local list={}
for i,v in ipairs(self.fbitemguids)do
if i~=self.mainfbIdx then
list[#list+1]=v
end
end

local lhlv
local jllv
for i,v in ipairs(list)do
local _lhlv=fabaoModel.getFabaoLianhuanum(v)
local _jllv=fabaoModel.getFabaoJilianLevel(v)
if _lhlv>0 then
lhlv=v
break
elseif _jllv>0 then
jllv=v
break
end
end
table.insert(list,1,self.mainfb)
local func=function()
fabaoProtocolControl.reqCreateBenMingFaBao(self.dzguid,self.ypitemguid,list)
end
local repeatType=REPEAT_TYPE.eDaoBingCombine
if lhlv or jllv then
local desc='辅助法宝被强化过，强化消耗的材料不会返还，确定要继续炼制吗？'
UIDialogManager.getConfirmDialog3(nil,desc,func,repeatType)
else
func()
end
end

function UIBenMingFabaoWin:onFabaoClick()
if self.previewItemguid then
tipsManager.showTips({itemguid=self.previewItemguid})
else
local list={}
for i,v in ipairs(self.fbitemguids)do
if i~=self.mainfbIdx then
list[#list+1]=v
end
end
table.insert(list,1,self.mainfb)

self.previewItemguid=fabaoPreviewModel:create(self.dzguid,self.ypitemguid,list)
tipsManager.showTips({itemguid=self.previewItemguid})
end
end

function UIBenMingFabaoWin:onSelectMainFaBao(index,itemguid)
local oldguid=self.mainfb
self.mainfb=itemguid
self.mainfbIdx=index
local isChangged=not mathHelper.compareInt64(oldguid,itemguid)
self.previewItemguid=nil
self.fbitemguids[index]=itemguid
self:freshFaBaos()
self:freshCost()
self:freshPreview()
self:stopAllTimer()
if isChangged then
self.effect4:setChildShowEffect(10294,true)
end
end

function UIBenMingFabaoWin:onChangeMainFabaoBtn()
local argstable={}
argstable.tipsList={}
local tipsList=argstable.tipsList
for i=1,3 do
local itemguid=self.fbitemguids[i]
local args={itemguid=itemguid}
args.attach={}
args.attach.insertBtnList={TIPS_SRC_TYPE.tipsChildMainFabaoButton}
args.attach.index=i
tipsList[#tipsList+1]=args
end
tipsList.posY=20

argstable.extList={}
local extList=argstable.extList
extList[#extList+1]=
{
childType=TIPS_SRC_TYPE.tipsChildSelectMainFabaoDesc,
argtable=
{
desc='本命法宝将继承主法宝的精炼等级、炼化属性、词缀属性和五行属性',
title='设置主法宝'
},
}
UIManager:showWindow('UIMultiTipsWin',argstable)
end

function UIBenMingFabaoWin:onChangeMainFabaoBtn2()
self:onChangeMainFabaoBtn()
end

function UIBenMingFabaoWin:onDzBtn()
self:onClickSelect()
end

function UIBenMingFabaoWin:onModelClick()
self:onClickSelect()
end

function UIBenMingFabaoWin:onClickSelect()
local func=function(...)
local args={
openType=dzSelectWinOpenType.eFabaoOwner,
effectType=dzSelectEffectType.ePlan,
bdData=self.bdData,
sfId=mapIdType.zhufeng,
funcIndex=1,
dzguid=self.dzguid,
callback=function(dzId)
if self.dzguid then
if tostring(self.dzguid)==tostring(dzId)then return end
self.dzguid=dzId
self.previewItemguid=nil
self:freshDiZiModel()
else
self.previewItemguid=nil
self.dzguid=dzId
self:freshInfo()
end
end
}
discipleSelectController:openDiscipleSelect(args)
end
if self.dzguid~=nil then
local desc='是否确定切换本命法宝主人？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func,REPEAT_TYPE.eChangeBenMingFaBaoOwner)
else
func()
end
end

function UIBenMingFabaoWin:onHelp()
local d={}
d.title='炼制规则'
d.mode=3
d.name='fabao_bm_lianzhi_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UIBenMingFabaoWin:freshInfo()
self:freshYuanPei()
self:freshFaBaos()
self:freshDiZiModel()
self:freshCost()
self:freshPreview()
self:freshEffect()
end


function UIBenMingFabaoWin:freshYuanPei()
local hasdz=self.dzguid~=nil
self.itemYuanPei:setActive(hasdz)
if not hasdz then return end
local ypitemguid=self.ypitemguid
local ypitemid=self.ypitemid
local widget=self.itemYuanPei:getWidgetBase()
widget:SetChildButtonClick(6,function()
self:clickYuanPei()
end,true)
if ypitemid then
local itemCfg=itemsConfig.getConfig(ypitemid)
widget:SetChildActive(0,true)
widget:SetChildCSImageSprite(0,globalABLookup.global,_colorBg[itemCfg.color])
widget:SetChildActive(1,true)
widget:SetChildIcon(1,iconHelper.getIconName(itemCfg.icon),false)
widget:SetChildActive(4,true)
widget:SetChildActive(5,false)
else
widget:SetChildActive(0,false)
widget:SetChildActive(1,false)
widget:SetChildActive(4,false)
widget:SetChildActive(5,true)
end
end

function UIBenMingFabaoWin:freshFaBaos()
local hasdz=self.dzguid~=nil
local ypitemguid=self.ypitemguid
local mainfb=self.mainfb
local hasmainfb=mainfb~=nil
for i,v in ipairs(self.itemFaBaoSlot)do
local show=hasdz and ypitemguid~=nil or false
v:setActive(show)
if show then
local widget=v:getWidgetBase()
local itemguid=self.fbitemguids[i]
widget:SetChildButtonClick(7,function()
self:clickFabao(i)
end,true)
local isMainFabao=mainfb and tostring(itemguid)==tostring(mainfb)
local name=not hasmainfb and'<color=#C39962>材料法宝</color>'or
isMainFabao and'<color=#FD8950>主法宝</color>'or
'<color=#C39962>辅法宝</color>'
local ypitem=bagModel.getItem(ypitemguid)
local fbtypeList=ypitem.itemData.fbtypeList
local fbtype=fbtypeList[i]
local fbtypeCfg=cfg_fabaoyuanpeitypeconfig_get(fbtype)
if itemguid then
local equip=fabaoHelper.getFabao(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local iconname=itemsModel.getIconName(equip)
widget:SetChildActive(0,true)
widget:SetChildCSImageSprite(0,globalABLookup.global,_colorBg[itemCfg.color])
widget:SetChildActive(1,true)
widget:SetChildIcon(1,iconname,false)
widget:SetChildText(3,name)
widget:SetChildActive(4,false)
widget:SetChildActive(5,true)
else
widget:SetChildActive(0,false)
widget:SetChildActive(1,false)
widget:SetChildText(3,name)
widget:SetChildActive(4,true)
widget:SetChildActive(5,false)
end
widget:SetChildCSImageSprite(7,globalABLookup.benmingFaBaoSprite,isMainFabao and
'image_benmingfbui_4'or'image_benmingfbui_3')
widget:SetChildActive(6,true)
widget:SetChildCSImageSprite(6,globalABLookup.benmingFaBaoSmallSprite,
iconHelper.getFaBaoTypeSmallIcon(fbtypeCfg.smallicon))
end
end
end

function UIBenMingFabaoWin:freshDiZiModel()
self.model:setChildUIModelRemoveTarget()
if self.dzguid then
self.btnSelect:setActive(true)
local dzguid=self.dzguid
local dzname=UIDiscipleModel:getDiscipleName(dzguid)
self.dzname:setText(dzname)
local sex=UIDiscipleModel:getDiscipleSex(dzguid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(dzguid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid,false,1)
local bodyId=imageInfo.sex==SEX_TYPE.eMale and 50001 or 50002
bodyId=cfgHelper.get2(cfg_disciplebodyimageconfig_get,bodyId,'out_side')
if modelParams.componets[1]~=nil then
self.model:setChildUIModelShowTarget(bodyId,modelParams.scale,nil,modelParams.anim,false,false)
self.model:setChildAddSkeletonSlot("tou1","head",modelParams.componets[1])
else
self.model:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false)
end
if modelParams.componets and modelParams.componets[1]then
self.model:setChildAddSkeletonSlot("tou1","head",modelParams.componets[1])
end
self.model:setChildUIModelShowTargetOffset(0,-80)

self.dzBtn:setActive(false)
else
self.btnSelect:setActive(false)
self.dzname:setText('请选择法宝主人')
self.dzBtn:setActive(true)
end
end

function UIBenMingFabaoWin:freshCost()
local hasdz=self.dzguid~=nil
local ypitemguid=self.ypitemguid
local show=ypitemguid and self:isFabaoFull()and self.mainfb~=nil or false
self.costRoot:setActive(hasdz and show)
if not show then return end
local fbguid=self.mainfb
local equip=fabaoHelper.getFabao(fbguid)
local fbitemid=equip.itemid
local itemCfg=itemsConfig.getConfig(fbitemid)
local ypitemid=self.ypitemid
local ypitemCfg=itemsConfig.getConfig(ypitemid)
local stage=itemCfg.stage
local costs=ypitemCfg.consume[stage]
for i,v in ipairs(self.items)do
local cost=costs[i]
v:setActive(cost~=nil)
if cost~=nil then
local widget=v:getWidgetBase()

local itemid=cost[1]
local need=cost[2]
self.checkList[itemid]=true
local itemCfg=itemsConfig.getConfig(itemid)
local countStr=UIDanYaoModel:getItemCountStr(itemid,need)
widget:SetChildButtonClick(0,function()
self:clickItem(itemid)
end,true)

widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconHelper.getIconName(itemCfg.icon),true)
widget:SetChildText(3,countStr)
widget:SetChildActive(4,false)
widget:SetChildText(5,'')
end
end
end

function UIBenMingFabaoWin:freshPreview()
local hasdz=self.dzguid~=nil
local ypitemid=self.ypitemid
local isFabaoFull=self:isFabaoFull()
local show=ypitemid and self:isFabaoFull()and self.mainfb~=nil or false
self.changeMainFabaoBtn2:setActive(isFabaoFull and self.mainfb==nil)
self.previewRoot:setActive(show and hasdz)
self.btnLianzhi:setActive(show and hasdz)
if not show then return end
local color=itemsConfig.getConfig(ypitemid).color
self.fabaoClick:setSprite(globalABLookup.benmingFaBaoSprite,_previewBg[color])
local ypitemCfg=itemsConfig.getConfig(ypitemid)
self.fbicon:setChildIcon(iconHelper.getIconName(ypitemCfg.fbicon),false)
self.changeMainFabaoBtn:setActive(true)
end

function UIBenMingFabaoWin:freshEffect()
self.effect1:setChildShowEffect(10257,true)

local show=self.ypitemguid and self:isFabaoFull()or false
self.effect2:setChildShowEffect(10258,show)
end

function UIBenMingFabaoWin:isFabaoFull()
if self.fbitemguids==nil then return false end
for i=1,3 do
if self.fbitemguids[i]==nil then return false end
end
return true
end

function UIBenMingFabaoWin:checkItemEnough()
local ypitemguid=self.ypitemguid
local show=ypitemguid and self:isFabaoFull()or false
if not show then return false end
local fbguid=self.mainfb
local equip=fabaoHelper.getFabao(fbguid)
local fbitemid=equip.itemid
local itemCfg=itemsConfig.getConfig(fbitemid)
local ypitemid=self.ypitemid
local ypitemCfg=itemsConfig.getConfig(ypitemid)
local stage=itemCfg.stage
local costs=ypitemCfg.consume[stage]
for i,v in ipairs(costs)do
local itemid=v[1]
local need=v[2]
local has=itemsModel.getCount(itemid)
if itemsModel.getCount(itemid)<need then
local name=itemsModel.getName(itemid)
UIManager.error(FMT.fmt('{0}不足',name))
gainControl:showGainWin(itemid)
return false
end
end
return true
end

function UIBenMingFabaoWin:showYuanPeiSelectWin()
local dzguid=self.dzguid
if dzguid==nil then
UIManager.error('请先选择主人')
return
end
local args={}
args.titleName="法宝原胚"
args.pos=1
args.extraWin='UIFabaoYuanPeiSelectWin'
local extraParams={}
extraParams.itemguid=self.ypitemguid
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIBenMingFabaoWin:showFabaoSelectWin(index)
local dzguid=self.dzguid
if dzguid==nil then
UIManager.error('请先选择主人')
return
end
local itemid=self.ypitemid
if itemid==nil then
UIManager.error('请先选择原胚')
return
end
local itemCfg=itemsConfig.getConfig(itemid)
local color=itemCfg.color
local ypitem=bagModel.getItem(self.ypitemguid)
local fbtypeList=ypitem.itemData.fbtypeList
local fbtype=fbtypeList[index]
local yptypeName=cfg_fabaoyuanpeitypeconfig_get(fbtype).name
local args={}
args.titleName="法宝选择"
args.pos=1
args.extraWin='UIFabaoMaterialSelectWin'
local extraParams={}
extraParams.color=color
extraParams.fbType=fbtype
extraParams.filterlist=self.fbitemguids
extraParams.holeIdx=index
local desc=FMT.fmt('{0}以上的{1}类法宝可作为材料法宝',
eQualityColorName[color],yptypeName)
extraParams.title=desc
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIBenMingFabaoWin:onSelectYuanPei(itemguid,itemid)
if tostring(itemguid)==tostring(self.ypitemguid)then return end
self.ypitemguid=itemguid
self.ypitemid=itemid
self.fbitemguids={}
self.mainfb=nil
self.mainfbIdx=nil
self.previewItemguid=nil
self:freshYuanPei()
self:freshFaBaos()
self:freshCost()
self:freshPreview()
end

function UIBenMingFabaoWin:onSelectFabao(index,itemguid,itemid)
local isFull=self:isFabaoFull()
if tostring(itemguid)==tostring(self.fbitemguids[index])then return end
local isMainFabao=index==self.mainfbIdx
if isMainFabao then
self.mainfb=nil
self.previewItemguid=nil
end
self.fbitemguids[index]=itemguid
self.previewItemguid=nil
self:freshFaBaos()
self:freshCost()
self:freshPreview()
self:freshEffect()
if self.ypitemid and self:isFabaoFull()and
(not isFull or isFull and isMainFabao)then
self:onChangeMainFabaoBtn()
end
end

function UIBenMingFabaoWin:onPutItem(itemguid,itemid,index)
self:onSelectFabao(index,itemguid,itemid)
end

function UIBenMingFabaoWin:onPutYuanPei(itemguid,itemid)
self:onSelectYuanPei(itemguid,itemid)
end

function UIBenMingFabaoWin:clickYuanPei()
self:showYuanPeiSelectWin()
end

function UIBenMingFabaoWin:clickFabao(index)
self:showFabaoSelectWin(index)
end

function UIBenMingFabaoWin:clickItem(itemid)
tipsManager.showTips({itemid=itemid,move=TIPS_MOVE_POS.eCenter})
end

function UIBenMingFabaoWin:onPlayComplete()
self.ypitemguid=nil
self.ypitemid=nil
self.fbitemguids={}
self.mainfb=nil
self.mainfbIdx=nil
self.previewItemguid=nil
self:freshYuanPei()
self:freshFaBaos()
self:freshCost()
self:freshPreview()
if self.showguid then
UIManager:showWindow('UIBenMingFabaoCreateWin',{itemguid=self.showguid})
end
end

function UIBenMingFabaoWin:onLianZhiRet(itemguid)
self.showguid=itemguid

AudioManager.playAudio(574)
self:startBehavior()
end

function UIBenMingFabaoWin:startBehavior()
local flag=0
for i=1,4 do
flag=flag+math.pow(2,i-1)
end
local target0=self.effect3:getID()

local target1=self.ypicon:getID()
local target2=self.fbIcon1:getID()
local target3=self.fbIcon2:getID()
local target4=self.fbIcon3:getID()

local parent=self.parent:getID()
local pos=self.winlua:GetChildPosition(target0)
local initData=
{
widget=self.winlua,
target0=target0,
target1=target1,
target2=target2,
target3=target3,
target4=target4,
parent=parent,
pos=pos,
flytime=0.8,
scaledelay=0.3,
scaletime=0.5,
winName=self.name,
func='onPlayComplete',
endtime=1.2,
}
self:stopBehavior()
self.bt=behaviorManager:addBehaviorTree(btType.bt_benming_create_fly,nil,true,initData)

end


function UIBenMingFabaoWin:stopBehavior()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end