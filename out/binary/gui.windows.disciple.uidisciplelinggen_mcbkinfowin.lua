







def_class("UIDiscipleLinggen_MCBKInfoWin",UIWindowBase)









function UIDiscipleLinggen_MCBKInfoWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.slotBKList=UIScrollView.get(self,2)
self.spineBg=UIObject.get(self,3)
self.title=UIObject.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIDiscipleLinggen_MCBKInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.slotBKList);self.slotBKList=nil;
_UIObject_release(self.spineBg);self.spineBg=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this

local CmpHoardRecordItemIndex={
root=0,
name=1,
icon=2,
typeicon=3,
attrs=4,
desc=5,
activebtn=6,
changebtn=7,
skilleffectBtn=8,
select=9,
quality=10,
standEffect=11,
expondEffect=12,
}

local _len=6





function UIDiscipleLinggen_MCBKInfoWin:onLoaded(...)
self:bindComponents()

_this=self

local _bind=function(...)
_this:bindSlotBKInfoItem(...)
end
self.slotBKList:bindScrollWidget(_bind)

self:addProNotify(2,201,self.recv_2_201)
self:addProNotify(2,203,self.recv_2_203)
end


function UIDiscipleLinggen_MCBKInfoWin:__delete()
_this=nil

self:unbindComponents()
end




function UIDiscipleLinggen_MCBKInfoWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.disciple_guid
self.select_pos=argtable.select_pos
self.discipleGuidStr=tostring(self.disciple_guid)

self:refreshAll()
end


function UIDiscipleLinggen_MCBKInfoWin:onHide()

end

function UIDiscipleLinggen_MCBKInfoWin:onCloseBtn()
self:closeSelf()
end



function UIDiscipleLinggen_MCBKInfoWin:refreshAll()

self.slotBKList:freshGridsNum(_len,_len,1,self.setZero)
self.setZero=true

local jumpIdx=self.select_pos>0 and self.select_pos or _len

self.slotBKList:jumpToLockX(jumpIdx)
end

local _mcInfoCmpIndex={
boardItem=0,
blackLock=1,
delbtn=2,
empty=3,
emptyTxt=4,
}

local _ab="ui/windows/disciple/varyspriteroot_atlas_pak.ab"
function UIDiscipleLinggen_MCBKInfoWin:bindSlotBKInfoItem(index,item)

local pos=index

if index==_len then
pos=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
pos=-pos
end

local isUnlock=true
if pos>0 then
isUnlock=UIDiscipleModel:checkHiddenSkillSlotUnlock(self.disciple_guid,pos)
else
isUnlock=UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)and pos~=0
end


local title
if pos>0 then
title=FMT.fmt("{0}号普通秘藏",pos)
else
if pos~=0 then
local type=-pos
local varyCfg=UIDiscipleModel:getLinggenSpecialCfg(type,true)
local elementName=varyCfg.elementname
title=FMT.fmt("变异秘藏·{0}",elementName)
else
title="变异秘藏"
pos=-1
end
end
item:SetChildText(0,title)

local slotLen=mzbkModel:getMZBKPosMaxSaveCount(pos)


local cloudResList=mzbkModel:getConfig('cloudResList')
local cloudList=cloudResList[slotLen]
item:SetChildCSImageSprite(2,_ab,cloudList[1])
item:SetChildCSImageSprite(3,_ab,cloudList[2])

local mzbkData=mzbkModel:getDiscipleMZBKInfoByPos(self.discipleGuidStr,pos)or defaultT



local isGray=not isUnlock

local mzList=mzbkData.mzList or defaultT
item:SetChildLayoutGroupCreateItems(1,slotLen,function(bkindex)
local bkItem=item:GetChildLayoutGroupGridItem(1,bkindex-1)
local data=mzList[bkindex]
local isShow=data~=nil
bkItem:SetChildActive(_mcInfoCmpIndex.boardItem,isShow)
bkItem:SetChildActive(_mcInfoCmpIndex.empty,not isShow)
bkItem:SetChildActive(_mcInfoCmpIndex.delbtn,isShow)
bkItem:SetChildActive(_mcInfoCmpIndex.blackLock,isGray)
bkItem:SetChildActive(_mcInfoCmpIndex.emptyTxt,not(not isShow and isGray))
if not isShow then
return
end

local hoardItem=bkItem:GetChildWidgetBase(0)

local levelLimit=not UIDiscipleModel:checkHoardCanUse(self.disciple_guid,data.hoardid,pos<0)
local lock=isGray or levelLimit
bkItem:SetChildActive(1,lock)
if lock then
local boardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data.hoardid)
local qulaityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(boardCfg.color)
bkItem:SetChildCSImageSprite(1,qab,qulaityName)
end

