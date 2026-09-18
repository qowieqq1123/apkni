







def_class("UITeZhiTuJianMainWin",UIWindowBase)









function UITeZhiTuJianMainWin:bindComponents()

self.activeAdd=UIText.get(self,0)
self.adddesc=UIText.get(self,1)
self.adddescRoot=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.desc=UIText.get(self,4)
self.descRoot=UIObject.get(self,5)
self.getdesc=UIText.get(self,6)
self.getRoot=UIObject.get(self,7)
self.gridContent=UIObject.get(self,8)
self.gridScrollView=UIObject.get(self,9)
self.horContent=UIObject.get(self,10)
self.horScrollView=UIObject.get(self,11)
self.icon=UIObject.get(self,12)
self.info2Panel=UIObject.get(self,13)
self.infoPanel=UIObject.get(self,14)
self.ItemContent=UIObject.get(self,15)
self.ItemScrollView=UIObject.get(self,16)
self.jifenBtn=UIButton.get(self,17)
self.jifenBtnReddot=UIObject.get(self,18)
self.jifenPro=UIText.get(self,19)
self.loveBtn=UIButton.get(self,20)
self.loveBtnImg=UIImage.get(self,21)
self.loveBtnReddot=UIObject.get(self,22)
self.lovelBtnTxt=UIText.get(self,23)
self.loveListBtn=UIButton.get(self,24)
self.loveListBtnImg=UIImage.get(self,25)
self.loveListBtnReddot=UIObject.get(self,26)
self.lovelListBtnTxt=UIText.get(self,27)
self.noLoveBtnTips=UIObject.get(self,28)
self.num=UIText.get(self,29)
self.oneKeybtn=UIButton.get(self,30)
self.oneKeybtnReddot=UIObject.get(self,31)
self.proValue=UIObject.get(self,32)
self.reawrdRoot=UIObject.get(self,33)
self.recvbtn=UIButton.get(self,34)
self.recvbtnReddot=UIObject.get(self,35)
self.recvBtnText=UIText.get(self,36)
self.recvRoot=UIObject.get(self,37)
self.sortConditionButton=UIButton.get(self,38)
self.sortOrderButton=UIButton.get(self,39)
self.sortTypeDropdown=UIDropdown.get(self,40)
self.titleName=UIText.get(self,41)
self.UIBaseItemSmall=UIBaseItem.get(self,42)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.jifenBtn:setButtonClick(function()self:onJifenBtn()end)

self.loveBtn:setButtonClick(function()self:onLoveBtn()end)

self.loveListBtn:setButtonClick(function()self:onLoveListBtn()end)

self.oneKeybtn:setButtonClick(function()self:onOneKeybtn()end)

self.recvbtn:setButtonClick(function()self:onRecvbtn()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)



end


function UITeZhiTuJianMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activeAdd);self.activeAdd=nil;
_UIObject_release(self.adddesc);self.adddesc=nil;
_UIObject_release(self.adddescRoot);self.adddescRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.descRoot);self.descRoot=nil;
_UIObject_release(self.getdesc);self.getdesc=nil;
_UIObject_release(self.getRoot);self.getRoot=nil;
_UIObject_release(self.gridContent);self.gridContent=nil;
_UIObject_release(self.gridScrollView);self.gridScrollView=nil;
_UIObject_release(self.horContent);self.horContent=nil;
_UIObject_release(self.horScrollView);self.horScrollView=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.info2Panel);self.info2Panel=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.ItemContent);self.ItemContent=nil;
_UIObject_release(self.ItemScrollView);self.ItemScrollView=nil;
_UIObject_release(self.jifenBtn);self.jifenBtn=nil;
_UIObject_release(self.jifenBtnReddot);self.jifenBtnReddot=nil;
_UIObject_release(self.jifenPro);self.jifenPro=nil;
_UIObject_release(self.loveBtn);self.loveBtn=nil;
_UIObject_release(self.loveBtnImg);self.loveBtnImg=nil;
_UIObject_release(self.loveBtnReddot);self.loveBtnReddot=nil;
_UIObject_release(self.lovelBtnTxt);self.lovelBtnTxt=nil;
_UIObject_release(self.loveListBtn);self.loveListBtn=nil;
_UIObject_release(self.loveListBtnImg);self.loveListBtnImg=nil;
_UIObject_release(self.loveListBtnReddot);self.loveListBtnReddot=nil;
_UIObject_release(self.lovelListBtnTxt);self.lovelListBtnTxt=nil;
_UIObject_release(self.noLoveBtnTips);self.noLoveBtnTips=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.oneKeybtn);self.oneKeybtn=nil;
_UIObject_release(self.oneKeybtnReddot);self.oneKeybtnReddot=nil;
_UIObject_release(self.proValue);self.proValue=nil;
_UIObject_release(self.reawrdRoot);self.reawrdRoot=nil;
_UIObject_release(self.recvbtn);self.recvbtn=nil;
_UIObject_release(self.recvbtnReddot);self.recvbtnReddot=nil;
_UIObject_release(self.recvBtnText);self.recvBtnText=nil;
_UIObject_release(self.recvRoot);self.recvRoot=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.UIBaseItemSmall);self.UIBaseItemSmall=nil;
end


















