







def_class("UIDZMountWin",UIWindowBase)









function UIDZMountWin:bindComponents()

self.UIDZMountWin=UIWindowLua.new(self,0)
self.root=UIObject.get(self,1)
self.dressToggle=UIToggleButton.get(self,2)
self.gainRoot=UIObject.get(self,3)
self.bagRoot=UIObject.get(self,4)
self.back=UIImage.get(self,5)
self.model=UIObject.get(self,6)
self.attrRoot=UIObject.get(self,7)
self.bookitem=UIBaseItem.get(self,8)
self.desc=UIText.get(self,9)
self.bagScrollView=UIScrollViewSlow.get(self,10)
self.gainScrollView=UIScrollView.get(self,11)
self.gainTitle=UIText.get(self,12)
self.ScrollView=UIScrollViewSlow.get(self,13)
self.dressToggleText=UIText.get(self,14)
self.dzname=UIText.get(self,15)
self.dzJobBtn=UIButton.get(self,16)
self.attr_3=UIText.get(self,17)
self.attr_2=UIText.get(self,18)
self.attr_1=UIText.get(self,19)
self.discipleJobIcon=UIImage.get(self,20)
self.mountName=UIText.get(self,21)
self.liandonBtn=UIButton.get(self,22)
self.discipleJobIcon2=UIImage.get(self,23)
self.spBg=UIObject.get(self,24)

self.dzJobBtn:setButtonClick(function()self:onDzJobBtn()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)
self.attr={
self.attr_1,
self.attr_2,
self.attr_3,
}



end


function UIDZMountWin:unbindComponents()
local _UIObject_release=UIObject.release
self.UIDZMountWin:deleteSelf();self.UIDZMountWin=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.dressToggle);self.dressToggle=nil;
_UIObject_release(self.gainRoot);self.gainRoot=nil;
_UIObject_release(self.bagRoot);self.bagRoot=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.bookitem);self.bookitem=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.gainScrollView);self.gainScrollView=nil;
_UIObject_release(self.gainTitle);self.gainTitle=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.dressToggleText);self.dressToggleText=nil;
_UIObject_release(self.dzname);self.dzname=nil;
_UIObject_release(self.dzJobBtn);self.dzJobBtn=nil;
_UIObject_release(self.attr_3);self.attr_3=nil;
_UIObject_release(self.attr_2);self.attr_2=nil;
_UIObject_release(self.attr_1);self.attr_1=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.mountName);self.mountName=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
_UIObject_release(self.spBg);self.spBg=nil;
self.attr=nil;
end

















local _creatGird=100
local _colomn=4

function UIDZMountWin:onLoaded(...)
self:bindComponents()
self.bagScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindBagGrid(...)
end
end)
self.bagScrollView:setSlowClickAction(function(...)self:onBagItemClick(...)end)

self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindBookGrid(...)
end
end)


self.gainScrollView:bindScrollWidget(function(...)
if self and not self.isClose then
self:fillGainData(...)
end
end)

self.gainScrollView:setClickAction(function(...)self:onGainItemClick(...)end)

self.curPageIndex=1

self.isToggleDress=false
self.dressToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self.dressToggleText:setText('显示已穿戴')
self:freshToggle()

self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemListChanged(...)end)
end

function UIDZMountWin:__delete()
self:unbindComponents()
end

function UIDZMountWin:onShow(argtable,afterOnloaded)
if afterOnloaded then

end
local dzguid=argtable.guid
local mountid=argtable.mountid or self.mountid
self:onSelectDZ(dzguid,mountid)
end

function UIDZMountWin:onHide()

end

function UIDZMountWin:onShowArgRecv(argtable)
self.mountid=nil
local dzguid=argtable.guid
self:onSelectDZ(dzguid,nil)
end



function UIDZMountWin:onSelectDZ(dzguid,mountid)
self.dzguid=dzguid
self.curPageIndex=1
self.mountid=mountid
self.mountModel=nil
self:freshInfo()
end

