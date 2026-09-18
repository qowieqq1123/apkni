







def_class("UIDiscipleLinggen_StrengthenLinggenWin",UIWindowBase)









function UIDiscipleLinggen_StrengthenLinggenWin:bindComponents()

self.bgspine=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.uplvnodeList=UIObject.get(self,2)
self.detalAttrRoot=UIObject.get(self,3)
self.progressRoot=UIObject.get(self,4)
self.detalAttrbtn=UIButton.get(self,5)
self.lbroot=UIObject.get(self,6)
self.strengthPanel=UIObject.get(self,7)
self.progress=UIProgressBarAni.get(self,8)
self.hiddenlist=UIObject.get(self,9)
self.switchRightBtn=UIButton.get(self,10)
self.switchLeftBtn=UIButton.get(self,11)
self.icontype=UIImage.get(self,12)
self.strengthenInfo=UIText.get(self,13)
self.resetBtn=UIButton.get(self,14)
self.botton=UIObject.get(self,15)
self.starList=UIObject.get(self,16)
self.top=UIObject.get(self,17)
self.mid=UIObject.get(self,18)
self.linggenicon=UIImage.get(self,19)
self.nodename=UIText.get(self,20)
self.levelcompare=UIText.get(self,21)
self.attrlist=UIObject.get(self,22)
self.costlist=UIObject.get(self,23)
self.costroot=UIObject.get(self,24)
self.strengthenBtn=UIButton.get(self,25)
self.strengthen=UIObject.get(self,26)
self.tip=UIText.get(self,27)
self.longclicktip=UIText.get(self,28)
self.shieldVaryTip=UIText.get(self,29)
self.costicon=UIObject.get(self,30)
self.costnum=UIText.get(self,31)
self.totallevelInfo=UIText.get(self,32)
self.closeBtn=UIButton.get(self,33)
self.uplvnodeContent=UIObject.get(self,34)
self.detalAttrList=UIObject.get(self,35)
self.resetAllBackBtn=UIButton.get(self,36)
self.resetAllBackImage=UIObject.get(self,37)

self.detalAttrbtn:setButtonClick(function()self:onDetalAttrbtn()end)

self.switchRightBtn:setButtonClick(function()self:onSwitchRightBtn()end)

self.switchLeftBtn:setButtonClick(function()self:onSwitchLeftBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)

self.strengthenBtn:setButtonClick(function()self:onStrengthenBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.resetAllBackBtn:setButtonClick(function()self:onResetAllBackBtn()end)



end


function UIDiscipleLinggen_StrengthenLinggenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgspine);self.bgspine=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uplvnodeList);self.uplvnodeList=nil;
_UIObject_release(self.detalAttrRoot);self.detalAttrRoot=nil;
_UIObject_release(self.progressRoot);self.progressRoot=nil;
_UIObject_release(self.detalAttrbtn);self.detalAttrbtn=nil;
_UIObject_release(self.lbroot);self.lbroot=nil;
_UIObject_release(self.strengthPanel);self.strengthPanel=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.hiddenlist);self.hiddenlist=nil;
_UIObject_release(self.switchRightBtn);self.switchRightBtn=nil;
_UIObject_release(self.switchLeftBtn);self.switchLeftBtn=nil;
_UIObject_release(self.icontype);self.icontype=nil;
_UIObject_release(self.strengthenInfo);self.strengthenInfo=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.botton);self.botton=nil;
_UIObject_release(self.starList);self.starList=nil;
_UIObject_release(self.top);self.top=nil;
_UIObject_release(self.mid);self.mid=nil;
_UIObject_release(self.linggenicon);self.linggenicon=nil;
_UIObject_release(self.nodename);self.nodename=nil;
_UIObject_release(self.levelcompare);self.levelcompare=nil;
_UIObject_release(self.attrlist);self.attrlist=nil;
_UIObject_release(self.costlist);self.costlist=nil;
_UIObject_release(self.costroot);self.costroot=nil;
_UIObject_release(self.strengthenBtn);self.strengthenBtn=nil;
_UIObject_release(self.strengthen);self.strengthen=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.longclicktip);self.longclicktip=nil;
_UIObject_release(self.shieldVaryTip);self.shieldVaryTip=nil;
_UIObject_release(self.costicon);self.costicon=nil;
_UIObject_release(self.costnum);self.costnum=nil;
_UIObject_release(self.totallevelInfo);self.totallevelInfo=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.uplvnodeContent);self.uplvnodeContent=nil;
_UIObject_release(self.detalAttrList);self.detalAttrList=nil;
_UIObject_release(self.resetAllBackBtn);self.resetAllBackBtn=nil;
_UIObject_release(self.resetAllBackImage);self.resetAllBackImage=nil;
end
















local CmpHiddenSkillItemIndex={
quality=0,
icon=1,
lock=2,
unlocktip=3,
emptyimg=4,
mask=5,
activeEffect=6,
}

local CmpUpLvNodeItemIndex={
activeIcon=0,
select=1,
hideLine=2,
activeLine=3,
lineNode=4,
activeNode=5,
upeffect=6,
}

local _this

local starPos={
[1]={{0,29}},
[2]={{-50,-2},{50,-2}},
[3]={{-30,20},{0,30},{30,20}},
[4]={{-50,-2},{-30,20},{30,20},{50,-2}},
[5]={{-50,-2},{-30,20},{0,30},{30,20},{50,-2}}
}

local starImgList={[0]='image_linggen_87',[1]='image_linggen_86',[2]='image_linggen_88'}




function UIDiscipleLinggen_StrengthenLinggenWin:onLoaded(...)
self:bindComponents()

