







def_class("UIDiscipleLinggen_ChangeDialogeWin",UIWindowBase)









function UIDiscipleLinggen_ChangeDialogeWin:bindComponents()

self.root=UIObject.get(self,0)
self.lgList=UIObject.get(self,1)
self.info=UIText.get(self,2)
self.returnroot=UIObject.get(self,3)
self.returnList=UIScrollView.get(self,4)
self.changevariationBtn=UIButton.get(self,5)
self.closeBtn=UIButton.get(self,6)

self.changevariationBtn:setButtonClick(function()self:onChangevariationBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIDiscipleLinggen_ChangeDialogeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.lgList);self.lgList=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.returnroot);self.returnroot=nil;
_UIObject_release(self.returnList);self.returnList=nil;
_UIObject_release(self.changevariationBtn);self.changevariationBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end



















function UIDiscipleLinggen_ChangeDialogeWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleLinggen_ChangeDialogeWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_ChangeDialogeWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.disciple_guid
self.changeLingGenDate=argtable.changeData

self.linggenList,self.lgList_lookup,self.lglen=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)
self.activeVaryLgType=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
self.linggenBaseCfg=cfgHelper.get1(cfg_disciplespiritrootbaseconfig_get,1)
self.averageLv=UIDiscipleModel:getLingGenAverageMaxLevel(self.disciple_guid)

self:refresh()
end


function UIDiscipleLinggen_ChangeDialogeWin:onHide()

end

function UIDiscipleLinggen_ChangeDialogeWin:refresh()
self.lgList:setChildLayoutGroupCreateItems(self.lglen,function(index)
local item=self.lgList:getChildLayoutGroupGridItem(index-1)
local data=self.linggenList[index]

local cfg=cfgHelper.get1(cfg_disciplespiritroottypeconfig_get,data.type)
local typeIconName=ELEMENT_TYPE.getIcon(cfg.element)
item:SetChildCSImageSprite(0,globalABLookup.global,typeIconName)

local lv

if data.type==self.activeVaryLgType then

lv=self.averageLv
else
lv=data.lv
end
local isReduce=self.activeVaryLgType==data.type
local numColor=isReduce and FONT_COLOR.eRedColor or FONT_COLOR.eNomalColor
item:SetChildText(3,toColorString(numColor,lv))
item:SetChildActive(2,isReduce)
end)

local maxlv=self.linggenBaseCfg.max/self.lglen
local cfg=cfgHelper.get1(cfg_disciplespiritroottypeconfig_get,self.activeVaryLgType)
local varydata=self.lgList_lookup[self.activeVaryLgType]
local info=FMT.fmt("更换变异后,<color=#549327>{0}</color>等级将降低至<color=#ca631d>{1}级</color>并返还<color=#ca631d>{2}-{3}</color>级的强化材料",cfg.name,maxlv,maxlv+1,varydata.lv)
self.info:setText(info)

local returnDataList=self:getReturnMaterial()

local initproplist={}
for k,data in pairs(returnDataList)do
local conf={itemid=data.itemid,itemcount=data.itemcount>1 and data.itemcount or'',showCountBG=data.itemcount>1,showname=false}
local propdata=itemsComponentHelper.getCommonFillDataSmall(conf)
table.insert(initproplist,propdata)
end

self.returnList:freshGridsNum(#returnDataList,Mathf.Ceil(#returnDataList/4),4,false)
self.returnList:initPropData(initproplist)
end

function UIDiscipleLinggen_ChangeDialogeWin:getReturnMaterial()
local lvAllCfg=cfg_disciplespiritrootlevelconfig()
local data=self.lgList_lookup[self.activeVaryLgType]
local maxlv=self.linggenBaseCfg.max/self.lglen
local varyLvCfg=lvAllCfg[self.lglen][self.activeVaryLgType][maxlv]
local curLvCfg=lvAllCfg[self.lglen][self.activeVaryLgType][data.lv]

local itemlist={}
for k,v in pairs(curLvCfg.back)do
itemlist[v[1]]=v[2]
end

for k,v in pairs(varyLvCfg.back)do
if itemlist[v[1]]then
itemlist[v[1]]=itemlist[v[1]]-v[2]
end
end

local returnlist={}
for k,v in pairs(itemlist)do
if v>0 then
table.insert(returnlist,{
itemid=k,
itemcount=v
})
end
end

table.sort(returnlist,function(a,b)
return a.itemid>b.itemid
end)

return returnlist
end





function UIDiscipleLinggen_ChangeDialogeWin:onChangevariationBtn()
UIDiscipleController:do_send_2_134(self.disciple_guid,self.changeLingGenDate.type)
self:closeSelf()
end



function UIDiscipleLinggen_ChangeDialogeWin:onCloseBtn()
self:closeSelf()
end