local horItemCmp=
{
horItem=0,
bg=1,
lockMask=2,
select=3,
itemContent=4,
reddot=5,
lockFlag=6,
recvedFlag=7,
click=8,
itemContentEx=9,
reddot=10,
}
local gridItemCmp=
{
name=0,
back=1,
effect=2,
select=3,
reddot=4,
}

local _abName='ui/windows/tezhitujian/tezhitujian_atlas_pak.ab'
local _this


function UITeZhiTuJianMainWin:onLoaded(...)
_this=self
self:bindComponents()
self.filterFlag={}
self.sortCdnList={}
end


function UITeZhiTuJianMainWin:__delete()
_this=nil
self:unbindComponents()
self.filterFlag=nil
self.sortCdnList=nil
end


function UITeZhiTuJianMainWin:onHide()

end




function UITeZhiTuJianMainWin:onShow(argtable,afterOnloaded)
self.config,self.len,self.configIndexlookup,self.config2=TeZhiTuJianModel:getConfigLoolup()
self.isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
self:refreshLoveList()
self:createHorContent()
self:refreshHorContent()
self:onHorItemClick(self.targetHorIndex or 1)
self:refreshJifenEnter()
self:refreshOneKeyState()
self:refreshLoveListBtn()
end

function UITeZhiTuJianMainWin:createHorContent()
self.horContent:setChildLayoutGroupClearAllItems()
local horContentLen=self.len
self.horContent:setChildLayoutGroupCreateItems(horContentLen,function(index)
local showType=self.configIndexlookup[index]
local cfg=self.config[showType]
local horitem=self.horContent:getChildLayoutGroupGridItem(index-1)
horitem:SetChildButtonClick(horItemCmp.click,function()
self:onHorItemClick(index)
end,true)
horitem:SetChildText(horItemCmp.itemContent,cfg.name)
end)
self.horgrids=self.horContent:getChildLayoutGroupGridList()
end

function UITeZhiTuJianMainWin:refreshHorContent()
local horContentLen=self.len
self.targetHorIndex=nil
for i=1,horContentLen do
local horitem=self.horgrids[i-1]
local pro,max=self:getTypePro(i)
horitem:SetChildText(horItemCmp.itemContentEx,FMT.fmt("{0}/{1}",pro,max))
local reddot=TeZhiTuJianModel:checkShowTypeReddot(self.configIndexlookup[i])
horitem:SetChildActive(horItemCmp.reddot,reddot)
if reddot and not self.targetHorIndex then
self.targetHorIndex=i
end
end
end

function UITeZhiTuJianMainWin:refreshGridContent(isfilter)
local showType=self.configIndexlookup[self.curHorIndex]



local sortChildList=TeZhiTuJianModel:getSortChildList(showType,self.sortCdnList[showType])
self.sortChildList=sortChildList
if self.resetGridSelect_mark then
self.resetGridSelect_mark=nil
self:resetGridSelect()
end
if self.resetGridSelect_mark2 then
self.resetGridSelect_mark2=nil
self:resetGridSelect2()
end
local count=#sortChildList
self.gridContent:setChildLayoutGroupCreateItems(count)
self.gridlist=self.gridContent:getChildLayoutGroupGridList()
if count>0 then