_this:refreshHoardItem(mzList,bkindex,hoardItem,pos,lock,title)

bkItem:SetChildButtonClick(2,function()
_this:onClickMZDelete(data,pos,bkindex,title)
end,true)
end)
end

function UIDiscipleLinggen_MCBKInfoWin:refreshHoardItem(list,index,item,pos,lock,title)
local data=list[index]
local boardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data.hoardid)
local desc=UIDiscipleModel:getDiscipleHoardDesc(data)
local skillIconName=iconHelper.getSkillIcon(boardCfg.icon)

local typeIconName,ab=ELEMENT_TYPE.getVaryIcon(boardCfg.element)

item:SetChildText(CmpHoardRecordItemIndex.name,boardCfg.name)
item:SetChildIcon(CmpHoardRecordItemIndex.icon,skillIconName,false)
item:SetChildCSImageSprite(CmpHoardRecordItemIndex.typeicon,ab,typeIconName)
item:SetChildLayoutGroupCreateItems(CmpHoardRecordItemIndex.attrs,data.len1,function(index)
local aitem=item:GetChildLayoutGroupGridItem(4,index-1)
local data=data.list1[index]
aitem:SetChildActive(-1,data~=nil)
if data then
local str=helper.getAttributeStr(data.param_1,data.param_2,nil,"{0}+{1}")
aitem:SetChildText(1,str)
end
end)
item:SetChildText(CmpHoardRecordItemIndex.desc,desc)

item:SetChildActive(CmpHoardRecordItemIndex.activebtn,false)
item:SetChildActive(CmpHoardRecordItemIndex.changebtn,false)


local qulaityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(boardCfg.color)
item:SetChildCSImageSprite(CmpHoardRecordItemIndex.quality,qab,qulaityName)

item:SetChildShowEffect(CmpHoardRecordItemIndex.expondEffect,0,false)

item:SetChildActive(CmpHoardRecordItemIndex.skilleffectBtn,boardCfg.additionskillid~=nil)
item:SetChildButtonClick(CmpHoardRecordItemIndex.skilleffectBtn,function()
local hiddenCfg=boardCfg
local skillid,gfUpValue=next(hiddenCfg.gongfa or{})
if skillid and gfUpValue then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
skillid=skillid,
addSkillLv=gfUpValue,
gfID=hiddenCfg.gongfaid,
item=item,
offset=Vector2(0,0),
isAdapter=true
})
elseif hiddenCfg.skillid then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
gfID=hiddenCfg.gongfaid,
item=item,
offset=Vector2(0,0),
isAdapter=true
})
end
end)

item:SetBaseItemClickEvent(-1,function()


local args={}
args.boardList=list
args.index=index
args.disciple_guid=self.disciple_guid
args.pos=pos
args.title=title
_this:showWindow("UIDiscipleLinggen_MZBKTransformHideSkillWin",args)
end)
end

function UIDiscipleLinggen_MCBKInfoWin:onClickMZDelete(data,pos,idx,title)

local cfg=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,data.hoardid)
local name=toColorString(cfg.color,cfg.name)
local content=FMT.fmt("是否删除{0}中的{1}秘藏",toColorString(FONT_COLOR.eRedColor,title),name)

local _delFunc=function()
mzbkController.req_disciple_delete_mz(self.disciple_guid,pos,idx,name)
end

local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=_delFunc,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end


function UIDiscipleLinggen_MCBKInfoWin.recv_2_201(dzGuid,pos,len,mzInfoList)
if _this==nil then return end
if mathHelper.compareInt64(_this.disciple_guid,dzGuid)then
_this:refreshAll()
end
end

function UIDiscipleLinggen_MCBKInfoWin.recv_2_203(dzGuid,pos,idx,len,mzInfoList)
if _this==nil then return end
if mathHelper.compareInt64(_this.disciple_guid,dzGuid)then
_this:refreshAll()
end
end