_this=self
self.upLvNodeListHeight=0
self.lv_node_lookup={}
self.lv_node_Count={}

self:addNotify(notifyConfig.onDiscipleLingGenUpLevel,function(...)self:onDiscipleLingGenUpLevel(...)end)
self:addNotify(notifyConfig.onDiscipleLingGenResetLevel,function(...)self:onDiscipleLingGenResetLevel(...)end)
self:addNotify(notifyConfig.onDiscipleLingGenEquipBoard,function(...)self:onDiscipleLingGenEquipBoard(...)end)
self:addNotify(notifyConfig.onNewDay5am,function(...)self:onNewDay5am(...)end)
self:addNotify(notifyConfig.onNewDay,function(...)self:onNewDay(...)end)


self:addNotify(notifyConfig.on_item_list_changed,function(...)self:on_item_list_changed(...)end)

self.hoardHoleState={}

self.strengthenBtn:setChildLongPress(1,function()
if not _this then return end
_this:onLongPressStrengthenBtn()
end,nil)
UIManager:showWindow("UITopMaskWin")
end


function UIDiscipleLinggen_StrengthenLinggenWin:__delete()
self:unbindComponents()
if not(UIManager:isActive("UIDiscipleLinggen_HiddenSkillSelectWin")or UIManager:isActive("UIDiscipleLinggen_variationLinggenWin"))then
UIManager:closeWindow("UITopMaskWin")
end
end















function UIDiscipleLinggen_StrengthenLinggenWin:onShow(argtable,afterOnloaded)
if afterOnloaded then

self:buildLvToNodeLoopUp()
end

self.disciple_guid=argtable.disciple_guid
self.data=argtable.data
self.isShowStrengthenPanel=argtable.isShowStrengthenPanel
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)
self.lglen=lglen
self.lglist=lglist
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self.lgCfg=UIDiscipleModel:getSpecialityConfigEx(netData,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,self.data.source)

local varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
self.isVary=varySrid==self.data.type and UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)

self.linggenBaseCfg=cfgHelper.get1(cfg_disciplespiritrootbaseconfig_get,1)
self.maxLv=UIDiscipleModel:getLingGenAverageMaxLevel(self.disciple_guid)
self.maxLv=self.isVary and self.maxLv+self.linggenBaseCfg.extra or self.maxLv

local selectLv=Mathf.Min(self.data.lv+1,self.maxLv)
self.selectIndex=self.lv_node_lookup[self.lglen][selectLv]
self.prohibitState=false


self.lgtabindex=1
for k,v in pairs(lglist)do
if v.type==self.data.type then
self.lgtabindex=k
end
end

self:refresh()
self:jumpToUpLvNode(self.selectIndex)

self:showWindow("UITopMoneyWin2",{moneys={{63,}}})

self:onShowResetAllBack()
end

function UIDiscipleLinggen_StrengthenLinggenWin:onShowArgRecv(args)
self.isJumpFirst=false
self:onShow(args)
end


function UIDiscipleLinggen_StrengthenLinggenWin:onHide()
self:hideWindow("UITopMoneyWin2")
end

function UIDiscipleLinggen_StrengthenLinggenWin:refresh()
self:refreshUpLvNodeList()
self:refreshHiddenSkillList()
self:refreshHiddenSlotOpenProgress()
self:refreshOther()
self:activeStrengthenPanel()
self:refreshDetalAttrPanel()
end


function UIDiscipleLinggen_StrengthenLinggenWin:refreshOther()

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local config=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,self.data.type)
local typeIconName=config.showlist[LingGenShowListIndex.SmalIcon]
self.icontype:setCSImageSprite(globalABLookup.varylinggensprite,typeIconName)


local linggenLv=self.data.lv
local totalLv=self:getLingGenMaxLevel()
self.strengthenInfo:setText(FMT.fmt("强化：{0}/{1}",linggenLv,totalLv))

self.switchLeftBtn:setActive(self.lglen>1)
self.switchRightBtn:setActive(self.lglen>1)
end



function UIDiscipleLinggen_StrengthenLinggenWin:refreshUpLvNodeList()
self.upLvNodeListHeight=0
local nodeNum_ConstDef=cfgHelper.getdef1(cfg_disciplespiritrootnodeconfig,'nodeNum')
local nodeNum=self.isVary and nodeNum_ConstDef[2]or nodeNum_ConstDef[1]

self.uplvnodeContent:setChildLayoutGroupClearAllItems()
self.uplvnodeContent:setChildLayoutGroupCreateItems(nodeNum,function(index)self:bindUpLvNode(index)end)
end

function UIDiscipleLinggen_StrengthenLinggenWin:jumpToUpLvNode(index)


local curpos=self.uplvnodeContent:getChildLocalPosition()
local halfSizeY=self.uplvnodeList:getChildSizeDeltaY()/2
local contentSize=self.uplvnodeContent:getChildSizeDeltaY()
local pos=cfgHelper.get2(cfg_disciplespiritrootnodeconfig_get,index,'nodepos')
local posy=pos[self.data.type][2]
local offsetY=100

posy=-posy+halfSizeY-offsetY
local isjump=true

if posy<halfSizeY*2-contentSize then
isjump=false
posy=halfSizeY*2-contentSize
end

if posy>-halfSizeY*0.8 then
isjump=false
posy=0
end


if not self.isJumpFirst then
self.uplvnodeContent:setChildAnchoredPos(0,posy)
self.isJumpFirst=true
else
if isjump then

if self.moveYTW then
self.uplvnodeContent:setChildAnchoredPos(0,self.moveYValue)
self.moveYTW:Kill()
end
self.moveYValue=posy
self.moveYTW=self.uplvnodeContent:setChildDOAnchorPosY(posy,1,function()end)
end
end
end