local isFirst=self.curChildIndex==nil
local targetChildIndex=nil
local targetGridIndex=nil
for i=1,count do
local cfg=sortChildList[i]
local item=self.gridlist[i-1]
item:SetChildActive(-1,true)
item:SetChildActive(gridItemCmp.select,false)
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
self:onGridItemClick(cfg.childIndex,i,true)
end)
local state=TeZhiTuJianModel:getTuJianState(cfg.id)
item:SetChildGray(gridItemCmp.back,state==TeZhiTuJianModel.TempState.eNotRecv)
item:SetChildActive(gridItemCmp.reddot,state==TeZhiTuJianModel.TempState.eRecv)

item:SetChildActive(gridItemCmp.select,self.curGridIndex==i)
if isFirst and state==TeZhiTuJianModel.TempState.eRecv and not targetChildIndex then
targetChildIndex=cfg.childIndex
targetGridIndex=i
end
self:refreshGridContentLove(item,cfg.type,cfg.spe_id)
end
if isFirst then
if not targetGridIndex then
targetGridIndex=1
local cfg=sortChildList[targetGridIndex]
targetChildIndex=cfg.childIndex
end
self:onGridItemClick(targetChildIndex,targetGridIndex)
else
self:MoveContent(self.curGridIndex)
end
end
end

function UITeZhiTuJianMainWin:tryGetGridItemIndex(spetype,speid)
for i,cfg in ipairs(self.sortChildList)do
if cfg.type==spetype and cfg.spe_id==speid then
return i,cfg.childIndex
end
end
return nil
end

function UITeZhiTuJianMainWin:refreshGridContentLove(item,spetype,speid)
if item==nil then
local index=self:tryGetGridItemIndex(spetype,speid)
if index~=nil then
item=self.gridlist[index-1]
end
end
if item==nil then return end
local check=UIDiscipleModel.checkSpecialityLove(spetype,speid)
item:SetChildActive(5,check)
end

function UITeZhiTuJianMainWin:refreshInfoPanel()
local showType=self.configIndexlookup[self.curHorIndex]
local typeCfg=self.config[showType]
local childList=typeCfg.childList
local selectCfg=childList[self.curChildIndex]
self.titleName:setText(selectCfg.nameEx)
self.descRoot:setActive(selectCfg.effects_desc~=nil)
local effects_desc=selectCfg.effects_desc or''
if not self.isGuoFu and selectCfg.effects_desc_overseas then
local gameversion=pfwindowslController:getGameVersion()
effects_desc=selectCfg.effects_desc_overseas[gameversion]or selectCfg.effects_desc_overseas[2]
end
self.desc:setText(effects_desc)
if effects_desc~=nil then
self.winlua:ForceLayoutVertical(self.descRoot:getID())
end
self.adddescRoot:setActive(selectCfg.effects_adddesc~=nil)
local adddesc=selectCfg.effects_adddesc
if selectCfg.effects_adddesc then



self.adddesc:setText(table.concat(adddesc,"\n"))
self.winlua:ForceLayoutVertical(self.adddescRoot:getID())
end
self.getRoot:setActive(selectCfg.getDesc~=nil)
self.getdesc:setText(selectCfg.getDesc)
if selectCfg.getDesc~=nil then
self.winlua:ForceLayoutVertical(self.getRoot:getID())
end
local state=self:getState(selectCfg.id)




self.recvRoot:setActive(true)
self.activeAdd:setActive(selectCfg.point>0)
if selectCfg.point>0 then
self.activeAdd:setText(FMT.fmt("激活积分：{0}",selectCfg.point))
end











local reward=selectCfg.active_reward
self.ItemContent:setChildLayoutGroupCreateItems(#reward,function(index)
local item=self.ItemContent:getChildLayoutGroupGridItem(index-1)
local itemCfg=reward[index]
local itemid=itemCfg[1]
local count=itemCfg[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local graynum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
if state==TeZhiTuJianModel.TempState.eRecved then
prop[PropIndex(DataPropKey.eWidgetActive,7)]=true
end
item:SetChildActive(2,state==TeZhiTuJianModel.TempState.eRecved)
item:SetChildActive(1,state==TeZhiTuJianModel.TempState.eRecv)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickItem(state==TeZhiTuJianModel.TempState.eRecv,itemid,selectCfg.id)
end)
end)


