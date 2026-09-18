







def_class("UIYunZhouZhenTuWin",UIWindowBase)









function UIYunZhouZhenTuWin:bindComponents()

self.bgspine=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.uplvnodeList=UIObject.get(self,2)
self.detalAttrRoot=UIObject.get(self,3)
self.progressRoot=UIObject.get(self,4)
self.AllAttrbtn=UIButton.get(self,5)
self.hiddenlist=UIObject.get(self,7)
self.strengthenBtn=UIButton.get(self,8)
self.costicon=UIObject.get(self,9)
self.costnum=UIText.get(self,10)
self.closeBtn=UIButton.get(self,11)
self.uplvnodeContent=UIObject.get(self,12)
self.detalAttrList=UIObject.get(self,13)
self.strengthPanel=UIObject.get(self,14)
self.skillbtn=UIButton.get(self,15)
self.sgreddot=UIObject.get(self,16)
self.tipsbtn=UIButton.get(self,17)

self.AllAttrbtn:setButtonClick(function()self:onAllAttrbtn()end)

self.strengthenBtn:setButtonClick(function()self:onStrengthenBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.skillbtn:setButtonClick(function()self:onSkillbtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)



end


function UIYunZhouZhenTuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgspine);self.bgspine=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uplvnodeList);self.uplvnodeList=nil;
_UIObject_release(self.detalAttrRoot);self.detalAttrRoot=nil;
_UIObject_release(self.progressRoot);self.progressRoot=nil;
_UIObject_release(self.AllAttrbtn);self.AllAttrbtn=nil;
_UIObject_release(self.hiddenlist);self.hiddenlist=nil;
_UIObject_release(self.strengthenBtn);self.strengthenBtn=nil;
_UIObject_release(self.costicon);self.costicon=nil;
_UIObject_release(self.costnum);self.costnum=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.uplvnodeContent);self.uplvnodeContent=nil;
_UIObject_release(self.detalAttrList);self.detalAttrList=nil;
_UIObject_release(self.strengthPanel);self.strengthPanel=nil;
_UIObject_release(self.skillbtn);self.skillbtn=nil;
_UIObject_release(self.sgreddot);self.sgreddot=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
end
















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

local ztitemidx=
{
selfitem=0,
bg=1,
iconbg=2,
icon=3,
select=4,
name=5,
lvl=6,
btn=7,
reddot=8
}
local nodeitemidx=
{
toppanel=0,
nodeicon=1,
nodename=2,

midpanel=3,
attrlist=4,

midtwopanel=5,
skillicon=6,
skillname=7,
skilldesc=8,

botton=9,
costlist=10,
costroot=11,
ymjimg=12,
longclicktip=13,

qianhuatxt=14,
locktxt=15,
}
local UpBtnName={"激活","强化","突破"}
local abname=''




function UIYunZhouZhenTuWin:onLoaded(...)
self:bindComponents()
_this=self
self.upLvNodeListHeight=0
self.lv_node_lookup={}
self.lv_node_Count={}
self.hoardHoleState={}

self.selectZTid=1
self.selectNodeidx=1
self.selectChongidx=1
self.widgetNode=self.strengthPanel:getWidgetBase()

self:addNotify(notifyConfig.onYunZhouZhenTuUpLevel,function(...)self:onYunZhouZhenTuUpLevel(...)end)





self.strengthenBtn:setChildLongPress(1,function()
if not _this then return end
_this:onLongPressStrengthenBtn()
end,nil)
UIManager:showWindow("UITopMaskWin")
end


function UIYunZhouZhenTuWin:__delete()
self:unbindComponents()
_this=nil
end


function UIYunZhouZhenTuWin:onNewDay()
end

function UIYunZhouZhenTuWin:onNewDay5am()
end

function UIYunZhouZhenTuWin:on_item_list_changed()

end

function UIYunZhouZhenTuWin:on_money_changed(mType,oldValue,newValue)
if _this.moneyId==mType then

end
end


function UIYunZhouZhenTuWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UIYunZhouZhenTuWin:onZTItemClick(index)
if self.selectZTid==index then
return
end
local old_index=self.selectZTid
self.selectZTid=index

if old_index>0 then
local old_item=self.hiddenlist:getChildLayoutGroupGridItem(old_index-1)
if old_item then
old_item:SetChildActive(ztitemidx.select,false)
end
end
local item=self.hiddenlist:getChildLayoutGroupGridItem(index-1)
if item then
item:SetChildActive(ztitemidx.select,true)
end


local yzztData=YunZhouZhenTuModel:getYZZTDataByID(self.selectZTid)
local Cfg_zt=self:getCfgByZT(self.selectZTid)
local Chongidx,Nodeidx=self:getNextChongidxAndNodeidx(Cfg_zt,yzztData,1,1)
self.selectNodeidx=Nodeidx
self.selectChongidx=Chongidx


self:refreshUpLvNodeList()

self:refreshRightNodePanel()
end


function UIYunZhouZhenTuWin:onTipsbtn()
local d={}
d.title='规则'
d.mode=3
d.name='ui_UIMoJieForceMainWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIYunZhouZhenTuWin:onAllAttrbtn()
self:showWindow('UIYunZhouZhenTuAttrWin')
end

function UIYunZhouZhenTuWin:onSkillbtn()

self:showWindow('UIYunZhouZhenTuAttrWin')
end

function UIYunZhouZhenTuWin:onStrengthenBtn()
end
function UIYunZhouZhenTuWin:onLongPressStrengthenBtn()
if not self.prohibitState then
local Nodeidx=self.selectNodeidx
local Chongidx=self.selectChongidx
local Cfg_zt=self:getCfgByZT(self.selectZTid)
local Nodeid=self:getNodeid(Cfg_zt,Chongidx,Nodeidx)
local Cfg_Node=self:getCfgByNode(Nodeid)
local cost=Cfg_Node.useItems
local state,itemid,itemNum=self:checkStrengthen(cost)
if state then
if not self.prohibitState then
self.prohibitState=true
YunZhouZhenTuController:send_6_190(self.selectZTid,Chongidx,Nodeidx)

end
else

gainControl:showCommonGainWin_item(itemid,{needCount=itemNum})
end
end
end





function UIYunZhouZhenTuWin:onShow(argtable,afterOnloaded)
if afterOnloaded then

end



self.Cfg_zt=cfg_yunzhouzhentuconfig()
self.Cfg_chongshu=cfg_zhentuchongshuconfig()
self.Cfg_zhenshu=cfg_zhenshujiedianconfig()

if argtable then
if argtable.ztid then
self.selectZTid=argtable.ztid
end
end
self.prohibitState=false

self:refresh(true)

end
function UIYunZhouZhenTuWin:onShowArgRecv(args)
self.isJumpFirst=false
self:onShow(args)
end

function UIYunZhouZhenTuWin:onHide()

end
function UIYunZhouZhenTuWin:onCloseBtn()
self:closeSelf()
end
function UIYunZhouZhenTuWin:refresh(init)
self:refreshZTList(init)
self:refreshUpLvNodeList()
self:refreshRightNodePanel()
end


function UIYunZhouZhenTuWin:refreshZTList()
local ztlist=self.Cfg_zt
local len=#ztlist
self.hiddenlist:setChildLayoutGroupCreateItems(len,function(index)
self:refreshSingleZT(index,ztlist[index])
end)
end
function UIYunZhouZhenTuWin:refreshSingleZT(index,Cfg_zt)
local item=self.hiddenlist:getChildLayoutGroupGridItem(index-1)
local ztid=index
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
local isjihuo=false
if yzztData then
isjihuo=true
end

local Chongidx,Nodeidx=self:getNextChongidxAndNodeidx(Cfg_zt,yzztData,1,1)
local Chongid=self:getChongid(Cfg_zt,Chongidx)
local Cfg_chongshu=self:getCfgByCS(Chongid)



