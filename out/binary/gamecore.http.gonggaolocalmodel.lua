gonggaoLocalModel={}


local _contentcfg=
{
{
title='开服公告',
content="开服公告内容1",
begin_time='1662452679',
end_time='1726388679',
},
{
title='开服公告2',
content="开服公告内容2",
begin_time='1662452679',
end_time='1726388679',
},
}

local _cfg=
{
noticenum=1,
eject=2,
}

function gonggaoLocalModel.getContentCfg()
return _contentcfg
end

function gonggaoLocalModel.getCfg()
return _cfg
end

function gonggaoLocalModel.test(num)
_cfg=
{
noticenum=num,
eject=2,
}
_contentcfg=
{
{
title='开服公告2',
content="开服公告内容2",
begin_time='1662452679',
end_tiem='1726388679',
},
}
end