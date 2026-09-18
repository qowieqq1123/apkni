







def_class("tipsChildTDLXMetrialDesc",UICloneObject)





tipsChildTDLXMetrialDesc.abName="ui/windows/tips/child/tipschildtdlxmetrialdesc.ab"

tipsChildTDLXMetrialDesc.assetName="tipsChildTDLXMetrialDesc"


function tipsChildTDLXMetrialDesc:bindComponents()

self.collectObjet=UIObject.get(self,0)
self.collectProgress=UIProgress.get(self,1)
self.desc=UIText.get(self,2)

end


function tipsChildTDLXMetrialDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.collectObjet);self.collectObjet=nil;
_UIObject_release(self.collectProgress);self.collectProgress=nil;
_UIObject_release(self.desc);self.desc=nil;
end









function tipsChildTDLXMetrialDesc:onLoaded(...)
self:bindComponents()
end


function tipsChildTDLXMetrialDesc:__delete()
self:unbindComponents()
end




function tipsChildTDLXMetrialDesc:onShow(args)
local data=args.argtable
local childType=args.childType
local itemid=data.itemid
local tjId=wanLingTaModel:good2TDLX(itemid)
local tjCfg=wanLingTaModel:getTuJianConfig(tjId)
local attach=data.attach
local formType=data.formType

local itemcfg=itemsConfig.getConfig(itemid)

local desc_str=''



local tjData=wanLingTaModel:getTuJianData(tjId)
local pieceNum=bagModel.getItemCountById(itemid)
local isActive=tjData.level>0
if isActive then

local star_str='当前等级：{0}级'
desc_str=desc_str..FMT.fmt(star_str,tjData.level)
desc_str=desc_str..'\n'

local piece_str='碎片数量：{0}'
desc_str=desc_str..FMT.fmt(piece_str,pieceNum)
end

local need
if not isActive then
need=tjCfg.activeUp[1][1][2]
local gbname=tjCfg.name
desc_str=desc_str..FMT.fmt('集齐{0}个碎片可以激活{1}',need,gbname)
end
self.desc:setText(desc_str)

local showProgress=formType~=TIPS_FORM_TYPE.eLink and not isActive
self.collectObjet:setActive(showProgress)
if showProgress then
local cur=pieceNum
if cur>need then
cur=need
end
local str=FMT.fmt('{0}/{1}',pieceNum,need)
self.collectProgress:setProgressValue(cur,need)
self.collectProgress:setChildProgressText(str)
end
end
