zheXianLingConfig={}

ZHE_XIAN_LING_STATUS=
{
eUnStart=0,
eDoing=1,
eFinish=2,
eReward=3,
}
ZHE_XIAN_LING_CND_TYPE=
{
eZMlv=1,
eRewardChapter=2,
}
local _lookup={}
local _list={}
local _bookOrder={}
local _chapterIdLookup={}
local _chapterLookup={}

function zheXianLingConfig.init()
local cfgs=zheXianLingConfig.getAllBookconfig()
local firstid
for i,v in ipairs(cfgs)do
local nextid=v.nextid
local id=v.id
local args={}
_lookup[id]=args
if nextid then
args.nextid=nextid
end
if firstid==nil then
firstid=id
_list[#_list+1]=id
end
for i,v in ipairs(v.chapterids)do
if _chapterIdLookup[id]==nil then _chapterIdLookup[id]={}end
_chapterLookup[v]={id,i}
local chapterIdLookup=_chapterIdLookup[id]
chapterIdLookup[i]=v
end
end

for i,v in ipairs(cfgs)do
local nextid=v.nextid
if nextid then
local args=_lookup[nextid]
args.lastid=v.id
end
end

local id=firstid
local nextid=_lookup[id].nextid
while nextid do
id=nextid
_list[#_list+1]=id
nextid=_lookup[id].nextid
end

for i,v in ipairs(_list)do
_bookOrder[v]=i
end
end

function zheXianLingConfig.getAllBookconfig()
return cfg_zxlbookconfig()
end

function zheXianLingConfig.getBookconfig(id)
return cfg_zxlbookconfig_get(id)
end

function zheXianLingConfig.getAllChapters(id)
return zheXianLingConfig.getBookconfig(id).chapterids
end

function zheXianLingConfig.getChapterconfig(id)
return cfg_zxlchapterconfig_get(id)
end

function zheXianLingConfig.getTaskId(chapter_id,idx)
local chapterCfg=zheXianLingConfig.getChapterconfig(chapter_id)
return chapterCfg.taskids[idx]
end

function zheXianLingConfig.getTaskIds(chapter_id)
local chapterCfg=zheXianLingConfig.getChapterconfig(chapter_id)
return chapterCfg.taskids
end

function zheXianLingConfig.getAttachBookId(id)
return _lookup[id].lastid,_lookup[id].nextid
end

function zheXianLingConfig.getBookLine()
return _list
end

function zheXianLingConfig.getBookIndex(book_id)
return _bookOrder[book_id]
end


function zheXianLingConfig.getChapterId(book_id,idx)
if _chapterIdLookup[book_id]then
return _chapterIdLookup[book_id][idx]
end
return-1
end


function zheXianLingConfig.getChapterIndex(chapter_id)
local cfg=_chapterLookup[chapter_id]or{}
return cfg[1],cfg[2]
end

function zheXianLingConfig.getJiYuanConfig(idx)
return cfg_zxlbasicconfig_get(1).pools[idx]
end

function zheXianLingConfig.getChapterOpenLv(chapter_id)
return zheXianLingConfig.getChapterconfig(chapter_id).zm_lv
end