item:SetChildText(ztitemidx.name,Cfg_zt.name)

if isjihuo then
local cs_name=Cfg_chongshu.name
local lvl=FMT.fmt("<color=#549327>{0}</color>",cs_name)
item:SetChildText(ztitemidx.lvl,lvl)
else
local lvl="<color=#c82c2c>未激活</color>"
item:SetChildText(ztitemidx.lvl,lvl)
end

if self.selectZTid==index then
item:SetChildActive(ztitemidx.select,true)
self.selectNodeidx=Nodeidx
self.selectChongidx=Chongidx

else
item:SetChildActive(ztitemidx.select,false)
end

item:SetChildButtonClick(ztitemidx.btn,function()
if _this==nil then return end
self:onZTItemClick(index,Cfg_zt)
end)


local reddot=self:checkUpReddot()
item:SetChildActive(ztitemidx.reddot,reddot)
end

function UIYunZhouZhenTuWin:refreshReddotZT()
local ztlist=self.Cfg_zt
local len=#ztlist
for index=1,len do
local item=self.hiddenlist:getChildLayoutGroupGridItem(index-1)
local reddot=self:checkUpReddot()
item:SetChildActive(ztitemidx.reddot,reddot)
end
end

function UIYunZhouZhenTuWin:refreshSingleUpLvZT(index,Cfg_zt,Chongidx,isjihuo)
local item=self.hiddenlist:getChildLayoutGroupGridItem(index-1)
local Chongid=self:getChongid(Cfg_zt,Chongidx)
local Cfg_chongshu=self:getCfgByCS(Chongid)



item:SetChildText(ztitemidx.name,Cfg_zt.name)

if isjihuo then
local cs_name=Cfg_chongshu.name
local lvl=FMT.fmt("<color=#549327>{0}</color>",cs_name)
item:SetChildText(ztitemidx.lvl,lvl)
else
local lvl="<color=#c82c2c>未激活</color>"
item:SetChildText(ztitemidx.lvl,lvl)
end

self:refreshReddotZT()
end


function UIYunZhouZhenTuWin:refreshRightNodePanel()
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(self.selectZTid)
local effectLevel=0
local Nodeidx=self.selectNodeidx
local Chongidx=self.selectChongidx
local Cfg_zt=self:getCfgByZT(self.selectZTid)
local Nodeid=self:getNodeid(Cfg_zt,Chongidx,Nodeidx)
local Cfg_Node=self:getCfgByNode(Nodeid)
local canUpSkill=Cfg_Node.effectLevel>0 and true or false
local jzattr=Cfg_Node.jzattr
local zstype=Cfg_Node.zstype
local unlock=Cfg_Node.unlock
local jihuo=false
local isMaxNode=false
if yzztData then
jihuo=true
effectLevel=yzztData.effectLevel
isMaxNode=self:checkIsMaxNode(Cfg_zt,yzztData.chongshu,yzztData.zhenshuMax)
end




self.widgetNode:SetChildText(nodeitemidx.nodename,Cfg_Node.name)
self.widgetNode:SetChildText(nodeitemidx.qianhuatxt,UpBtnName[zstype])


if jzattr then
local nextjzattr
local nextChongidx,nextNodeidx=self:getNextChongidxAndNodeidx(Cfg_zt,yzztData,Chongidx,Nodeidx)
if Nodeidx~=nextNodeidx then
local nextNodeid=self:getNodeid(Cfg_zt,nextChongidx,nextNodeidx)
local nextCfg_Node=self:getCfgByNode(nextNodeid)
nextjzattr=nextCfg_Node.jzattr
end