function UIDiscipleLinggen_StrengthenLinggenWin:freshSingleUpLvNode(index)
local item=self.uplvnodeContent:getChildLayoutGroupGridItem(index-1)
self:bindUpLvNode(index,item)
end


function UIDiscipleLinggen_StrengthenLinggenWin:refreshHiddenSkillList()
local curTotalLv=UIDiscipleModel:getDiscipleTotalLinggenLevel(self.disciple_guid)
local hiddenSkillList=UIDiscipleModel:getDiscipleHoard(self.disciple_guid)
self.hiddenlist:setChildLayoutGroupCreateItems(5,function(index)
self:refreshSingleHiddenSkill(index,curTotalLv,hiddenSkillList[index])
end)
end

function UIDiscipleLinggen_StrengthenLinggenWin:refreshSingleHiddenSkill(index,curTotalLv,data)
local limit=self.linggenBaseCfg.limit
local item=self.hiddenlist:getChildLayoutGroupGridItem(index-1)
local isUnlock=curTotalLv>=limit[index]
local isEquiped=data and data.activelistlen>0

if self.hoardHoleState[index]~=nil then
if self.hoardHoleState[index]==false and isUnlock==true then
item:SetChildShowEffect(CmpHiddenSkillItemIndex.activeEffect,10460,true)
else
item:SetChildShowEffect(CmpHiddenSkillItemIndex.activeEffect,0,false)
end
end
self.hoardHoleState[index]=isUnlock


item:SetChildActive(-1,true)
item:SetChildActive(CmpHiddenSkillItemIndex.icon,isEquiped and isUnlock)
item:SetChildActive(CmpHiddenSkillItemIndex.lock,not isUnlock)
item:SetChildActive(CmpHiddenSkillItemIndex.unlocktip,not isUnlock)
item:SetChildText(CmpHiddenSkillItemIndex.unlocktip,FMT.fmt("{0}级",limit[index]))
item:SetChildActive(CmpHiddenSkillItemIndex.emptyimg,not isEquiped and isUnlock)
item:SetChildActive(CmpHiddenSkillItemIndex.mask,not isUnlock)

if isEquiped and isUnlock then
local hoardData=data.activeList[1]
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,hoardData.hoardid)
local iconName=iconHelper.getSkillIcon(hoardCfg.icon)
item:SetChildIcon(CmpHiddenSkillItemIndex.icon,iconName,false)
end

item:SetBaseItemClickEvent(-1,function()
if isUnlock then
if isEquiped then
self:showWindow("UIDiscipleLinggen_HiddenSkillTipsWn",{
disciple_guid=self.disciple_guid,
item=item,
data=data,
parentWin=self,
attench={
closeCallBack=function()
_this.uplvnodeList:setActive(true)
end
},
closeCallBack=function()
_this.uplvnodeList:setActive(false)
end
})
else
UIManager:showWindow("UIDiscipleLinggen_HiddenSkillSelectWin",{
disciple_guid=self.disciple_guid,
boardPosData=data,
closeCallBack=function()
_this.uplvnodeList:setActive(true)
end
})
_this.uplvnodeList:setActive(false)
end
else
UIManager.info(FMT.fmt('灵根总等级达到{0}级解锁',limit[index]))
end
end)
end

function UIDiscipleLinggen_StrengthenLinggenWin:refreshHiddenSlotOpenProgress(lv)
local curTotalLv=lv or UIDiscipleModel:getDiscipleTotalLinggenLevel(self.disciple_guid)
local maxTotalLv=self.linggenBaseCfg.limit[5]
self.progress:animateThreeParams(curTotalLv,maxTotalLv,0.5)

self.totallevelInfo:setText(FMT.fmt("总强化\n{0}级",curTotalLv))
end


function UIDiscipleLinggen_StrengthenLinggenWin:activeStrengthenPanel()
self.strengthPanel:setActive(self.isShowStrengthenPanel)


self:refreshStrengthenPanel(self.selectIndex)

end

function UIDiscipleLinggen_StrengthenLinggenWin:refreshStrengthenPanel(nodeIndex)
local isAssertVary=UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)
local averageLv=UIDiscipleModel:getLingGenAverageMaxLevel(self.disciple_guid)

local nodeDef=cfgHelper.getdef1(cfg_disciplespiritrootnodeconfig,'nodeNum')
local limitNodeIndex=self.data.varyState==1 and nodeDef[2]or nodeDef[1]

local lv=self.data.lv
local nextNodeIndex=self.lv_node_lookup[self.lglen][self.data.lv+1]
local nextlv=nextNodeIndex and(nextNodeIndex<=limitNodeIndex and self.data.lv+1 or self.data.lv)or self.data.lv
nextNodeIndex=self.lv_node_lookup[self.lglen][nextlv]
local lgtype=self.data.type




local nodeCfg=cfgHelper.get1(cfg_disciplespiritrootnodeconfig_get,nodeIndex)
local nodeLvRange=nodeCfg.lvrange[self.lglen]

local isCurNode=nextlv>=nodeLvRange[1]and nextlv<=nodeLvRange[2]
local isAfterNode=nextlv<nodeLvRange[1]
local isBeforeNode=nextlv>nodeLvRange[2]

if not isAssertVary and nextlv>averageLv then
if nextlv==nodeLvRange[1]then
isCurNode=false
isAfterNode=true
end
end


local stage
local totalStage
local isFirstFlag=nodeIndex==1 and 0 or 1
local isStart=false
local baseLv