function UIDZMountWin:onSelectMount(mountid)
if self.mountid==mountid then return end
self.mountid=mountid
self:freshBookSelectFlag()
self:freshBagPanel()
self:freshMountInfo()
self:freshGainPanel()
end

function UIDZMountWin:onEdgeEvent()
if self.curPageIndex>=self.tPage then return end
self.curPageIndex=self.curPageIndex+1
self:freshBagPanel()
end

function UIDZMountWin:freshInfo()
self:freshBookPanel()
self:freshBagPanel()
self:freshGainPanel()
self:freshDZInfo()
self:freshMountInfo()
self:freshLeftList()
self:freshMountEquip()
end

function UIDZMountWin:freshBagPanel()
self.initBagView=nil
self.bagScrollView:clearSlowItems()
self:freshBagData()
self:freshBagGirds()
end

function UIDZMountWin:freshBagData()
local itemid=self.mountid
local mountInfo=mountModel:getMountByDZ(self.dzguid)
local filter={}
filter[ITEM_FILTER_TYPE.eItemid]=itemid




local itemlist=mountBagModel:getBagItemsByFilter(filter,false)
if self.isToggleDress then
local equips=mountModel:getMountByFilter(filter)
itemlist=table.concatTableX(equips,itemlist)
end
self.itemsList=itemlist
self.itemsLen=#itemlist
self:onSortBagItems()
end

function UIDZMountWin:freshBagRoot()
local itemid=self.mountid
local hasMount=mountBagModel:hasMountId(itemid)
self.bagRoot:setActive(hasMount)
end

function UIDZMountWin:freshBagGirds()
local itemsLen=self.itemsLen
self.bagRoot:setActive(itemsLen>0)
if itemsLen<=0 then return end
local itemsList=self.itemsList
local itemid=self.mountid
self.tPage=math.ceil(itemsLen/_creatGird)
local curPageIndex=self.curPageIndex
local tNum=curPageIndex*_creatGird
tNum=math.min(tNum,itemsLen)
local row=math.ceil(tNum/_colomn)+3
tNum=row*_colomn

self.space={}
self.bagScrollView:freshSlowGrids(tNum,row,_colomn,self.initBagView~=true)
self.initBagView=true
end

function UIDZMountWin:bindBagGrid(index,item)
local itemInfo=self.itemsList[index]
local isTemp=itemInfo==nil
if not isTemp then
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemCfg=itemsConfig.getConfig(itemid)
local color=itemCfg.color
local iconName=itemsModel.getIconName(itemInfo)
local owner=bagHelper.hasItemInLocalFile(itemid)
local isEquip=mountModel:isEquipedOnAnyDZ(itemguid)
local isLD=liandonModel:getIsLianDonItem(itemid)

widgetHelper.setItemQulaity(item,itemid,0,color)
item:SetChildIcon(1,iconName,false)
item:SetChildActive(2,isEquip)
item:SetChildActive(4,isLD)
item:SetBaseItemChildID(-1,itemid)
item:SetBaseItemChildGUID(-1,itemguid)
else
item:SetChildActive(0,false)
item:SetChildIcon(1,'',false)
item:SetChildActive(2,false)
item:SetChildActive(4,false)
item:SetBaseItemChildID(-1,-1)
item:SetBaseItemChildGUID(-1,-1)
end
end

function UIDZMountWin:onSortBagItems()
if self.itemsLen<=1 then return end
local itemsList=self.itemsList
local sortTag={}
for i,v in ipairs(itemsList)do
local itemid=v.itemid
local itemCfg=itemsConfig.getConfig(itemid)
sortTag[tostring(v.itemguid)]=itemCfg.color*1000+i
end

