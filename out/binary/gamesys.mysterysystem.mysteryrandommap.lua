mysteryRandomMap={}

local fixedMapPath="/mjmap/map/"

local templateMapPath="mjmap/randomMap/"

local roomMapPath="mjmap/roomMap/"

local entityStrCfg=nil

local _HexMapManager=CS.HexagonMapManagerInterface

local loadData={}

local heightMin,heightMax=-7,3

function mysteryRandomMap:ExportRandom(fbId)

local fbCfg=cfgHelper.get(cfg_secretscenefubenconfig_get,fbId)
local template=fbCfg.template
local walksurface=fbCfg.walksurface
local blocksurface=fbCfg.blocksurface
local createNum=fbCfg.mapNum
local color=fbCfg.color

if not createNum then
return
end

local allList={}
if template[1]==2 then
local i=1
for c=1,100 do
local list=mysteryRandomMap:RandomMap(template,fbCfg.dzTemplate,walksurface,fbCfg.delGrids,color,fbCfg.movemonsternum,fbCfg.movemonster,fbId,c)
if list then
allList[i]=list
i=i+1
end
if i>createNum then
break
end
end

elseif template[1]==3 then
for c=1,createNum do
local list=mysteryRandomMap:RandomFixedMap(template,walksurface,color,fbId)
allList[c]=list
end
end

local str=FMT.fmt("randomMap_{0}={\n{1}\n}\n return randomMap_{0}",fbId,serializeHelper.serializeEx(allList))





local p=FMT.fmt("{0}randomMap_{1}",templateMapPath,fbId)

loadData[p]=allList

local path=FMT.fmt("/{0}randomMap_{1}.lua",templateMapPath,fbId)
fileHelper.writeFileEx(path,str)

local writablePath=CS.GamePath.writablePath
local last=writablePath:match("^(.*\\)")
path=FMT.fmt("{0}rawconfig/server/skynet/logic/config/mjmap/randomMap/randomMap_{1}.lua",last,fbId)



fileHelper.writeFile(path,str)

end


function mysteryRandomMap:ExportRandomAllMap(createNum)
local fbCfg=cfg_secretscenefubenconfig()
for i,v in pairs(fbCfg)do
local template=v.template
if template[1]==2 or template[1]==3 then
mysteryRandomMap:ExportRandom(v.id,createNum)
end
end
end


function mysteryRandomMap:ExportRandomAllRoomMap(createNum)
local doorCfg=cfg_secretscenetransferdoor()
for i,v in pairs(doorCfg)do
mysteryRandomMap:ExportRoomRandom(v.id,createNum)
end
end

function mysteryRandomMap:RandomMapIndex(fbId,index)

local p=FMT.fmt("{0}randomMap_{1}",templateMapPath,fbId)
local mapData
if not loadData[p]then
mapData=reimport(p)
else
mapData=loadData[p]
end

local fbCfg=cfgHelper.get(cfg_secretscenefubenconfig_get,fbId)
local template=fbCfg.template
local walksurface=fbCfg.walksurface
local blocksurface=fbCfg.blocksurface

local color=fbCfg.color
local allList=mapData

if index>0 then
if template[1]==2 then
local list=mysteryRandomMap:RandomMap(template,fbCfg.dzTemplate,walksurface,fbCfg.delGrids,color,fbCfg.movemonsternum,fbCfg.movemonster,fbId,index)
allList[index]=list
elseif template[1]==3 then
local list=mysteryRandomMap:RandomFixedMap(template,walksurface,color,fbId)
allList[index]=list
end
else
for i=1,#allList do
if template[1]==2 then
local list=mysteryRandomMap:RandomMap(template,fbCfg.dzTemplate,walksurface,fbCfg.delGrids,color,fbCfg.movemonsternum,fbCfg.movemonster,fbId,i)
allList[i]=list
elseif template[1]==3 then
local list=mysteryRandomMap:RandomFixedMap(template,walksurface,color,fbId)
allList[i]=list
end
end
end

local path=FMT.fmt("/{0}randomMap_{1}.lua",templateMapPath,fbId)
local str=FMT.fmt("randomMap_{0}={\n{1}\n} \n return randomMap_{0}",fbId,serializeHelper.serializeEx(allList))
loadData[path]=allList
fileHelper.writeFileEx(path,str)

local writablePath=CS.GamePath.writablePath
local last=writablePath:match("^(.*\\)")
path=FMT.fmt("{0}rawconfig/server/skynet/logic/config/mjmap/randomMap/randomMap_{1}.lua",last,fbId)
fileHelper.writeFile(path,str)

end

function mysteryRandomMap:RandomMap(template,dzTemplate,walksurface,delGrids,color,movemonsternum,movemonster,fbId,index)
local templateList=template[2]
local list={}
local tNum=0


local delCount=0
if delGrids then
delCount=math.random(delGrids[1],delGrids[2])
end