if isCurNode then
stage=lv-nodeLvRange[1]+isFirstFlag
totalStage=nodeLvRange[2]-nodeLvRange[1]+isFirstFlag

if lv+1==nodeLvRange[1]then
isStart=true
end

if self.lv_node_lookup[self.lglen][lv]==self.lv_node_lookup[self.lglen][nextlv]then
baseLv=nodeLvRange[1]-1

end
end

if isAfterNode then
stage=nodeLvRange[2]-nodeLvRange[1]+isFirstFlag
totalStage=nodeLvRange[2]-nodeLvRange[1]+isFirstFlag
lv=Mathf.Max(nodeLvRange[1]-1,0)
nextlv=nodeLvRange[2]
end

if isBeforeNode then
stage=nodeLvRange[2]-nodeLvRange[1]+isFirstFlag
totalStage=nodeLvRange[2]-nodeLvRange[1]+isFirstFlag
lv=Mathf.Max(nodeLvRange[1]-1,1)
nextlv=nodeLvRange[2]
end

local isNoShieldVary=true
if nextlv>averageLv then
isNoShieldVary=isNoShieldVary and isAssertVary
end


local starPosList=totalStage>5 and starPos[5]or starPos[totalStage]
self.starList:setChildLayoutGroupCreateItems(totalStage,function(index)
local item=self.starList:getChildLayoutGroupGridItem(index-1)
local realIndex=(index-1)%5+1
local stageIndex=Mathf.Ceil(index/5)
local isActive=false
local activeImge=starImgList[stageIndex]
if isBeforeNode then
isActive=true
end

if isCurNode then
isActive=lv>=(nodeLvRange[1]+index-isFirstFlag)and lv~=0
end

local pos=starPosList[realIndex]
item:SetChildAnchoredPos(-1,pos[1],pos[2])
item:SetChildActive(-1,isActive or index<=5)
item:SetChildActive(0,isActive)
item:SetChildCSImageSprite(0,globalABLookup.varylinggensprite,activeImge)
end)



local iconName=FMT.fmt('image_linggen_lgqh{0}',lgtype)
self.linggenicon:setCSImageSprite(globalABLookup.varylinggensprite,iconName)


self.nodename:setText(nodeCfg.nodename[lgtype])


self.levelcompare:setText(FMT.fmt("等级：{0}/{1}",stage,totalStage))




local attrs=self:compareAddtion(self.disciple_guid,lgtype,lv,nextlv,not isCurNode,isStart,baseLv)







local extra_upmzzl_desc=cfgHelper.get4(cfg_disciplespiritrootlevelconfig_get,self.lglen,self.data.type,nextlv,'extra_upmzzl_desc')or{}
for k,v in pairs(extra_upmzzl_desc[self.lglen]or{})do
local infoColor=(isBeforeNode or(stage==totalStage and isCurNode))and FONT_COLOR.eGreenTxtColor or FONT_COLOR.eGrayColor
local info=toColorString(infoColor,v)
table.insert(attrs,{info=info,addvalue=0})
end

self.attrlist:setChildLayoutGroupCreateItems(#attrs,function(index)
local item=self.attrlist:getChildLayoutGroupGridItem(index-1)
local data=attrs[index]

item:SetChildText(0,data.info)
item:SetChildActive(1,data.addvalue>0)
if data.addvalue>0 then
item:SetChildText(1,helper.getAttributeStrEx(data.type,data.addvalue))
item:SetChildActive(2,data.isAdd or data.isNew)
end
end)

self.costlist:setActive(isCurNode and(nextNodeIndex~=nil and limitNodeIndex>=nextNodeIndex)and lv~=nextlv)
self.strengthen:setActive((isBeforeNode or(isCurNode and stage==totalStage))and isNoShieldVary)
self.strengthenBtn:setActive(isCurNode and(stage~=totalStage)and isNoShieldVary)
self.costroot:setActive(isCurNode and(stage~=totalStage)and lv~=nextlv)
self.longclicktip:setActive(isCurNode and(stage~=totalStage)and isNoShieldVary)
self.tip:setActive(isAfterNode)

self.shieldVaryTip:setText(FMT.fmt("灵根总等级{0}级以上即可恢复",self.linggenBaseCfg.vary[2]))
self.shieldVaryTip:setActive(not isAfterNode and not isNoShieldVary)

local lvCfg=cfgHelper.get3(cfg_disciplespiritrootlevelconfig_get,self.lglen,lgtype,lv)

if isCurNode and(lv~=nextlv)then


self.costnum:setActive(lvCfg.consume~=nil)
if lvCfg.consume then
local consume=lvCfg.consume or{}
self:freshStrengthenConsumePart(consume)

local hbconsume=lvCfg.consume[1]
local hbIconName=itemsModel.getItemIconName(hbconsume[1])
local hbHasNum=itemsModel.getCount(hbconsume[1])
local hbTxtColor=hbHasNum>=hbconsume[2]and FONT_COLOR.eGrayWhiteTxtColor or FONT_COLOR.eRedColor
self.costicon:setChildIcon(hbIconName,false)
self.costnum:setText(toColorString(hbTxtColor,hbconsume[2]))
end
end

if isAfterNode then
local consume=lvCfg.consume or{}
self:freshStrengthenConsumePart(consume)
end


end

function UIDiscipleLinggen_StrengthenLinggenWin:freshStrengthenConsumePart(consumeList)
local initPropData={}
local deltaNum={}
for index=2,#consumeList do
local data=consumeList[index]
local itemid=data[1]
local needNum=data[2]
local hasNum=itemsModel.getCount(itemid)

local hasColor=hasNum>=needNum and FONT_COLOR.eGrayWhiteTxtColor or FONT_COLOR.eRedColor
local countdesc=toColorString(hasColor,FMT.fmt('{0}/{1}',hasNum,needNum))