local canLove=selectCfg.canLove
self.loveBtn:setActive(canLove)
self.noLoveBtnTips:setActive(not canLove)
if canLove then
self:refreshLoveBtn()
end
end

function UITeZhiTuJianMainWin:refreshLoveBtn()
local showType=self.configIndexlookup[self.curHorIndex]
local typeCfg=self.config[showType]
local childList=typeCfg.childList
local selectCfg=childList[self.curChildIndex]
local spetype=selectCfg.type
local speid=selectCfg.spe_id
local check=UIDiscipleModel.checkSpecialityLove(spetype,speid)
local str=check==true and'取关'or'关注'
self.lovelBtnTxt:setText(str)
local icon=check==true and'image_guanzhu_3'or'image_guanzhu_1'
self.loveBtnImg:setSprite(_abName,icon)
self:refreshLoveBtnReddot()
end

function UITeZhiTuJianMainWin:refreshLoveBtnReddot()
local isReddot=TeZhiTuJianModel:checkSpecialityLoveReddot()
self.loveBtnReddot:setActive(isReddot)
end

function UITeZhiTuJianMainWin:refreshOneKeyState()
local count,limt=self:getCanRecvCount()
self.oneKeybtn:setActive(count>=limt)
end

function UITeZhiTuJianMainWin:refreshJifenEnter()
local pro,max=self:getJiFenPro()

self.jifenPro:setText(FMT.fmt("{0}/{1}",pro,max))
self.proValue:setChildIconFillAmount(pro/max)
local reddot=self:checkJiFenReddot()
self.jifenBtnReddot:setActive(reddot)
end

function UITeZhiTuJianMainWin:onHorItemClick(index)
if self.curHorIndex==index then
return
end
if self.curHorIndex then
local lasthoritem=self.horgrids[self.curHorIndex-1]
lasthoritem:SetChildActive(horItemCmp.select,false)
end
local curhoritem=self.horgrids[index-1]
curhoritem:SetChildActive(horItemCmp.select,true)
self.curHorIndex=index

self.curChildIndex=nil
self.curGridIndex=nil
self:refreshGridContent()
end

function UITeZhiTuJianMainWin:resetGridSelect()
local showType=self.configIndexlookup[self.curHorIndex]
local typeCfg=self.config[showType]
local childList=typeCfg.childList
local selectCfg=childList[self.curChildIndex]
local spetype=selectCfg.type
local speid=selectCfg.spe_id
local curGridIndex,curChildIndex=self:tryGetGridItemIndex(spetype,speid)
self.curChildIndex=curChildIndex
self.curGridIndex=curGridIndex
end

function UITeZhiTuJianMainWin:resetGridSelect2()

local showType=self.configIndexlookup[self.curHorIndex]
local typeCfg=self.config[showType]
local childList=typeCfg.childList
local selectCfg=childList[self.curChildIndex]
local spetype=selectCfg.type
local speid=selectCfg.spe_id
local spe=self.loveSpeList[self.selectLoveIndex]
local check=false
if spe~=nil then
local spetype_=spe[1]
local speid_=spe[2]
if spetype~=spetype_ or speid~=speid_ then
local curGridIndex,curChildIndex=self:tryGetGridItemIndex(spetype_,speid_)
if curGridIndex then
self.curChildIndex=curChildIndex
self.curGridIndex=curGridIndex
check=true
end
end
end
if not check then
self:resetGridSelect()
end
end

function UITeZhiTuJianMainWin:onGridItemClick(childIndex,index,isClick)
local selectCfg=self.sortChildList[index]
local spetype=selectCfg.type
local speid=selectCfg.spe_id
local ischange=self.curChildIndex~=childIndex
if ischange==true then
if self.curGridIndex then
local lastgriditem=self.gridlist[self.curGridIndex-1]
lastgriditem:SetChildActive(gridItemCmp.select,false)
end
local curgriditem=self.gridlist[index-1]
curgriditem:SetChildActive(gridItemCmp.select,true)
self.curChildIndex=childIndex
self.curGridIndex=index
if not self.loveListMark then
self:refreshInfoPanel()
end
end
if self.loveListMark==true then
self:resetLoveSelect()
if isClick then
if not UIDiscipleModel.checkSpecialityLove(spetype,speid)then
if UIDiscipleModel.canSpecialityLove(spetype,speid,true)then
UIDiscipleModel.recordSpecialityLove(spetype,speid,true)