table.sort(itemsList,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
end

function UIDZMountWin:freshGainPanel()
local itemsLen=self.itemsLen
self.gainRoot:setActive(itemsLen<=0)
if itemsLen>0 then return end
local itemid=self.mountid
local itemCfg=itemsConfig.getConfig(itemid)
local produce=itemCfg.produce or{}
local len=#produce
self.produce=produce
self.gainScrollView:freshGridsNum(len,len,1,self.initGain~=true)
self.initGain=true
end

function UIDZMountWin:fillGainData(index,widget)
local info=self.produce[index]
local jump=info.jump
local hasjump=jump~=nil
local unLock,err=self:checkGainUnLock(info)
local isUnlock=jump and unLock or false
widget:SetChildText(0,info.desc)
widget:SetChildActive(1,not unLock)
widget:SetChildActive(2,isUnlock)
widget:SetChildButtonClick(3,function()
if not hasjump then

return
end
if isUnlock then
jumpManager:jump(jump)
else
UIManager.error(err)
end
end)
end

function UIDZMountWin:checkGainUnLock(v)
local sysid=v.sysid
local lv=v.lv
if sysid then
if not systemModel.isOpen(sysid)then
local name=systemConfig.getSystemName(sysid)
return false,FMT.fmt('请先开启{0}系统，无法跳转',name)
end
end
if lv then
if playerModel:getActorLevel()<lv then
return false,FMT.fmt('宗门等级不足{0}级，无法跳转',lv)
end
end
return true
end

function UIDZMountWin:freshBookPanel()
local cfgs=cfg_lookupmountconfig()
local colorlist=({}
)local temp={}
local sortTag={}
local booklookup={}
local mountInfo=mountModel:getMountByDZ(self.dzguid)or{}
local equip_itemid=mountInfo.itemid
local hasEquip=mountInfo.itemid~=nil
for color,list in pairs(cfgs)do
for _,itemid in ipairs(list)do
if self:showItem(itemid,equip_itemid)then
temp[#temp+1]=itemid
booklookup[itemid]=true


local owner=bagHelper.hasItemInLocalFile(itemid)or
bagModel.getItemCountById(itemid)>0 or
mountModel:isEquipedItemIdOnAnyDZ(itemid)
local ownerTag=owner and 1 or 0
sortTag[itemid]=ownerTag*1000+
color*100-
itemid/10000
end
end
end
table.sort(temp,function(a,b)
return sortTag[a]>sortTag[b]
end)
self.booklist=temp


if self.mountid then
local flag=false
for i,v in ipairs(temp)do
if self.mountid==v then
flag=true
break
end
end
if not flag then
self.mountid=nil
end
end

if self.mountid==nil then
if equip_itemid then
self.mountid=equip_itemid
else
for i,itemid in ipairs(temp)do
if bagModel.getItemCountById(itemid)>0 then
self.mountid=itemid
break
end
end
end
if self.mountid==nil then
self.mountid=temp[1]
end
end
self:freshBookGirds()
end

function UIDZMountWin:showItem(itemid,equip_itemid)
local showRule=itemsConfig.getConfig(itemid).showRule
local owner=bagHelper.hasItemInLocalFile(itemid)or
bagModel.getItemCountById(itemid)>0 or
mountModel:isEquipedItemIdOnAnyDZ(itemid)
return showRule==0 or showRule==nil or
showRule==1 and
owner
end

function UIDZMountWin:freshBookGirds()
self.ScrollView:clearSlowItems()
local booklist=self.booklist
local tNum=#booklist
local row=math.ceil(tNum/_colomn)
self.ScrollView:freshSlowGrids(tNum,row,_colomn,self.initBookView~=true)
self.initBookView=true
end

function UIDZMountWin:bindBookGrid(index,widget)
local itemid=self.booklist[index]
self:fillBookItemId(widget,itemid,index)
end

function UIDZMountWin:fillBookItemId(widget,itemid,index)
local mountInfo=mountModel:getMountByDZ(self.dzguid)or{}
local equip_itemid=mountInfo.itemid
local item=widget:GetChildWidgetBase(0)
local itemCfg=itemsConfig.getConfig(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)
local color=itemCfg.color
local iconName=iconHelper.getIconName(itemid)
local gray=not bagHelper.hasItemInLocalFile(itemid)and
bagModel.getItemCountById(itemid)<=0 and
itemid~=equip_itemid

widget:SetChildActive(1,gray)
widget:SetChildActive(3,isLD)
widget:SetChildGray(3,gray)

widgetHelper.setItemQulaity(item,itemid,0,color)
item:SetChildGray(0,gray)
item:SetChildIcon(1,iconName,false)
item:SetChildGray(1,gray)
item:SetChildActive(2,false)
item:SetChildActive(3,self.mountid==itemid)
item:SetBaseItemChildID(-1,itemid)
item:SetBaseItemClickEvent(-1,function()
self:onBookItemClick(itemid,index)
end)
end

function UIDZMountWin:fillEquipItem(widget,data)
local isTemp=data==nil
local item=widget:GetChildWidgetBase(0)
local betterList=equipsHelper.getBetterOnlyMountBydizi(self.dzguid,true)
local hasBetter=#betterList>0
local unlock=mountHelper.isCanDressByDZ(self.dzguid)
if not isTemp then
local itemid=data.itemid
local itemguid=data.itemguid
local itemCfg=itemsConfig.getConfig(itemid)
local color=itemCfg.color
local iconName=iconHelper.getIconName(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)

widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,hasBetter)
widget:SetChildActive(4,false)
widget:SetChildActive(5,isLD)

widgetHelper.setItemQulaity(item,itemid,0,color)
item:SetChildIcon(1,iconName,false)
item:SetChildActive(2,false)
item:SetChildActive(3,false)
item:SetBaseItemClickEvent(-1,function()
self:onEquipItemClick(itemid,itemguid)
end)
else
widget:SetChildActive(1,true)
widget:SetChildActive(2,not unlock)
widget:SetChildActive(3,unlock and hasBetter)
widget:SetChildActive(4,unlock and not hasBetter)
widget:SetChildActive(5,false)

item:SetChildActive(0,false)
item:SetChildIcon(1,'',false)
item:SetChildActive(2,false)
item:SetChildActive(3,not unlock)
widget:SetBaseItemClickEvent(-1,function()
self:onEquipItemClick(-1)
end)
end
end

function UIDZMountWin:freshBookSelectFlag()
for i,v in ipairs(self.booklist)do
local widget=self.ScrollView:getSlowItemByIndex(i-1)
local isSelect=v==self.mountid
local item=widget:GetChildWidgetBase(0)
item:SetChildActive(3,isSelect)
end
end

function UIDZMountWin:freshMountEquip()
local dzguid=self.dzguid
local mountInfo=mountModel:getMountByDZ(dzguid)
local hasMount=mountInfo~=nil
local widget=self.winlua:GetChildWidgetBase(self.bookitem:getID())
self:fillEquipItem(widget,mountInfo)

self.attrRoot:setActive(hasMount)
self.desc:setActive(not hasMount)
if hasMount then
local itemid=mountInfo.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local list=mountHelper.getBaseAttrsList(itemCfg)
for i=1,3 do
local v=list[i]
if v then
local name,valstr=equipsHelper.getAttr(v[1],v[2])
self.attr[i]:setText(FMT.fmt('{0}:{1}',name,valstr))
else
self.attr[i]:setText('')
end
end
end
end

function UIDZMountWin:freshMountInfo()
local itemid=self.mountid
local itemCfg=itemsConfig.getConfig(itemid)
local itemsCfg=itemsConfig.getConfig(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)
local node=itemsCfg.node or'zuoqidian'
local modelParams=itemCfg.model
local modelId=modelParams.model
local name=string.insertBreakLine(itemCfg.name)
if pfwindowslController:checkIsGameVersion_yuenan()then
name=itemCfg.name
end
self.mountName:setText(name)
self.liandonBtn:setActive(isLD)
local dzguid=self.dzguid
if self.mountModel~=modelId then
self.mountModel=modelId
local offset=modelParams.offset or{}
local offsetX=0
local offsetY=0
local scaleArgs=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'scales')or{}
local scale=scaleArgs[2]or 1
local offset=modelParams.offset or{}
comHelper.setChildMount(self.winlua,self.model:getID(),modelId,{},node,scale,offsetX,offsetY,offset[3]or 1)
if modelParams.spSlot~=nil then
self.model:setChildUIModelMountSeparatorSlot(modelParams.spSlot)
end
end
end