local grayNum=hasNum>=needNum and 0 or 1
local conf={itemid=itemid,itemcount=countdesc,showCountBG=true,showname=false,gray=grayNum}
local propdata=itemsComponentHelper.getCommonFillDataSmall(conf)
table.insert(initPropData,propdata)
table.insert(deltaNum,{needNum,needNum-hasNum})
end



self.costlist:setChildLayoutGroupCreateItems(#initPropData,function(idx)
local item=self.costlist:getChildLayoutGroupGridItem(idx-1)
local propdata=initPropData[idx]
item:SetChildPropData(-1,propdata)

item:SetBaseItemClickEvent(-1,function(itemid,index,guid,attach)
local deltaCnt=deltaNum[idx]
if deltaCnt[2]>0 then
gainControl:showCommonGainWin_item(itemid,{needCount=deltaCnt[1]})
else
itemsComponentHelper.onItemClickEx(itemid,index,guid,attach)
end
end)
end)
end


function UIDiscipleLinggen_StrengthenLinggenWin:bindUpLvNode(index)
local item=self.uplvnodeContent:getChildLayoutGroupGridItem(index-1)







local isAssertVary=UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)
local averageLv=UIDiscipleModel:getLingGenAverageMaxLevel(self.disciple_guid)

local nodeNum=cfgHelper.getdef1(cfg_disciplespiritrootnodeconfig,'nodeNum')
local varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
local maxNum=self.isVary and nodeNum[2]or nodeNum[1]

local curLv=self.data.lv
local nextLv=self.lv_node_lookup[self.lglen][curLv+1]and curLv+1 or curLv
local nextNodeIndex=maxNum>=index+1 and index+1 or index


local nodeCfg=cfgHelper.get1(cfg_disciplespiritrootnodeconfig_get,index)
local nextNodeCfg=cfgHelper.get1(cfg_disciplespiritrootnodeconfig_get,nextNodeIndex)

local nodeLvLimitMin,nodeLvLimitMax=nodeCfg.lvrange[self.lglen][1],nodeCfg.lvrange[self.lglen][2]
local nextNodeLvLimitMin,nextNodeLvLimitMax=nextNodeCfg.lvrange[self.lglen][1],nextNodeCfg.lvrange[self.lglen][2]

local isActive=curLv>=nodeLvLimitMin and curLv~=0
local isLineActive=curLv>=nextNodeLvLimitMin and index~=maxNum
if nodeLvLimitMax>averageLv then
isLineActive=isLineActive and isAssertVary
isActive=isActive and isAssertVary
end
item:SetChildActive(-1,true)


local iconName
local iconIndex=index>nodeNum[1]and self.data.type*2 or self.data.type*2-1
if nodeCfg.nodetype==1 then
iconName=FMT.fmt('image_linggen_xiaodian{0}',iconIndex)
item:SetChildScale(CmpUpLvNodeItemIndex.select,Vector3.New(0.58,0.58,1))
else
iconName=FMT.fmt('image_linggen_dadian{0}',iconIndex)
item:SetChildScale(CmpUpLvNodeItemIndex.select,Vector3.New(0.9,0.9,1))
end
item:SetChildCSImageSprite(CmpUpLvNodeItemIndex.activeIcon,globalABLookup.varylinggensprite,iconName)
item:SetChildGray(CmpUpLvNodeItemIndex.activeIcon,not isActive)


local iconName=FMT.fmt('frame_linggen_xian{0}',self.data.type)
item:SetChildCSImageSprite(2,globalABLookup.varylinggensprite,iconName)
item:SetChildCSImageSprite(3,globalABLookup.varylinggensprite,iconName)
item:SetChildActive(4,index~=maxNum)
local curValue=isLineActive and 1 or 0
item:SetChildIconFillAmount(3,curValue)


if index~=maxNum then
local curPos=nodeCfg.nodepos[self.data.type]
local nextNodePostable=cfgHelper.get2(cfg_disciplespiritrootnodeconfig_get,index+1,'nodepos')
local nextNodePos=nextNodePostable[self.data.type]
local dis=Vector2.Distance(Vector2.New(curPos[1],curPos[2]),Vector2.New(nextNodePos[1],nextNodePos[2]))
item:SetChildSizeDelta(2,dis,23)
item:SetChildSizeDelta(3,dis,23)
local dir=Vector2.New(nextNodePos[1],nextNodePos[2])-Vector2.New(curPos[1],curPos[2])
local angle=Mathf.Atan2(dir.y,dir.x)*180/Mathf.PI
item:SetChildRotation(2,0,0,angle)
item:SetChildRotation(3,0,0,angle)
end


item:SetChildShowEffect(1,10415,self.selectIndex==index)


item:SetBaseItemClickEvent(-1,function()

local preitem=self.uplvnodeContent:getChildLayoutGroupGridItem(self.selectIndex-1)
preitem:SetChildActive(1,false)

self.selectIndex=index
item:SetChildActive(1,true)
self:onClickUpLvNode(index)
end)

local pos=nodeCfg.nodepos[self.data.type]
item:SetChildLocalPosition(-1,Vector3(pos[1],pos[2],0))
self.upLvNodeListHeight=Mathf.Max(self.upLvNodeListHeight,pos[2]+300)

self.uplvnodeContent:setChildSizeDelta(696.9823,self.upLvNodeListHeight)
end

function UIDiscipleLinggen_StrengthenLinggenWin:onClickUpLvNode(index)
self.selectIndex=index
self:refreshStrengthenPanel(index)
self:freshSingleUpLvNode(index)
end