self.resetGridSelect_mark=true
self:refreshGridContent()
self:refreshLoveList()
self:refreshLoveListPanel()
UIManager.info('关注成功')
end
end
end
end

end


function UITeZhiTuJianMainWin:getTypePro(index)
local showType=self.configIndexlookup[index]
return TeZhiTuJianModel:getTypePro(showType)
end

function UITeZhiTuJianMainWin:getJiFenPro()
local curNum=TeZhiTuJianModel:getAllActiveJiFen()
local targetNum=TeZhiTuJianModel:getFirstNotRecvJiFen()
return curNum,targetNum
end

function UITeZhiTuJianMainWin:getCanRecvCount()
return TeZhiTuJianModel:getAllRecvCount()
end

function UITeZhiTuJianMainWin:getState(id)
return TeZhiTuJianModel:getTuJianState(id)
end

function UITeZhiTuJianMainWin:checkJiFenReddot()
return TeZhiTuJianModel:checkStageProReddot()
end





function UITeZhiTuJianMainWin:onCloseBtn()
self:closeSelf()
end

function UITeZhiTuJianMainWin:onSortConditionButton()



































local showType=self.configIndexlookup[self.curHorIndex]
local typeCfg=self.config[showType]
local filterName=typeCfg.filterName
local filterFlag=self.filterFlag[showType]or typeCfg.filterFlag
local attach={showType=showType}
local callback=function(data)
local filterFlag=data.filterFlag
local filterName=data.filterName
local attach=data.attach
local showType=attach.showType
self.filterFlag[showType]=filterFlag


self.sortCdnList[showType]=nil
for i,v in ipairs(filterFlag)do
for ii,vv in ipairs(v)do
if vv then
local cdnType=filterName[i][2][ii].cdnType
if not self.sortCdnList[showType]then
self.sortCdnList[showType]={}
end
table.insert(self.sortCdnList[showType],cdnType)
end
end
end

self.resetGridSelect_mark=true
self:refreshGridContent(true)

end
local conflictList=
{
[1]={
[1]={2},
[2]={1},
},
}
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=2
args.extraWin='UIFilterWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,attach=attach,comfirmCallback=callback,conflictList=conflictList}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)


end

function UITeZhiTuJianMainWin:onSortOrderButton()
UIManager.info("onOrtOrderButton")
end

function UITeZhiTuJianMainWin:onJifenBtn()

local args={}
args.titleName="特质图鉴积分"
args.pos=3
args.extraWin='UITeZhiJiFenWin'
UIManager:showWindow('UICommonPageWin',args)
end

function UITeZhiTuJianMainWin:onOneKeybtn()
TeZhiTuJianController.req_2_151(0)
end

function UITeZhiTuJianMainWin:onRecvbtn()
local showType=self.configIndexlookup[self.curHorIndex]
local typeCfg=self.config[showType]
local childList=typeCfg.childList
local selectCfg=childList[self.curChildIndex]
local bookId=selectCfg.id
local state=TeZhiTuJianModel:getTuJianState(bookId)
if state==TeZhiTuJianModel.TempState.eRecv then
TeZhiTuJianController.req_2_151(bookId)
elseif state==TeZhiTuJianModel.TempState.eNotRecv then
UIManager.info("未激活")
end
end

function UITeZhiTuJianMainWin:onClickItem(recvFlag,itemid,bookId)
if recvFlag then
TeZhiTuJianController.req_2_151(bookId)
else

tipsManager.showTips({itemid=itemid,backType=TIPS_BACK_TYPE.eSelfBack})
end
end

function UITeZhiTuJianMainWin:MoveContent(targetGridIndex)
local hight=self.gridContent:getChildRectHeight()
if hight<=360 then
return
end
local rol=math.ceil(targetGridIndex/4)
local targetY=(rol-1)*80
local contentPos=self.gridContent:getChildAnchoredPosition()
local curMoveY=contentPos.y
local curTargetY=targetY-curMoveY
if curTargetY<0 or curTargetY>=320 then
local maxY=hight-360
local y=targetY>maxY and maxY-3 or targetY
self.gridContent:setChildAnchoredPos(0,y)
end
end