local attrs=self:getAttrInfoList(jzattr,nextjzattr)
self.widgetNode:SetChildLayoutGroupCreateItems(nodeitemidx.attrlist,#attrs,function(index)
local item=self.widgetNode:GetChildLayoutGroupGridItem(nodeitemidx.attrlist,index-1)
local data=attrs[index]
local name=helper.getAttributeName(data.attrId)
local sVal=helper.getAttributeStrEx(data.attrId,data.attrVal)
local str=FMT.fmt('{0}：{1}',name,sVal)
item:SetChildText(0,str)
item:SetChildActive(1,data.isAdd)
if data.isAdd then
local addVal=helper.getAttributeStrEx(data.attrId,data.addVal)
item:SetChildText(1,addVal)
end
end)
end


local skillicon=Cfg_zt.skillicon



if effectLevel>0 then
self.widgetNode:SetChildGray(nodeitemidx.skillicon,false)

local name=''
if self:checkIsMaxSkillLvl(Cfg_zt,effectLevel)then
name=FMT.fmt('{0}  <color=#549327>{1}级</color>',Cfg_zt.skillname,effectLevel)
else
name=FMT.fmt('{0}  <color=#549327>{1}级 下一级：{2}</color>',Cfg_zt.skillname,effectLevel,effectLevel+1)
end
self.widgetNode:SetChildText(nodeitemidx.skillname,name)


local descs=Cfg_zt.Upskilldesc
local parmdescs=Cfg_zt.Upskilldesc2
if canUpSkill and not isMaxNode then
parmdescs=Cfg_zt.Upskilldesc3
end
local desc=''
xpcall(function()
desc=FMT.fmt(descs,unpack(parmdescs[effectLevel]))
end,function(err)
logErr(FMT.fmt('技能描述参数报错,当前云舟阵图技能等级{0}',effectLevel))
end)
self.widgetNode:SetChildText(nodeitemidx.skilldesc,desc)
else
self.widgetNode:SetChildGray(nodeitemidx.skillicon,true)

local name=FMT.fmt('{0}<color=#549327>（激活）</color>',Cfg_zt.skillname)
self.widgetNode:SetChildText(nodeitemidx.skillname,name)

local descs=Cfg_zt.Upskilldesc
local parmdescs=Cfg_zt.Upskilldesc2
local desc=''
xpcall(function()
desc=FMT.fmt(descs,unpack(parmdescs[effectLevel]))
end,function(err)
logErr(FMT.fmt('技能描述参数报错,当前云舟阵图技能等级{0}',effectLevel))
end)
desc=FMT.fmt("<color=#827f78>{0}</color>",desc)
self.widgetNode:SetChildText(nodeitemidx.skilldesc,desc)
end


local isunlock,lockStr=YunZhouZhenTuModel:checkUnlockNode(unlock)
if isunlock then
self.widgetNode:SetChildActive(nodeitemidx.locktxt,false)

if isMaxNode then
self.widgetNode:SetChildActive(nodeitemidx.botton,false)
self.widgetNode:SetChildActive(nodeitemidx.ymjimg,true)
else
self.widgetNode:SetChildActive(nodeitemidx.botton,true)
self.widgetNode:SetChildActive(nodeitemidx.ymjimg,false)

local cost=Cfg_Node.useItems
self:refreshStrengthenBtn(self.widgetNode,cost)


local state=self:checkStrengthen(cost)
self.sgreddot:setActive(state)
end
else
self.widgetNode:SetChildActive(nodeitemidx.botton,false)
self.widgetNode:SetChildActive(nodeitemidx.locktxt,true)
self.widgetNode:SetChildActive(nodeitemidx.ymjimg,false)
self.widgetNode:SetChildText(nodeitemidx.locktxt,lockStr)
end
end

function UIYunZhouZhenTuWin:refreshStrengthenBtn(widgetNode,cost)