function UIDZMountWin:freshDZInfo()
local dzguid=self.dzguid
local dzname=UIDiscipleModel:getDiscipleName(dzguid)
self.dzname:setText(dzname)

local jobicon=UIDiscipleModel:getJobIconNameX(dzguid)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(dzguid)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(isSPdz)
self.spBg:setActive(isSPdz)
if isSPdz then
local switchidx=1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(dzguid,switchidx)
self.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
self.discipleJobIcon:setChildAnchoredPos(-10,10)
local scale=54/68
self.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
end

local args={
tmLv=UIDiscipleModel:getTianMingLevel(self.dzguid)
}

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.dzguid,true,1,args)
modelParams.anim=mountHelper.getMountAniByDZ(dzguid,modelParams.anim)
self.model:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false)
self.model:setChildUIModelShowTargetOffset(0,0)

end

function UIDZMountWin:freshToggle(isToggle)
self.dressToggle:setToggle(self.isToggleDress)
end

function UIDZMountWin:freshLeftList()
local dzguid=self.dzguid
local win=UIManager:findActiveWindow('UIDiscipleListComponent')
if win then
return win:onSelect(dzguid,nil,true)
end
end

function UIDZMountWin:onBagItemClick(id,index,guid,attach)
if id==-1 then return end
tipsManager.showTips({formType=TIPS_FORM_TYPE.eMountBag,
itemid=id,
itemguid=guid,
attach={diziguid=self.dzguid}})
end