function UITeZhiTuJianMainWin:onLoveBtn()
local showType=self.configIndexlookup[self.curHorIndex]
local typeCfg=self.config[showType]
local childList=typeCfg.childList
local selectCfg=childList[self.curChildIndex]
local spetype=selectCfg.type
local speid=selectCfg.spe_id
local check=UIDiscipleModel.checkSpecialityLove(spetype,speid)
if check==true then
local callback=function()
if _this==nil then return end
UIDiscipleModel.recordSpecialityLove(spetype,speid,false)
_this:refreshLoveList()

_this.resetGridSelect_mark=true
_this:refreshGridContent()
_this:refreshLoveBtn()
UIManager.info('取关成功')
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveDelete)
if not flag then
local contentStr=FMT.fmt('是否取消关注<color=#7d3b17>{0}</color> ',selectCfg.name)
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
choosetext='今日不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveDelete,flag)
end,
okcallback=function()
if _this==nil then return end
callback()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
callback()
end
else
if not UIDiscipleModel.canSpecialityLove(spetype,speid,true)then
return
end
UIDiscipleModel.recordSpecialityLove(spetype,speid,true)

self.resetGridSelect_mark=true
self:refreshGridContent()
self:refreshLoveBtn()
self:refreshLoveList()
UIManager.info('关注成功')
if TeZhiTuJianModel:checkSpecialityLoveReddot()then
TeZhiTuJianModel:recordSpecialityLoveFisrt()
self:refreshLoveReddot()
end
end
end

function UITeZhiTuJianMainWin:refreshRightPanel()
self.infoPanel:setActive(not self.loveListMark)
self.info2Panel:setActive(self.loveListMark)
if self.loveListMark then
self:refreshLoveListPanel()
else
self:refreshInfoPanel()
end
end

function UITeZhiTuJianMainWin:refreshLoveListBtn()
local str=self.loveListMark==true and'关闭列表'or'关注列表'
self.lovelListBtnTxt:setText(str)
local icon=self.loveListMark==true and'image_guanzhuliebiao_3'or'image_guanzhuliebiao_2'
self.loveListBtnImg:setSprite(_abName,icon)
self:refreshLoveListBtnReddot()
end

function UITeZhiTuJianMainWin:refreshLoveListBtnReddot()
local isReddot=TeZhiTuJianModel:checkSpecialityLoveReddot()
self.loveListBtnReddot:setActive(isReddot)
end

function UITeZhiTuJianMainWin:onLoveListBtn()
self.loveListMark=not self.loveListMark
self:refreshLoveListBtn()
self:refreshRightPanel()
if TeZhiTuJianModel:checkSpecialityLoveReddot()then
TeZhiTuJianModel:recordSpecialityLoveFisrt()
self:refreshLoveReddot()
end
end

function UITeZhiTuJianMainWin:refreshLoveList()
local loveSpeList={}
local c=0
local lp=UIDiscipleModel.getSpecialityLoveLookup()
if lp~=nil then
for spetype,v in pairs(lp)do
for speid,_ in pairs(v)do
c=c+1
local cfg=self.config2[spetype][speid]
local book_id=cfg.id
local d={spetype,speid}
local sorts={}
sorts[1]=10-cfg.showType
local state=TeZhiTuJianModel:getTuJianState(book_id)
if state~=TeZhiTuJianModel.TempState.eNotRecv then
sorts[2]=1
else
sorts[2]=0
end
sorts[3]=10000-book_id
d.sorts=sorts
loveSpeList[c]=d
end
end
if c>1 then
mathHelper.sortWeightList(loveSpeList)
end
end
self.loveSpeList=loveSpeList
end


function UITeZhiTuJianMainWin:calculationLoveSelect()
local showType=self.configIndexlookup[self.curHorIndex]
local typeCfg=self.config[showType]
local childList=typeCfg.childList
local selectCfg=childList[self.curChildIndex]
local spetype=selectCfg.type
local speid=selectCfg.spe_id
for i,spe in ipairs(self.loveSpeList)do
if spetype==spe[1]and speid==spe[2]then
return i
end
end
return nil
end

function UITeZhiTuJianMainWin:resetLoveSelect()
local idx=self:calculationLoveSelect()
if idx~=nil and self.selectLoveIndex~=idx then
self:onLoveItemClick(idx)
end
end