function UIDiscipleLinggen_StrengthenLinggenWin:getLingGenMaxLevel()
local lv=UIDiscipleModel:getLingGenAverageMaxLevel(self.disciple_guid)
local extra=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'extra')
local varyid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
local isAssertVary=UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)
if self.data.varyState==1 and self.data.type==varyid and isAssertVary then
lv=lv+extra
end
return lv
end

local transMap=function(keyindex,list)
local temp={}
for k,v in pairs(list)do
temp[v[keyindex]]=v
end
return temp
end

function UIDiscipleLinggen_StrengthenLinggenWin:compareAddtion(guid,lgtype,lglv1,lglv2,showDValue,isStart,baselv)
local lgLvCfg=cfg_disciplespiritrootlevelconfig()
local lvCfg1=lgLvCfg[self.lglen][lgtype][lglv1]or{}
local lvCfg2=lgLvCfg[self.lglen][lgtype][lglv2]
local lvCfg3=baselv and lgLvCfg[self.lglen][lgtype][baselv]

local compareAttrList={}

local isSumeLv=lglv1==lglv2


local baseTransAttr1=transMap(1,table.deepCopy(lvCfg1 and lvCfg1.attr or{}))
local baseTransAttr2=transMap(1,table.deepCopy(lvCfg2 and lvCfg2.attr or{}))
local baseTransAttr3=lvCfg3 and transMap(1,table.deepCopy(lvCfg3 and lvCfg3.attr or{}))
for attrtype,v in pairs(baseTransAttr2)do
local type=v[1]
local value=v[2]
local attrcfg=helper.getAttributeCfg(type)

local cdata=baseTransAttr1[type]
local addValue=0
local isAdd=false
if isSumeLv then
if cdata then
local cvalue=cdata[2]
if baseTransAttr3 then
addValue=value-cvalue
isAdd=value>cvalue
if baseTransAttr1[type]then
value=cvalue-baseTransAttr3[type][2]
else
value=cvalue
end
end
end
table.insert(compareAttrList,{
info=helper.getAttributeStr(type,value,nil,"{0}:{1}"),
type=type,
value=value,
addvalue=0,
isAdd=false,
sortWidget=attrcfg.priority
})
else
if cdata then
local cvalue=cdata[2]
local isAdd=false
if baseTransAttr3 then
addValue=value-cvalue
isAdd=value>cvalue
if baseTransAttr1[type]then
value=cvalue-baseTransAttr3[type][2]
else
value=cvalue
end
else
if showDValue then
value=value-cvalue
else
addValue=value-cvalue
isAdd=value>cvalue
end
end


if isStart then
value=0
end

table.insert(compareAttrList,{
info=helper.getAttributeStr(type,value,nil,"{0}:{1}"),
type=type,
value=value,
addvalue=addValue,
isAdd=isAdd,
sortWidget=attrcfg.priority
})
else
if not showDValue then
addValue=value
value=0
isAdd=true
else
addValue=0
isAdd=false
end
table.insert(compareAttrList,{
info=helper.getAttributeStr(type,value,nil,"{0}:{1}"),
type=type,
value=value,
isAdd=isAdd,
isNew=true,
addvalue=addValue,
sortWidget=attrcfg.priority
})
end
end
end

local excludeZeroList={}
for k,v in pairs(compareAttrList)do
if v.value>0 or v.isNew or v.isAdd then
table.insert(excludeZeroList,v)
end
end

compareAttrList=excludeZeroList


table.sort(compareAttrList,function(a1,a2)
return a1.sortWidget<a2.sortWidget
end)

return compareAttrList
end


function UIDiscipleLinggen_StrengthenLinggenWin:buildLvToNodeLoopUp()
local nodecfg=cfg_disciplespiritrootnodeconfig()
for len=1,5 do
self.lv_node_lookup[len]={}
self.lv_node_Count[len]={}
self.lv_node_lookup[len][0]=1
for nodeindex=1,#nodecfg do
local cfg=nodecfg[nodeindex]
local range=cfg.lvrange[len]
for i=range[1],range[2]do
self.lv_node_lookup[len][i]=nodeindex
self.lv_node_Count[len][nodeindex]=self.lv_node_Count[len][nodeindex]and self.lv_node_Count[len][nodeindex]+1 or 1
end
end
end
end

function UIDiscipleLinggen_StrengthenLinggenWin:checkStrengthen()
local lvCfg=cfgHelper.get3(cfg_disciplespiritrootlevelconfig_get,self.lglen,self.data.type,self.data.lv)
local consume=lvCfg.consume

local state=true
local gainItemId
local gainNum
for k,itemdata in pairs(consume)do
local itemid=itemdata[1]
local hasnum=itemsModel.getCount(itemid)
local neednum=itemdata[2]
state=state and hasnum>=neednum
if not state then
gainItemId=itemid
gainNum=neednum
break
end
end
return state,gainItemId,gainNum
end


function UIDiscipleLinggen_StrengthenLinggenWin:onDiscipleLingGenUpLevel(dz_guid,linggen_id,linggen_lv)
if mathHelper.compareInt64(dz_guid,self.disciple_guid)and self.data.type==linggen_id then
self.data.lv=linggen_lv
self.data.source.param_2=linggen_lv

local varyid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
local isVary=varyid==self.data.type and UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)
if isVary~=self.isVary then
self.isVary=isVary
self:onShowArgRecv(_this)
else
local nextLv=Mathf.Min(linggen_lv+1,self.maxLv)
local nextIndex=self.lv_node_lookup[self.lglen][nextLv]
local index=self.lv_node_lookup[self.lglen][linggen_lv]
local preitem=self.uplvnodeContent:getChildLayoutGroupGridItem(self.selectIndex-1)
preitem:SetChildActive(1,false)
local func=function()