function UIDZMountWin:onBookItemClick(id,index,guid,attach)

if id==-1 then return end
self:onSelectMount(id)
end

function UIDZMountWin:onEquipItemClick(id,guid)
if not mountHelper.isCanDressByDZ(self.dzguid,true)then return end
if id==-1 then
equipListManager.showTips({movepos=TIPS_MOVE_POS.eLeft,
diziguid=self.dzguid,
equipType=EQUIP_TYPE.eMount})
else
tipsManager.showTips({formType=TIPS_FORM_TYPE.eMountEquip,
itemguid=guid,
itemid=id,
attach={diziguid=self.dzguid}})
end
end

function UIDZMountWin:onGainItemClick(id,index,guid,attach)

local produce=self.produce
local jumpArgs=produce[id].jump
if jumpArgs then
jumpManager:jump(jumpArgs)
else
loggerUtil.logErrFMT('道具{0}获取途径中跳转没有配置',self.itemid)
end
end

function UIDZMountWin:onToggleChanged(name,isToggle,data)
if self.isToggleDress==isToggle then return end
self.isToggleDress=isToggle
self:freshToggle()
self:freshBagPanel()
self:freshGainPanel()
end

function UIDZMountWin:onItemListChanged(array)
for i,v in ipairs(array)do
local itemid=v[3]
if itemid==self.mountid then
self:freshBagPanel()
self:freshGainPanel()
end
end
end

function UIDZMountWin:onDzJobBtn()
local dzID=UIDiscipleModel:getDiscipleID(self.dzguid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.dzguid)
local jobid=imageInfo.job
local args={}
args.posItem=self.discipleJobIcon
args.pos=Vector2.New(0,-20)
commonTipsHelper.showDiscipleJpbTips(dzID,jobid,args)
end

function UIDZMountWin:onChangeMount(dzguid,itemguid,itemid)
if not mathHelper.compareInt64(dzguid,self.dzguid)then return end
self:freshMountEquip()
self:freshBagPanel()
self:freshGainPanel()
self:freshBookPanel()
equipListManager.closeTips()
end

function UIDZMountWin:onLiandonBtn()
local linkageId=liandonModel:getLianDonLinkageIdByItemId(self.mountid)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end