function UITeZhiTuJianMainWin:refreshLoveListPanel()
if self.selectLoveIndex==nil then
self.selectLoveIndex=1
elseif self.loveSpeList[self.selectLoveIndex]==nil then
self.selectLoveIndex=1
end

local n=#self.loveSpeList
local panelWidget=self.info2Panel:getWidgetBase()
local has=n>0
panelWidget:SetChildActive(0,not has)
panelWidget:SetChildActive(1,has)
if has==true then

local idx=self:calculationLoveSelect()
if idx~=nil then
self.selectLoveIndex=idx
end

panelWidget:SetChildLayoutGroupCreateItems(2,n,function(index)
local spe=self.loveSpeList[index]
local item=panelWidget:GetChildLayoutGroupGridItem(2,index-1)
local spetype=spe[1]
local speid=spe[2]
local cfg=self.config2[spetype][speid]
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
self:onLoveItemClick(index)
end)
item:SetChildActive(3,index==self.selectLoveIndex)
end)
self:refreshLoveListPanel2()
end

local max=UIDiscipleModel.getSpecialityLoveNumMax()
local str
if n<max then
str=FMT.fmt('(<color=#37AE20>{0}</color>/{1})',n,max)
else
str=FMT.fmt('({0}/{1})',n,max)
end
panelWidget:SetChildText(6,str)

if self.initLoveListPanel==nil then
self.initLoveListPanel=true
panelWidget:SetChildButtonClick(4,function()
if _this==nil then return end
_this:onDelLoveClick()
end)
panelWidget:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onGoBtnClick()
end)
end
end

function UITeZhiTuJianMainWin:refreshLoveListPanel2()
local panelWidget=self.info2Panel:getWidgetBase()

local spe=self.loveSpeList[self.selectLoveIndex]
local spetype=spe[1]
local speid=spe[2]
local cfg=self.config2[spetype][speid]
local adddesc=cfg.effects_adddesc
panelWidget:SetChildText(3,table.concat(adddesc,"\n"))
end

function UITeZhiTuJianMainWin:onLoveItemClick(index)
if self.selectLoveIndex~=index then
local panelWidget=self.info2Panel:getWidgetBase()
local item
if self.selectLoveIndex~=nil then
item=panelWidget:GetChildLayoutGroupGridItem(2,self.selectLoveIndex-1)
item:SetChildActive(3,false)
end
item=panelWidget:GetChildLayoutGroupGridItem(2,index-1)
item:SetChildActive(3,true)
self.selectLoveIndex=index
self:refreshLoveListPanel2()
end
end

function UITeZhiTuJianMainWin:onDelLoveClick()
local spe=self.loveSpeList[self.selectLoveIndex]
local spetype=spe[1]
local speid=spe[2]
local callback=function()
if _this==nil then return end
UIDiscipleModel.recordSpecialityLove(spetype,speid,false)
_this:refreshLoveList()
_this:refreshLoveListPanel()

_this.resetGridSelect_mark2=true
_this:refreshGridContent()
UIManager.info('取关成功')
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveDelete)
if not flag then
local cfg=self.config2[spetype][speid]
local contentStr=FMT.fmt('是否取消关注<color=#7d3b17>{0}</color> ',cfg.name)
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
choosetext='今日不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveDelete,flag)
end,
okcallback=function()
if _this==nil then return end
callback()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
callback()
end
end

function UITeZhiTuJianMainWin:refreshLoveReddot()
self:refreshLoveBtnReddot()
self:refreshLoveListBtnReddot()
end

function UITeZhiTuJianMainWin:onGoBtnClick()
local showSetup=guildOrderModel:checkOrderActive(GUILD_ORDER_TYPE.eQuicklyZhaoMu)
if not showSetup then
UIManager.error('法令暂未开启')
return
end
local args={}
args.pos=3
args.showBG=true
guildOrderModel:openSetupWin(GUILD_ORDER_TYPE.eQuicklyZhaoMu,args)
end


function UITeZhiTuJianMainWin:recv_2_151()
self.resetGridSelect_mark=true
self:refreshGridContent()
if not self.loveListMark then
self:refreshInfoPanel()
end
self:refreshOneKeyState()
self:refreshJifenEnter()
self:refreshHorContent()
end