if template[1]==3 then
table.insert(list,{template[2],template[3],1})
tNum=tNum+1
elseif template[1]==2 then
for _,v in ipairs(templateList)do
if type(v[1])=="number"then
table.insert(list,v)
tNum=tNum+v[3]
else
local t=math.random(1,#v)
table.insert(list,v[t])
tNum=tNum+v[t][3]
end
end
end


local mapCfgList={}
local maxX,maxY=0,0
local randomIdxList={}
for i=1,tNum do
randomIdxList[i]=i
end

local randomIdx=1
local xCount=math.ceil(math.sqrt(tNum))
local yCount=xCount
for i,v in ipairs(list)do
local config=cfgHelper.get(cfg_sseventgrouptemplateconfig_get,v[1])
if config then
local tpfile=config.tpfile
if tpfile then
for ii=1,v[3]do
local idx=math.random(1,#tpfile)
local mapConfig=table.deepCopy(mysteryMapConfig.get_mystery_template_config(tpfile[idx][1]))
local x=mapConfig[3][1]
local y=mapConfig[3][2]
if x>maxX then
maxX=x
end
if y>maxY then
maxY=y
end
local mapData={groupId=v[2],tempCfg=config,mapCfg=mapConfig,awayborn=config.awayborn==1}
if randomIdx==1 then
mapData.bornPoint=true
local ridx=math.random(1,#randomIdxList)
local bornPointIdx=randomIdxList[ridx]
table.remove(randomIdxList,ridx)
mapData.mapIdx=bornPointIdx

else
local bornPointIdx=mapCfgList[1].mapIdx
if config.awayborn==1 then
local candidates={}
if bornPointIdx%xCount~=0 then
candidates[bornPointIdx+1]=true
end
if bornPointIdx%xCount~=1 then
candidates[bornPointIdx-1]=true
end
if bornPointIdx/xCount>1 then
candidates[bornPointIdx-xCount]=true
end
if bornPointIdx/xCount<yCount then
candidates[bornPointIdx+xCount]=true
end
local newIdxList={}
for i,v in ipairs(randomIdxList)do
if not candidates[v]then
table.insert(newIdxList,{i,v})
end
end
if#newIdxList>0 then
local ridx=math.random(1,#newIdxList)
local bornPointIdx=newIdxList[ridx][2]
table.remove(randomIdxList,newIdxList[ridx][1])
mapData.mapIdx=bornPointIdx
else

local ridx=math.random(1,#randomIdxList)
local bornPointIdx=randomIdxList[ridx]
table.remove(randomIdxList,ridx)
mapData.mapIdx=bornPointIdx
end
else
local ridx=math.random(1,#randomIdxList)
local bornPointIdx=randomIdxList[ridx]
table.remove(randomIdxList,ridx)
mapData.mapIdx=bornPointIdx
end
end
table.insert(mapCfgList,mapData)
randomIdx=randomIdx+1
end
end

end
end



if dzTemplate then
local outIdxList={}
for i=1,tNum do
if i%xCount==0 then
table.insert(outIdxList,{i,'right'})
end
if i%xCount==1 then
table.insert(outIdxList,{i,'left'})
end
if i/xCount<=1 then
table.insert(outIdxList,{i,'under'})
end
if i/xCount>=yCount then
table.insert(outIdxList,{i,'top'})
end
end
local tpList={}
for i,v in ipairs(dzTemplate)do
local config=cfgHelper.get(cfg_sseventgrouptemplateconfig_get,v[1])
if config then
local tpfile=config.tpfile

for ii=1,v[3]do
local idx=math.random(1,#tpfile)
local mapConfig=table.deepCopy(mysteryMapConfig.get_mystery_template_config(tpfile[idx][1]))
table.insert(tpList,tpfile[idx][1])
local x=mapConfig[3][1]
local y=mapConfig[3][2]
if x>maxX then
maxX=x
end
if y>maxY then
maxY=y
end

local mapData={groupId=v[2],tempCfg=config,mapCfg=mapConfig,awayborn=config.awayborn==1}

if#outIdxList>0 then
local randomOutIdx=outIdxList[math.random(1,#outIdxList)]
mapData.mapIdx=randomOutIdx[1]
mapData.dianzuiArrow=randomOutIdx[2]
table.insert(mapCfgList,mapData)
end
end

end
end

end



table.sort(mapCfgList,function(a,b)
return a.mapIdx<b.mapIdx
end)

local mapData={}
local delList={}
local entList={}


for y=0,yCount*maxY do
for x=0,xCount*maxX do

local sur=mysteryRandomMap.getSurface(walksurface)
local data={0,sur,{x,y},math.random(heightMin,heightMax)/10,0}

mapData[table.concat({x,y},'_')]=data
delList[table.concat({x,y},'_')]={x,y}
end
end

local portalKey={}

maxX=maxX+1
maxY=maxY+1

local oriList={}
for i,v in ipairs(mapCfgList)do
local mapIdx=v.mapIdx
local orix=((mapIdx-1)%xCount)*maxX
local oriy=math.floor((mapIdx-1)/xCount)*maxY
local groupId=v.groupId
local tempCfg=v.tempCfg
table.insert(oriList,{orix,oriy,mapIdx,maxX,maxY})
local oldx=orix
local oldy=oriy
local lx,ly,rx,ry
if v.dianzuiArrow then
if v.dianzuiArrow=='left'then
orix=orix-maxX
lx,ly,rx,ry=orix,oriy,oldx,oriy+maxY
elseif v.dianzuiArrow=='right'then
orix=orix+maxX
lx,ly,rx,ry=oldx,oriy,orix,oriy+maxY
elseif v.dianzuiArrow=='under'then
oriy=oriy-maxY
lx,ly,rx,ry=orix,oriy,orix+maxX,oldy
elseif v.dianzuiArrow=='top'then
oriy=oriy+maxY
lx,ly,rx,ry=orix,oldy,orix+maxX,oriy
end
end

local minX,minY=0,0
for k,v2 in pairs(v.mapCfg[1])do
if v2[3][1]<minX then
minX=v2[3][1]
end
if v2[3][2]<minY then
minY=v2[3][2]
end
end

local maplist={}
for _,v2 in pairs(v.mapCfg[1])do
local data=table.deepCopy(v2)
data[3][1]=tonumber(v2[3][1])-minX
data[3][2]=tonumber(v2[3][2])-minY
table.insert(maplist,data)
end

local mlist={}
for _,v2 in pairs(v.mapCfg[2])do
local data=table.deepCopy(v2)
data[3][1]=tonumber(v2[3][1])-minX
data[3][2]=tonumber(v2[3][2])-minY
table.insert(mlist,data)
end

for ii,vv in ipairs(maplist)do
if vv[5]==0 then
local data=vv

local oX=vv[3][1]
local oY=vv[3][2]

local x=orix+oX
local y=oriy+oY

data[3][1]=x
data[3][2]=y

local key=table.concat({x,y},'_')
local height=math.random(-3,7)/10
data[4]=height

if data[2]<1 then
data[2]=mysteryRandomMap.getSurface(walksurface)
end

if mapData[key]and mapData[key][1]==1 then

else
mapData[key]=data
delList[key]={x,y}
end




end
end

for i3,v3 in ipairs(mlist)do
local ent=table.deepCopy(v3)
local x=orix+v3[3][1]
local y=oriy+v3[3][2]

if v3[2]<0 then
local id=mysteryRandomMap.getRandomEntity(v3[1],v3[2],tempCfg,color,groupId,fbId)
ent[2]=id
end
local key=table.concat({x,y},'_')
ent[3][1]=x
ent[3][2]=y

if entList[key]then


end
entList[key]=entList[key]or{}

table.insert(entList[key],ent)


portalKey[key]={key,mapIdx,v3[3][1],v3[3][2],orix,oriy,x,y}

delList[key]=nil

if not mapData[key]then
error(FMT.fmt('这个实体没有地表{0}',key))
end



end



if v.dianzuiArrow then
local roadcb=function(x,y)
local sur=mysteryRandomMap.getSurface(walksurface)
local data={0,sur,{x,y},math.random(heightMin,heightMax)/10,0}
mapData[table.concat({x,y},'_')]=data
delList[table.concat({x,y},'_')]={x,y}
end
if v.dianzuiArrow=='left'then
local y=ly+math.floor(maxY/2)
for x=lx,0 do
local key=table.concat({x,y},'_')
if not mapData[key]then
roadcb(x,y)
end
end
elseif v.dianzuiArrow=='right'then
local y=ly+math.floor(maxY/2)
for x=0,rx+maxX do
local key=table.concat({x,y},'_')
if not mapData[key]then
roadcb(x,y)
end
end
elseif v.dianzuiArrow=='under'then
local x=lx+math.floor(maxY/2)
for y=ly,0 do
local key=table.concat({x,y},'_')
if not mapData[key]then
roadcb(x,y)
end
end
elseif v.dianzuiArrow=='top'then
local x=lx+math.floor(maxY/2)
for y=0,ry do
local key=table.concat({x,y},'_')
if not mapData[key]then
roadcb(x,y)
end
end
end
end

local etReplace=tempCfg.etReplace
if etReplace then
local replaceEnt={}
for _,w0 in pairs(entList)do
for _,w in pairs(w0)do
if w[5]~=1 then
if not replaceEnt[w[1]]then
replaceEnt[w[1]]={}
end
table.insert(replaceEnt[w[1]],w)
end
end
end

for _,w in pairs(etReplace)do
local rt=w[1]
local rid=w[2]
for i3=1,w[3]do
if replaceEnt[w[4]]and next(replaceEnt[w[4]])then
local rand=math.random(1,#replaceEnt[w[4]])
local ent=replaceEnt[w[4]][rand]
ent[1]=rt
ent[2]=rid
local key=table.concat({ent[3][1],ent[3][2]},'_')
if entList[key]then
for _,w1 in pairs(entList[key])do
if w1[1]==rt then
w1=ent
break
end
end
end

table.remove(replaceEnt[w[4]],rand)
end
end
end
end

end



if delCount>0 then
local keyList={}
local count=0
for k,v2 in pairs(delList)do
count=count+1
keyList[count]=k
end

local nums={}
for i=1,count do
nums[i]=i
end

for i=#nums,2,-1 do

local j=math.random(1,i)
nums[i],nums[j]=nums[j],nums[i]
end

local delIdx=0
for i=1,count do
if delIdx>delCount then
break
end
local num=table.remove(nums)

local k=keyList[num]

local posT=string.split(k,'_')
local x,y=tonumber(posT[1]),tonumber(posT[2])
local roundList=mysteryPosHelper.get_round_pos_list(Vector3(x,y,0),1)
local haveNum=0
for i,v2 in ipairs(roundList)do
local key=table.concat({v2.x,v2.y},'_')
if mapData[key]then
haveNum=haveNum+1
end
end

if haveNum>5 then
if mapData[k]and mapData[k][1]==0 and not entList[k]then

mapData[k]=nil
delList[k]=nil
delIdx=delIdx+1


end
end

end
end




if movemonsternum and movemonsternum>0 then
for i=1,movemonsternum do
local total=0
for _,w in ipairs(movemonster)do
total=total+w[2]
end
local rnd=math.random(total)

local sum=0
local index=1
for i,w in ipairs(movemonster)do
sum=sum+w[2]
if rnd<=sum then
index=i
break
end
end

local monster=movemonster[index][1]

local keyList={}
for k,v2 in pairs(delList)do
table.insert(keyList,k)
end
if#keyList>0 then
local surfaceDataKey=keyList[math.random(1,#keyList)]
if mapData[surfaceDataKey]and mapData[surfaceDataKey][1]==0 and not entList[surfaceDataKey]then

local pos=delList[surfaceDataKey]
local data={3,monster,{tonumber(pos[1]),tonumber(pos[2])},1,0}
entList[surfaceDataKey]={data}

delList[surfaceDataKey]=nil


end
end
end
end



local minX,minY=0,0

for k,v2 in pairs(mapData)do
if v2[3][1]<minX then
minX=v2[3][1]
end
if v2[3][2]<minY then
minY=v2[3][2]
end
end

local birth={}

local maplist={}
for _,v2 in pairs(mapData)do
local data=v2
data[3][1]=tonumber(v2[3][1])-minX
data[3][2]=tonumber(v2[3][2])-minY

if data[1]==1 then
birth=data
end

table.insert(maplist,data)
end



local mlist={}
for _,v2 in pairs(entList)do
for _,v3 in pairs(v2)do
local data=v3
data[3][1]=tonumber(v3[3][1])-minX
data[3][2]=tonumber(v3[3][2])-minY
table.insert(mlist,data)
end

end



if not next(birth)then
local keyList={}
for k,v2 in pairs(mapData)do
if v2[1]==0 or v2[1]==4 then
table.insert(keyList,v2)
end
end
birth=keyList[math.random(1,#keyList)]

if birth then
birth[1]=1
birth[3][1]=tonumber(birth[3][1])-minX
birth[3][2]=tonumber(birth[3][2])-minY
end
end



local unlinkGrid=mysteryRandomMap:checkMapLink(maplist,birth,true)
if next(unlinkGrid)then
loggerUtil.logWarnFMT("秘境{0}出现断层 索引{1},已尝试修复，请检查",fbId,index)
end

table.sort(maplist,function(a,b)
return a[3][2]<b[3][2]and a[3][1]<b[3][1]
end)

return{maplist,mlist,{maxX*xCount,maxY*yCount},birth}
end

function mysteryRandomMap:RandomFixedMap(template,walksurface,color,fbId)
local list={}
local tNum=0


if template[1]==3 then
table.insert(list,{template[2],template[3],1})
tNum=tNum+1
end

local mapCfgList={}
local maxX,maxY=0,0
local randomIdxList={}
for i=1,tNum do
randomIdxList[i]=i
end

local xCount=math.ceil(math.sqrt(tNum))
local yCount=xCount
for i,v in ipairs(list)do
local config=cfgHelper.get(cfg_sseventgrouptemplateconfig_get,v[1])
if config then

local tpfile2=config.tpfile2
if tpfile2 then
for ii,vv in ipairs(tpfile2)do
local mapConfig=table.deepCopy(mysteryMapConfig.get_mystery_map_config(vv[1]))
local x=mapConfig[3][1]
local y=mapConfig[3][2]
if x>maxX then
maxX=x
end
if y>maxY then
maxY=y
end
local mapData={groupId=v[2],tempCfg=config,mapCfg=mapConfig,awayborn=config.awayborn==1,mapIdx=ii}
table.insert(mapCfgList,mapData)
end

end
else
loggerUtil.logErrFMT("副本{1} 模板配置没找到：id {0}",v[1],fbId)
end
end

table.sort(mapCfgList,function(a,b)
return a.mapIdx<b.mapIdx
end)

local mapData={}
local delList={}
local entList={}

for i,v in ipairs(mapCfgList)do
local mapIdx=v.mapIdx
local orix=((mapIdx-1)%xCount)*maxX
local oriy=math.floor((mapIdx-1)/xCount)*maxY
local groupId=v.groupId
local tempCfg=v.tempCfg

local lx,ly,rx,ry

for ii,vv in ipairs(v.mapCfg[1])do
if vv[5]==0 then
local data=vv

local x=nil
local y=nil

x=orix+vv[3][1]
y=oriy+vv[3][2]

data[3][1]=x
data[3][2]=y

local key=table.concat({x,y},'_')



if data[2]<1 then
data[2]=mysteryRandomMap.getSurface(walksurface)
end

mapData[key]=data

delList[key]={x,y}

end
end



for i3,v3 in ipairs(v.mapCfg[2])do
local ent=v3
local x=nil
local y=nil
x=orix+v3[3][1]
y=oriy+v3[3][2]
ent[3][1]=x
ent[3][2]=y

if v3[2]<0 then
local id=mysteryRandomMap.getRandomEntity(v3[1],v3[2],tempCfg,color,groupId,fbId)
ent[2]=id
end

local key=table.concat({x,y},'_')

entList[key]=ent

delList[key]=nil

if not mapData[key]then
error(FMT.fmt('这个实体没有地表{0}',key))
end
end

local etReplace=tempCfg.etReplace
if etReplace then
local replaceEnt={}
for _,w in pairs(entList)do
if w[5]~=1 then
if not replaceEnt[w[1]]then
replaceEnt[w[1]]={}
end
table.insert(replaceEnt[w[1]],w)
end
end

for _,w in pairs(etReplace)do
local rt=w[1]
local rid=w[2]
for i3=1,w[3]do
if replaceEnt[w[4]]and next(replaceEnt[w[4]])then
local rand=math.random(1,#replaceEnt[w[4]])

local ent=replaceEnt[w[4]][rand]
ent[1]=rt
ent[2]=rid
local key=table.concat({ent[3][1],ent[3][2]},'_')
entList[key]=ent
table.remove(replaceEnt[w[4]],rand)
end
end
end
end



local minX,minY=0,0

for k,v3 in pairs(mapData)do
if v3[3][1]<minX then
minX=v3[3][1]
end
if v3[3][2]<minY then
minY=v3[3][2]
end
end

local birth={}
local maplist={}
for _,v3 in pairs(mapData)do
local data=v3
data[3][1]=tonumber(v3[3][1])-minX
data[3][2]=tonumber(v3[3][2])-minY
if data[1]==1 then
birth=data
end
table.insert(maplist,data)
end

if not next(birth)then

local keyList={}
for k,v2 in pairs(mapData)do
if v2[1]==0 or v2[1]==4 then
table.insert(keyList,v2)
end
end
local key=math.random(1,#keyList)
birth=keyList[key]
birth[1]=1
birth[3][1]=tonumber(birth[3][1])-minX
birth[3][2]=tonumber(birth[3][2])-minY
end

local mlist={}
for _,v in pairs(entList)do
local data=v
data[3][1]=tonumber(v[3][1])-minX
data[3][2]=tonumber(v[3][2])-minY
table.insert(mlist,data)
end

table.sort(maplist,function(a,b)
return a[3][2]<b[3][2]and a[3][1]<b[3][1]
end)

return{maplist,mlist,{maxX*xCount,maxY*yCount},birth}
end
end

function mysteryRandomMap.getSurface(walksurface)
local surfaceGroupId=walksurface[math.random(1,#walksurface)]
local surfaceGroup=cfgHelper.get(cfg_secretscentsurfacegroupconfig_get,surfaceGroupId[1],"surface")[surfaceGroupId[2]]
return surfaceGroup[math.random(2,#surfaceGroup)][1]

end

function mysteryRandomMap.initEntityStrCfg()
if not entityStrCfg then
entityStrCfg={}
local cfg=cfg_ssentitytypeconfig()
for i,v in ipairs(cfg)do
entityStrCfg[v.etTypeStr]=v
end
end
end

function mysteryRandomMap.getRandomEntity(key,id,tempCfg,color,groupId,fbID)
color=color or 1






local cfg=cfg_ssentitytypeconfig_get(key)
if not cfg then
return
end


local randId=cfg.randId
if randId and randId[id]then
local randIdT=randId[id]
local randId=nil
if type(randIdT)=='table'then
local id=randIdT[color]
if id then
randId=randIdT[#randIdT]
else
randId=id
end
if not tempCfg[randId]then
for i=1,#randIdT do
if tempCfg[randIdT[i]]then
randId=randIdT[i]
end
end
end
else
randId=randIdT
end

local config=tempCfg[randId]
if config then
local group=config[groupId]
if group then

if type(group[2][1])=="number"then
local total=0
for i=2,#group do
total=total+group[i][2]
end
local rnd=math.random(total)

local sum=0
local index=1
for i=2,#group do
sum=sum+group[i][2]
if rnd<=sum then
index=i
break
end
end

return group[index][1]
else
local idx=math.random(1,#group[2])
return group[2][idx][1]
end
else
loggerUtil.logErrFMT("秘境(房间)Id:{2},模板id:{4},随机物索引{0}找不到对应随机物(实体类型{3}),请检查配置，实体id{1}",groupId,id,fbID,cfg.name,tempCfg.id)
local group=config[1]
if type(group[2][1])=="number"then
return group[2][1]
else
local idx=math.random(1,#group[2])
return group[2][idx][1]
end
end
else
loggerUtil.logErrFMT("秘境(房间)Id:{2},模板id:{4},随机物(实体类型{3})找不到对应随机物字段{0},请检查配置，实体id{1}",randId,id,fbID,cfg.name,tempCfg.id)
end
end

end

function mysteryRandomMap:ExportRoomRandom(templateId)


local doorCfg=cfgHelper.get(cfg_secretscenetransferdoor_get,templateId)

local room=doorCfg.room
local color=doorCfg.color
local roomIndexList=doorCfg.roomIndex
local walksurface=doorCfg.roomsurface
local position=doorCfg.position
local allList={}
local createNum=doorCfg.mapNum
if not createNum then
return
end
for c=1,createNum do
local roomIndex=nil
for i,v in ipairs(roomIndexList)do
if c>=v[1]and c<=v[2]then
roomIndex=v[3]
end
end
local list=mysteryRandomMap:RandomRoomMap(room,roomIndex,walksurface,color,position,templateId)

allList[c]=list
end

local str=FMT.fmt("roomMap_{0}={\n{1}\n} return roomMap_{0}",templateId,serializeHelper.serializeEx(allList))





local p=FMT.fmt("{0}roomMap_{1}",roomMapPath,templateId)

loadData[p]=allList

local path=FMT.fmt("/{0}roomMap_{1}.lua",roomMapPath,templateId)
fileHelper.writeFileEx(path,str)

local writablePath=CS.GamePath.writablePath
local last=writablePath:match("^(.*\\)")
path=FMT.fmt("{0}rawconfig/server/skynet/logic/config/mjmap/roomMap/roomMap_{1}.lua",last,templateId)
fileHelper.writeFile(path,str)

end

function mysteryRandomMap:RandomRoomMapIndex(transId,index)


local p=FMT.fmt("{0}roomMap_{1}",roomMapPath,transId)
local mapData
if not loadData[p]then
mapData=reimport(p)
else
mapData=loadData[p]
end

local doorCfg=cfgHelper.get(cfg_secretscenetransferdoor_get,transId)
local room=doorCfg.room
local color=doorCfg.color
local roomIndexList=doorCfg.roomIndex
local walksurface=doorCfg.roomsurface
local roomIndex=nil
for i,v in ipairs(roomIndexList)do
if index>=v[1]and index<=v[2]then
roomIndex=v[3]
end
end
local position=doorCfg.position

local allList=mapData

if index>0 then
local list=mysteryRandomMap:RandomRoomMap(room,roomIndex,walksurface,color,position,transId)
allList[index]=list
else
for i=1,#allList do
local list=mysteryRandomMap:RandomRoomMap(room,roomIndex,walksurface,color,position,transId)
allList[i]=list
end
end


local path=FMT.fmt("/{0}roomMap_{1}.lua",roomMapPath,transId)
local str=FMT.fmt("roomMap_{0}=\n{1}\nreturn roomMap_{0}",transId,serializeHelper.serializeEx(allList))
loadData[path]=allList
fileHelper.writeFileEx(path,str)

local writablePath=CS.GamePath.writablePath
local last=writablePath:match("^(.*\\)")
path=FMT.fmt("{0}rawconfig/server/skynet/logic/config/mjmap/roomMap/roomMap_{1}.lua",last,transId)
fileHelper.writeFile(path,str)

end

function mysteryRandomMap:RandomRoomMap(template,roomIndex,walksurface,color,position,tId)
local tNum=1
local mapCfgList={}
local maxX,maxY=0,0
local randomIdxList={}
for i=1,tNum do
randomIdxList[i]=i
end
local tlist={{template,roomIndex,1}}
local randomIdx=1
local xCount=math.ceil(math.sqrt(tNum))
local yCount=xCount
local isFixed=false
for i,v in ipairs(tlist)do
local config=cfgHelper.get(cfg_sseventgrouptemplateconfig_get,v[1])
if config then
local tpfile=config.tpfile
if tpfile then
local idx=math.random(1,#tpfile)
local mapConfig=table.deepCopy(mysteryMapConfig.get_mystery_template_config(tpfile[idx][1]))
local x=mapConfig[3][1]
local y=mapConfig[3][2]
if x>maxX then
maxX=x
end
if y>maxY then
maxY=y
end
local mapData={groupId=v[2],tempCfg=config,mapCfg=mapConfig,awayborn=config.awayborn==1}
if#mapCfgList==0 then
mapData.bornPoint=true
local ridx=math.random(1,#randomIdxList)
local bornPointIdx=randomIdxList[ridx]
table.remove(randomIdxList,ridx)
mapData.mapIdx=bornPointIdx

else
local bornPointIdx=mapCfgList[1].mapIdx
if config.awayborn==1 then
local candidates={}
if bornPointIdx%xCount~=0 then
candidates[bornPointIdx+1]=true
end
if bornPointIdx%xCount~=1 then
candidates[bornPointIdx-1]=true
end
if bornPointIdx/xCount>1 then
candidates[bornPointIdx-xCount]=true
end
if bornPointIdx/xCount<yCount then
candidates[bornPointIdx+xCount]=true
end
local newIdxList={}
for i,v in ipairs(randomIdxList)do
if not candidates[v]then
table.insert(newIdxList,{i,v})
end
end
if#newIdxList>0 then
local ridx=math.random(1,#newIdxList)
local bornPointIdx=newIdxList[ridx][2]
table.remove(randomIdxList,newIdxList[ridx][1])
mapData.mapIdx=bornPointIdx
else
loggerUtil.logErrFMT("已经没有远离出生点的点了")
local ridx=math.random(1,#randomIdxList)
local bornPointIdx=randomIdxList[ridx]
table.remove(randomIdxList,ridx)
mapData.mapIdx=bornPointIdx
end
else
local ridx=math.random(1,#randomIdxList)
local bornPointIdx=randomIdxList[ridx]
table.remove(randomIdxList,ridx)
mapData.mapIdx=bornPointIdx
end
end
table.insert(mapCfgList,mapData)
randomIdx=randomIdx+1
end


local tpfile2=config.tpfile2
if tpfile2 then
for i,v in ipairs(tpfile2)do
local mapConfig=table.deepCopy(mysteryMapConfig.get_mystery_map_config(v[1]))
local x=mapConfig[3][1]
local y=mapConfig[3][2]
if x>maxX then
maxX=x
end
if y>maxY then
maxY=y
end
local mapData={groupId=roomIndex,tempCfg=config,mapCfg=mapConfig,awayborn=config.awayborn==1}
mapData.mapIdx=i

table.insert(mapCfgList,mapData)
randomIdx=randomIdx+1
end
isFixed=true
end
end
end

table.sort(mapCfgList,function(a,b)
return a.mapIdx<b.mapIdx
end)

local mapData={}
local delList={}
local entList={}

maxX=maxX+1
maxY=maxY+1

for i,v in ipairs(mapCfgList)do
local mapIdx=v.mapIdx
local orix=((mapIdx-1)%xCount)*maxX
local oriy=math.floor((mapIdx-1)/xCount)*maxY
local groupId=v.groupId
local tempCfg=v.tempCfg
local lx,ly,rx,ry
for ii,vv in ipairs(v.mapCfg[1])do
if vv[5]==0 then
local data=vv

local x=nil
local y=nil

x=orix+vv[3][1]
y=oriy+vv[3][2]

data[3][1]=x
data[3][2]=y

local key=table.concat({x,y},'_')
if not isFixed then
local height=math.random(heightMin,heightMax)/10
data[4]=height
end

if data[2]<1 then
data[2]=mysteryRandomMap.getSurface(walksurface)
end

mapData[key]=data

delList[key]={x,y}

if position then
if x==position[1]and y==position[2]then
entList[key]={eMysteryEntityType.ePortal,tId,{x,y},1,0}
end
end
end
end

for i3,v3 in ipairs(v.mapCfg[2])do
local ent=v3
local x=nil
local y=nil
x=orix+v3[3][1]
y=oriy+v3[3][2]
ent[3][1]=x
ent[3][2]=y

if v3[2]<0 then
local id=mysteryRandomMap.getRandomEntity(v3[1],v3[2],tempCfg,color,groupId,tId)
if id then
ent[2]=id
else

end
end

local key=table.concat({x,y},'_')

entList[key]=ent

delList[key]=nil

if not mapData[key]then
error(FMT.fmt('这个实体没有地表{0}',key))
end
end

local etReplace=tempCfg.etReplace
if etReplace then
local replaceEnt={}
for _,w in pairs(entList)do
if w[5]~=1 then
if not replaceEnt[w[1]]then
replaceEnt[w[1]]={}
end
table.insert(replaceEnt[w[1]],w)
end
end

for _,w in pairs(etReplace)do
local rt=w[1]
local rid=w[2]
for i3=1,w[3]do
if replaceEnt[w[4]]and next(replaceEnt[w[4]])then
local rand=math.random(1,#replaceEnt[w[4]])
local ent=replaceEnt[w[4]][rand]
ent[1]=rt
ent[2]=rid
local key=table.concat({ent[3][1],ent[3][2]},'_')
entList[key]=ent
table.remove(replaceEnt[w[4]],rand)
end
end
end
end
end


local minX,minY=0,0

for k,v in pairs(mapData)do
if v[3][1]<minX then
minX=v[3][1]
end
if v[3][2]<minY then
minY=v[3][2]
end
end
local birth=nil
local maplist={}
for _,v in pairs(mapData)do
local data=v
data[3][1]=tonumber(v[3][1])-minX
data[3][2]=tonumber(v[3][2])-minY
table.insert(maplist,data)
if position and data[3][1]==position[1]and data[3][2]==position[2]then
birth=data
end
end


if not birth then
local keyList={}
for k,v2 in pairs(mapData)do
if v2[1]==1 or v2[1]==3 then
table.insert(keyList,v2)
end
end
birth=keyList[math.random(1,#keyList)]
if birth then
birth[1]=1
birth[3][1]=tonumber(birth[3][1])-minX
birth[3][2]=tonumber(birth[3][2])-minY
end
end

if not birth then
loggerUtil.logErrFMT('真的没有出生点{0}',tId)
end

local mlist={}

if position then
local key=table.concat({position[1],position[2]},'_')
if not entList[key]then
entList[key]={eMysteryEntityType.ePortal,tId,{position[1],position[2]},1,0}
end
end

for _,v in pairs(entList)do
local data=v
data[3][1]=tonumber(v[3][1])-minX
data[3][2]=tonumber(v[3][2])-minY
table.insert(mlist,data)
end



table.sort(maplist,function(a,b)
return a[3][2]<b[3][2]and a[3][1]<b[3][1]
end)

return{maplist,mlist,{maxX*xCount,maxY*yCount},birth}
end

function mysteryRandomMap.LoadRoomMap(transId,index)
local p=FMT.fmt("{0}roomMap_{1}",roomMapPath,transId)
local mapData
if not loadData[p]then
mapData=reimport(p)
else
mapData=loadData[p]
end

if not mapData then
return
end

local map=mapData[index]


if not map then
UIManager.error("地图不存在")
return
end

UIManager:showWindow('UIMysteryHUDWin')
MysteryModel.loadingTile={}
MysteryController:loadMap(function()

MysteryController:loadAllFBTile()
timeEventController.delayDo(1,function()
mysteryRandomMap.initRoomMap(transId,map)
end,false)
end)
end


function mysteryRandomMap:loadMap(fbId,fbIndex)
fbIndex=fbIndex or 1
local path=FMT.fmt("{0}randomMap_{1}",templateMapPath,fbId)

local mapData
if not loadData[path]then
mapData=reimport(path)
else
mapData=loadData[path]
end


if not mapData then
return
end

local map=mapData[fbIndex]


if not map then
UIManager.error("地图不存在")
return
end

UIManager:showWindow('UIMysteryHUDWin')
MysteryModel.loadingTile={}
MysteryController:loadMap(function()

MysteryController:loadFBTile(fbId)
timeEventController.delayDo(1,function()
mysteryRandomMap.initMap(fbId,map)
end,false)
end)
end


function mysteryRandomMap:loadAllMap(fbId)
local path=FMT.fmt("{0}randomMap_{1}",templateMapPath,fbId)

local mapData
if not loadData[path]then
mapData=reimport(path)
else
mapData=loadData[path]
end


if not mapData then
return
end

local map=mapData


if not map then
UIManager.error("地图不存在")
return
end



UIManager:showWindow('UIMysteryHUDWin')
MysteryModel.loadingTile={}
MysteryController:loadMap(function()

MysteryController:loadFBTile(fbId)
timeEventController.delayDo(1,function()

for i,v in ipairs(map)do
local m=table.deepCopy(v)
local offset=(i-1)*30

for i,v1 in ipairs(m[1])do
v1[3][1]=v1[3][1]+offset
end

for i,v1 in ipairs(m[2])do
v1[3][1]=v1[3][1]+offset
end

m[4][3][1]=m[4][3][1]+offset

mysteryRandomMap.initMap(fbId,m)
end


end,false)
end)
end


function mysteryRandomMap.loadFixedMap(fbId)
local fbCfg=cfgHelper.get(cfg_secretscenefubenconfig_get,fbId)
local template=fbCfg.template[2]
local path=FMT.fmt("{0}{1}",fixedMapPath,template)

local mapData
if not loadData[path]then
mapData=reimport(path)
else
mapData=loadData[path]
end

if not mapData then
return
end

if not mapData then
UIManager.error("地图不存在")
end

UIManager:showWindow('UIMysteryHUDWin')
MysteryModel.loadingTile={}
MysteryController:loadMap(function()

MysteryController:loadFBTile(fbId,nil)
timeEventController.delayDo(1,function()
mysteryRandomMap.initMap(fbId,mapData)
end,false)
end)
end

function mysteryRandomMap.initMap(fbId,mapData)
mysteryRandomMap.initEntityStrCfg()
MysteryModel:clear_fb_data()
local cfg_fb=cfg_secretscenefubenconfig_get(fbId)
local grid_size=cfg_fb.gridsize
_HexMapManager.SetGridSize(grid_size[1],grid_size[2],0)

local cfg_surface=cfg_secretscentsurfaceconfig()
for i,v in ipairs(mapData[1])do
local surface=v[2]
local config=cfg_surface[surface]
local pos=Vector3(v[3][1],v[3][2],0)
MysteryController:Paint(pos,config.groupid,surface,HexMapLayer.Ground,v[4])
end

for e,v in ipairs(mapData[2])do
if v[2]>0 then
local entityType=v[1]
mysteryEntityController:createEntity(entityType,{etId=v[2],x=v[3][1],y=v[3][2],roomId=0})
end
end

local model=
{
id=113109,
components={},
layer=SortingLayers.ITBuilding,
scale=1.5,
}

local data=
{
move_complete=true,
per_steps=1,
fight_value=1,
showInFog=1,
useTree=false
}

mysteryPlayerModel:create_entity(eMysteryEntityType.ePlayer,1,Vector3.New(mapData[4][3][1],mapData[4][3][2],0),0,model,data)
end

function mysteryRandomMap.initRoomMap(fbId,mapData)
mysteryRandomMap.initEntityStrCfg()
MysteryModel:clear_fb_data()

local grid_size={2.5,3}
_HexMapManager.SetGridSize(grid_size[1],grid_size[2],0)

local cfg_surface=cfg_secretscentsurfaceconfig()

for i,v in ipairs(mapData[1])do
local surface=v[2]
local config=cfg_surface[surface]
if config then
local pos=Vector3(v[3][1],v[3][2],0)
MysteryController:Paint(pos,config.groupid,surface,HexMapLayer.Ground,v[4])
else
error(FMT.fmt('找不到地表配置：{0}',surface))
end
end

for e,v in ipairs(mapData[2])do
if v[2]>0 then
local entityType=v[1]
mysteryEntityController:createEntity(entityType,{etId=v[2],x=v[3][1],y=v[3][2],roomId=0})
end
end

local model=
{
id=113109,
components={},
layer=SortingLayers.ITBuilding,
scale=1.5,
}

local data=
{
move_complete=true,
per_steps=1,
fight_value=1,
showInFog=1,
useTree=false
}

mysteryPlayerModel:create_entity(eMysteryEntityType.ePlayer,1,Vector3.New(mapData[4][3][1],mapData[4][3][2],0),0,model,data)
end

function mysteryRandomMap.clearMap()
_HexMapManager.ClearMapAsset()
mysteryEntityController.invokeAllModelsFunc("clear_entity_list")
UIManager:closeWindow('UIMysteryHUDWin')
end

function mysteryRandomMap.onFileExport(allList)
local m={}
local mstr=''
for i,v in ipairs(allList)do
local isInsert=true
for i2,v2 in ipairs(m)do
if serializeHelper.serializeEx(v[1])==v2 then
isInsert=false
break
end
end
if isInsert then
m[#m+1]=serializeHelper.serializeEx(v[1])
end
end

mstr=mstr..'local m={'
for i,v in ipairs(m)do
mstr=mstr..'{'..v..'},'
end
mstr=mstr..'}'
local allStr='{'
for i,v in ipairs(allList)do
local isInsert=nil
for i2,v2 in ipairs(m)do
if serializeHelper.serializeEx(v[1])==v2 then
isInsert=i2
break
end
end
local str='{'
if isInsert then
str=str..'m['..isInsert..'],'
for i3=2,#v do
str=str..serializeHelper.serializeEx(v[i3])..','
end
str=str..'},'
else
str=str..serializeHelper.serializeEx(v)..'},'
end
allStr=allStr..str
end
return mstr,allStr
end

function mysteryRandomMap.checkAllMapLink()
local fbCfg=cfg_secretscenefubenconfig()
for id,v in pairs(fbCfg)do
local template=v.template
if template[1]==2 then
local path=FMT.fmt("{0}randomMap_{1}",templateMapPath,v.id)
local iserr=false
local mapData
if not loadData[path]then
local fpath=fileHelper.getFullPath(FMT.fmt("{0}.lua",path))
if fileHelper.isFileExists(fpath)then
mapData=require(path)
loadData[path]=mapData
end

else
mapData=loadData[path]
end
if mapData then
for i,vv in ipairs(mapData)do
local unLinkGrid=mysteryRandomMap:checkMapLink(vv[1],vv[4])
if next(unLinkGrid)then
iserr=true
loggerUtil.logErrFMT("秘境{0}出现断层 索引{1}",id,i)
end
end
end
end
end
end

function mysteryRandomMap.fixAllMapLink()
local fbCfg=cfg_secretscenefubenconfig()
for id,v in pairs(fbCfg)do
local template=v.template
if template[1]==2 then
local path=FMT.fmt("{0}randomMap_{1}",templateMapPath,v.id)
local iserr=false
local mapData
if not loadData[path]then
local fpath=fileHelper.getFullPath(FMT.fmt("{0}.lua",path))
if fileHelper.isFileExists(fpath)then
mapData=require(path)
loadData[path]=mapData
end

else
mapData=loadData[path]
end
if mapData then
for i,vv in ipairs(mapData)do
local unLinkGrid=mysteryRandomMap:checkMapLink(vv[1],vv[4],true)
if next(unLinkGrid)then
iserr=true
loggerUtil.logErrFMT("秘境{0}出现断层 索引{1}",id,i)
end
end
end

if iserr then
local path=FMT.fmt("/{0}randomMap_{1}.lua",templateMapPath,v.id)
local str=FMT.fmt("randomMap_{0}={\n{1}\n} \n return randomMap_{0}",v.id,serializeHelper.serializeEx(mapData))
loadData[path]=mapData
fileHelper.writeFileEx(path,str)

local writablePath=CS.GamePath.writablePath
local last=writablePath:match("^(.*\\)")
path=FMT.fmt("{0}rawconfig/server/skynet/logic/config/mjmap/randomMap/randomMap_{1}.lua",last,v.id)
fileHelper.writeFile(path,str)
end
end
end
end




function mysteryRandomMap:checkMapLink(mapData,birth,checkFix)
local mapMap={}
for i,v in ipairs(mapData)do
local key=table.concat({v[3][1],v[3][2]},'_')
mapMap[key]=v
end

local unLinkGrid,fixGrid=mysteryRandomMap:startCheckPath(mapMap,birth,checkFix)

if checkFix then
if next(fixGrid)then
for i,v in pairs(fixGrid)do
table.insert(mapData,v)
end

table.sort(mapData,function(a,b)
return a[3][2]<b[3][2]and a[3][1]<b[3][1]
end)
end
end

return unLinkGrid
end

function mysteryRandomMap:startCheckPath(mapData,birth,checkFix)
local bx,by=birth[3][1],birth[3][2]
local key=table.concat({bx,by},'_')
self.checkMapGrid={[key]=birth}
self.unLinkGrid={}

self.fixGrid={}

self:checkPath(mapData,{bx,by})

for k,v in pairs(mapData)do
if not self.checkMapGrid[k]then
self.unLinkGrid[k]=v
end
end

if checkFix then
for _,unLinkGrid in pairs(self.unLinkGrid)do
mysteryRandomMap:fixPath(unLinkGrid)
end
end

return self.unLinkGrid,self.fixGrid
end

function mysteryRandomMap:checkPath(mapData,birth)
local roundList=mysteryPosHelper.get_round_pos_list(Vector3(birth[1],birth[2],0),1)
for i,v2 in ipairs(roundList)do
local key=table.concat({v2.x,v2.y},'_')
if mapData[key]and not self.checkMapGrid[key]then
self.checkMapGrid[key]=mapData[key]
mysteryRandomMap:checkPath(mapData,{v2.x,v2.y})
end
end
end

function mysteryRandomMap:fixPath(unLinkGrid)
local distance=100000
local lastGrid=nil
local pos={x=unLinkGrid[3][1],y=unLinkGrid[3][2]}
for key,v in pairs(self.checkMapGrid)do
local d=mysteryPosHelper.get_pos_distance(pos,{x=v[3][1],y=v[3][2]})
if d<distance then
distance=d
lastGrid=v
end
end



if lastGrid then
local lastGridPos={x=lastGrid[3][1],y=lastGrid[3][2]}

local dx=math.abs(lastGridPos.x-pos.x)
local dy=math.abs(lastGridPos.y-pos.y)
for i1=0,dx do
local x
if lastGridPos.x-pos.x>0 then
x=lastGridPos.x-i1
else
x=lastGridPos.x+i1
end
local y=lastGridPos.y
if i1==dx then
for i2=0,dy do
if lastGridPos.y-pos.y>0 then
y=lastGridPos.y-i2
else
y=lastGridPos.y+i2
end
end
end
local key=table.concat({x,y},'_')

if not self.checkMapGrid[key]and not self.unLinkGrid[key]and not self.fixGrid[key]then
local g=table.deepCopy(lastGrid)
g[3][1]=x
g[3][2]=y
self.fixGrid[key]=g
end
end
end

end