self.prohibitState=false

if self.selectIndex~=nextIndex then
self.selectIndex=nextIndex
self:freshSingleUpLvNode(nextIndex)
end
self:activeStrengthenPanel()

self:freshSingleUpLvNode(index)
self:freshSingleUpLvNode(Mathf.Max(index-1,1))

self:refreshHiddenSkillList()
self:refreshHiddenSlotOpenProgress()
self:refreshOther()
end



local reducelv=Mathf.Max(linggen_lv-1,1)
if index==self.lv_node_lookup[self.lglen][reducelv]then

self:playUpLvAniamtion1(index)
func()
else

self:jumpToUpLvNode(nextIndex)
self:playUpLvAniamtion2(index,func)
end

self:refreshDetalAttrPanel()
end


end
end

function UIDiscipleLinggen_StrengthenLinggenWin:onDiscipleLingGenResetLevel(dz_guid,linggen_id,linggen_lv)
if mathHelper.compareInt64(dz_guid,self.disciple_guid)and self.data.type==linggen_id then
self.data.source.param_2=linggen_lv
self.data.lv=linggen_lv
self.isJumpFirst=false
self.selectIndex=1

self.isVary=self.isVary and UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)

self:refresh()
self:jumpToUpLvNode(self.selectIndex)
end
end

function UIDiscipleLinggen_StrengthenLinggenWin:onDiscipleLingGenEquipBoard(dz_guid,pos,data)
if mathHelper.compareInt64(dz_guid,self.disciple_guid)then
self:refreshHiddenSkillList()
end
end

function UIDiscipleLinggen_StrengthenLinggenWin:on_item_list_changed()
self:activeStrengthenPanel()
end

function UIDiscipleLinggen_StrengthenLinggenWin:onNewDay()
self:onShowResetAllBack()
end

function UIDiscipleLinggen_StrengthenLinggenWin:onNewDay5am()
self:onShowResetAllBack()
end

function UIDiscipleLinggen_StrengthenLinggenWin:onShowResetAllBack()
self.resetAllBackArgs=nil
local reset_all_back=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'reset_all_back')
self.resetAllBackImage:setActive(false)
if not reset_all_back then
self.resetAllBackBtn:setActive(false)
return false
end

local openStamp=timeHelper.getServerLongTime()

local isShow=false
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.disciple_guid)
if reset_all_back[imageInfo.job]~=nil then
local minTime=timeHelper.dataToTimeStam(reset_all_back[imageInfo.job][1])
local maxTime=timeHelper.dataToTimeStam(reset_all_back[imageInfo.job][2])
if openStamp>=minTime and openStamp<=maxTime then
isShow=true
end
end
if not isShow then
self.resetAllBackBtn:setActive(false)
return false
end

local jobStr
for jobId,v in pairs(reset_all_back)do
local minTime=timeHelper.dataToTimeStam(v[1])
local maxTime=timeHelper.dataToTimeStam(v[2])
if openStamp>=minTime and openStamp<=maxTime then
if not self.resetAllBackArgs then
self.resetAllBackArgs={}
self.resetAllBackArgs.type=2
self.resetAllBackArgs.timeStr=FMT.fmt("{0} - {1}",v[1],v[2])
end
local jobName=UIDiscipleModel:getJobName(jobId)
if not jobStr then
jobStr=jobName
else
jobStr=FMT.fmt("{0}、{1}",jobStr,jobName)
end
end
end
if self.resetAllBackArgs~=nil then
local moneyStr
local resetlgpercent=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'resetlgpercent')
for id,v in pairs(resetlgpercent)do
local name=itemsModel.getName(id)
if not moneyStr then
moneyStr=name
else
moneyStr=FMT.fmt("{0}、{1}",moneyStr,name)
end
end
self.resetAllBackArgs.descStr=FMT.fmt("活动期间<color=#fd8950>{0}</color>职业重置灵根将<color=#fd8950>返还100%</color>强化消耗的<color=#fd8950>{1}</color>",jobStr,moneyStr)
end
self.resetAllBackBtn:setActive(self.resetAllBackArgs~=nil)
return self.resetAllBackArgs~=nil
end




function UIDiscipleLinggen_StrengthenLinggenWin:onResetBtn()
if self.data.lv~=0 then
local resetlgpercent=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'resetlgpercent')
local reset_all_back=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'reset_all_back')
local count=resetlgpercent[eMoneyType.mtWuXingYuBi]

local isAllBack=false
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.disciple_guid)
if reset_all_back[imageInfo.job]~=nil then
local openStamp=timeHelper.getServerLongTime()
local minTime=timeHelper.dataToTimeStam(reset_all_back[imageInfo.job][1])
local maxTime=timeHelper.dataToTimeStam(reset_all_back[imageInfo.job][2])
if openStamp>=minTime and openStamp<=maxTime then
isAllBack=true
count=100
end
end