if cost then
widgetNode:SetChildActive(nodeitemidx.costlist,true)
widgetNode:SetChildLayoutGroupCreateItems(nodeitemidx.costlist,#cost,function(idx)
local item=widgetNode:GetChildLayoutGroupGridItem(nodeitemidx.costlist,idx-1)
local costdata=cost[idx]
local itemid=costdata[1]
local needNum=costdata[2]
local hasNum=0
if moneyConfig.isMoney(itemid)then
hasNum=moneyModel.getMoney(itemid)
else
hasNum=bagModel.getItemCountById(itemid)
end
local hasColor=hasNum>=needNum and FONT_COLOR.eGrayWhiteTxtColor or FONT_COLOR.eRedColor
hasNum=FMT.fmt('{0}',mathHelper.formatNumber9(hasNum,1))
needNum=FMT.fmt('{0}',mathHelper.formatNumber9(needNum,1))

local countdesc=toColorString(hasColor,FMT.fmt('{0}/{1}',hasNum,needNum))
local grayNum=hasNum>=needNum and 0 or 1
local conf={itemid=itemid,itemcount=countdesc,showCountBG=true,showname=false,gray=grayNum}
local propdata=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(-1,propdata)
item:SetBaseItemClickEvent(-1,function(...)
if _this==nil then return end
self:onClickItem(...)
end)
end)
else
widgetNode:SetChildActive(nodeitemidx.costlist,false)
end
end


function UIYunZhouZhenTuWin:refreshUpLvNodeList()
self.uplvnodeList:setChildCanvasGroupAlpha(0)
self.upLvNodeListHeight=0
local Cfg_zt=self:getCfgByZT(self.selectZTid)
local chongid=self:getChongid(Cfg_zt,self.selectChongidx)
local chongshuCfg=self:getCfgByCS(chongid)
local zhenshuList=chongshuCfg.zhenshuList
local nodeNum=#zhenshuList
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(self.selectZTid)
local zhenshuMax=0
if yzztData then
zhenshuMax=yzztData.zhenshuMax
local sever_cs=yzztData.chongshu
if sever_cs~=self.selectChongidx then
zhenshuMax=0
end
end

self.uplvnodeContent:setChildLayoutGroupClearAllItems()
self.uplvnodeContent:setChildLayoutGroupCreateItems(nodeNum,function(index)
self:bindUpLvNode(index,zhenshuMax,zhenshuList)
end)
self.uplvnodeList:setChildCanvasGroupDOFade(1,0.2,nil)
end
function UIYunZhouZhenTuWin:bindUpLvNode(index,zhenshuMax,zhenshuList)
local item=self.uplvnodeContent:getChildLayoutGroupGridItem(index-1)





local maxNum=#zhenshuList
local Nodeid=zhenshuList[index]
local nextNodeIndex=maxNum>=index+1 and index+1 or index
local nextNodeid=zhenshuList[nextNodeIndex]
local isNotMaxNode=index~=maxNum

local nodeCfg=self:getCfgByNode(Nodeid)
local nextNodeCfg=self:getCfgByNode(nextNodeid)
local isActive=zhenshuMax>=index
local isLineActive=zhenshuMax>=nextNodeIndex and isNotMaxNode
item:SetChildActive(-1,true)


self:freshNodeIcon(item,isActive,isLineActive,nodeCfg,isNotMaxNode)


if index~=maxNum then
local curPos=nodeCfg.nodepos
local nextNodePos=nextNodeCfg.nodepos
local dis=Vector2.Distance(Vector2.New(curPos[1],curPos[2]),Vector2.New(nextNodePos[1],nextNodePos[2]))
item:SetChildSizeDelta(2,dis,23)
item:SetChildSizeDelta(3,dis,23)
local dir=Vector2.New(nextNodePos[1],nextNodePos[2])-Vector2.New(curPos[1],curPos[2])
local angle=Mathf.Atan2(dir.y,dir.x)*180/Mathf.PI
item:SetChildRotation(2,0,0,angle)
item:SetChildRotation(3,0,0,angle)
end


if self.selectNodeidx==index then
item:SetChildActive(1,true)
item:SetChildShowEffect(1,10415,true)
else
item:SetChildActive(1,false)
end


local pos=nodeCfg.nodepos
item:SetChildLocalPosition(-1,Vector3(pos[1],pos[2],0))
self.upLvNodeListHeight=Mathf.Max(self.upLvNodeListHeight,pos[2]+300)