local timeStr=nil
local content=nil
if isAllBack then
content=self.resetAllBackArgs.descStr
timeStr=FMT.fmt("<color=#fd8950>活动时间：\n{0}</color>",self.resetAllBackArgs.timeStr)
else
content=FMT.fmt("灵根强化等级重置为0级并返回所有强化材料与{0}%的五行玉币，是否重置？",count)
end
local showdata=
{
type=isAllBack and'UIDialougeLingGenResetAllBack'or'UIDialouge',
title='提示',
content=content,
timeStr=timeStr,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
UIDiscipleController:do_send_2_132(self.disciple_guid,self.data.type)
end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
UIManager.info("灵根等级为0，无法重置")
end
end



function UIDiscipleLinggen_StrengthenLinggenWin:onStrengthenBtn()












end

function UIDiscipleLinggen_StrengthenLinggenWin:onLongPressStrengthenBtn()
if not self.prohibitState then
local state,itemid,itemNum=self:checkStrengthen()
if state then
if not self.prohibitState then
self.prohibitState=true
UIDiscipleController:do_send_2_131(self.disciple_guid,self.data.type)
end
else
UIManager.info("消耗道具不足")

gainControl:showCommonGainWin_item(itemid,{needCount=itemNum})
end
end
end


function UIDiscipleLinggen_StrengthenLinggenWin:onCloseBtn()
UIManager:invokeUIMethod('UIDiscipleLinggenlInfoWin','refresh')
self:closeSelf()
end

function UIDiscipleLinggen_StrengthenLinggenWin:onSwitchLeftBtn()
if self.lgtabindex-1==0 then
self.lgtabindex=self.lglen+1
end
local data=self.lglist[self.lgtabindex-1]
local callback=function()
self.isJumpFirst=false
UIManager:showWindow("UIDiscipleLinggen_StrengthenLinggenWin",{
disciple_guid=_this.disciple_guid,
data=data,
isShowStrengthenPanel=true,
})
end
UIManager:showWindow("UIFightPrepareLoading",{para=1,startCallback=callback})
end

function UIDiscipleLinggen_StrengthenLinggenWin:onSwitchRightBtn()
if self.lgtabindex==self.lglen then
self.lgtabindex=0
end
local data=self.lglist[self.lgtabindex+1]
local callback=function()
self.isJumpFirst=false
UIManager:showWindow("UIDiscipleLinggen_StrengthenLinggenWin",{
disciple_guid=_this.disciple_guid,
data=data,
isShowStrengthenPanel=true,
})
end
UIManager:showWindow("UIFightPrepareLoading",{para=1,startCallback=callback})
end

function UIDiscipleLinggen_StrengthenLinggenWin:onDetalAttrbtn()
if self.data.lv>0 then
self.isShowDetalAttr=not self.isShowDetalAttr
self.detalAttrRoot:setActive(self.isShowDetalAttr)

if self.isShowDetalAttr then
self.detalAttrRoot:setChildCanvasGroupAlpha(0)
self.detalAttrRoot:setChildCanvasGroupDOFade(1,0.2,nil)
self.winlua:ForceLayoutRect(self.detalAttrRoot:getID())
end
else
UIManager.info("暂未强化灵根")
end
end

function UIDiscipleLinggen_StrengthenLinggenWin:onResetAllBackBtn()
if not self.resetAllBackArgs then
if not self:onShowResetAllBack()then
UIManager.info('不在返还活动期间')
return
end
end
self.resetAllBackArgs.closeFunc=function()
_this.resetAllBackImage:setActive(false)
end
self.resetAllBackImage:setActive(true)
self:showWindow("UIDiscipleLinggenResetAllBackWin",self.resetAllBackArgs)
end

function UIDiscipleLinggen_StrengthenLinggenWin:refreshDetalAttrPanel()

local isAssertVary=UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)
local averageLv=UIDiscipleModel:getLingGenAverageMaxLevel(self.disciple_guid)
local maxlv=self.data.lv
if not isAssertVary and self.data.lv>averageLv then
maxlv=averageLv
end

local attrs=self:compareAddtion(self.disciple_guid,self.data.type,0,maxlv,false)

local extra_upmzzl_desc=cfgHelper.get4(cfg_disciplespiritrootlevelconfig_get,self.lglen,self.data.type,maxlv,'effects_dvalue_desc')or{}
for k,v in pairs(extra_upmzzl_desc[self.lglen]or{})do
table.insert(attrs,{info=v,addvalue=0})
end

self.detalAttrList:setChildLayoutGroupCreateItems(#attrs,function(index)
local item=self.detalAttrList:getChildLayoutGroupGridItem(index-1)
local data=attrs[index]

item:SetChildActive(-1,data~=nil)
if data then
local name
local val
if data.type then
name=helper.getAttributeName(data.type)
val=helper.getAttributeStrEx(data.type,data.addvalue)

if data.type>100 then
name=toColorStringX("#fd8950",name)
val=toColorStringX("#fd8950",val)
end
else
local strlist=string.split(data.info,'+')
name=toColorStringX("#fd8950",strlist[1])
val=toColorStringX("#fd8950",strlist[2])
end

item:SetChildText(0,name)
item:SetChildText(1,val)
end
end)

self.winlua:ForceLayoutRect(self.detalAttrRoot:getID())
end


function UIDiscipleLinggen_StrengthenLinggenWin:playUpLvAniamtion1(index)
local item=self.uplvnodeContent:getChildLayoutGroupGridItem(index-1)
item:SetChildShowEffect(6,10413,true)
end

function UIDiscipleLinggen_StrengthenLinggenWin:playUpLvAniamtion2(index,callback)
local preitem=self.uplvnodeContent:getChildLayoutGroupGridItem(index-2)
local item=self.uplvnodeContent:getChildLayoutGroupGridItem(index-1)

if self.lineProgressDT then
local lineitem=self.uplvnodeContent:getChildLayoutGroupGridItem(index-2)
lineitem:SetChildIconFillAmount(3,1)
self.lineProgressDT:Kill()
end


local duration=0.2
self.lineProgressDT=preitem:SetChildImageDOFillAmount(3,1,duration,nil)

self:delayDo(duration,function()
item:SetChildShowEffect(6,10413,true)
if callback then
callback()
end
end)
end