self.uplvnodeContent:setChildSizeDelta(697,self.upLvNodeListHeight)
end
function UIYunZhouZhenTuWin:freshNodeIcon(item,isActive,isLineActive,nodeCfg,isNotMaxNode)
local lineColor=nodeCfg.lineColor

local iconName=FMT.fmt('image_linggen_xiaodian{0}',lineColor[1])
item:SetChildScale(CmpUpLvNodeItemIndex.select,Vector3.New(0.58,0.58,1))
item:SetChildCSImageSprite(CmpUpLvNodeItemIndex.activeIcon,globalABLookup.varylinggensprite,iconName)
item:SetChildGray(CmpUpLvNodeItemIndex.activeIcon,not isActive)

local iconName2=FMT.fmt('frame_linggen_xian{0}',lineColor[2])
item:SetChildCSImageSprite(CmpUpLvNodeItemIndex.hideLine,globalABLookup.varylinggensprite,iconName2)
item:SetChildCSImageSprite(CmpUpLvNodeItemIndex.activeLine,globalABLookup.varylinggensprite,iconName2)
item:SetChildActive(CmpUpLvNodeItemIndex.lineNode,isNotMaxNode)
local curValue=isLineActive and 1 or 0
item:SetChildIconFillAmount(CmpUpLvNodeItemIndex.activeLine,curValue)
end

function UIYunZhouZhenTuWin:freshSingleUpLvNode(index,zhenshuMax,zhenshuList)
local item=self.uplvnodeContent:getChildLayoutGroupGridItem(index-1)
local maxNum=#zhenshuList
local Nodeid=zhenshuList[index]
local nextNodeIndex=maxNum>=index+1 and index+1 or index
local isNotMaxNode=index~=maxNum

local nodeCfg=self:getCfgByNode(Nodeid)
local isActive=zhenshuMax>=index
local isLineActive=zhenshuMax>=nextNodeIndex and isNotMaxNode

self:freshNodeIcon(item,isActive,isLineActive,nodeCfg,isNotMaxNode)


if self.selectNodeidx==index then
item:SetChildActive(1,true)
item:SetChildShowEffect(1,10415,true)
else
item:SetChildActive(1,false)
end
end


function UIYunZhouZhenTuWin:onYunZhouZhenTuUpLevel(ztid,chongshu,zhenshu,effectLevel)
if _this==nil then return end
if self.selectZTid~=ztid then return end


local preitem=self.uplvnodeContent:getChildLayoutGroupGridItem(zhenshu-1)
preitem:SetChildActive(1,false)

local Cfg_zt=self:getCfgByZT(self.selectZTid)
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(self.selectZTid)
local Chongidx,Nodeidx=self:getNextChongidxAndNodeidx(Cfg_zt,yzztData,chongshu,zhenshu)

self.selectNodeidx=Nodeidx
self.selectChongidx=Chongidx

local zhenshuMax=0
if yzztData then
zhenshuMax=yzztData.zhenshuMax
end
local chongid=self:getChongid(Cfg_zt,self.selectChongidx)
local chongshuCfg=self:getCfgByCS(chongid)
local zhenshuList=chongshuCfg.zhenshuList

local func=function()
self.prohibitState=false


if chongshu~=self.selectChongidx then
self:refreshUpLvNodeList()
else
self:freshSingleUpLvNode(zhenshu,zhenshuMax,zhenshuList)
if zhenshu~=self.selectNodeidx then
self:freshSingleUpLvNode(self.selectNodeidx,zhenshuMax,zhenshuList)
end
end


self:refreshSingleUpLvZT(self.selectZTid,Cfg_zt,Chongidx,true)

self:refreshRightNodePanel()
end


self:playUpLvAniamtion2(zhenshu,func)
end

function UIYunZhouZhenTuWin:playUpLvAniamtion1(index)
local item=self.uplvnodeContent:getChildLayoutGroupGridItem(index-1)
item:SetChildShowEffect(6,10413,true)
end
function UIYunZhouZhenTuWin:playUpLvAniamtion2(index,callback)
local item=self.uplvnodeContent:getChildLayoutGroupGridItem(index-1)
if self.lineProgressDT then
if index>1 then
local lineitem=self.uplvnodeContent:getChildLayoutGroupGridItem(index-2)
lineitem:SetChildIconFillAmount(3,1)
end
self.lineProgressDT:Kill()
end
local duration=0.2
if index>1 then
local preitem=self.uplvnodeContent:getChildLayoutGroupGridItem(index-2)
self.lineProgressDT=preitem:SetChildImageDOFillAmount(3,1,duration,nil)
end
self:delayDo(duration,function()
item:SetChildShowEffect(6,10413,true)
if callback then
callback()
end
end)
end



function UIYunZhouZhenTuWin:getCfgByZT(selectZTid)
if self.Cfg_zt[selectZTid]then
return self.Cfg_zt[selectZTid]
else
logErr(FMT.fmt('找不到阵图配置，阵图id：{0}',selectZTid))
end
end
function UIYunZhouZhenTuWin:getCfgByCS(chongid)
if self.Cfg_chongshu[chongid]then
return self.Cfg_chongshu[chongid]
else
logErr(FMT.fmt('找不到重数配置，重数id：{0}',chongid))
end
end
function UIYunZhouZhenTuWin:getCfgByNode(Nodeid)
if self.Cfg_zhenshu[Nodeid]then
return self.Cfg_zhenshu[Nodeid]
else
logErr(FMT.fmt('找不到节点配置，节点id：{0}',Nodeid))
end
end

function UIYunZhouZhenTuWin:getChongid(Cfg_zt,selectChongidx)
local chongshuList=Cfg_zt.chongshu
if chongshuList then
return chongshuList[selectChongidx]
else
logErr(FMT.fmt('找不到阵图的重数id配置，阵图id：{0}，重数下标：{1}',Cfg_zt.id,selectChongidx))
end
end

function UIYunZhouZhenTuWin:getNodeid(Cfg_zt,selectChongidx,selectNodeidx)
local chongid=self:getChongid(Cfg_zt,selectChongidx)
if chongid then
local chongshuCfg=self:getCfgByCS(chongid)
if chongshuCfg then
local zhenshuList=chongshuCfg.zhenshuList
if zhenshuList then
return zhenshuList[selectNodeidx]
else
logErr(FMT.fmt('找不到阵图的节点id配置，阵图id：{0}，重数下标：{1}，节点下标：{1}',Cfg_zt.id,selectChongidx,selectNodeidx))
end
end
end
end

function UIYunZhouZhenTuWin:checkUpReddot()

local Nodeidx=self.selectNodeidx
local Chongidx=self.selectChongidx
local Cfg_zt=self:getCfgByZT(self.selectZTid)
local chongshuList=Cfg_zt.chongshu
if Chongidx>=#chongshuList then
local maxchongid=chongshuList[#chongshuList]
local chongshuCfg=self:getCfgByCS(maxchongid)
local zhenshuList=chongshuCfg.zhenshuList
if Nodeidx>=#zhenshuList then
return false
end
end


local Nodeid=self:getNodeid(Cfg_zt,Chongidx,Nodeidx)
local Cfg_Node=self:getCfgByNode(Nodeid)
local unlock=Cfg_Node.unlock
local isunlock=YunZhouZhenTuModel:checkUnlockNode(unlock)
if not isunlock then
return false
end


local state=true
local cost=Cfg_Node.useItems
if cost then
for k,itemdata in pairs(cost)do
local itemid=itemdata[1]
local hasNum=itemsModel.getCount(itemid)
if moneyConfig.isMoney(itemid)then
hasNum=moneyModel.getMoney(itemid)
else
hasNum=bagModel.getItemCountById(itemid)
end
local neednum=itemdata[2]
state=state and hasNum>=neednum
if not state then
break
end
end
end
return state
end

function UIYunZhouZhenTuWin:checkStrengthen(cost)
if cost then
local state=true
local gainItemId
local gainNum
for k,itemdata in pairs(cost)do
local itemid=itemdata[1]
local hasNum=itemsModel.getCount(itemid)
if moneyConfig.isMoney(itemid)then
hasNum=moneyModel.getMoney(itemid)
else
hasNum=bagModel.getItemCountById(itemid)
end
local neednum=itemdata[2]
state=state and hasNum>=neednum
if not state then
gainItemId=itemid
gainNum=neednum
break
end
end
return state,gainItemId,gainNum
else
return true
end
end



function UIYunZhouZhenTuWin:checkIsMaxChongidx(Cfg_zt,Chongidx)
local chongshuList=Cfg_zt.chongshu
if chongshuList then
return Chongidx>=#chongshuList
end
return false
end

function UIYunZhouZhenTuWin:checkIsMaxNodeidx(Cfg_zt,Chongidx,Nodeidx)
local chongid=self:getChongid(Cfg_zt,Chongidx)
if chongid then
local chongshuCfg=self:getCfgByCS(chongid)
if chongshuCfg then
local zhenshuList=chongshuCfg.zhenshuList
if zhenshuList then
return Nodeidx>=#zhenshuList
end
end
end
return false
end

function UIYunZhouZhenTuWin:checkIsMaxNode(Cfg_zt,Chongidx,Nodeidx)
local chongshuList=Cfg_zt.chongshu
if chongshuList then
if Chongidx>=#chongshuList then
local chongid=chongshuList[#chongshuList]
local chongshuCfg=self:getCfgByCS(chongid)
if chongshuCfg then
local zhenshuList=chongshuCfg.zhenshuList
if zhenshuList then
return Nodeidx>=#zhenshuList
end
end
end
end
return false
end

function UIYunZhouZhenTuWin:checkIsMaxSkillLvl(Cfg_zt,effectLevel)
local MaxSkilllvl=Cfg_zt.MaxSkilllvl or 0
return effectLevel>=MaxSkilllvl
end

function UIYunZhouZhenTuWin:getNextChongidxAndNodeidx(Cfg_zt,yzztData,Chongidx,Nodeidx)

local chongidx=Chongidx
local nodeidx=Nodeidx
if yzztData then
chongidx=yzztData.chongshu
nodeidx=yzztData.zhenshuMax
if self:checkIsMaxNodeidx(Cfg_zt,chongidx,nodeidx)then

if not self:checkIsMaxChongidx(Cfg_zt,chongidx)then
chongidx=chongidx+1
nodeidx=1
end
else
nodeidx=nodeidx+1
end
end
return chongidx,nodeidx
end

function UIYunZhouZhenTuWin:getAttrInfoList(attrs1,attrs2)
local attrs=attrs1
local attrLookup={}
local attrTypeList={}
for index,attrInfo in ipairs(attrs)do
attrLookup[attrInfo[1]]=attrInfo[2]
attrTypeList[#attrTypeList+1]=attrInfo[1]
end
local curSkillInfo=attrs
local nextSkillInfo=attrs2
local transTable=function(list)
local temp={}
if list then
for index,data in ipairs(list)do
temp[data[1]]=data[2]
end
end
return temp
end
local attrInfoList={}
local curAttrLookup=transTable(curSkillInfo)
local nextAttrLookup=transTable(nextSkillInfo or curSkillInfo)
for index,atype in ipairs(attrTypeList)do
local temp={}
temp.attrId=atype
temp.attrVal=attrLookup[atype]
temp.isAdd=nextAttrLookup[atype]~=nil
if temp.isAdd then
temp.addVal=nextAttrLookup[atype]-curAttrLookup[atype]
end
if temp.addVal==0 then
temp.isAdd=false
end
attrInfoList[index]=temp
end
return attrInfoList
end